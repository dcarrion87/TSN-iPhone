//
//  TSNPerson.m
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import "TSNPerson.h"

@implementation TSNPerson

@synthesize fname,sname,favouriteColour,age;


-(id)initWithFname:(NSString *)aFname sname:(NSString*)aSname colour:(UIColor *)col age:(int)aAge{
    self=[super init];
    if(self){
        self.fname=aFname;
        self.sname=aSname;
        self.age=aAge;
        self.favouriteColour=col;
    }
    return self;
}

@end
