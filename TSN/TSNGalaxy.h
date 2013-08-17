//
//  TSNPerson.h
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNGalaxy : NSObject

@property(strong)NSString *name;
@property double redshift;
@property double ra;
@property double dec;
@property double complete;
@property(strong)NSURL *thumbnailUrl;
@property(strong)UIImage *thumbnailImage;
          
-(id)initWithName:(NSString *)aName
         redshift:(double)aRedshift
               ra:(double)aRa
              dec:(double)aDec
         complete:(double)aComplete
        thumbnailUrl:(NSURL *)aThumbnailUrl;

@end
