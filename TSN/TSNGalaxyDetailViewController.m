//
//  TSNPersonDetailViewController.m
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxyDetailViewController.h"
#import "TSNGalaxyWebViewController.h"
#import "TSNShared.h"

@interface TSNGalaxyDetailViewController ()

@end

@implementation TSNGalaxyDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[TSNShared sharedInstance].background];
    self.nameLabel.text = self.galaxy.galName;
    self.redshiftLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.redshift];
    self.raLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.ra];
    self.decLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.dec];
    self.imageIndex = 0;
    [self updateImageViews];
    [self fetchImageData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showPriorImage
{
    self.imageIndex--;
    [self updateImageViews];
}

- (IBAction)showNextImage
{
    self.imageIndex++;
    [self updateImageViews];
}

- (void)updateImageViews{
    
    // If we have filter images downloaded, update corresponding image views.
    if(self.galaxy.filterImages.count > 0){
        self.imageViewL.image = [self.galaxy.filterImages objectAtIndex:(self.imageIndex-1)%(self.galaxy.filterImages.count)];
        self.imageViewC.image = [self.galaxy.filterImages objectAtIndex:self.imageIndex%(self.galaxy.filterImages.count)];
        self.imageViewR.image = [self.galaxy.filterImages objectAtIndex:(self.imageIndex+1)%(self.galaxy.filterImages.count)];
        self.imageLabel.text = [self.galaxy.filterLabels objectAtIndex:self.imageIndex%(self.galaxy.filterLabels.count)];
    // Otherwise load our placeholder images.
    } else {
        self.imageViewC.image = [TSNShared sharedInstance].imgPlaceholder;
        self.imageViewL.image = [TSNShared sharedInstance].imgPlaceholder;
        self.imageViewR.image = [TSNShared sharedInstance].imgPlaceholder;
        self.imageLabel.text = @"";
    }
}

-(void)fetchImageData{
    if(self.galaxy.filterImages.count > 0){
        return;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(queue,  ^{
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                      [NSString stringWithFormat:@"%@/boinc/%@/galaxies/%@.json?locale=en",
                                                       [TSNShared sharedInstance].baseURL,
                                                       [[TSNShared sharedInstance] getUserId],
                                                       self.galaxy.galId]]options:0 error:&error];
        // Return if theres a problem with connection.
        if(error){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
            return;
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *filterImages = [json valueForKeyPath:@"result.galaxy.filter_images"];
        // Loop through filter images and add image/label objects
        for (id filterImage in filterImages) {
            dispatch_async(queue,  ^{
                UIImage *i = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[filterImages objectForKey:filterImage]]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    // Only add if an image exists.
                    if(i != nil){
                        [self.galaxy.filterLabels addObject:filterImage];
                        [self.galaxy.filterImages addObject:i];
                        [self updateImageViews];
                    }
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                });
            });
        }
        
    });
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"TSNGalaxyWebSegue"]){
        TSNGalaxyWebViewController *vc = (TSNGalaxyWebViewController *)segue.destinationViewController;
        vc.galaxy = self.galaxy;
        
    }
}

@end
