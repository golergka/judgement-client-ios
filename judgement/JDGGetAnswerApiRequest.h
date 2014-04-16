//
//  JDGGetAnswerApiRequest.h
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"
#import "JDGApiClient.h"
#import "JDGUser.h"
#import "JDGQuestion.h"

@interface JDGGetAnswerApiRequest : JDGApiRequest

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGUser *)user
              question:(JDGQuestion *)question
       successCallback:(getAnswerCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
