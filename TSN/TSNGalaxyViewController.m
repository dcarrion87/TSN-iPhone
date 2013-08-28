//
//  TSNContactListViewController.m
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxyViewController.h"
#import "TSNGalaxy.h"
#import "TSNGalaxyDetailViewController.h"
#import "TSNLoginViewController.h"
#import "TSNShared.h"
#import "MBProgressHUD.h"


@interface TSNGalaxyViewController ()

@end

@implementation TSNGalaxyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isFirstFetch){
        [self fetchGalaxies];
        self.isFirstFetch = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.galaxies = [[NSMutableArray alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshGalaxies:) forControlEvents:UIControlEventValueChanged];
    self.isFirstFetch = YES;
}

- (IBAction)refreshGalaxies:(id)sender
{
    [self fetchGalaxies];
    [self.refreshControl endRefreshing];
}

// Move this to Galaxy Manager class
- (void)fetchGalaxies
{
    if(self.isFetching){
        return;
    }
    
    [self indicateFetching:YES];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);    
    dispatch_async(queue,  ^{
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:
                                        [NSString stringWithFormat:@"%@/boinc/%@/galaxies.json?locale=en",
                                        [TSNShared sharedInstance].baseURL,
                                        [[TSNShared sharedInstance] getUserId]]] options:0 error:&error];
        if (error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self indicateFetching:NO];
                [self displayFetchError];
            });
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSArray *gals = [json valueForKeyPath:@"result.galaxies.galaxy"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.galaxies removeAllObjects];
        });
        for (NSDictionary *gal in gals) {
            // Create galaxy object with base details
            TSNGalaxy *g = [[TSNGalaxy alloc]initWithGalId:[gal objectForKey:@"id"]
                                                   galName:[gal objectForKey:@"name"]];
            // Set the rest
            [g setRedshift:[[gal objectForKey:@"redshift"] doubleValue]];
            [g setRa:[[gal objectForKey:@"ra_cent"] doubleValue]];
            [g setDec:[[gal objectForKey:@"dec_cent"] doubleValue]];
            [g setComplete:[[gal objectForKey:@"percentage_complete"] doubleValue]];
            [g setThumbnailUrl:[NSURL URLWithString:[gal objectForKey:@"thumbnail_url"]]];
            [g setNedUrl:[NSURL URLWithString:[gal objectForKey:@"more_info_url"]]];
                       
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.galaxies addObject:g];
                
            });
                      
        }
        
        if(self.galaxies.count == 0){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self indicateFetching:NO];
                [self displayEmptyWarning];
            });
            return;
        }
                
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        for (TSNGalaxy *gal in self.galaxies) {
            dispatch_async(queue,  ^{
                UIImage *i = [UIImage imageWithData:[NSData dataWithContentsOfURL:gal.thumbnailUrl]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    gal.thumbnailImage = i;
                    [self.tableView reloadData];
                    [self indicateFetching:NO];
                });
            });
        }
    });

}

- (void)indicateFetching:(BOOL)fetching{
    if(fetching){
        self.isFetching = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if(HUD == nil){
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
        }
        [HUD show:YES];
    } else {
        self.isFetching = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [HUD hide:YES];
    }
}

- (void)displayFetchError{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"There was a problem fetching galaxy data."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)displayEmptyWarning{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:@"There are no galaxies to enumerate for this user."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"TSNGalaxyDetailSegue"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *ip = [self.tableView indexPathForCell:cell];
        TSNGalaxy *g = [self.galaxies objectAtIndex:ip.row];
        
        TSNGalaxyDetailViewController *vc = (TSNGalaxyDetailViewController *)segue.destinationViewController;
        vc.galaxy = g;
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.galaxies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TSNGalaxy *g = [self.galaxies objectAtIndex:indexPath.row];
    cell.textLabel.text = g.galName;
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    if(g.thumbnailImage == nil){
        cell.imageView.image = [TSNShared sharedInstance].tnPlaceholder;
    } else{
        cell.imageView.image = g.thumbnailImage;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Percent complete: %.2f", g.complete];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
