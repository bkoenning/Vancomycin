//
//  TableItem.h
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//
#import <Foundation/Foundation.h>

#define kTableItemChanged    @"TableItemChange"

@interface TableItem : NSObject

@property (nonatomic) NSString *tableHeader;
@property BOOL isSet;

-(id) initWithTitle: (NSString*) title;

-(void)postDidChangeNotification;
-(NSString*) tableDescription;

@end
