//
//  Weight.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"



typedef enum
{
    KG,
    LB
}WeightUnit;


@interface Weight : NSObject <NumberValue, NSCopying>

@property (nonatomic) NSNumber* weight;
@property (nonatomic) WeightUnit units;

-(instancetype) initWithFloat: (float)weight unit: (WeightUnit) units;
-(NSString*) unitString;
-(void) convertTo: (WeightUnit) wu;
-(NSNumber*) getValueAs:(WeightUnit) wu;
-(Weight*) getWeightAs:(WeightUnit)wu;
-(instancetype)copyWithZone:(NSZone *)zone;

@end
