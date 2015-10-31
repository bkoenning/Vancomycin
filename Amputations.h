//
//  Amputations.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Amputations : NSObject <NSCopying>

-(instancetype)initWithAmputationBoolValues_left_lower_leg:  (BOOL)LLL
                                            left_upper_leg:  (BOOL)LUL
                                            left_lower_arm:  (BOOL)LLA
                                            left_upper_arm:  (BOOL)LUA
                                           right_lower_leg:  (BOOL)RLL
                                           right_upper_leg:  (BOOL)RUL
                                           right_upper_arm:  (BOOL)RUA
                                           right_lower_arm:  (BOOL)RLA
                             right_upper_leg_checked_first:  (BOOL)RULF
                              left_upper_leg_checked_first:  (BOOL)LULF
                             right_upper_arm_checked_first:  (BOOL)RUAF
                              left_upper_arm_checked_first:  (BOOL)LUAF;


@property (nonatomic) NSMutableDictionary *amps;
@property (nonatomic) NSMutableDictionary *percentages;
@property (nonatomic) NSMutableDictionary *checkOrder;

-(BOOL) hasAmputations;

-(float) percentLoss;
-(instancetype)copyWithZone:(NSZone *)zone;



@end
