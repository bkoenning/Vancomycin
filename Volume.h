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


@interface Volume : NSObject <NumberValue>

@property  (nonatomic) NSNumber *volume;
@property (nonatomic) VolumeUnit unit;

-(instancetype) initWithFloat: (float) vol andUnits: (VolumeUnit) un;
-(NSString*) unitString;
-(void) convertTo: (VolumeUnit) vu;
//-(NSNumber*) getValueAs:(VolumeUnit) vu;
-(Volume*) getVolumeAs:(VolumeUnit)vu;


@end
