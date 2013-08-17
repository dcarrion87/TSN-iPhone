//
//  TSNPerson.m
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxy.h"

@implementation TSNGalaxy

//@synthesize name,redshift,ra,dec,thumbnailUrl,thumbnailImage;


-(id)initWithName:(NSString *)aName
         redshift:(double)aRedshift
               ra:(double)aRa
              dec:(double)aDec
         complete:(double)aComplete
     thumbnailUrl:(NSURL *)aThumbnailUrl{
    self=[super init];
    if(self){
        self.name=aName;
        self.redshift=aRedshift;
        self.ra=aRa;
        self.dec=aDec;
        self.complete=aComplete;
        self.thumbnailUrl=aThumbnailUrl;
    }
    return self;
}

@end
