//
//  JDGPageFactory.m
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGPageFactory.h"

@implementation JDGPageFactory

-(JDGPageViewController *)createPage
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(BOOL)tryUpdateWithFactory:(JDGPageFactory *)factory
{
    return NO;
}

@end
