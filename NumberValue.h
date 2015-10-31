//
//  NumberValue.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef _NumberValue_h
#define _NumberValue_h

@protocol NumberValue

@required
-(NSString*) valueAsString;
-(NSString*) unitString;

@end


#endif
