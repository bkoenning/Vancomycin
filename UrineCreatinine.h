//
//  UrineCreatinine.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CreatinineConcentration.h"
//#import "NumberValue.h"



//typedef enum
//{
  //  MILLIGRAMS_PER_DECILITER,
    //MICRO_MOLES_PER_LITER
    
//}UrineCreatinineConcentrationUnit;

@interface UrineCreatinine :  CreatinineConcentration


+(BOOL)regexForUrineCreatinineConcentrationInMgDL: (NSString*)ucr;
+(BOOL)regexForUrineCreatinineConcentrationInMicromolL:(NSString *)ucr;


+(Creatinine*)maxDailyExcretion;
+(Creatinine*)minDailyExcretion;
-(Creatinine*)creatinineExcreted: (Volume*)v;


//@property (nonatomic) NSNumber *value;
//@property (nonatomic) UrineCreatinineConcentrationUnit units;

//-(instancetype) initWithFloat: (float)val andUnits: (UrineCreatinineConcentrationUnit) un;
//-(void)convertTo: (UrineCreatinineConcentrationUnit) un;


@end
