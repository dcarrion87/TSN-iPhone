//
//  TSNProfileViewController.m
//  TSN
//
//  Created by Daniel Carrion on 28/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNProfileViewController.h"
#import "TSNShared.h"

@interface TSNProfileViewController ()

@end

@implementation TSNProfileViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.title = [[TSNShared sharedInstance] getUserId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"TSNLogoutSegue"]){
        [[TSNShared sharedInstance] clearUserId];
        NSLog([[TSNShared sharedInstance] getUserId]);
    }
}

@end
