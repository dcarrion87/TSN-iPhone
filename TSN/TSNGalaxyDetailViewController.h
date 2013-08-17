//
//  TSNPersonDetailViewController.h
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSNGalaxy.h"

@interface TSNGalaxyDetailViewController : UIViewController

@property(weak) IBOutlet UILabel *nameLabel;
@property(weak) IBOutlet UILabel *redshiftLabel;
@property(weak) IBOutlet UILabel *raLabel;
@property(weak) IBOutlet UILabel *decLabel;
@property(weak) IBOutlet UIImageView *imageView;

@property(strong) TSNGalaxy *galaxy;

@end
