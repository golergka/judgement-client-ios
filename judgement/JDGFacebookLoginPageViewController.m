//
//  JDGFacebookLoginPageViewController.m
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGFacebookLoginPageViewController.h"
#import "JDGRootViewController.h"

@interface JDGFacebookLoginPageViewController ()

@end

@implementation JDGFacebookLoginPageViewController

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
    self.loginView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Login view delagate

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                           user:(id<FBGraphUser>)user
{
    self.hintLabel.text = [NSString stringWithFormat:@"Atta boy! Great to see you, %@.", user.first_name];
    [[JDGRootViewController sharedController] scrollRight];
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.hintLabel.text = @"Why don't you login with Facebook?";
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
