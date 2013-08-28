//
//  TSNShared.h
//  TSN
//
//  Created by Daniel Carrion on 14/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//
// This is our singleton for the app containing
// shared data.

#import <Foundation/Foundation.h>

@interface TSNShared : NSObject

@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) UIImage *tnPlaceholder;
@property (nonatomic, retain) UIImage *imgPlaceholder;
@property (nonatomic, retain) UIImage *background;

+ (TSNShared*)sharedInstance;

// Methods for clearing, setting and getting user id from keychain.
- (void) setUserId: (NSString*) userId;
- (NSString*) getUserId;
- (void) clearUserId;

@end