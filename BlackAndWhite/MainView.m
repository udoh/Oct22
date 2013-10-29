//
//  MainView.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "MainView.h"
#import "Constants.h"


@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect bounds = self.bounds;
        
        // Add title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(bounds.size.width - 250 - BUTTON_BORDER_MARGIN, 34, 250, 106)];
        titleLabel.numberOfLines = 2;
        titleLabel.textAlignment = NSTextAlignmentRight;
        CGSize shadowOffset = CGSizeMake(2, 2);
        titleLabel.shadowOffset = shadowOffset;
        titleLabel.shadowColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.8];
        
        NSString *text = @"Black and White Photography";
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Zapfino" size:14.0] range:NSMakeRange(0, [text length])];
        titleLabel.attributedText = attrStr;
        [self addSubview:titleLabel];

        // Add background image
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
        
        CGRect backgroundFrame = self.bounds;
        backgroundFrame.size.height += 20;
        backgroundImage.frame = backgroundFrame;
        backgroundImage.alpha = 0.2;
        backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:backgroundImage];

        // Add title imageView
        UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.jpg"]];
        CGRect titleImageFrame = CGRectMake(BUTTON_BORDER_MARGIN, 148, bounds.size.width - (2 * BUTTON_BORDER_MARGIN), bounds.size.height * 0.62);
        titleImage.frame = titleImageFrame;
        [self addSubview:titleImage];

        // Buttons
        UIButton * photosButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        photosButton.frame = CGRectMake( bounds.size.width - (BUTTON_WIDTH + BUTTON_BORDER_MARGIN), bounds.size.height - (BUTTON_HEIGHT + BUTTON_BORDER_MARGIN - STATUSBAR), BUTTON_WIDTH, BUTTON_HEIGHT);
        [photosButton setTitle:@"Photos" forState:UIControlStateNormal];
        [photosButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * aboutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        aboutButton.frame = CGRectMake( bounds.size.width - (2 * BUTTON_WIDTH + BUTTON_BORDER_MARGIN + BUTTON_TO_BUTTON_MARGIN), bounds.size.height - (BUTTON_HEIGHT + BUTTON_BORDER_MARGIN - STATUSBAR), BUTTON_WIDTH, BUTTON_HEIGHT);
        [aboutButton setTitle:@"About" forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:photosButton];
        [self addSubview:aboutButton];
    }
    return self;
}

- (void)switchView:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Photos"]) {
        [self.delegate switchToView:@"PhotosView" fromView:self];
    } else if ([sender.titleLabel.text isEqualToString:@"About"]) {
        [self.delegate switchToView:@"AboutView" fromView:self];
    }
}

@end
