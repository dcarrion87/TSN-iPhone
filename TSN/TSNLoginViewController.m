//
//  TSNLoginViewController.m
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNLoginViewController.h"
#import "TSNGalaxyListViewController.h"
#import "TSNShared.h"

@interface TSNLoginViewController ()

@end

@implementation TSNLoginViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

-(IBAction)loginButton:(id)sender{

    TSNShared *si = [TSNShared sharedInstance];
    if([self.idTextField.text length] > 0){
        [si setUserId:self.idTextField.text];
        [si setIsAuthenticated:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
