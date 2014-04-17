//
//  JDGDetailViewController.h
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDGQuestion.h"

@interface JDGQuestionDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) JDGQuestion *question;

@property (weak, nonatomic) IBOutlet UILabel            *questionTextLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *questionAnswerControl;

@end
