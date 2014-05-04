//
//  JDGClient.m
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiClient.h"
#import "NSDictionary+JDGUrlEncoding.h"

#import "JDGApiRequest.h"
#import "JDGGetQuestionsApiRequest.h"
#import "JDGRegisterApiRequest.h"
#import "JDGGetAnswerApiRequest.h"
#import "JDGAnswerApiRequest.h"
#import "JDGAddQuestionApiRequest.h"
#import "JDGSetFacebookAccessTokenRequest.h"

static JDGApiClient *sharedClient;

@implementation JDGApiClient
{
    NSMutableArray *requests;
}

#pragma mark Singleton

+ (JDGApiClient*)sharedClient
{
    return sharedClient;
}

+ (void)initialize
{
    static BOOL initialized = NO;
    if (!initialized)
    {
        initialized = YES;
        sharedClient = [[JDGApiClient alloc] init];
    }
}

#pragma mark User interface

- (void)getQuestionsWithSuccessCallback:(getQuestionsCallback)onSuccess
                           failCallback:(requestFailCallback)onFail
{
#if DEBUG
    NSLog(@"getQuestions");
#endif
    [requests addObject:[[JDGGetQuestionsApiRequest alloc] initWithApiClient:self
                                                             successCallback:onSuccess
                                                                failCallback:onFail]];
}

-(void)registerWithVendorIdHash:(NSString *)vendorIdHash
                successCallback:(registerCallback)onSuccess
                   failCallback:(requestFailCallback)onFail
{
#if DEBUG
    NSLog(@"register");
#endif
    [requests addObject:[[JDGRegisterApiRequest alloc] initWithApiClient:self
                                                            vendorIdHash:vendorIdHash
                                                         successCallback:onSuccess
                                                            failCallback:onFail]];
}

-(void)getAnswerWithUser:(JDGValidatedUser *)user
                question:(JDGQuestion *)question
         successCallback:(getAnswerCallback)onSuccess
            failCallback:(requestFailCallback)onFail
{
#if DEBUG
    NSLog(@"getAnswer");
#endif
    [requests addObject:[[JDGGetAnswerApiRequest alloc] initWithApiClient:self
                                                                     user:user
                                                                 question:question
                                                          successCallback:onSuccess
                                                             failCallback:onFail]];
}

-(void)answerWithUser:(JDGValidatedUser *)user
             question:(JDGQuestion *)question
          answerValue:(BOOL)answerValue
      successCallback:(answerCallback)onSuccess
         failCallback:(requestFailCallback)onFail
{
    [requests addObject:[[JDGAnswerApiRequest alloc] initWithApiClient:self
                                                                  user:user
                                                              question:question
                                                           answerValue:answerValue
                                                       successCallback:onSuccess
                                                          failCallback:onFail]];
}

-(void)addQuestionWithUser:(JDGValidatedUser *)user
                      text:(NSString *)questionText
                  deadline:(NSDate *)questionDeadline
           successCallback:(addQuestionCallback)onSuccess
              failCallback:(requestFailCallback)onFail
{
    [requests addObject:[[JDGAddQuestionApiRequest alloc] initWithApiClient:self
                                                                       user:user
                                                                       text:questionText
                                                                   deadline:questionDeadline
                                                            successCallback:onSuccess
                                                               failCallback:onFail]];
}

-(void)setFacebookAccessToken:(JDGValidatedUser *)user
          facebookAccessToken:(NSString *)token
              successCallback:(setFacebookAccessTokenCallback)onSuccess
                 failCallback:(requestFailCallback)onFail
{
    [requests addObject:[[JDGSetFacebookAccessTokenRequest alloc] initWithApiClient:self
                                                                               user:user
                                                                facebookAccessToken:token
                                                                    successCallback:onSuccess
                                                                       failCallback:onFail]];
}

#pragma mark Request helpers

-(NSURL*)urlForParams:(NSDictionary *)params
{
    NSString *apiServer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"JDGApiServer"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", apiServer, [params urlEncodedString]]];
}

-(void)completeRequest:(id)request
{
    [requests removeObject:request];
}

@end
