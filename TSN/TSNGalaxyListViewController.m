//
//  TSNContactListViewController.m
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxyListViewController.h"
#import "TSNGalaxy.h"
#import "TSNGalaxyDetailViewController.h"
#import "TSNLoginViewController.h"
#import "TSNShared.h"
#import "MBProgressHUD.h"


@interface TSNGalaxyListViewController ()

@end

@implementation TSNGalaxyListViewController

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
    
    TSNShared *si = [TSNShared sharedInstance];
    if(si.isAuthenticated == YES){
        if(self.isFirstFetch){
            [self fetchGalaxies];
            self.isFirstFetch = NO;
        }
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TSNLoginViewController * vc = [sb instantiateViewControllerWithIdentifier:@"TSNLoginViewController"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.galaxies = [[NSMutableArray alloc] init];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [self.refreshControl addTarget:self action:@selector(refreshGalaxies:) forControlEvents:UIControlEventValueChanged];
    self.isFirstFetch = YES;
}

- (IBAction)refreshGalaxies:(id)sender
{
    [self fetchGalaxies];
    [self.refreshControl endRefreshing];
}

- (void)fetchGalaxies
{
    if(self.isFetching){
        return;
    }
    
    self.isFetching = YES;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [HUD show:YES];
    dispatch_async(queue,  ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:
                                        [NSString stringWithFormat:@"http://production-test.theskynet.org/boinc/%@/galaxies.json?per_page=10",[TSNShared sharedInstance].userId]]];
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSArray *gals = [json valueForKeyPath:@"result.galaxies.galaxy"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.galaxies removeAllObjects];
        });
        for (NSDictionary *gal in gals) {
            TSNGalaxy *g = [[TSNGalaxy alloc]initWithName:[gal objectForKey:@"name"]
                                                 redshift:[[gal objectForKey:@"redshift"] doubleValue]
                                                       ra:[[gal objectForKey:@"ra_cent"] doubleValue]
                                                      dec:[[gal objectForKey:@"dec_cent"] doubleValue]
                                                 complete:[[gal objectForKey:@"percentage_complete"] doubleValue]
                                            thumbnailUrl:[NSURL URLWithString:[gal objectForKey:@"thumbnail_url"]]
                            ];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.galaxies addObject:g];
                
            });
            
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [HUD hide:YES];
        });
        
        for (TSNGalaxy *gal in self.galaxies) {
            dispatch_async(queue,  ^{
                UIImage *i = [UIImage imageWithData:[NSData dataWithContentsOfURL:gal.thumbnailUrl]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    gal.thumbnailImage = i;
                    [self.tableView reloadData];
                });
            });
        }
                           
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.isFetching = NO;
        });
    });

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
    cell.textLabel.text = g.name;
    if(g.thumbnailImage == nil){
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
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
