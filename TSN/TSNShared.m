//
//  TSNShared.m
//  TSN
//
//  Created by Daniel Carrion on 14/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNShared.h"
#import "TSNLoginViewController.h"
#import "KeychainItemWrapper.h"

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
        self.baseURL = @"http://production-test.theskynet.org";
        self.imgPlaceholder = [UIImage imageNamed:@"imgPlaceholder.png"];
        self.tnPlaceholder = [UIImage imageNamed:@"tnPlaceholder.png"];
        self.background= [UIImage imageNamed:@"background.png"];
    }
    return self;
}


- (void) setUserId: (NSString*) userId {
    [self clearUserId];
    KeychainItemWrapper *k = [[KeychainItemWrapper alloc]initWithIdentifier:@"LoginData" accessGroup:nil];
    [k setObject:userId forKey:(__bridge id)kSecAttrAccount];
}

- (NSString*) getUserId{
    KeychainItemWrapper *k = [[KeychainItemWrapper alloc]initWithIdentifier:@"LoginData" accessGroup:nil];
    return [k objectForKey:(__bridge id)kSecAttrAccount];
}

- (void) clearUserId{
    KeychainItemWrapper *k = [[KeychainItemWrapper alloc]initWithIdentifier:@"LoginData" accessGroup:nil];
    [k resetKeychainItem];
}

@end