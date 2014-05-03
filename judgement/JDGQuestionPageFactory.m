//
//  JDGQuestionPageFactory.m
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestionPageFactory.h"
#import "JDGQuestionPageViewController.h"

@interface JDGQuestionPageFactory ()
{
    JDGQuestion *_question;
}

@property (strong)          JDGQuestion *question;
@property (weak)    JDGQuestionPageViewController *viewController;

@end

@implementation JDGQuestionPageFactory

#pragma mark Init

-(id)initWithQuestion:(JDGQuestion *)question
{
    if (self = [super init])
    {
        self.question = question;
    }
    return self;
}

#pragma mark Properties

-(void)setQuestion:(JDGQuestion *)question
{
    if (self.viewController != nil)
    {
        self.viewController.question = question;
    }
    _question = question;
}

-(JDGQuestion*)question
{
    return _question;
}

#pragma mark Public methods

-(JDGPageViewController *)createPage
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"QuestionDetailViewController"];
    self.viewController.question = self.question;
    return self.viewController;
}

-(BOOL)tryUpdateWithFactory:(JDGPageFactory *)factory
{
    if ([JDGPageFactory class] == [JDGQuestionPageFactory class])
    {
        JDGQuestionPageFactory *questionFactory = (JDGQuestionPageFactory *) factory;
        if (self.question == nil)
        {
            self.question = questionFactory.question;
            return YES;
        }
        else
        {
            return (self.question == questionFactory.question);
        }
    }
    else
    {
        return NO;
    }
}

@end
