//
//  TSNPersonDetailViewController.m
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxyDetailViewController.h"

@interface TSNGalaxyDetailViewController ()

@end

@implementation TSNGalaxyDetailViewController

@synthesize  nameLabel,redshiftLabel,raLabel,decLabel,galaxy;

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
    
    self.navigationItem.title = self.galaxy.name;
    self.redshiftLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.redshift];
    self.raLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.ra];
    self.decLabel.text = [NSString stringWithFormat:@"%.3f",self.galaxy.dec];
    self.imageView.image = self.galaxy.thumbnailImage;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
