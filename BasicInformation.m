//
//  BasicInformation.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "BasicInformation.h"
#import <UIKit/UIKit.h>

@interface BasicInformation()
@end


@implementation BasicInformation

@synthesize weight, height,gender, age,amputations, isSet;

-(instancetype)init
{
    self = [super initWithTitle:@"Basic Information"];
    [self setGender:[[Gender alloc]init]];
    [self setWeight:[[Weight alloc]init]];
    [self setHeight:[[Height alloc]init]];
    [self setAge:[[Age alloc]init]];
    [self setAmputations:[[Amputations alloc]init]];
    [self setIsSet:NO];
    return self;
}


-(instancetype)initWithWeight:(Weight *)w height:(Height *)h gender:(Gender *)g amputations:(Amputations *)amp age:(Age *)a
{
    self = [ super initWithTitle:@"Basic Information"];
    [self setWeight:[w cop]]
    [self setWeight:w];
    [self setHeight:h];
    [self setGender:g];
    [self setAmputations:amp];
    [self setAge:a];
    [self setIsSet:NO];
    return self;
}


-(NSString*) description
{
    
    NSString *string  = [NSString stringWithFormat:@"Weight:  %@ \rIBW:  %@", [weight description], [[self idealBodyWeight]description]];
    return string;
}



-(void)dealloc
{
    weight = nil;
    height = nil;
    gender = nil;
    age = nil;
    amputations = nil;
}

-(Weight*)idealBodyWeight
{
    float percentLost = 0;
    for (NSString *str in [[[self amputations]amps]allKeys]){
        if ([NSNumber numberWithBool:YES] == [[[self amputations]amps]valueForKey:str]){
            percentLost += [[[[self amputations]percentages] valueForKey:[NSString stringWithFormat:@"%@%@", str, @"_percent"]]floatValue];
        }
    }
    float value = [[[self height] getValueAs:IN]floatValue] - 60;
    value = (( value * 2.3 ) + [[self gender]getIdealBodyWeightStartInKg]);
    value = value * ( 1 - (percentLost / 100.0));
    return [[Weight alloc]initWithFloat:value unit:KG];
}

-(NSString*)tableDescription
{
    NSMutableString *string = [NSMutableString stringWithString:@"Data entered:\n"];
    [string appendString:@"Actual Weight:  "];
    Weight *actualWeight = [[self weight]copy];
    [string appendString: [actualWeight description]];
    if ([actualWeight units] == KG)
        [actualWeight convertTo:LB];
    else
        [actualWeight convertTo:KG];
    [string appendString:@" ("];
    [string appendString:[actualWeight description]];
    [string appendString:@")\n"];
    [string appendString:@"Ideal Body Weight:  "];
    Weight *ibw = [self idealBodyWeight];
    if ([[self weight]units] == KG)
        [ibw convertTo:KG];
    else
        [ibw convertTo:LB];
    [string appendString:[ibw description]];
    if ([ibw units] == KG)
        [ibw convertTo:LB];
    else
        [ibw convertTo:KG];
    [string appendString:@" ("];
    [string appendString:[ibw description]];
    [string appendString:@")\n"];
    Height *heightcopy = [[self height]copy];
    [string appendString:@"Height:  "];
    [string appendString:[heightcopy description]];
    [string appendString:@" ("];
    if ([heightcopy units] == IN)
        [heightcopy convertTo:CM];
    else
        [heightcopy convertTo:IN];
    [string appendString:[heightcopy description]];
    [string appendString:@")\n"];
    if ([[self amputations]hasAmputations]){
        [string appendString:@"Amputations:  "];
        [string appendString:[[self amputations]description]];
    }
    return [NSString stringWithString:string];
}

@end
