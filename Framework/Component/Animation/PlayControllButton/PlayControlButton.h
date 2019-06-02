//
//  RSPlayPauseButton.h
//
//  Created by Raphael Schaad on 2014-03-22.
//  This is free and unencumbered software released into the public domain.
//


#import <UIKit/UIKit.h>


//if (!self.playPauseButton) {
//    self.playPauseButton = [[RSPlayPauseButton alloc] init];
//    self.playPauseButton.paused = NO;
//    CGRect frame = self.playPauseButton.frame;
//    frame.origin = CGPointMake(CGRectGetMaxX(self.bounds) - frame.size.width - kMargin, CGRectGetMaxY(self.bounds) - frame.size.height - kMargin);
//    self.playPauseButton.frame = frame;
//    self.playPauseButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
//    self.playPauseButton.color = [UIColor colorWithWhite:0.8 alpha:1.0];
//    [self.playPauseButton addTarget:self action:@selector(playPauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.playPauseButton];
//}
//
//[self.playPauseButton setPaused:YES animated:YES];

typedef NS_ENUM(NSUInteger, RSPlayPauseButtonAnimationStyle) {
    RSPlayPauseButtonAnimationStyleSplit,
    RSPlayPauseButtonAnimationStyleSplitAndRotate // Default
};


//
//  Displays a  ⃝ with either the ► (play) or ❚❚ (pause) icon and nicely morphs between the two states.
//
@interface RSPlayPauseButton : UIControl

// State
@property (nonatomic, assign, getter = isPaused) BOOL paused; // Default is `YES`; changing this way is not animated
- (void)setPaused:(BOOL)paused animated:(BOOL)animated;

// Style
@property (nonatomic, strong) UIColor *color; // Default is 96% black
@property (nonatomic, assign) RSPlayPauseButtonAnimationStyle animationStyle; // Default is `RSPlayPauseButtonAnimationStyleSplitAndRotate`

@end
