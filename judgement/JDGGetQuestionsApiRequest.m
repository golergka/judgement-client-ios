//
//  JDGGetQuestionsApiRequest.m
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGGetQuestionsApiRequest.h"
#import "JDGQuestion.h"

@implementation JDGGetQuestionsApiRequest
{
    NSURLConnection         *_connection;
    getQuestionsCallback    _onSuccess;
}

-(id)initWithApiClient:(JDGApiClient *)client
       successCallback:(getQuestionsCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client
                           failCallback:onFail])
    {
        NSURL *url = [client urlForParams:@{@"method": @"getQuestions"}];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request
                                                     delegate:self];
        _onSuccess = onSuccess;
    }
    return self;
}

-(void)processContent:(id)content
{
    NSArray *questionsJsonArray = (NSArray*)content;
#ifdef DEBUG
    NSLog(@"Questions: %@", questionsJsonArray);
#endif
    NSMutableArray *questionsArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < questionsJsonArray.count; i++)
    {
        [questionsArray addObject:[JDGQuestion questionFromJson:questionsJsonArray[i]]];
    }
    _onSuccess(questionsArray);
    [self.apiClient completeRequest:self];
}

@end
