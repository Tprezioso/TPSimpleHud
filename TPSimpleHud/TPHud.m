//
//  TPHud.m
//  TPSimpleHud
//
//  Created by Thomas Prezioso on 10/29/15.
//  Copyright © 2015 Thomas Prezioso. All rights reserved.
//

#import "TPHud.h"

@interface TPHud ()

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) CGFloat alpha;

@end

@implementation TPHud

- (instancetype)init
{
    return [[TPHud alloc] initWithCustomStyle:UIActivityIndicatorViewStyleWhiteLarge backgroundColor:[UIColor grayColor] size:80 alpha:.8];
}

#pragma mark Public Methods
- (instancetype)initWithCustomStyle:(NSInteger)style backgroundColor:(UIColor *)backgroundColor size:(CGFloat)size alpha:(CGFloat)alpha;
{
    self.alpha = alpha;
    self = [super init];
    if (self) {
        self.hudView = [[UIView alloc] init];
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [self addSubview:self.hudView];
        [self.hudView addSubview:self.activityIndicatorView];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.hudView.backgroundColor = backgroundColor;
        self.hudView.layer.cornerRadius = 6;
        self.hudView.alpha = 0;
        [self.activityIndicatorView startAnimating];
        self.hudView.translatesAutoresizingMaskIntoConstraints = NO;
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{@"background":self.hudView, @"activity":self.activityIndicatorView, @"superview":self};
        NSDictionary *metrics = @{@"side":@(size)};
        {
            NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"[superview]-(<=1)-[background(side)]" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views];
            [self addConstraints:horizontal];
        }
        {
            NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[background(side)]" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views];
            [self addConstraints:vertical];
        }
        
        {
            NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|[activity]|" options:kNilOptions metrics:metrics views:views];
            [self.hudView addConstraints:horizontal];
        }
        {
            NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[activity]|" options:kNilOptions metrics:metrics views:views];
            [self.hudView addConstraints:vertical];
        }
    }
    return self;
}

- (void)hideInView:(UIView *)view
{
        [UIView animateWithDuration:.5 animations:^{
        self.hudView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"progressHud":self};
        NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|[progressHud]|" options:kNilOptions metrics:nil views:views];
        [view addConstraints:horizontal];
        NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[progressHud]|" options:kNilOptions metrics:nil views:views];
        [view addConstraints:vertical];
    [UIView animateWithDuration:.5 animations:^{
        self.hudView.alpha = self.initialAlpha;
    }];
}

@end
