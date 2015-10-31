//
//  TableItem.m
//  Vancomycin
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"


@interface TableItem()

@end

@implementation TableItem

@synthesize tableHeader, isSet;

-(id)init
{
    self = [super init];
    [self setTableHeader:@""];
    [self setIsSet:NO];
    return self;
}

-(instancetype) initWithTitle:(NSString *)title
{
    self = [super init];
    [self setTableHeader:title];
    [self setIsSet:NO];
    return self;
}

-(NSString*)tableDescription
{
    return [self tableHeader];
}


- (void)postDidChangeNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kTableItemChanged
                                                        object:self];
}

-(void)dealloc
{
    tableHeader = nil;
}

@end
