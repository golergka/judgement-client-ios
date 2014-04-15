//
//  JDGRegisterApiRequest.h
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"

@interface JDGRegisterApiRequest : JDGApiRequest

@property(readwrite,copy) registerCallback onSuccess;

-(id)initWithApiClient:(JDGApiClient *)client
          vendorIdHash:(NSString*)vendorIdHash
       successCallback:(registerCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
