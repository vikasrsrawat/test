//
//  LabelWithAttachmentViewController.m
//  AtrributedString
//
//  Created by Admin on 28/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "LabelWithAttachmentViewController.h"

@interface LabelWithAttachmentViewController ()

@end

@implementation LabelWithAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar.topItem setTitle:@"Label Attachment"];
    self.navigationController.topViewController.title = @"Label Attachment";

    // Create Attributed String
    NSMutableAttributedString *attstring=[[NSMutableAttributedString alloc]init];
    [attstring appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"Vikas   "]];
    
    // Create Attachemnt
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    UIImage *imag=[UIImage imageNamed:@"rose_PNG639.png"];
    
    //Resize Image To The Font Size
    CGRect rect = CGRectMake(0,0,imag.size.width*self.lblAttrbutedString.font.pointSize/imag.size.height,self.lblAttrbutedString.font.pointSize);
    UIGraphicsBeginImageContext(rect.size );
    [imag drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    textAttachment.image = picture1;
    
    // Add Attachemnt Image
    [attstring appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    self.lblAttrbutedString.attributedText=attstring;
    
    [self.lblAttrbutedString sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
