//
//  JDGFacebookLoginPageViewController.h
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGPageViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface JDGFacebookLoginPageViewController : JDGPageViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView    *loginView;
@property (weak, nonatomic) IBOutlet UILabel        *hintLabel;

@end
