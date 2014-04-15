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

#pragma mark Request helpers

-(NSURL*)urlForParams:(NSDictionary *)params
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080?%@", [params urlEncodedString]]];
}

-(void)completeRequest:(id)request
{
    [requests removeObject:request];
}

@end
