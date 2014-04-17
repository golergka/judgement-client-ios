//
//  JDGAnswerApiRequest.h
//  judgement
//
//  Created by Max Yankov on 17.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"
#import "JDGQuestion.h"

@interface JDGAnswerApiRequest : JDGApiRequest

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
              question:(JDGQuestion *)question
           answerValue:(BOOL)answerValue
       successCallback:(answerCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
