//
//  JDGClient.h
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDGApiRequest;

typedef void (^getQuestionsCallback)(NSArray *);
typedef void (^requestFailCallback) (void);

@interface JDGApiClient : NSObject

+ (JDGApiClient*)sharedClient;

-(void)getQuestionsWithSuccessCallback:(getQuestionsCallback)onSuccess
                          failCallback:(requestFailCallback)onFail;

-(NSURL*)urlForParams:(NSDictionary*)params;
-(void)completeRequest:(JDGApiRequest*)request;

@end