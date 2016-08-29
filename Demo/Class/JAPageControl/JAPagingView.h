//
//  JAPagingView.h
//  JAImagePagingView
//
//  Created by Jitendra on 8/17/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAPagingView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
/*
 *
 *  Add the array of images.
 */
@property(nonatomic,strong)NSArray *arrItems;
@end
