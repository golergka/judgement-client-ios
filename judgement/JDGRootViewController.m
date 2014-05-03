//
//  JDGRootViewController.m
//  judgement
//
//  Created by Max Yankov on 02.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGRootViewController.h"
#import "JDGPageContentViewController.h"
#import "JDGApiClient.h"
#import "JDGQuestionDetailViewController.h"

@interface JDGRootViewController ()

@property (strong, atomic) NSMutableDictionary *pages;
@property NSArray *questions;

-(void)refresh;
-(JDGPageContentViewController *)pageAtIndex:(NSUInteger)index;

@end

@implementation JDGRootViewController
@synthesize pages, pageViewController, questions, buttonView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pages = [[NSMutableDictionary alloc] init];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionPageViewController"];
    self.pageViewController.dataSource = self;
    
    JDGPageContentViewController *startViewController = [self pageAtIndex:0];
    [self.pageViewController setViewControllers:@[startViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    self.pageViewController.view.frame = self.view.frame;
    [self addChildViewController:pageViewController];
    [self.view insertSubview:pageViewController.view belowSubview:self.buttonView];
//    [self.view addSubview:pageViewController.view ];
    
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewControlle
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((JDGPageContentViewController *) viewController).pageIndex;
    index--;
    return [self pageAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((JDGPageContentViewController *) viewController).pageIndex;
    index++;
    return [self pageAtIndex:index];
}

- (JDGPageContentViewController*)pageAtIndex:(NSUInteger)index
{
    JDGQuestionDetailViewController *result = (JDGQuestionDetailViewController *)[pages objectForKey:[NSNumber numberWithUnsignedInteger:index]];
    
    if (result == nil)
    {
        JDGQuestion *question;
        
        if (((questions != nil && index  < [questions count] && (question = [questions objectAtIndex:index]) != nil ) || index == 0))
        {
            result = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionDetailViewController"];
            result.question = question;
            result.pageIndex = index;
        }
        if (result != nil)
        {
            [pages setObject:result forKey:[NSNumber numberWithUnsignedInteger:index]];
        }
    }
    return result;
}

-(void)refresh
{
    [[JDGApiClient sharedClient]
     getQuestionsWithSuccessCallback:^(NSArray* newQuestions) {
         self.questions = newQuestions;
         [pages enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
             JDGQuestionDetailViewController *viewController = (JDGQuestionDetailViewController *)obj;
             NSUInteger index = (NSUInteger) [((NSNumber *) key) integerValue];
             if (index < [questions count])
             {
                 viewController.question = [questions objectAtIndex:index];
             }
             else
             {
                 viewController.question = nil;
             }
         }];
     }
     failCallback:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
