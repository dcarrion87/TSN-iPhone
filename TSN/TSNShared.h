//
//  TSNShared.h
//  TSN
//
//  Created by Daniel Carrion on 14/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNShared : NSObject
{
    NSString *userId;
    BOOL isAuthenticated;
}

@property (nonatomic, retain) NSString *userId;
@property BOOL isAuthenticated;

+ (TSNShared*)sharedInstance;

@end