//
//  TSNShared.m
//  TSN
//
//  Created by Daniel Carrion on 14/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNShared.h"
#import "TSNLoginViewController.h"

@implementation TSNShared

@synthesize userId,isAuthenticated;

+ (TSNShared*)sharedInstance
{
    static TSNShared *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TSNShared alloc] init];
    });
    return sharedInstance;

}

- (id)init
{
    self = [super init];
    if ( self )
    {
        userId = [[NSString alloc] init];
        isAuthenticated = NO;
        
    }
    return self;
}


@end