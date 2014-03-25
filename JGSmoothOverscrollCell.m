//
//  JGScrollCell.m
//  JGScrollCellExample
//
//  Created by Jaden Geller on 3/9/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGSmoothOverscrollCell.h"

@interface JGSmoothOverscrollCell ()

@property (nonatomic) JGSmoothOverscrollView *scrollView;

@end

@implementation JGSmoothOverscrollCell

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedInit_JGSmoothOverscrollCell];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit_JGSmoothOverscrollCell];
    }
    return self;
}

-(void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    self.scrollView.frame = self.bounds;
}

-(void)sharedInit_JGSmoothOverscrollCell{
    [self addSubview:self.scrollView];
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
   
}

-(JGSmoothOverscrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[JGSmoothOverscrollView alloc]init];
        _scrollView.overscrollDelegate = self;
    }
    return _scrollView;
}

-(void)didOverscroll:(JGOverscrollDirection)direction{
    NSLog(@"We moved in the direction with identfier #%i",direction);
}

-(BOOL)shouldReturnFromDirection:(JGOverscrollDirection)direction{
    return (direction != JGOverscrollDirectionRight);
}

@end
