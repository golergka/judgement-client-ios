//
//  JDGDetailViewController.m
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestionPageViewController.h"
#import "JDGAnswer.h"
#import "JDGRootViewController.h"

static NSDateFormatter * deadlineDateFormatter;

@interface JDGQuestionPageViewController ()
{
    JDGQuestion *_question;
    NSString    *_hint;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
-(void)configureView;
+(NSDateFormatter*)deadlineDateFormatter;
@end

@implementation JDGQuestionPageViewController

#pragma mark - Deadline date formatter

+(void)initialize
{
    if (self == [JDGQuestionPageViewController self])
    {
        deadlineDateFormatter = [[NSDateFormatter alloc] init];
        [deadlineDateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [deadlineDateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [deadlineDateFormatter setDoesRelativeDateFormatting:YES];
    }
}

+(NSDateFormatter*)deadlineDateFormatter
{
    return deadlineDateFormatter;
}

#pragma mark - Properties

-(void)setHint:(NSString *)hint
{
    _hint = hint;
    if (self.hintLabel)
    {
        self.hintLabel.text = hint;
        self.hintLabel.hidden = (hint.length == 0);
    }
}

-(NSString*)hint
{
    return _hint;
}

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

-(JDGQuestion*)question
{
    return _question;
}

#pragma mark Service methods

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.question) {
        // Texts
        self.questionTextLabel.text = [self.question text];
        self.questionDeadlineLabel.text = [NSString stringWithFormat:@"Deadline: %@", [deadlineDateFormatter stringFromDate:[self.question deadline]]];
        // Answerable
        self.questionAnswerControl.enabled = [self.question canAnswer];
        // Answer value
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
    
    [self.loadingView setHidden:(self.question != nil)];
    [self.questionView setHidden:(self.question == nil)];
}

-(void)answer
{
    BOOL shouldScroll = false;
    if (self.question)
    {
        shouldScroll = (self.question.myAnswer == nil);
        [self.question answerWithValue:(self.questionAnswerControl.selectedSegmentIndex == 0)];
    }
    if (shouldScroll)
    {
        [[JDGRootViewController sharedController] scrollRight];
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
    
    self.hint = _hint;
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
