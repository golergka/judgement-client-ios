//
//  JDGGetAnswerApiRequest.m
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGGetAnswerApiRequest.h"
#import "JDGAnswer.h"

@interface JDGGetAnswerApiRequest()

@property JDGValidatedUser *user;
@property JDGQuestion *question;

@end

@implementation JDGGetAnswerApiRequest
{
    NSURLConnection* _connection;
    getAnswerCallback _onSuccess;
}

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
              question:(JDGQuestion *)question
       successCallback:(getAnswerCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client
                           failCallback:onFail])
    {
        self.user = user;
        self.question = question;
        NSDictionary *params = @{
            @"method":      @"getAnswer",
            @"questionId":  [NSNumber numberWithInt:question.uid],
            @"userId":      [NSNumber numberWithInt:user.uid]
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
    JDGAnswer *result = [[JDGAnswer alloc] initWithJson:content];
    result.user = self.user;
    result.question = self.question;
    _onSuccess(result);
    [self.apiClient completeRequest:self];
}

@end
