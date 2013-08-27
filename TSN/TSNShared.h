//
//  TSNShared.h
//  TSN
//
//  Created by Daniel Carrion on 14/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNShared : NSObject

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) UIImage *tnPlaceholder;
@property (nonatomic, retain) UIImage *imgPlaceholder;
@property (nonatomic, retain) UIImage *background;

+ (TSNShared*)sharedInstance;

@end