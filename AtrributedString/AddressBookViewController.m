//
//  AddressBookViewController.m
//  AtrributedString
//
//  Created by Admin on 28/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "AddressBookViewController.h"

@interface AddressBookViewController ()
{
    ABPeoplePickerNavigationController *_addressBookController;
    NSMutableArray *contactPhoneNumbers;
    UIView *popView;
    NSString *selectedNumber;
}

@end

@implementation AddressBookViewController
@synthesize innerView;
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.navigationController.navigationBar.topItem setTitle:@"Address Book"];
    self.navigationController.topViewController.title =@"Address Book";

    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePopUp:)];
    popView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
  // innerView.frame=CGRectMake(10, 100, 250, 200);
    innerView.center=popView.center;
    innerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:innerView];
    popView.backgroundColor=[UIColor blackColor];
    innerView.hidden=YES;
    popView.alpha=0.0;
    popView.hidden=YES;
    [self.view addSubview:popView];
    [self.view addSubview:innerView];
    tapgesture.numberOfTapsRequired = 1;
    [popView addGestureRecognizer:tapgesture];
    contactPhoneNumbers=[[NSMutableArray alloc]init];
}

- (void)removePopUp:(UITapGestureRecognizer *)gesture {
    innerView.hidden=YES;
    popView.alpha=0.0;
    popView.hidden=YES;
}

-(void)removePopUp
{
    innerView.hidden=YES;
    popView.alpha=0.0;
    popView.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    if (contactPhoneNumbers.count==1)
    {
        self.lblContactPhoneNumber.text=[contactPhoneNumbers objectAtIndex:0];
    }
    else if(contactPhoneNumbers.count!=0)
    {
        popView.hidden=NO;
        [self.tblContactNumber reloadData];

        [UIView transitionWithView:popView duration:0.0
                           options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            selectedNumber=@"";
                            [self adjustHeightOfTableview];
                            popView.alpha=0.5;
                            innerView.hidden=NO;
                        }
                        completion:^(BOOL finished)
        {
         }];
    }
    else
    {
        self.lblContactPhoneNumber.text=@"No Number Found";
    }

}

- (IBAction)getContactPhoneNumber:(UIButton *)sender {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted)
    {
        UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [cantAddContactAlert show];
        NSLog(@"Denied");
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        NSLog(@"Authorized");
    }
    else
    {
        //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                //4
                NSLog(@"Just denied");
                return;
            }
            //5
            NSLog(@"Just authorized");
        });
        NSLog(@"Not determined");
    }
    
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    _addressBookController.peoplePickerDelegate=self;
    [self presentViewController:_addressBookController animated:YES completion:nil];
}


///for ios 8 and above
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
   // NSMutableArray *arrayofAddressClassObjects =[[NSMutableArray alloc]init];
    NSMutableArray *phoneNumber=[[NSMutableArray alloc]init] ;
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int i=0 ; i<ABMultiValueGetCount(phones);i++)
    {
        [phoneNumber addObject:(__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, i)];
    }
    
    //    if(phoneNumber != NULL)
    //    {
    //
    //        AddressObject *obj = [[AddressObject alloc]init];
    //        obj.contactName = firstName;
    //        obj.contactNumber = phoneNumber;
    //
    //        [arrayofAddressClassObjects addObject:obj];
    //    }
    contactPhoneNumbers=[[NSMutableArray alloc]init];
    NSCharacterSet *allowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    // AddressObject *asd=[arrayofAddressClassObjects objectAtIndex:0];
    if (phoneNumber.count!=0)
    {
        for (int i=0 ; i<phoneNumber.count; i++) {
            NSString *phnmbr=[[[phoneNumber objectAtIndex:i] componentsSeparatedByCharactersInSet:allowedChars] componentsJoinedByString:@""];
            if (phnmbr.length>=10)
            {
                NSString *subStr = [phnmbr substringWithRange:NSMakeRange(phnmbr.length-10, 10)];
                [contactPhoneNumbers addObject:subStr];
            }
        }
        if (contactPhoneNumbers.count==1)
        {
            self.lblContactPhoneNumber.text=[contactPhoneNumbers objectAtIndex:0];
            
        }
        else if(contactPhoneNumbers.count!=0)
        {
            [self.tblContactNumber reloadData];
            [UIView transitionWithView:popView duration:1.5
                               options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                popView.alpha=1.0;
                            }
                            completion:^(BOOL finished) {
                                
                            }];
        }
        else
        {
            self.lblContactPhoneNumber.text=@"No Number Found";
        }
    }
    else
    {
        self.lblContactPhoneNumber.text=@"No Number Found";
    }
    
    if (firstName==nil || [firstName isKindOfClass:[NSNull class]] || [firstName isEqualToString:@"<null>"] || [firstName isEqualToString:@"<nil>"])
    {
        self.lblContactName.text=@"NA";
    }
    else{
        self.lblContactName.text=firstName;
        
    }
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}


// Below ios 8
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    //NSMutableArray *arrayofAddressClassObjects =[[NSMutableArray alloc]init];
    NSMutableArray *phoneNumber=[[NSMutableArray alloc]init] ;
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int i=0 ; i<ABMultiValueGetCount(phones);i++)
    {
        [phoneNumber addObject:(__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, i)];
    }
    
    //    if(phoneNumber != NULL)
    //    {
    //
    //        AddressObject *obj = [[AddressObject alloc]init];
    //        obj.contactName = firstName;
    //        obj.contactNumber = phoneNumber;
    //
    //        [arrayofAddressClassObjects addObject:obj];
    //    }
    contactPhoneNumbers=[[NSMutableArray alloc]init];
    NSCharacterSet *allowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    // AddressObject *asd=[arrayofAddressClassObjects objectAtIndex:0];
    if (phoneNumber.count!=0)
    {
        for (int i=0 ; i<phoneNumber.count; i++) {
            NSString *phnmbr=[[[phoneNumber objectAtIndex:i] componentsSeparatedByCharactersInSet:allowedChars] componentsJoinedByString:@""];
            if (phnmbr.length>=10)
            {
                NSString *subStr = [phnmbr substringWithRange:NSMakeRange(phnmbr.length-10, 10)];
                [contactPhoneNumbers addObject:subStr];
            }
        }
        if (contactPhoneNumbers.count==1)
        {
            self.lblContactPhoneNumber.text=[contactPhoneNumbers objectAtIndex:0];

        }
        else if(contactPhoneNumbers.count!=0)
        {
            [self.tblContactNumber reloadData];
            [UIView transitionWithView:popView duration:1.5
                               options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                popView.alpha=1.0;

                            }
                            completion:^(BOOL finished) {
                                
                            }];

            
        }
        else
        {
            self.lblContactPhoneNumber.text=@"No Number Found";
        }
    }
    else
    {
        self.lblContactPhoneNumber.text=@"No Number Found";
    }
    
    if ([self isEqual:firstName])
    {
        self.lblContactName.text=@"NA";
    }
    else{
        self.lblContactName.text=firstName;
    }
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    return NO;
}


-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [contactPhoneNumbers count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [contactPhoneNumbers objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedNumber=[contactPhoneNumbers objectAtIndex:indexPath.row];
}
- (void)adjustHeightOfTableview
{
    CGFloat height = self.tblContactNumber.contentSize.height;
    CGFloat maxHeight =[UIScreen mainScreen].bounds.size.height-208;
    
   // self.tblContactNumber.superview.frame.size.height - self.tblContactNumber.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    NSLog(@"height %f",height);
    NSLog(@"height %f",maxHeight);

    if (height > maxHeight)
        height = maxHeight;
        
   // [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.innerView.frame;
        frame.size.height = self.innerView.frame.size.height+ height- self.tblContactNumber.frame.size.height;
        self.innerView.frame = frame;
        innerView.center=popView.center;

 //   }];
}

- (IBAction)onClickCancel:(UIButton *)sender {
    selectedNumber=@"";
    [self removePopUp];

}

- (IBAction)onClickSelectButton:(UIButton *)sender {
    if (![self isNULL:selectedNumber]) {
        _lblContactPhoneNumber.text=selectedNumber;

    }
    [self removePopUp];
}


-(BOOL)isNULL:(id)str
{
    if ([str isKindOfClass:[NSString class] ]) {
     
    if([str length] >0 && ![str isEqualToString:@""] && ![str isEqualToString:@"<null>"] && ![str isEqualToString:@"(null)"] && ![str isKindOfClass:[NSNull class]])
    {
        return  NO;
    }
    else
        return YES;
    }
    return YES;
}
@end
