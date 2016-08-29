//
//  JAPagingView.m
//  JAImagePagingView
//
//  Created by Jitendra on 8/17/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

#import "JAPagingView.h"
#define CurrentPageIndicatorTintColor  [UIColor orangeColor];
#define PageIndicatorTintColor         [UIColor lightGrayColor];
@implementation JAPagingView
{
    UICollectionView *aCollectionView;
    UICollectionViewFlowLayout * layout;
    UIPageControl *pageControl;
    NSTimer *timer;
}

-(void)awakeFromNib
{
 
    
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self UISetup];
        
    }
    return self;
    
}
#pragma Mark :-  working on collection view with pahecontrol.

-(void)UISetup
{
   
    layout=[[UICollectionViewFlowLayout alloc] init];
    aCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, self.frame.size.height) collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    aCollectionView.pagingEnabled = YES;
    [aCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    aCollectionView.delegate = (id)self;
    aCollectionView.dataSource = (id)self;
    aCollectionView.backgroundColor = [UIColor clearColor];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    aCollectionView.showsVerticalScrollIndicator = NO;
    aCollectionView.showsHorizontalScrollIndicator = NO;
    pageControl.currentPage = 0;
    pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor =  CurrentPageIndicatorTintColor;
    pageControl.pageIndicatorTintColor        =  PageIndicatorTintColor;
    [self addSubview:aCollectionView];
    [self addTimer];  // start a timer first time.
    
}
/* *****************************  Start Collection View Delagate ***********************************/

#pragma Mark: - Collection View Delagte And Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _arrItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    UIImage *aImage = [UIImage imageNamed:[_arrItems objectAtIndex:indexPath.row]];
    aImageView.image = aImage;
    
    [cell addSubview:aImageView];
    cell.backgroundColor=[UIColor greenColor];
    pageControl.frame = CGRectMake(cell.frame.size.width/2,cell.frame.size.height -10,0,0);
    pageControl.numberOfPages = _arrItems.count;
    [cell addSubview:pageControl];
 
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = aCollectionView.frame.size.width;
    pageControl.currentPage = aCollectionView.contentOffset.x / pageWidth;
    [self addTimer]; // add Timer when scroll colletions view

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

// *************************** End Collection view Delagte ***********************************************

#pragma Mark :-  Add timer Function.
- (void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage
{
    // 1.back to the middle of sections
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.next position
    NSInteger nextItem = currentIndexPathReset.item+1;
    NSInteger nextSection = currentIndexPathReset.section;
    pageControl.currentPage = nextItem;
    if (nextItem == _arrItems.count) {
        nextItem = 0;
          pageControl.currentPage = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    
    // 3.scroll to next position
    [aCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSIndexPath *)resetIndexPath
{
    // currentIndexPath
    NSIndexPath *currentIndexPath = [[aCollectionView indexPathsForVisibleItems] lastObject];
    // back to the middle of sections
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    [aCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}
#pragma Mark :- Remove Timer.
- (void)removeTimer
{
    // stop NSTimer
    [timer invalidate];
    // clear NSTimer
    timer = nil;
}


@end
