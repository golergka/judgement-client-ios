//
//  JDGQuestion.h
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDGModel.h"

#define JDGQuestionDidUpdateNotification @"JDGQuestionDidUpdateNotification"

@class JDGAnswer;

@interface JDGQuestion : JDGModel

@property NSString  * text;
@property NSDate    * deadline;
@property BOOL      answered;
@property BOOL      rightAnswer;

@property(readonly) JDGAnswer * myAnswer;

-(void)answerWithValue:(BOOL)value;
-(BOOL)canAnswer;

@end
