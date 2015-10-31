//
//  _24HourUrineCollection.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "_24HourUrineCollection.h"

@implementation _24HourUrineCollection

-(instancetype)init
{
    self = [super initWithTitle:@"24 Hour Urine Collection"];
    //[self setUrineCr:[[UrineCreatinine alloc]initWithFloat:0 andUnits:MILLIGRAMS_PER_DECILITER]];
    //[self setSerumCr:[[SerumCreatinine alloc]initWithFloat:0 andUnits:MG_PER_DECILITER]];
    [self setUrineCr:[[UrineCreatinine alloc]init]];
    [self setSerumCr:[[SerumCreatinine alloc]init]];
    [self setUrineVolume:[[Volume alloc]initWithFloat:0 andUnits:L]];
    [self setIsSet:NO];
    return  self;
}

-(NSString*)tableDescription
{
    NSMutableString *string = [NSMutableString stringWithString:@"Data entered:\n"];
    [string appendString:@"Serum creatinine:  "];
    if (![self serumCr]){
        [string appendString:@"null"];
    }
    [string appendString:[[self serumCr]description]];
    [string appendString:@"\nUrine creatinine:  "];
    [string appendString:[[self urineCr]description]];
    [string appendString:@"\nUrine Volume:  "];
    [string appendString:[[self urineVolume]description]];
    return [NSString stringWithString:string];
}


-(Creatinine*)creatinineExcreted
{
   // if ([[[self urineCr]mol]returnAsMolar]){
     //   return [[Creatinine alloc]initWithMolarFloat:[[[self urineCr]]] molarUnit:<#(MolarUnit)#>]
    //}
    
    Molecule *cr  = [[self urineCr]getAmountPerVolume:[self urineVolume]];
    Creatinine *CREA = [[self urineCr]getAmountPerVolume:<#(Volume *)#>]
    return  cr;
    
}

@end
