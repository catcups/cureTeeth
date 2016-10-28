//
//  MSPlaceHolderTextView.h
//  MSUnified
//
//  Created by William on 12/22/15.
//  Copyright © 2015 max. All rights reserved.
//

#import <UIPlaceholderTextView/UIPlaceholderTextView.h>

@interface MSPlaceHolderTextView : UIPlaceHolderTextView

@property (nonatomic, assign) NSUInteger textLimit;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end
