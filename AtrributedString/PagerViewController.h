//
//  PagerViewConroller.h
//  AtrributedString
//
//  Created by Admin on 05/08/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagerViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;
@property (weak,nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *headingCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *scrollCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@end
