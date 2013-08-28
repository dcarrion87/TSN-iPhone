//
//  TSNGalaxyNEDViewController.m
//  TSN
//
//  Created by Daniel Carrion on 27/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxyWebViewController.h"

@interface TSNGalaxyWebViewController ()

@end

@implementation TSNGalaxyWebViewController

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
    
    // Load the NED page for galaxy
    [self.nedPage loadRequest:[NSURLRequest requestWithURL:self.galaxy.nedUrl]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
