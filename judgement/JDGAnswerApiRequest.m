//
//  JDGAnswerApiRequest.m
//  judgement
//
//  Created by Max Yankov on 17.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGAnswerApiRequest.h"

@implementation JDGAnswerApiRequest
{
    NSURLConnection*    _connection;
    answerCallback      _onSuccess;
}

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
              question:(JDGQuestion *)question
           answerValue:(BOOL)answerValue
       successCallback:(answerCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client failCallback:onFail])
    {
        NSDictionary *params = @{
            @"method"       : @"answer",
            @"questionId"   : [NSNumber numberWithInt:question.uid],
            @"vendorIdHash" : [user vendorIdHash],
            @"answer"       : @(answerValue)
        };
        NSURL *url = [client urlForParams:params];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        _onSuccess = onSuccess;
    }
    return self;
}

-(void)processContent:(id)content
{
    _onSuccess();
    [self.apiClient completeRequest:self];
}

@end
