//
//  JDGAddQuestionViewController.h
//  judgement
//
//  Created by Max Yankov on 02.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDGAddQuestionViewController : UIViewController <UITextFieldDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)questionEdited:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem    *submitButton;
@property (weak, nonatomic) IBOutlet UITextField        *questionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker       *deadlinePicker;


@end
