//
//  TSNPersonDetailViewController.m
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNPersonDetailViewController.h"

@interface TSNPersonDetailViewController ()

@end

@implementation TSNPersonDetailViewController

@synthesize  fnameLabel,snameLabel,ageLabel,person;

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
    
    self.fnameLabel.text = self.person.fname;
    self.snameLabel.text = self.person.sname;
    self.ageLabel.text = [NSString stringWithFormat:@"%d",self.person.age];
    [self.view setBackgroundColor:self.person.favouriteColour];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
