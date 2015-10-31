//
//  Height.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"

typedef enum
{
    CM,
    IN
}HeightUnit;


@interface Height : NSObject <NumberValue, NSCopying>

@property (nonatomic) NSNumber* height;
@property (nonatomic) HeightUnit units;

-(instancetype) initWithFloat: (float)height unit: (HeightUnit) units;
-(NSString*) unitString;
-(void) convertTo: (HeightUnit) hu;
-(NSNumber*) getValueAs:(HeightUnit) hu;
-(instancetype)copyWithZone:(NSZone *)zone;

@end
