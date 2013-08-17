//
//  TSNPersonDetailViewController.h
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSNGalaxy.h"

@interface TSNPersonDetailViewController : UIViewController

@property(weak) IBOutlet UILabel *fnameLabel;
@property(weak) IBOutlet UILabel *snameLabel;
@property(weak) IBOutlet UILabel *ageLabel;

@property(strong) TSNGalaxy *person;

@end
