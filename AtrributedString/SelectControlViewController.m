//
//  SelectControlViewController.m
//  AtrributedString
//
//  Created by Admin on 03/08/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "SelectControlViewController.h"
#import "LabelWithAttachmentViewController.h"
#import "ViewAniamtionViewController.h"
#import "AddressBookViewController.h"
#import "QRScannerViewController.h"
#import "NSstring+Contains.h"
#import "PagerViewController.h"
#import <sys/utsname.h>
#define _iphn6 [[UIScreen mainScreen] bounds].size.height == 568
@interface SelectControlViewController ()
{
    NSMutableArray *controlArray;
    QRScannerViewController *vc1;
}

@end

@implementation SelectControlViewController

- (void)viewDidLoad {
#if iphn6
    NSLog(@" yes");
#else
    NSLog(@" no");
#endif
  //  return NO;

[super viewDidLoad];
          self.navigationController.interactivePopGestureRecognizer.enabled = false;
    [self.navigationController.navigationBar.topItem setTitle:@"Please Select An Option"];
    controlArray=[[NSMutableArray alloc]initWithObjects:@"Attributed String",@"View Animation",@"Address Book",@"QR Scanner",@"Page View", nil];
    self.tblSelectControl.tableHeaderView=[UIView new];
    self.tblSelectControl.tableFooterView=[UIView new];
    NSLog(@"name %@",[self machineName]);
    NSString *macname=[self machineName];
    NSString* deviceType;
    if([macname isEqualToString:@"iPhone1,2"])
    {
        deviceType = @"iPhone 3G";
    }
    else if([macname isEqualToString:@"iPhone2,1"])
    {
        deviceType = @"iPhone 3GS";
    }
    else if([macname isEqualToString:@"iPhone3,1"] || [macname isEqualToString:@"iPhone3,2"] || [macname isEqualToString:@"iPhone3,3"])
    {
        deviceType = @"iPhone 4";
    }
    else if([macname isEqualToString:@"iPhone4,1"])
    {
        deviceType = @"iPhone 4S";
    }
    else if([macname isEqualToString:@"iPhone5,1"])
    {
        deviceType = @"iPhone 5";
    }
    else if([macname isEqualToString:@"iPod1,1"])
    {
        deviceType = @"iPod Touch 1G";
    }
    else if([macname isEqualToString:@"iPod2,1"] || [macname isEqualToString:@"iPod2,2"])
    {
        deviceType = @"iPod Touch 2G";
    }
    else if([macname isEqualToString:@"iPod3,1"])
    {
        deviceType = @"iPod Touch 3G";
    }
    else if([macname isEqualToString:@"iPod4,1"])
    {
        deviceType = @"iPod Touch 4G";
    }
    else if([macname isEqualToString:@"iPod5,1"])
    {
        deviceType = @"iPod Touch 5G";
    }
    NSLog(@"deviceType %@",deviceType);
    
    vc1=[[QRScannerViewController alloc]initWithNibName:@"QRScannerViewController" bundle:nil];
    vc1.ob=self;
}
-(NSString *)machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.fromNotification) {
        if ([self.fromNotification isKindOfClass:[NSString class]]) {
            if ([self.fromNotification isEqualToString:@"yes"])
            {
                [self navigateTo];
            }
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.fromNotification=@"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [controlArray count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString  *reusableIdentifier=@"Cell";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
    if (cell==nil) {
        
        cell=[tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    }
    cell.textLabel.text=[controlArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        LabelWithAttachmentViewController *vc=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row==1)
    {
        ViewAniamtionViewController *vc=[[ViewAniamtionViewController alloc]initWithNibName:@"ViewAniamtionViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==2)
    {
        AddressBookViewController *vc=[[AddressBookViewController alloc]initWithNibName:@"AddressBookViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==3)
    {
        QRScannerViewController *vc=[[QRScannerViewController alloc]initWithNibName:@"QRScannerViewController" bundle:nil];
        [self.navigationController pushViewController:vc1 animated:YES];
    }
    else if (indexPath.row==4)
    {
        PagerViewController *vc=[[PagerViewController alloc]initWithNibName:@"PagerViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        NSString *url= [[controlArray objectAtIndex:indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"text  %@",url);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

}

-(void)navigateTo
{
    UIViewController *vc;
    NSString *controller=self.viewController;
    if ([controller isEqualToString:@"LabelWithAttachmentViewController"] || [controller isEqualToString:@"1"] || [controller myContainsString:@"QR"] || [controller myContainsString:@"qr"])
    {
        vc=[[LabelWithAttachmentViewController alloc]initWithNibName:@"LabelWithAttachmentViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if ([controller isEqualToString:@"ViewAniamtionViewController"] || [controller isEqualToString:@"2"] || [controller myContainsString:@"ANIMATION"] || [controller myContainsString:@"animation"])
    {
        vc=[[ViewAniamtionViewController alloc]initWithNibName:@"ViewAniamtionViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([controller isEqualToString:@"AddressBookViewController"] || [controller isEqualToString:@"3"] || [controller myContainsString:@"ADDRESS"] || [controller myContainsString:@"address"])
    {
        vc=[[AddressBookViewController alloc]initWithNibName:@"AddressBookViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([controller isEqualToString:@"QRScannerViewController"] || [controller isEqualToString:@"4"] || [controller myContainsString:@"QR"] || [controller myContainsString:@"qr"] )
    {
//        QRScannerViewController *vc=[[QRScannerViewController alloc]initWithNibName:@"QRScannerViewController" bundle:nil];
        [self.navigationController pushViewController:vc1 animated:YES];
    }
}
-(void)addObjectToTable:(NSString *)url
{
    [controlArray addObject:url];
    [self.tblSelectControl reloadData];
}
@end
