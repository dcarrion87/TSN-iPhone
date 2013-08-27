//
//  TSNLoginViewController.m
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNLoginViewController.h"
#import "TSNGalaxyViewController.h"
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
	// Set vew background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[TSNShared sharedInstance].background];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if([identifier isEqualToString:@"TSNLoginSegue"]){
        TSNShared *si = [TSNShared sharedInstance];
        NSPredicate *idTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?:[1-9]+)"];
        if([idTest evaluateWithObject:self.idTextField.text]){
            [si setUserId:self.idTextField.text];
            self.errorLabel.hidden = YES;
            return YES;
        } else{
            self.errorLabel.hidden = NO;
        }
        
    }
    return NO;
}


@end
