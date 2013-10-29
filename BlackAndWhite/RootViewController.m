//
//  RootViewController.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "RootViewController.h"
#import "MainView.h"
#import "PhotosView.h"
#import "AboutView.h"
#import "SignupView.h"
#import "SwitchViewDelegate.h"


@interface RootViewController ()
@property (strong, nonatomic) MainView *mainView;
@property (strong, nonatomic) PhotosView *photosView;
@property (strong, nonatomic) AboutView *aboutView;
@property (strong, nonatomic) SignupView *signUpView;
@end


@implementation RootViewController

- (void)loadView
{
    CGRect bounds = [UIScreen mainScreen].applicationFrame;
    
    // create all 4 subviews and add them; hide all but mainView
    self.mainView = [[MainView alloc] initWithFrame:bounds];
    self.mainView.delegate = self;
    self.view = self.mainView;
    
    self.photosView = [[PhotosView alloc] initWithFrame:bounds];
    self.photosView.delegate = self;
    
    self.aboutView = [[AboutView alloc] initWithFrame:bounds];
    self.aboutView.delegate = self;
    
    self.signUpView = [[SignupView alloc] initWithFrame:bounds];
    self.signUpView.delegate = self;
}

- (void)switchToView:(NSString *)viewName fromView:(UIView *)fromView
{
    if ([viewName isEqualToString:@"PhotosView"]) {
        self.view = self.photosView;
        // view animation
//        [UIView transitionFromView:fromView
//                            toView:self.photosView
//                          duration:1
//                           options:UIViewAnimationOptionTransitionFlipFromLeft
//                        completion:nil];
        
    } else if ([viewName isEqualToString:@"MainView"]) {
        self.view = self.mainView;
    } else if ([viewName isEqualToString:@"AboutView"]) {
        self.view = self.aboutView;
    } else if ([viewName isEqualToString:@"SignupView"]) {
        self.view = self.signUpView;
    }
}

@end
