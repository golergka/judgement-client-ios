//
//  JDGAnswer.h
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDGModel.h"
#import "JDGQuestion.h"
#import "JDGValidatedUser.h"

@interface JDGAnswer : JDGModel

@property BOOL value;

@property(weak) JDGQuestion *question;
@property(weak) JDGValidatedUser     *user;

@end
