//
//  JDGQuestionPageFactory.h
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDGPageFactory.h"
#import "JDGQuestion.h"

@interface JDGQuestionPageFactory : JDGPageFactory

-(id)initWithQuestion:(JDGQuestion *)question;
-(id)initWithQuestion:(JDGQuestion *)question
                 hint:(NSString*)hint;

@end
