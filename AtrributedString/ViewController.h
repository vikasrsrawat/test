//
//  ViewController.h
//  AtrributedString
//
//  Created by Admin on 27/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIView *viw;

- (IBAction)onClickAnimation:(UIButton *)sender;

@end

