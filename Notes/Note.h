//
//  Note.h
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
-(id)initWithTitle:(NSString *)title detail:(NSString *)detail;
@end
