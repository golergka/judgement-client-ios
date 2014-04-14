//
//  JDGGetQuestionsApiRequest.h
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"

@interface JDGGetQuestionsApiRequest : JDGApiRequest

-(id)initWithApiClient:(JDGApiClient *)client
       successCallback:(getQuestionsCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
