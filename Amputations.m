//
//  Amputations.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Amputations.h"

@interface Amputations()


@end

@implementation Amputations

@synthesize amps, percentages, checkOrder;

-(instancetype)copyWithZone:(NSZone *)zone
{
    NSNumber *test = [NSNumber numberWithBool:YES];
    BOOL LUL = ([[self amps]objectForKey:@"left_upper_leg"] == test);
    BOOL LLL = ([[self amps]objectForKey:@"left_lower_leg"] == test);
    BOOL LUA = ([[self amps]objectForKey:@"left_upper_arm"] == test);
    BOOL LLA = ([[self amps]objectForKey:@"left_lower_arm"] == test);
    BOOL RLA = ([[self amps]objectForKey:@"right_lower_arm"] == test);
    BOOL RUA = ([[self amps]objectForKey:@"right_upper_arm"] ==test);
    BOOL RUL = ([[self amps]objectForKey:@"right_upper_leg"] == test);
    BOOL RLL = ([[self amps]objectForKey:@"right_lower_leg"] == test);
    
    BOOL RULF = ([[self amps]objectForKey:@"right_upper_leg_checked_first"] == test);
    BOOL LULF = ([[self amps]objectForKey:@"left_upper_leg_checked_first"] == test);
    BOOL LUAF = ([[self amps]objectForKey:@"left_upper_arm_checked_first"] ==test);
    BOOL RUAF = ([[self amps] objectForKey:@"right_upper_arm_checked_first"] == test);
    
    Amputations *ampCopy = [[Amputations allocWithZone:zone]initWithAmputationBoolValues_left_lower_leg:LLL left_upper_leg:LUL left_lower_arm:LLA left_upper_arm:LUA right_lower_leg:RLL right_upper_leg:RUL right_upper_arm:RUA right_lower_arm:RLA right_upper_leg_checked_first:RULF left_upper_leg_checked_first:LULF right_upper_arm_checked_first:RUAF left_upper_arm_checked_first:LUAF];
    
    return ampCopy;
    
}


-(instancetype)init
{
    self = [self initWithAmputationBoolValues_left_lower_leg:NO left_upper_leg:NO left_lower_arm:NO left_upper_arm:NO right_lower_leg:NO right_upper_leg:NO right_upper_arm:NO right_lower_arm:NO right_upper_leg_checked_first:NO left_upper_leg_checked_first:NO right_upper_arm_checked_first:NO left_upper_arm_checked_first:NO];
    return  self;
}


-(instancetype)initWithAmputationBoolValues_left_lower_leg:(BOOL)LLL left_upper_leg:(BOOL)LUL left_lower_arm:(BOOL)LLA left_upper_arm:(BOOL)LUA right_lower_leg:(BOOL)RLL right_upper_leg:(BOOL)RUL right_upper_arm:(BOOL)RUA right_lower_arm:(BOOL)RLA right_upper_leg_checked_first:(BOOL)RULF left_upper_leg_checked_first:(BOOL)LULF right_upper_arm_checked_first:(BOOL)RUAF left_upper_arm_checked_first:(BOOL)LUAF
{
    self = [super init];
    
    [self setAmps:[NSMutableDictionary dictionary]];
    
    [[self amps]setObject:[NSNumber numberWithBool:LLA] forKey:@"left_lower_arm"];
    [[self amps]setObject:[NSNumber numberWithBool:LUA] forKey:@"left_upper_arm"];
    [[self amps]setObject:[NSNumber numberWithBool:RLA] forKey:@"right_lower_arm"];
    [[self amps]setObject:[NSNumber numberWithBool:RUA] forKey:@"right_upper_arm"];
    [[self amps]setObject:[NSNumber numberWithBool:RLL] forKey:@"right_lower_leg"];
    [[self amps]setObject:[NSNumber numberWithBool:RUL] forKey:@"right_upper_leg"];
    [[self amps]setObject:[NSNumber numberWithBool:LLL] forKey:@"left_lower_leg"];
    [[self amps]setObject:[NSNumber numberWithBool:LUL] forKey:@"left_upper_leg"];
    
    [self setCheckOrder:[NSMutableDictionary dictionary]];
    
    [[self checkOrder]setObject:[NSNumber numberWithBool:LUAF] forKey:@"left_upper_arm_checked_first"];
    [[self checkOrder]setObject:[NSNumber numberWithBool:RUAF] forKey:@"right_upper_arm_checked_first"];
    [[self checkOrder]setObject:[NSNumber numberWithBool:RULF] forKey:@"right_upper_leg_checked_first"];
    [[self checkOrder]setObject:[NSNumber numberWithBool:LULF] forKey:@"left_upper_leg_checked_first"];
    
    
    [self setPercentages:[NSMutableDictionary dictionary]];
    
    [[self percentages]setObject:[NSNumber numberWithFloat: 2.3] forKey:@"left_lower_arm_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 2.3] forKey:@"right_lower_arm_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 5.9] forKey:@"right_lower_leg_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 5.9] forKey:@"left_lower_leg_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 10.1] forKey:@"right_upper_leg_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 10.1] forKey:@"left_upper_leg_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 2.7] forKey:@"right_upper_arm_percent"];
    [[self percentages]setObject:[NSNumber numberWithFloat: 2.7] forKey:@"left_upper_arm_percent"];
    return self;
}

-(void)dealloc
{
    [self setAmps:nil];
    [self setPercentages:nil];
    
}

-(BOOL)hasAmputations
{
    NSArray *array = [[self amps]allValues];
    
    for (NSObject *obj in array){
        if (obj == [NSNumber numberWithBool:YES]){
            return true;
        }
    }
    return false;
}

-(float)percentLoss
{
    NSArray *keys = [[self amps]allKeys];
    float lost = 0;
    
    for (NSString *str in keys){
        if ([[self amps]valueForKey:str] == [NSNumber numberWithBool:YES]){
            lost += [[[self percentages] valueForKey:[NSString stringWithFormat:@"%@%@", str, @"_percent"]]floatValue];
        }
        
    }
    return lost;
}

-(NSString*)description
{
    BOOL firstAmpuation = NO;
    if (![self hasAmputations]){
        return @"None";
    }
    else{
        NSMutableString *str = [[NSMutableString alloc]init];
        if ([[self amps]valueForKey:@"left_upper_arm"] == [NSNumber numberWithBool:YES]){
            [str appendString:@"Left arm"];
            float val = [[[self percentages]valueForKey:@"left_lower_arm_percent"]floatValue];
            val += [[[self percentages]valueForKey:@"left_upper_arm_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        else if ([[self amps]valueForKey:@"left_lower_arm"] == [NSNumber numberWithBool:YES]){
            [str appendString:@"Left lower arm"];
            float val = [[[self percentages]valueForKey:@"left_lower_arm_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        if ([[self amps]valueForKey:@"right_upper_arm"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Right arm"];
            float val = [[[self percentages]valueForKey:@"right_lower_arm_percent"]floatValue];
            val += [[[self percentages]valueForKey:@"right_upper_arm_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        else if ([[self amps]valueForKey:@"right_lower_arm"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Right lower arm"];
            float val = [[[self percentages]valueForKey:@"right_lower_arm_percent"]floatValue];
            [str appendString:@"("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        if ([[self amps]valueForKey:@"right_upper_leg"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Right leg"];
            float val = [[[self percentages]valueForKey:@"right_upper_leg_percent"]floatValue];
            val += [[[self percentages]valueForKey:@"right_lower_leg_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        else if ([[self amps]valueForKey:@"right_lower_leg"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Right lower leg"];
            float val = [[[self percentages]valueForKey:@"right_lower_leg_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        if ([[self amps]valueForKey:@"left_upper_leg"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Left leg"];
            float val = [[[self percentages]valueForKey:@"left_lower_leg_percent"]floatValue];
            val += [[[self percentages]valueForKey:@"left_upper_leg_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        else if ([[self amps]valueForKey:@"left_lower_leg"] == [NSNumber numberWithBool:YES]){
            if (firstAmpuation){
                [str appendString:@", "];
            }
            [str appendString:@"Left lower leg"];
            float val = [[[self percentages]valueForKey:@"left_lower_leg_percent"]floatValue];
            [str appendString:@" ("];
            [str appendString:[NSString stringWithFormat:@"%g", val]];
            [str appendString:@"%)"];
            firstAmpuation = YES;
        }
        return  str;
    }
}

@end