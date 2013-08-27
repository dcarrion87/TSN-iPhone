//
//  TSNPerson.h
//  TSN
//
//  Created by Daniel Carrion on 12/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNGalaxy : NSObject

@property(strong)NSString *galId;
@property(strong)NSString *galName;
@property double redshift;
@property double ra;
@property double dec;
@property double complete;
@property(strong)NSURL *thumbnailUrl;
@property(strong)UIImage *thumbnailImage;
@property(strong)NSMutableArray *filterImages;
@property(strong)NSMutableArray *filterLabels;
@property(strong)NSURL *nedUrl;


          
-(id)initWithGalId:(NSString *)galId galName:(NSString*)galName;

@end
