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
#import "JDGUser.h"

@implementation JDGQuestion
@synthesize text, date, myAnswer;

-(id) initWithJson:(NSDictionary *)json
{
    if (self = [super init])
    {
        self.text = [json objectForKey:@"text"];
        NSString *dateString = [json objectForKey:@"date"];
        self.date = [[JDGModel jsonDateFormatter] dateFromString:dateString];
        [[JDGApiClient sharedClient] getAnswerWithUser:[JDGUser thisUser]
                                              question:self
                                       successCallback:^(JDGAnswer *answer) {
                                           self.myAnswer = answer;
                                       }
                                          failCallback:nil
         ];
    }
    return self;
}

@end
