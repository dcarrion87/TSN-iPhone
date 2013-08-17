//
//  TSNPerson.h
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNPerson : NSObject

@property(strong)NSString *fname;
@property(strong)NSString *sname;
@property(strong)UIColor *favouriteColour;
@property int age;

-(id)initWithFname:(NSString *)aFname sname:(NSString*)aSname colour:(UIColor *)col age:(int)aAge;

@end
