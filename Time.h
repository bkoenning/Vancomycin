//
//  Time.h
//  Vancomycin
//
//  Created by Brandon Koenning on 11/1/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    SECOND = 1,
    MINUTE = 60,
    HOUR = 3600,
    DAY = 86400
}TimeUnit;


@interface Time : NSObject <NSCopying>

@property NSNumber *time;
@property TimeUnit timeUnit;

-(instancetype)initWithFloat: (float)num andTimeUnit: (TimeUnit)tu;
-(Time*)convertedTo: (TimeUnit)tu;
-(instancetype)copyWithZone:(NSZone *)zone;

@end
