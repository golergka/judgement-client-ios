//
//  JDGPageFactory.h
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDGPageViewController.h"

@interface JDGPageFactory : NSObject

-(JDGPageViewController *)createPage;
-(BOOL)tryUpdateWithFactory:(JDGPageFactory *)factory;

@end
