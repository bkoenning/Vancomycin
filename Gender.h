//
//  Gender.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gender : NSObject <NSCopying>

@property char gender;

-(instancetype)initWithChar:(char) g;
-(float) getIdealBodyWeightStartInKg;
-(instancetype)copyWithZone:(NSZone *)zone;




@end
