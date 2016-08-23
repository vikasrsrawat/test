//
//  ViewAniamtionViewController.m
//  AtrributedString
//
//  Created by Admin on 28/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "ViewAniamtionViewController.h"

@interface ViewAniamtionViewController ()
{
    BOOL open;
}

@end

@implementation ViewAniamtionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    open=false;
    //[self.navigationController.navigationBar.topItem setTitle:@"View Aniamtion"];
self.navigationController.topViewController.title = @"View Aniamtion";
   NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                  target: self
                                                selector:@selector(startAnimation:)
                                                userInfo: nil repeats:YES];

    
   // [self performSelector:@selector(startAnimation:) withObject:nil afterDelay:2.0];
 //   [self performSelector:@selector(startAnimation:) withObject:nil afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
    
}


-(void)startAnimation:(NSTimer *)time
{
//Checking view Is Open
    if(open)
    {
        CGRect rect = self.viewAnimation.frame;
        rect.size.height=0;
        //Transition view for flip rotation animation
        [UIView transitionWithView:self.viewAnimation duration:1.5 options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut animations:^()
         {
             //Animation  for chnage of frame size
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:1.5];
             // [UIView setAnimationDelay:1.0];
             [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
             self.viewAnimation.frame = rect;
             [UIView commitAnimations];

         }completion:^(BOOL finished) {

             open=false;
             
         }];
    }
    else
    {
        //Transition view for flip rotation animation
        CGRect rect = self.viewAnimation.frame;
        rect.size.height=450;
        [UIView transitionWithView:self.viewAnimation duration:1.5
                           options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            //Animation  for chnage of frame size
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1.5];
                            // [UIView setAnimationDelay:1.0];
                            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                            self.viewAnimation.frame = rect;
                            [UIView commitAnimations];

                        }
                        completion:^(BOOL finished) {
                            open=true;
                            
                        }];
    }
}

@end
