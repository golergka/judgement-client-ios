//
//  JDGRootViewController.m
//  judgement
//
//  Created by Max Yankov on 02.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGRootViewController.h"
#import "JDGPageViewController.h"
#import "JDGApiClient.h"
#import "JDGQuestionPageViewController.h"

@interface JDGRootViewController ()

@property (strong, atomic)  NSMutableDictionary *pages;
@property                   NSArray             *questions;
@property                   NSUInteger          currentPageIndex;
@property                   NSUInteger          expectingPageIndex;

-(void)refresh;
-(JDGPageViewController *)pageAtIndex:(NSUInteger)index;

@end

@implementation JDGRootViewController
@synthesize pages, pageViewController, questions, buttonView, currentPageIndex;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pages = [[NSMutableDictionary alloc] init];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionPageViewController"];
    self.pageViewController.dataSource = self;
    
    JDGPageViewController *startViewController = [self pageAtIndex:0];
    self.currentPageIndex = 0;
    [self.pageViewController setViewControllers:@[startViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    self.pageViewController.view.frame = self.view.frame;
    self.pageViewController.delegate = self;
    [self addChildViewController:pageViewController];
    [self.view insertSubview:pageViewController.view belowSubview:self.buttonView];
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((JDGPageViewController *) viewController).pageIndex;
    index--;
    return [self pageAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((JDGPageViewController *) viewController).pageIndex;
    index++;
    return [self pageAtIndex:index];
}

#pragma mark Service methods

- (JDGPageViewController*)pageAtIndex:(NSUInteger)index
{
    JDGQuestionPageViewController *result = (JDGQuestionPageViewController *)[pages objectForKey:[NSNumber numberWithUnsignedInteger:index]];
    
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
             JDGQuestionPageViewController *viewController = (JDGQuestionPageViewController *)obj;
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

#pragma mark UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    id nextViewController = [pendingViewControllers firstObject];
    if ([nextViewController isKindOfClass:[JDGPageViewController class]])
    {
        JDGPageViewController *nextPage = (JDGPageViewController *)nextViewController;
        self.expectingPageIndex = nextPage.pageIndex;
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController
       didFinishAnimating:(BOOL)finished
  previousViewControllers:(NSArray *)previousViewControllers
      transitionCompleted:(BOOL)completed
{
    if (finished)
    {
        self.currentPageIndex = self.expectingPageIndex;
    }
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
