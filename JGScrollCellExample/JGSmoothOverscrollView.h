//
//  JGSmoothOverscrollView.h
//  JGScrollCellExample
//
//  Created by Jaden Geller on 3/9/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JGOverscrollDirectionNone,
    JGOverscrollDirectionUp,
    JGOverscrollDirectionDown,
    JGOverscrollDirectionLeft,
    JGOverscrollDirectionRight
} JGOverscrollDirection;

@protocol JGSmoothOverscollViewDelegate <NSObject>

-(void)didOverscroll:(JGOverscrollDirection)direction;
-(BOOL)shouldReturnFromDirection:(JGOverscrollDirection)direction;

@end

@interface JGSmoothOverscrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic) UIEdgeInsets overscrollSize;
@property (nonatomic, readonly) UIView *contentView;

-(void)resetPosition;

@property (nonatomic, weak) id<JGSmoothOverscollViewDelegate> overscrollDelegate;

@end
