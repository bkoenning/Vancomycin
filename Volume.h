//
//  Volume.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"

typedef enum
{
    L = 1,
    DL = 10,
    ML = 1000
}VolumeUnit;


@interface Volume : NSObject <NumberValue, NSCopying>

@property  (nonatomic) NSNumber *volume;
@property (nonatomic) VolumeUnit unit;

-(instancetype) initWithFloat: (float) vol andUnits: (VolumeUnit) un;
-(NSString*) unitString;
-(Volume*)convertedToVolumeUnit:(VolumeUnit)vu;
-(instancetype)copyWithZone:(NSZone *)zone;
-(int)compareTo: (Volume*)v;
-(BOOL)isInRangeLower: (Volume*)lower upper:(Volume*)upper;


@end
