//
//  JDGFacebookLoginPageFactory.m
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGFacebookLoginPageFactory.h"

@implementation JDGFacebookLoginPageFactory

-(JDGPageViewController *)createPage
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:@"FacebookLoginViewController"];
}

-(BOOL)tryUpdateWithFactory:(JDGPageFactory *)factory
{
    return [factory class] == [self class];
}

@end
