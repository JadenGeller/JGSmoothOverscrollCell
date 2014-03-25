//
//  JGScrollCell.h
//  JGScrollCellExample
//
//  Created by Jaden Geller on 3/9/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGSmoothOverscrollView.h"

@interface JGSmoothOverscrollCell : UICollectionViewCell <JGSmoothOverscollViewDelegate>

@property (nonatomic, readonly) JGSmoothOverscrollView *scrollView;

@end
