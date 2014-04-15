//
//  JDGApiRequest.h
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDGApiClient.h"

@interface JDGApiRequest : NSObject <NSURLConnectionDataDelegate>

@property(readwrite,copy) requestFailCallback   onFail;
@property(readonly, weak) JDGApiClient*         apiClient;

-(id)initWithApiClient:(JDGApiClient*)client
          failCallback:(requestFailCallback)onFail;

-(void)processContent:(id)content;

@end
