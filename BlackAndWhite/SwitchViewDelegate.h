//
//  SwitchViewDelegate.h
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import <Foundation/Foundation.h>

@protocol SwitchViewDelegate <NSObject>

- (void)switchToView:(NSString *)viewName fromView:(UIView *)fromView;

@end
