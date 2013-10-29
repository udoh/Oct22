//
//  SignupView.h
//  BlackAndWhiteApp
//
//  Created by Udo Hoppenworth on 10/21/13.
//
//

#import <UIKit/UIKit.h>
#import "SwitchViewDelegate.h"


@interface SignupView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) id <SwitchViewDelegate> delegate;

@end
