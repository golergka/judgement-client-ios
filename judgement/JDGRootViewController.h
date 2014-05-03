//
//  JDGRootViewController.h
//  judgement
//
//  Created by Max Yankov on 02.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDGRootViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIButton *buttonView;

-(void)scrollRight;
-(void)addPageFactories:(NSArray *)factories;

+(JDGRootViewController *)sharedController;

@end
