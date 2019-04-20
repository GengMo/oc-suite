//
//  ViewController.m
//  startup
//
//  Created by 7 on 22/12/2017.
//  Copyright © 2017 7. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
//#import "WebSampleVC.h"
//#import "WebSampleVCByLabel.h"
//#import "WebSampleVCByTextView.h"
#import "AttributeLabelSampleVC.h"
#import "AttributeLabelSampleVCLite.h"
#import "RichTextEditorSampleVC.h"
//#import "WebSampleVCByJQuery.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "BadgeViewController.h"

@interface MainViewController () <TZImagePickerControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS App Write In Objective-C";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

//- (IBAction)onWeb {
//    WebSampleVC *c = [WebSampleVC new];
//    [self.navigationController pushViewController:c animated:YES];
//}
//
//- (IBAction)onWebByLabel:(id)sender {
//    WebSampleVCByLabel *c = [WebSampleVCByLabel new];
//    
//    [self.navigationController pushViewController:c animated:YES];
//}
//
//- (IBAction)onWebByTextView:(id)sender {
//    WebSampleVCByTextView *c = [WebSampleVCByTextView new];
//    
//    [self.navigationController pushViewController:c animated:YES];
//}

- (IBAction)onAttribtueLabel:(id)sender {
    AttributeLabelSampleVC *c = [AttributeLabelSampleVC new];
    
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)onAttributeLabelLite:(id)sender {
    AttributeLabelSampleVCLite *c = [AttributeLabelSampleVCLite new];
    
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)onRichTextEditor:(id)sender {
    RichTextEditorSampleVC *c = [RichTextEditorSampleVC new];
    
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)onWebByJQuery:(id)sender {
//    WebSampleVCByJQuery *c = [WebSampleVCByJQuery new];
//    
//    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)onShowImagePicker:(id)sender {
    // https://github.com/banchichen/TZImagePickerController
    // https://github.com/banchichen/TZImagePreviewController
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES; // 圆形裁剪框
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        INFO(@"picker one image")
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
