//
//  JDGQuestion.m
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestion.h"
#import "JDGModel.h"
#import "JDGApiClient.h"
#import "JDGAnswer.h"
#import "JDGValidatedUser.h"

@implementation JDGQuestion
{
    JDGAnswer* _myAnswer;
}
@synthesize text, deadline;

-(id)initWithJson:(NSDictionary *)json
{
    if (self = [super initWithJson:json])
    {
        self.text = [json objectForKey:@"text"];
        NSString *dateString = [json objectForKey:@"deadline"];
        self.deadline = [[JDGModel jsonDateFormatter] dateFromString:dateString];
        [self refresh];
    }
    return self;
}

-(void)refresh
{
    [[JDGApiClient sharedClient]
     getAnswerWithUser:[JDGValidatedUser thisUser]
     question:self
     successCallback:^(JDGAnswer *answer) {
         _myAnswer = answer;
         [[NSNotificationCenter defaultCenter]
          postNotificationName:JDGQuestionDidUpdateNotification
          object:self];
     }
     failCallback:nil
     ];
    
}

-(void)answerWithValue:(BOOL)value
{
    [[JDGApiClient sharedClient]
     answerWithUser:[JDGValidatedUser thisUser]
     question:self
     answerValue:value
     successCallback:^(void) {
         [self refresh];
     }
     failCallback:nil
     ];
}

-(BOOL)canAnswer
{
    return [deadline compare:[NSDate date]] == NSOrderedDescending;
}

-(JDGAnswer*)myAnswer
{
    return _myAnswer;
}

@end
