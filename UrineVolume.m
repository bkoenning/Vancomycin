//
//  UrineVolume.m
//  Vancomycin
//
//  Created by Brandon Koenning on 11/4/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "UrineVolume.h"

@implementation UrineVolume

+(UrineVolume*)minDaily
{
    return [[UrineVolume alloc]initWithFloat:600 andUnits:ML];
}
+(UrineVolume*)maxDaily
{
    return [[UrineVolume alloc]initWithFloat:8000 andUnits:ML];
}

-(UrineVolume*)converted:(VolumeUnit)vu
{
    //Volume *rawVol = [self converted:vu];
    Volume *rawVol = [super convertedToVolumeUnit:vu];
    
    return  [[UrineVolume alloc]initWithFloat:[[rawVol volume]floatValue] andUnits:vu];
}

+(BOOL)regexForDailyUrineVolumeInML:(NSString *)v
{
    NSRegularExpression *wholeWithOptionalDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{3,4}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeWithOptionalDecimalPointMatch = [wholeWithOptionalDecimalPoint firstMatchInString:v options:0 range:NSMakeRange(0, [v length])];
    
    NSRegularExpression *wholeWithOptional2DecimalPlaces = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{3,4})(\\.\\d{1,2})?$"options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeWithOptional2DecimalPlacesMatch = [wholeWithOptional2DecimalPlaces firstMatchInString:v options:0 range:NSMakeRange(0, [v length])];
    
    return  wholeWithOptional2DecimalPlacesMatch || wholeWithOptionalDecimalPointMatch;
}
+(BOOL)regexForDailyUrineVolumeInL:(NSString *)v
{
    NSRegularExpression *decimalNumberWithNoLeading = [NSRegularExpression regularExpressionWithPattern:@"^(\\.\\d{1,5})$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *decimalNumberWithNoLeadingMatch = [decimalNumberWithNoLeading firstMatchInString:v options:0 range:NSMakeRange(0, [v length])];
    
    NSRegularExpression *wholeWithOptionalDecimal = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1})(\\.\\d{1,5})?$"options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeWithOptionalDecimalMatch = [wholeWithOptionalDecimal firstMatchInString:v options:0 range:NSMakeRange(0, [v length])];
    
    NSRegularExpression *wholeWithDecimalPoint = [NSRegularExpression regularExpressionWithPattern:@"^(\\d{1}\\.?)$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *wholeWithDecimalPointMatch = [wholeWithDecimalPoint firstMatchInString:v options:0 range:NSMakeRange(0, [v length])];
    
    return  decimalNumberWithNoLeadingMatch || wholeWithDecimalPointMatch || wholeWithOptionalDecimalMatch;
    
}





@end
