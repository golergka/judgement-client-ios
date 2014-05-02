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
        NSString    *textString;
        NSString    *dateString;
        id          answeredObject;
        id          rightAnswerObject;
        
        if (json == nil)
        { goto fail; }
        
        textString          = [json objectForKey:@"text"];
        dateString          = [json objectForKey:@"deadline"];
        answeredObject      = [json objectForKey:@"answered"];
        rightAnswerObject   = [json objectForKey:@"rightAnswer"];
        
        if (textString          == nil ||
            dateString          == nil ||
            answeredObject      == nil ||
            rightAnswerObject   == nil)
        { goto fail; }
        
        self.text           = textString;
        self.deadline       = [[JDGModel jsonDateFormatter] dateFromString:dateString];
        self.answered       = [answeredObject boolValue];
        self.rightAnswer    = [rightAnswerObject boolValue];
        
        [self refresh];
        
        if(false)
        {
        fail:
            self = nil;
        }
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
     failCallback:^(void) {
         [self refresh];
     }
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
