//
//  SignupView.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "SignupView.h"
#import "Constants.h"


@interface SignupView()
@property (strong, nonatomic) UITextField *emailTextField;
@end


@implementation SignupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect bounds = self.bounds;
        self.backgroundColor = [UIColor lightGrayColor];
        
        // Add email text field
        self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(BUTTON_BORDER_MARGIN, bounds.size.height / 3, bounds.size.width / 3*2, 25)];
        self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.emailTextField.placeholder = @"Please enter your email";
        self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.emailTextField.delegate = self;
        [self addSubview:self.emailTextField];
        
        // Buttons
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backButton.frame = CGRectMake( bounds.size.width - (BUTTON_WIDTH + BUTTON_BORDER_MARGIN), BUTTON_BORDER_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT);
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submitButton.frame = CGRectMake( BUTTON_BORDER_MARGIN + bounds.size.width / 3*2 + BUTTON_TO_BUTTON_MARGIN, bounds.size.height / 3, BUTTON_WIDTH, BUTTON_HEIGHT);
        [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(showConfirmation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitButton];
    }
    return self;
}

- (void)switchView:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Back"]) {
        [self.delegate switchToView:@"AboutView" fromView:self];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)showConfirmation
{
    NSString *messageText = [NSString stringWithFormat:@"Your email:\n%@", self.emailTextField.text];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Thanks for signing up!"
                                                      message:messageText
                                                     delegate:self
                                            cancelButtonTitle:@"Dismiss"
                                            otherButtonTitles:nil];
    [message show];
    [self.delegate switchToView:@"MainView" fromView:self];
}

@end
