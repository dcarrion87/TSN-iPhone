//
//  TSNGalaxyNEDViewController.h
//  TSN
//
//  Created by Daniel Carrion on 27/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSNGalaxy.h"

@interface TSNGalaxyNEDViewController : UIViewController

@property(weak) IBOutlet UIWebView *nedPage;
@property(strong) TSNGalaxy *galaxy;

@end
