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
-(FlowRate*)perTimeUnit: (TimeUnit)u;

@end
