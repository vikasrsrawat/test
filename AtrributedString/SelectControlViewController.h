//
//  SelectControlViewController.h
//  AtrributedString
//
//  Created by Admin on 03/08/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScannerViewController.h"

@interface SelectControlViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,QrDEl>
@property (weak, nonatomic) IBOutlet UITableView *tblSelectControl;
@property (strong, nonatomic) IBOutlet NSString *viewController;
@property (strong, nonatomic) IBOutlet NSString *fromNotification;

@end
