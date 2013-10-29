//
//  AboutView.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "AboutView.h"
#import "Constants.h"


@implementation AboutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect bounds = self.bounds;
        self.backgroundColor = [UIColor lightGrayColor];
        
        // Add UITextView
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(BUTTON_BORDER_MARGIN, 100, self.bounds.size.width - (2 * BUTTON_BORDER_MARGIN), bounds.size.height * 0.53)];
        textView.text = @"";
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"txt"];
        
        NSError *err = nil;
        NSString *aboutText = [NSString stringWithContentsOfFile:filePath
                                                           encoding:NSUTF8StringEncoding
                                                              error:&err];
        if (aboutText == nil) {
            NSLog(@"Error reading %@: %@", filePath, err);
        } else {
            textView.text = aboutText;
        }
        
        [self addSubview:textView];
        
        // Buttons
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backButton.frame = CGRectMake( bounds.size.width - (BUTTON_WIDTH + BUTTON_BORDER_MARGIN), bounds.size.height - (BUTTON_HEIGHT + BUTTON_BORDER_MARGIN - STATUSBAR), BUTTON_WIDTH, BUTTON_HEIGHT);
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UIButton * signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        signupButton.frame = CGRectMake( 0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        signupButton.center = CGPointMake(bounds.size.width / 2, 100 + bounds.size.height * 0.53 + BUTTON_BORDER_MARGIN);
        [signupButton setTitle:@"Signup" forState:UIControlStateNormal];
        [signupButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:signupButton];
    }
    return self;
}

- (void)switchView:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Back"]) {
        [self.delegate switchToView:@"MainView" fromView:self];
    } else if ([sender.titleLabel.text isEqualToString:@"Signup"]) {
        [self.delegate switchToView:@"SignupView" fromView:self];
    }
}

@end
