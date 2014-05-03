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
#import "JDGPageFactory.h"
#import "JDGQuestionPageFactory.h"

static JDGRootViewController *sharedController;

@interface JDGRootViewController ()

@property (strong, atomic)  NSMutableDictionary *pages;
@property (strong, atomic)  NSMutableArray      *pageFactories;
@property                   NSArray             *questions;
@property                   NSUInteger          currentPageIndex;
@property                   NSUInteger          expectingPageIndex;

-(void)refresh;
-(JDGPageViewController *)pageAtIndex:(NSUInteger)index;
-(void)updatePageController;

@end

@implementation JDGRootViewController
@synthesize pages, pageViewController, questions, buttonView, currentPageIndex, pageFactories;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pages = [[NSMutableDictionary alloc] init];
    self.pageFactories = [[NSMutableArray alloc] init];
    sharedController = self;
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionPageViewController"];
    self.pageViewController.dataSource = self;
    self.currentPageIndex = 0;
    [self updatePageController];
    self.pageViewController.view.frame = self.view.frame;
    self.pageViewController.delegate = self;
    [self addChildViewController:pageViewController];
    [self.view insertSubview:pageViewController.view belowSubview:self.buttonView];
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self updatePageController];
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

#pragma mark Static methods

+(JDGRootViewController *)sharedController
{
    return sharedController;
}

#pragma mark Public methods

-(void)addPageFactories:(NSArray *)factories
{
    NSUInteger oldFactoriesCount = pageFactories.count;
    
    for (JDGPageFactory *newFactory in factories)
    {
        // TODO: fix n^2 check
        BOOL duplicate = false;
        for(JDGPageFactory *existingFactory in pageFactories)
        {
            if ([existingFactory tryUpdateWithFactory:newFactory])
            {
                duplicate = true;
                break;
            }
        }
        if (!duplicate)
        {
            [pageFactories addObject:newFactory];
        }
    }
    
    if (factories.count != oldFactoriesCount && ABS(oldFactoriesCount - currentPageIndex) < 2)
    {
        [self updatePageController];
    }
}

#pragma mark Service methods

-(void)updatePageController
{
    JDGPageViewController *controller = [self pageAtIndex:currentPageIndex];
    if (controller == nil)
    {
        controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LoadingViewController"];
    }
    controller.pageIndex = currentPageIndex;
    [self.pageViewController setViewControllers:@[controller]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}

- (JDGPageViewController*)pageAtIndex:(NSUInteger)index
{
    JDGPageViewController *result = (JDGPageViewController *)[pages objectForKey:[NSNumber numberWithUnsignedInteger:index]];
    
    if (result == nil)
    {   
        if (pageFactories != nil && index  < [pageFactories count])
        {
            JDGPageFactory *resultFactory = [pageFactories objectAtIndex:index];
            if (resultFactory != nil)
            {
                result = [resultFactory createPage];
                result.pageIndex = index;
            }
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
         NSMutableArray *pageFactories = [[NSMutableArray alloc] initWithCapacity:newQuestions.count];
         for (JDGQuestion *question in newQuestions) {
             [pageFactories addObject:[[JDGQuestionPageFactory alloc] initWithQuestion:question]];
         }
         [self addPageFactories:pageFactories];
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
