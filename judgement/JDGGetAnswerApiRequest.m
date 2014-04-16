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

@property JDGUser *user;
@property JDGQuestion *question;

@end

@implementation JDGGetAnswerApiRequest
{
    NSURLConnection* _connection;
    getAnswerCallback _onSuccess;
}

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGUser *)user
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
            @"questionId":  [NSNumber numberWithInt:user.uid],
            @"userId":      [NSNumber numberWithInt:question.uid]
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
