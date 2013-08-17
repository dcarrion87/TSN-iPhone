//
//  TSNContactListViewController.h
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface TSNGalaxyListViewController : UITableViewController{
    
     MBProgressHUD *HUD;
}

@property(strong) NSMutableArray *galaxies;
@property BOOL isFetching;
@property BOOL isFirstFetch;

-(void)fetchGalaxies;

@end
