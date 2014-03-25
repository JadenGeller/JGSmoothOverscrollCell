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
    
    _contentView = [[UIView alloc]init];
    [super addSubview:_contentView];
    
    
    self.backgroundColor = [UIColor clearColor];
    
//    [self observeValueForKeyPath:@"frame" ofObject:self change:nil context:0];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//
//    [self updateOverscrollSize];
//}

//-(void)setBounds:(CGRect)bounds{
//    [super setBounds:bounds];
//    [self updateOverscrollSize];
////    NSLog(@"bo %@",NSStringFromCGRect(bounds));
//}
//
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateOverscrollSize];
}

-(void)setOverscrollSize:(UIEdgeInsets)overscrollSize{
//    BOOL isCentered = CGPointEqualToPoint(self.returnPoint, self.contentOffset);
    
    _overscrollSize = overscrollSize;

    [self updateOverscrollSize];
//    if (isCentered) [self resetPosition];
}

-(void)resetPosition{
    self.contentOffset = self.returnPoint;
}

-(BOOL)overscrollVertical{
    return (self.overscroll.top + self.overscroll.bottom > 0);
}

-(BOOL)overscrollHorizontal{
    return (self.overscroll.left + self.overscroll.right > 0);
}

-(void)updateOverscrollSize{
    self.overscroll = UIEdgeInsetsMake(self.overscrollSize.top ? (self.overscrollSize.top + self.frame.size.height) : 0, self.overscrollSize.left ? (self.overscrollSize.left + self.frame.size.width) : 0, self.overscrollSize.bottom ? (self.overscrollSize.bottom + self.frame.size.height) : 0, self.overscrollSize.right ? (self.overscrollSize.right + self.frame.size.width) : 0);
    
    self.contentSize = CGSizeMake(self.frame.size.width + self.overscroll.left + self.overscroll.right, self.frame.size.height + self.overscroll.top + self.overscroll.bottom);
    
    self.contentView.frame = CGRectMake(self.overscroll.left, self.overscroll.top, self.frame.size.width, self.frame.size.height);
    
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.overscroll));
    
    //[self resetPosition];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
