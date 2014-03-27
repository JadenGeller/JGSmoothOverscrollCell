//
//  JGSmoothOverscrollView.m
//  JGScrollCellExample
//
//  Created by Jaden Geller on 3/9/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGSmoothOverscrollView.h"

@interface JGSmoothOverscrollView ()

@property (nonatomic, readonly) CGPoint returnPoint;
@property (nonatomic) UIEdgeInsets overscroll;

@end

@implementation JGSmoothOverscrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit_JGSmoothOverscrollView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedInit_JGSmoothOverscrollView];
    }
    return self;
}

-(void)sharedInit_JGSmoothOverscrollView{
    [super setDelegate:self];
    
    self.bounces = NO;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.clipsToBounds = NO;
    
    self.scrollEnabled = YES;
    
    self.contentView = [[UIView alloc]init];
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    [super addSubview:_contentView];
    [self layoutIfNeeded];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateOverscrollSize];
}

-(void)setOverscrollSize:(UIEdgeInsets)overscrollSize{
    _overscrollSize = overscrollSize;
    
    [self layoutIfNeeded];
}

-(void)resetPosition{
    self.contentOffset = self.returnPoint;
}

-(void)layoutSubviews{
    [self updateOverscrollSize];
}

-(void)updateOverscrollSize{
    self.overscroll = UIEdgeInsetsMake(self.overscrollSize.top ? (self.overscrollSize.top + self.frame.size.height) : 0, self.overscrollSize.left ? (self.overscrollSize.left + self.frame.size.width) : 0, self.overscrollSize.bottom ? (self.overscrollSize.bottom + self.frame.size.height) : 0, self.overscrollSize.right ? (self.overscrollSize.right + self.frame.size.width) : 0);
    
    self.contentSize = CGSizeMake(self.frame.size.width + self.overscroll.left + self.overscroll.right, self.frame.size.height + self.overscroll.top + self.overscroll.bottom);
    
    self.contentView.frame = CGRectMake(self.overscroll.left, self.overscroll.top, self.frame.size.width, self.frame.size.height);
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([self directionForContentOffset:*targetContentOffset] == JGOverscrollDirectionNone) {
        CGPoint returnPoint = self.returnPoint;
        targetContentOffset->x = returnPoint.x;
        targetContentOffset->y = returnPoint.y;
    }
}

-(JGOverscrollDirection)directionForContentOffset:(CGPoint)contentOffset{
    if (contentOffset.x >= self.contentSize.width-self.frame.size.width && self.overscrollSize.left) return JGOverscrollDirectionLeft;
    else if (contentOffset.x <= 0  && self.overscrollSize.right) return JGOverscrollDirectionRight;
    else if (contentOffset.y <= 0  && self.overscrollSize.bottom) return JGOverscrollDirectionDown;
    else if (contentOffset.y >= self.contentSize.height-self.frame.size.height && self.overscrollSize.top) return JGOverscrollDirectionUp;
    else return JGOverscrollDirectionNone;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self returnToCenter];
}

-(CGPoint)returnPoint{
    return CGPointMake(self.overscroll.left, self.overscroll.top);
}

-(void)returnToCenter{
    
    JGOverscrollDirection dir = [self directionForContentOffset:self.contentOffset];
    if (dir != JGOverscrollDirectionNone) [self.overscrollDelegate didOverscroll:dir];
    
    if ([self.overscrollDelegate shouldReturnFromDirection:dir]) {
        [self scrollRectToVisible:CGRectMake(self.returnPoint.x, self.returnPoint.y, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) [self returnToCenter];
}

@end
