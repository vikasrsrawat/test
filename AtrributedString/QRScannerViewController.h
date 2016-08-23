//
//  QRScannerViewController.h
//  AtrributedString
//
//  Created by Admin on 03/08/16.
//  Copyright © 2016 Vikas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol QrDEl <NSObject>

-(void)addObjectToTable:(NSString *)url;

@end

@interface QRScannerViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

{
       id <QrDEl> _ob;
}
@property (strong) id ob;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UIButton *bbitemStart;
- (IBAction)start:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *Go;
- (IBAction)go:(UIButton *)sender;
@end
