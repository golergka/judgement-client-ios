//
//  JDGDetailViewController.m
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestionDetailViewController.h"
#import "JDGAnswer.h"

@interface JDGQuestionDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
-(void)configureView;
-(void)update;
@end

@implementation JDGQuestionDetailViewController

#pragma mark - Managing the detail item

- (void)setQuestion:(JDGQuestion *)newQuestion
{
    if (_question != newQuestion) {
        if (_question)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:JDGQuestionDidUpdateNotification
                                                          object:_question];
        }
        _question = newQuestion;
        [self configureView];
        if (_question)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(configureView)
                                                         name:JDGQuestionDidUpdateNotification
                                                       object:_question];
        }
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.question) {
        self.questionTextLabel.text = [self.question text];
        JDGAnswer* myAnswer = self.question.myAnswer;
        if (myAnswer)
        {
            if (myAnswer.value)
            {
                self.questionAnswerControl.selectedSegmentIndex = 0;
            }
            else
            {
                self.questionAnswerControl.selectedSegmentIndex = 1;
            }
        }
        else
        {
            self.questionAnswerControl.selectedSegmentIndex = -1;
        }
    }
}

-(void)answer
{
    if (self.question)
    {
        [self.question answerWithValue:(self.questionAnswerControl.selectedSegmentIndex == 0)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [self.questionAnswerControl addTarget:self
                                   action:@selector(answer)
                         forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
