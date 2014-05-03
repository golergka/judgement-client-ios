//
//  JDGAddQuestionApiRequest.m
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGAddQuestionApiRequest.h"

@implementation JDGAddQuestionApiRequest
{
    NSURLConnection         *_connection;
    addQuestionCallback     _onSuccess;
    requestFailCallback     _onFail;
}

-(id)initWithApiClient:(JDGApiClient *)client
                  text:(NSString *)questionText
              deadline:(NSDate *)questionDate
       successCallback:(addQuestionCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client failCallback:onFail])
    {
        NSDictionary *params = @{
            @"method": @"addQuestion",
            @"questionText": questionText,
            @"questionDeadline":questionDate
        };
        NSURL *url = [client urlForParams:params];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];
        _onSuccess = onSuccess;
        _onFail = onFail;
    }
    return self;
}

-(void)processContent:(id)content
{
    JDGQuestion *result = [[JDGQuestion alloc] initWithJson:content];
    if (result != nil)
    {
        _onSuccess(result);
    }
    else
    {
        _onFail();
    }
    [self.apiClient completeRequest:self];
}

@end
