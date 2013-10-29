//
//  PhotoHolderView.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "PhotoHolderView.h"
#import <QuartzCore/QuartzCore.h>


@implementation PhotoHolderView

#define IMAGE_SCALE 0.95
#define TITLE_SPACE 14
#define TITLE_HEIGHT 12

- (void)setup
{
    // Determine bounds and calculate the size of the imageView
    CGRect bounds = self.bounds;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.0;
    
    // View should work also if not square; determine the smaller side
    CGFloat size = MIN(bounds.size.width, bounds.size.height);
    
    CGFloat margin = size * (1 - IMAGE_SCALE);
    
    // Image
    CGRect imageFrame = CGRectMake(bounds.origin.x + margin, bounds.origin.y + margin, bounds.size.width - (margin * 2), bounds.size.height - (margin * 2) - TITLE_HEIGHT);
    
    self.imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];

    // Label
    CGRect labelFrame = CGRectMake(0, bounds.size.height - TITLE_SPACE, bounds.size.width, TITLE_HEIGHT);
    self.titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.titleLabel.text = @"Photo 1";
    self.titleLabel.font = [UIFont systemFontOfSize:10.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

@end
