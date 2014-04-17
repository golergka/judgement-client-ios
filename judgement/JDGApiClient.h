//
//  JDGClient.h
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDGAnswer.h"
#import "JDGValidatedUser.h"

@class JDGApiRequest;
@class JDGGetQuestionsApiRequest;
@class JDGRegisterApiRequest;

typedef void (^getQuestionsCallback)(NSArray *);
typedef void (^registerCallback)    (JDGValidatedUser *);
typedef void (^getAnswerCallback)   (JDGAnswer *);
typedef void (^answerCallback)      (void);

typedef void (^requestFailCallback) (void);

@interface JDGApiClient : NSObject

+ (JDGApiClient*)sharedClient;

-(void)getQuestionsWithSuccessCallback:(getQuestionsCallback)onSuccess
                          failCallback:(requestFailCallback)onFail;

-(void)registerWithVendorIdHash:(NSString*)vendorIdHash
                successCallback:(registerCallback)onSuccess
                   failCallback:(requestFailCallback)onFail;

-(void)getAnswerWithUser:(JDGValidatedUser *)user
                question:(JDGQuestion *)question
         successCallback:(getAnswerCallback)onSuccess
            failCallback:(requestFailCallback)onFail;

-(void)answerWithUser:(JDGValidatedUser *)user
             question:(JDGQuestion *)question
          answerValue:(BOOL)answerValue
      successCallback:(answerCallback)onSuccess
         failCallback:(requestFailCallback)onFail;


-(NSURL*)urlForParams:(NSDictionary*)params;
-(void)completeRequest:(JDGApiRequest*)request;

@end