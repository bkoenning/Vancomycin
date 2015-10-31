//
//  Age.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Age.h"

@interface Age()

@end

@implementation Age

@synthesize age;

-(instancetype)copyWithZone:(NSZone *)zone
{
    Age *ageCopy = [[Age allocWithZone:zone]init];
    [ageCopy setAge:[NSNumber numberWithInt:[[self age]intValue]]];
    return  ageCopy;
}

-(instancetype)initWithInteger:(int)a
{
    self = [super init];
    if (self){
        [self setAge:[NSNumber numberWithInt:a]];
    }
    return self;
}


-(instancetype)init
{
    self = [self initWithInteger:0];
    return  self;
}

-(NSString*)valueAsString
{
    return [NSString stringWithFormat:@"%ld", (long)[[self age]integerValue]];
}

-(NSString*) unitString
{
    return @"years";
}

-(void)dealloc
{
    age = nil;
}

@end
