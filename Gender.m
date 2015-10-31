//
//  Gender.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Gender.h"

@implementation Gender

@synthesize gender;

-(instancetype)initWithChar:(char)g
{
    self = [super init];
    if (self){
        [self setGender:g];
    }
    return  self;
}

-(instancetype)init
{
    self = [self initWithChar:'m'];
    return  self;
}

-(NSString*) description
{
    if ([self gender] == 'm') return @"male";
    else return @"female";
}

-(float) getIdealBodyWeightStartInKg
{
    if ([self gender] == 'f')
        return 45.5;
    else return 50;
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    Gender *gcopy = [[Gender allocWithZone:zone]initWithChar:gender];
    return  gcopy;
}






@end
