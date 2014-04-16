//
//  JDGQuestion.h
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDGModel.h"

@class JDGAnswer;

@interface JDGQuestion : JDGModel

@property NSString * text;
@property NSDate * date;

@property JDGAnswer * myAnswer;

@end
