//
//  Age.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"


@interface Age : NSObject <NumberValue, NSCopying>

@property (nonatomic) NSNumber *age;

-(instancetype)initWithInteger:(int)a;
-(instancetype)copyWithZone:(NSZone *)zone;

@end

