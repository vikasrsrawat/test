//
//  ViewController.m
//  AtrributedString
//
//  Created by Admin on 27/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "ViewController.h"

#import "AddressObject.h"
@interface ViewController ()
{
    bool open;
    ABPeoplePickerNavigationController *_addressBookController;
}

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    open=false;
    NSMutableAttributedString *attstring=[[NSMutableAttributedString alloc]init];
    [attstring appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"Vikas   "]];
    
    // Create Attachemnt
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    UIImage *imag=[UIImage imageNamed:@"rose_PNG639.png"];
    
    //Resize Image To The Font Size
    CGRect rect = CGRectMake(0,0,imag.size.width*self.lbl.font.pointSize/imag.size.height,self.lbl.font.pointSize);
    UIGraphicsBeginImageContext(rect.size );
    [imag drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    textAttachment.image = picture1;
    [[UIApplication sharedApplication] scheduledLocalNotifications];
    // Add Attachemnt Image
    
    [attstring appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    self.lbl.attributedText=attstring;
    
    [self.lbl sizeToFit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickAnimation:(UIButton *)sender
{
    
    /*  NSString *unfilteredString = @"!@#$%^&*()_+|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
     NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
     NSString *resultString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
     NSLog (@"Result: %@", resultString);
     
     
     NSArray *addr=[self addressBookLoader];
     for (AddressObject *asd in addr) {
     if (asd.contactNumber.count!=0) {
     
     NSString *phnmbr=[[[asd.contactNumber objectAtIndex:0] componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
     if (phnmbr.length>=10)
     {
     NSLog(@"name10  =%@   phone= %@",asd.contactName,phnmbr );
     NSString *subStr = [phnmbr substringWithRange:NSMakeRange(phnmbr.length-10, 10)];
     NSLog(@"name 10 =%@   phone= %@",asd.contactName,subStr );
     
     }
     }
     NSLog(@"name =%@   phone= %@",asd.contactName, asd.contactNumber );
     
     // NSString *trimmed = [foo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     }*/
    
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
    }
    
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:_addressBookController animated:YES completion:nil];
    
    
    /*
     //    [UIView beginAnimations:nil context:nil];
     //    [UIView setAnimationDuration:0.5];
     //   // [UIView setAnimationDelay:1.0];
     //  [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     //
     //   // self.viw.frame = CGRectMake(50, 50, 100, 100);
     //    self.viw.frame = CGRectMake(250, 350, 20, 30);;
     //
     //    [UIView commitAnimations];
     if(open)
     {
     CGRect rect = self.lbl.frame;
     rect.size.height=0;
     
     [UIView transitionWithView:self.lbl duration:1.5 options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut animations:^()
     {
     
     //  self.lbl.frame = rect;
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1.5];
     // [UIView setAnimationDelay:1.0];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     
     // self.viw.frame = CGRectMake(50, 50, 100, 100);
     // self.viw.frame = CGRectMake(250, 350, 20, 30);;
     self.lbl.frame = rect;
     [UIView commitAnimations];
     
     
     
     } completion:^(BOOL finished) {
     //  self.lbl.frame = rect;
     
     open=false;
     
     }];
     
     
     
     //        [UIView animateWithDuration:0.7
     //                              delay:0.0
     //                            options:UIViewAnimationOptionTransitionFlipFromRight
     //                         animations:^{
     //                             self.lbl.frame = rect;//CGRectMake(250, 350, 20, 30);
     //                         }
     //                         completion:^(BOOL finished) {
     //                             open=false;
     //
     //                         }];
     }
     else
     {
     
     CGRect rect = self.lbl.frame;
     rect.size.height=450;
     
     [UIView transitionWithView:self.lbl duration:1.5
     options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
     animations:^{
     // self.lbl.frame = rect;//CGRectMake(250, 350, 20, 30);
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1.5];
     // [UIView setAnimationDelay:1.0];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     
     // self.viw.frame = CGRectMake(50, 50, 100, 100);
     // self.viw.frame = CGRectMake(250, 350, 20, 30);;
     self.lbl.frame = rect;
     [UIView commitAnimations];
     
     
     }
     completion:^(BOOL finished) {
     // self.lbl.frame = rect;
     
     open=true;
     
     }];
     
     }*/
    
    
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSMutableArray *arrayofAddressClassObjects =[[NSMutableArray alloc]init];
    NSMutableArray *phoneNumber=[[NSMutableArray alloc]init] ;
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int i=0 ; i<ABMultiValueGetCount(phones);i++)
    {
        [phoneNumber addObject:(__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, i)];
    }
    
    if(phoneNumber != NULL)
    {
        AddressObject *obj = [[AddressObject alloc]init];
        obj.contactName = firstName;
        obj.contactNumber = phoneNumber;
        [arrayofAddressClassObjects addObject:obj];
        
    }
    NSCharacterSet *allowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    AddressObject *asd=[arrayofAddressClassObjects objectAtIndex:0];
    if (asd.contactNumber.count!=0)
    {
        NSString *phnmbr=[[[asd.contactNumber objectAtIndex:0] componentsSeparatedByCharactersInSet:allowedChars] componentsJoinedByString:@""];
        if (phnmbr.length>=10)
        {
            NSString *subStr = [phnmbr substringWithRange:NSMakeRange(phnmbr.length-10, 10)];
            NSLog(@"name 10 =%@   phone= %@",asd.contactName,subStr );
        }
    }
    
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}
@end
