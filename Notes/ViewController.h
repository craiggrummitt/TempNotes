//
//  ViewController.h
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;

@interface ViewController : UIViewController<UITextFieldDelegate>
-(id)initWithNote:(Note *)note;

@end

