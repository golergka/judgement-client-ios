//
//  JDGDetailViewController.h
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDGQuestion.h"
#import "JDGPageViewController.h"

@interface JDGQuestionPageViewController : JDGPageViewController

@property (strong, nonatomic)   JDGQuestion *question;
@property                       NSString *hint;

@property (weak, nonatomic) IBOutlet UILabel            *questionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel            *questionDeadlineLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *questionAnswerControl;
@property (weak, nonatomic) IBOutlet UILabel            *hintLabel;

@property (weak, nonatomic) IBOutlet UIView             *loadingView;
@property (weak, nonatomic) IBOutlet UIView             *questionView;

@end
