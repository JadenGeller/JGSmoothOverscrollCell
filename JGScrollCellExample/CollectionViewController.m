//
//  CollectionViewController.m
//  JGScrollCellExample
//
//  Created by Jaden Geller on 3/9/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "CollectionViewController.h"
#import "JGSmoothOverscrollCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGSmoothOverscrollCell *cell = (JGSmoothOverscrollCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CGFloat side = (collectionView.frame.size.width - cell.frame.size.width)/2.0;
    cell.scrollView.overscrollSize = UIEdgeInsetsMake(0, side, 0, side);
    
    if (!cell.scrollView.contentView.subviews.count){
        UIView *view = [[UIView alloc]init];
        [cell.scrollView.contentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        
        [cell.scrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view(50)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
        [cell.scrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];

    }
    [(UIView*)cell.scrollView.contentView setBackgroundColor:[UIColor colorWithHue:(double)indexPath.row/[collectionView numberOfItemsInSection:0] saturation:1 brightness:1 alpha:1]];
    
    [cell.scrollView resetPosition];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
