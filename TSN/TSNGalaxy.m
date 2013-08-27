//
//  TSNPerson.m
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNGalaxy.h"

@implementation TSNGalaxy

-(id)initWithGalId:(NSString *)galId galName:(NSString*)galName{
    self=[super init];
    if(self){
        self.galId=galId;
        self.galName=galName;
        self.redshift=0;
        self.ra=0;
        self.dec=0;
        self.complete=0;
        self.thumbnailUrl=nil;
        self.thumbnailImage=nil;
        
        self.filterImages = [[NSMutableArray alloc] init];
        self.filterLabels = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
