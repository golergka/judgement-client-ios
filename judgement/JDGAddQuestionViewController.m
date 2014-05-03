//
//  JDGAddQuestionViewController.m
//  judgement
//
//  Created by Max Yankov on 02.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGAddQuestionViewController.h"
#import "JDGApiClient.h"
#import "JDGRootViewController.h"
#import "JDGQuestionPageFactory.h"

@interface JDGAddQuestionViewController ()

@end

@implementation JDGAddQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.questionTextField.delegate = self;
    self.deadlinePicker.minimumDate = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(id)sender {
    [[JDGApiClient sharedClient]
     addQuestionWithUser: [JDGValidatedUser thisUser]
     text               : self.questionTextField.text
     deadline           :self.deadlinePicker.date
     successCallback    :^(JDGQuestion *question) {
         JDGQuestionPageFactory *factory = [[JDGQuestionPageFactory alloc] initWithQuestion:question
                                                                                       hint:@"Your question have been added!"];
         [[JDGRootViewController sharedController] addPageFactories:@[factory]];
     }
     failCallback       :nil
     ];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)questionEdited:(id)sender {
    self.submitButton.enabled = (self.questionTextField.text.length > 0);
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
