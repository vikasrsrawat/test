//
//  AddressBookViewController.h
//  AtrributedString
//
//  Created by Admin on 28/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddressBookViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblContactNumber;
- (IBAction)onClickCancel:(UIButton *)sender;
- (IBAction)onClickSelectButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (weak, nonatomic) IBOutlet UILabel *lblContactName;
@property (weak, nonatomic) IBOutlet UILabel *lblContactPhoneNumber;
- (IBAction)getContactPhoneNumber:(UIButton *)sender;

@end
