//
//  PhotosView.m
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import "PhotosView.h"
#import "PhotoHolderView.h"
#import "Constants.h"

#define BORDER_MARGIN_SCALE 0.05
#define IMAGE_MARGIN_SCALE 0.01
#define BOTTOM_MARGIN 30
#define NUM_COLUMNS_IPHONE 3
#define NUM_COLUMNS_IPAD 5


@interface PhotosView ()
@property (strong, nonatomic) NSMutableArray *photoPool;
@property (strong, nonatomic) NSMutableArray *currentPhotos;
@property (nonatomic) int numberOfColumns;
@property (nonatomic) int numberOfRows;
@end


@implementation PhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect bounds = self.bounds;
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.photoPool = [[NSMutableArray alloc] init];
        self.currentPhotos = [[NSMutableArray alloc] init];
        
        // Determine device and add photos to array
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {    // iPhone
            self.numberOfColumns = NUM_COLUMNS_IPHONE;
        } else {                                                        // iPad
            self.numberOfColumns = NUM_COLUMNS_IPAD;
        }
    
        // Calculate necessary geometric properties
        CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);
        CGFloat borderMargin = size * BORDER_MARGIN_SCALE;
        CGFloat imageMargin = size * IMAGE_MARGIN_SCALE;
        CGFloat imageWidth = (self.bounds.size.width - (borderMargin * 2) - (imageMargin * self.numberOfColumns - 1)) / self.numberOfColumns;
        
        CGFloat leftColumnCenter = borderMargin + (imageWidth / 2);
        CGFloat rightColumnCenter = self.bounds.size.width - leftColumnCenter;
        CGFloat distanceMaxColumns = rightColumnCenter - leftColumnCenter;
        CGFloat distanceBetweenCentersColumns = distanceMaxColumns / (self.numberOfColumns - 1);
        
        CGFloat topRowCenter = borderMargin + (imageWidth / 2);
        
        // How many rows fit on screen without clipping the views
        int rowCount = 0;
        CGFloat height = borderMargin;
        
        while (height < (self.bounds.size.height * 0.8)) {
            height += imageWidth + imageMargin;
            if (height < self.bounds.size.height) {
                rowCount++;
            }
        }
        
        // Add image to array
        for (int i = 1; i <= 33; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
            [self.photoPool addObject:image];
        }
        
        self.numberOfRows = rowCount;
        
        CGRect photoFrame = CGRectMake(0, 0, imageWidth, imageWidth);
        
        // Create photo grid; add to currentPhotos array for use in layoutSubviews
        for (int column = 0; column < self.numberOfColumns; column++) {
            for (int row = 0; row < self.numberOfRows; row++) {
                CGPoint photoCenter = CGPointMake(leftColumnCenter + (column * distanceBetweenCentersColumns), topRowCenter + (row * distanceBetweenCentersColumns));
                PhotoHolderView *photo = [[PhotoHolderView alloc] initWithFrame:photoFrame];
                photo.imageView.image = [self randomImage];
                
                int imageNumber = row * self.numberOfColumns + column + 1;
                
                photo.titleLabel.text = [NSString stringWithFormat:@"Photo %d", imageNumber];
                photo.center = photoCenter;
                [self addSubview:photo];
                [self.currentPhotos addObject:photo];
            }
        }
        
        // Button
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backButton.frame = CGRectMake( bounds.size.width - (BUTTON_WIDTH + BUTTON_BORDER_MARGIN), bounds.size.height - (BUTTON_HEIGHT + BUTTON_BORDER_MARGIN - STATUSBAR), BUTTON_WIDTH, BUTTON_HEIGHT);
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:backButton];
        
    }
    return self;
}

- (UIImage *)randomImage
{
    int index = arc4random() % [self.photoPool count];
    UIImage *image = self.photoPool[index];
    [self.photoPool removeObjectAtIndex:index];
    
    return image;
}

- (void)layoutSubviews
{
    int numberOfRows = self.numberOfRows;
    int numberOfColumns = self.numberOfColumns;
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    // If landscape swap rows and columns
    if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
        numberOfRows = self.numberOfColumns;
        numberOfColumns = self.numberOfRows;
    }
    
    // Calculate necessary geometric properties
    CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat borderMargin = size * BORDER_MARGIN_SCALE;
    CGFloat imageMargin = size * IMAGE_MARGIN_SCALE;
    CGFloat imageWidth = (self.bounds.size.width - (borderMargin * 2) - (imageMargin * numberOfColumns - 1)) / numberOfColumns;
    
    CGFloat leftColumnCenter = borderMargin + (imageWidth / 2);
    CGFloat rightColumnCenter = self.bounds.size.width - leftColumnCenter;
    CGFloat distanceMaxColumns = rightColumnCenter - leftColumnCenter;
    CGFloat distanceBetweenCentersColumns = distanceMaxColumns / (numberOfColumns - 1);
    
    CGFloat topRowCenter = borderMargin + (imageWidth / 2);
    
    // Reposition subviews based on device rotation
    for (int column = 0; column < numberOfColumns; column++) {
        for (int row = 0; row < numberOfRows; row++) {
            CGPoint photoCenter = CGPointMake(leftColumnCenter + (column * distanceBetweenCentersColumns), topRowCenter + (row * distanceBetweenCentersColumns));
            int imageNumber = row * numberOfColumns + column;
            PhotoHolderView *photo = self.currentPhotos[imageNumber];
            photo.titleLabel.text = [NSString stringWithFormat:@"Photo %d", imageNumber + 1];

            photo.center = photoCenter;
        }
    }
}

- (void)switchView:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Back"]) {
        [self.delegate switchToView:@"MainView" fromView:self];
    }
}

@end
