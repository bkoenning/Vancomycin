//
//  FlowRate.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/30/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Volume.h"
#import "Time.h"

@interface FlowRate : NSObject <NSCopying>

@property Volume *volume;
@property Time *time;

-(instancetype)initWithVolume: (Volume*)vol andTime:(Time*)t;
-(instancetype)copyWithZone:(NSZone *)zone;
-(FlowRate*)reduced;
-(Volume*)withTime: (Time*)t;
-(Time*)withVolume: (Volume*)v;
-(FlowRate*)inTimeUnit: (TimeUnit)u;
-(FlowRate*)inVolumeUnit: (VolumeUnit)u;
-(FlowRate*)inVolumeUnit:(VolumeUnit)vu andTimeUnit: (TimeUnit)tu;
-(int)compareTo: (FlowRate*)fr;
-(BOOL)isInRangeLower: (FlowRate*)lower upper:(FlowRate*)upper;

@end
