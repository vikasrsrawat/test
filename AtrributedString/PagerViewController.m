//
//  PagerViewConroller.m
//  AtrributedString
//
//  Created by Admin on 05/08/16.
//  Copyright © 2016 Paymate. All rights reserved.
//https://www.dropbox.com/s/uc1hare4s51bfbv/vivek%20deore.zip?dl=0

#import "PagerViewController.h"
#import "HeadingCollectionViewCell.h"
#import "ScrollCollectionViewCell.h"
#import "QRScannerViewController.h"
#import "AddressBookViewController.h"
#import "LabelWithAttachmentViewController.h"
#import "ViewAniamtionViewController.h"
#import "SelectControlViewController.h"
#import "DeviceConstant.h"

static NSString *headingCellIdentifer=@"HeadingCollectionViewCell";
static NSString *scrollCellIdentifer=@"ScrollCollectionViewCell";

@interface PagerViewController ()
{
    NSArray *arrHeading;
    CGFloat screenWidth;
    int selectedCell;
    NSIndexPath *currentItem;
    bool scrollBottom;
    CGPoint lasttranslation;
    UILabel *lblScroll;
    NSMutableArray *headingCellWidth;
}

@end

@implementation PagerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    selectedCell=0;
    arrHeading=[[NSArray alloc]initWithObjects:@"Virtual Address",@"Mobile Number",@"A/C No",@"Aadhaar", nil];
    headingCellWidth=[[NSMutableArray alloc]init];
    scrollBottom=false;
    screenWidth=[UIScreen mainScreen].bounds.size.width;
    if (IS_IPHONE4) {
            self.backScrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*568/320);
    }

    [self.headingCollectionView registerClass:[HeadingCollectionViewCell class] forCellWithReuseIdentifier:headingCellIdentifer];
    UINib *nib = [UINib nibWithNibName:headingCellIdentifer bundle:nil];
    [self.headingCollectionView registerNib:nib forCellWithReuseIdentifier:headingCellIdentifer];
    UINib *nib1 = [UINib nibWithNibName:scrollCellIdentifer bundle:nil];
    [self.scrollCollectionView registerNib:nib1 forCellWithReuseIdentifier:scrollCellIdentifer];
   
    for (NSString *str in arrHeading) {
        CGRect labelRect = [str
                            boundingRectWithSize:CGSizeMake(1000, 1000)
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] }
                            context:nil];
        [headingCellWidth addObject:[NSString stringWithFormat:@"%f",labelRect.size.width+20]];
    
    }
    lblScroll=[[UILabel alloc]initWithFrame:CGRectMake(10, self.headingCollectionView.frame.size.height-10,[[headingCellWidth objectAtIndex:0] floatValue]-20, 6)];
    lblScroll.layer.cornerRadius=3;
    [lblScroll.layer setMasksToBounds:YES];
    [lblScroll setBackgroundColor:[UIColor redColor]];
    [self.headingCollectionView addSubview:lblScroll];
}

-(void)viewDidAppear:(BOOL)animated
{
    currentItem=[NSIndexPath indexPathForRow:0 inSection:0];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrHeading count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==10) {
        HeadingCollectionViewCell *cell=(HeadingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:headingCellIdentifer forIndexPath:indexPath];
   
        if (selectedCell==indexPath.row) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[arrHeading objectAtIndex:indexPath.row] attributes:nil]];
            [cell.lblHeading setTextColor:[UIColor redColor]];
            cell.lblHeading.attributedText=attributedString;
        }
        else
        {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[arrHeading objectAtIndex:indexPath.row] attributes:nil]];
            [cell.lblHeading setTextColor:[UIColor blackColor]];
            cell.lblHeading.attributedText=attributedString;
        }
        return cell;
    }
    else
    {
        ScrollCollectionViewCell *cell=(ScrollCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:scrollCellIdentifer forIndexPath:indexPath];
        
        if (indexPath.row==0) {
            LabelWithAttachmentViewController *qra=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
            [cell.contentView addSubview:qra.view];
        }
        else if (indexPath.row==1)
        {        LabelWithAttachmentViewController *qra=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
            [cell.contentView addSubview:qra.view];
        }
        else if (indexPath.row==2)
        {
            LabelWithAttachmentViewController *qra=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
            [cell.contentView addSubview:qra.view];
        }
        else if (indexPath.row==3)
        {
            LabelWithAttachmentViewController *qra=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
            [cell.contentView addSubview:qra.view];
        }
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==10) {
    selectedCell=(int)indexPath.row;
    currentItem=indexPath;
    scrollBottom=false;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    //centr.x=cell.center.x;
    CGRect rect=lblScroll.frame;
    rect.origin.x=cell.frame.origin.x+10;
    rect.size.width=cell.frame.size.width-20;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    // [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    lblScroll.frame=rect;
    [self.headingCollectionView reloadData];
    [UIView commitAnimations];

    [self.headingCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.scrollCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout*)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==10)
    {
        CGRect labelRect = [[arrHeading objectAtIndex:indexPath.row]
                            boundingRectWithSize:CGSizeMake(1000, 1000)
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] }
                            context:nil];
        CGSize cellSize=CGSizeMake(labelRect.size.width+20, collectionView.frame.size.height);
        return  cellSize;
    }
    else if (collectionView.tag==20)
    {
        CGSize cellSize=CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
        return  cellSize;
    }
    return CGSizeMake(0, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isKindOfClass:[UICollectionView class]] && scrollBottom)
    {
        if (scrollView.tag==20)
        {
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if (lasttranslation.x == translation.x) {
                return;
            }
            NSIndexPath *nextItem;
            if(lasttranslation.x > translation.x)
            {
                if (currentItem.row==[arrHeading count]-1)
                {
                    NSLog(@"right return");
                    return;
                }
                NSLog(@"right ");
                nextItem = [NSIndexPath indexPathForItem:currentItem.item + 1 inSection:currentItem.section];
                UICollectionViewCell *cell = (UICollectionViewCell *)[self.headingCollectionView
                                                                      cellForItemAtIndexPath:nextItem];
                scrollBottom=false;
                CGRect rect=lblScroll.frame;
                rect.origin.x=cell.frame.origin.x+10;
                rect.size.width=cell.frame.size.width-20;
                [UIView transitionWithView:lblScroll duration:0.5
                                   options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                animations:^{
                                    lblScroll.frame=rect;

                                    //Animation  for chnage of frame size
                                    [UIView beginAnimations:nil context:nil];
                                    [UIView setAnimationDuration:0.5];
                                    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                    lblScroll.frame=rect;
                                    [UIView commitAnimations];
                                    
                                }
                                completion:^(BOOL finished) {
                                    
                                }];
                [self.headingCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                [self.scrollCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                selectedCell=(int)nextItem.row;
                [self.headingCollectionView reloadData];
            }
            else
            {
                NSLog(@"Left ");
                if (currentItem.row==0) {
                    NSLog(@"left return");
                    return;
                }
                NSLog(@"left");
                nextItem = [NSIndexPath indexPathForItem:currentItem.item - 1 inSection:currentItem.section];
                UICollectionViewCell *cell = (UICollectionViewCell *)[self.headingCollectionView cellForItemAtIndexPath:nextItem];
                scrollBottom=false;
                CGRect rect=lblScroll.frame;
                rect.origin.x=cell.frame.origin.x+10;
                rect.size.width=cell.frame.size.width-20;
                [UIView transitionWithView:lblScroll duration:0.5
                                   options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                animations:^{
                                    //Animation  for chnage of frame size
                                    lblScroll.frame=rect;

                                    [UIView beginAnimations:nil context:nil];
                                    [UIView setAnimationDuration:0.5];
                                    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                    lblScroll.frame=rect;
                                    
                                    [UIView commitAnimations];
                                    
                                }
                                completion:^(BOOL finished) {
                                    
                                }];
                [self.headingCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
               [self.scrollCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                selectedCell=(int)nextItem.row;
                [self.headingCollectionView reloadData];
            }
            currentItem=nextItem;
            scrollBottom=false;
            scrollView.scrollEnabled = NO;
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if([scrollView isKindOfClass:[UICollectionView class]])
    {
        if (scrollView.tag==20)
        {
            scrollBottom=false;
            scrollView.scrollEnabled = YES;;
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    if([scrollView isKindOfClass:[UICollectionView class]] )
    {
        if (scrollView.tag==20) {
            scrollView.scrollEnabled = YES;;
            lasttranslation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            scrollBottom=true;
        }
    }
    
}
@end
