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
        self.userId = [[NSString alloc] init];
        self.baseURL = @"http://production-test.theskynet.org";
        self.imgPlaceholder = [UIImage imageNamed:@"imgPlaceholder.png"];
        self.tnPlaceholder = [UIImage imageNamed:@"tnPlaceholder.png"];
        self.background= [UIImage imageNamed:@"background.png"];
    }
    return self;
}

- (void) clear{
    self.userId = nil;
}


@end