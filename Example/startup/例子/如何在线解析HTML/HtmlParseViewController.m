//
//  HtmlParseViewController.m
//  startup
//
//  Created by fallen.ink on 2019/6/2.
//  Copyright © 2019 7. All rights reserved.
//

#import "HtmlParseViewController.h"
#import "AppDelegate.h"
#import <Framework/GDataXMLNode.h>
#import <Framework/AnimatedImage.h>
#import <Framework/AnimatedImageView.h>

@interface HtmlParseViewController ()
@property (nonatomic, strong) _NetJsonRPC *net;
@property (nonatomic, strong) _NetHost *host;
@property (nonatomic, strong) AnimatedImageView *imageView;
@end

@implementation HtmlParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // https://hanyu.baidu.com/s?wd={word}&cf=rcmd&t=img&ptype=zici
    
    self.host = [[_NetHost alloc] initWithHostName:@"hanyu.baidu.com"];
    
    self.host.defaultParameterEncoding = NetRequestParameterEncodingURL;
    self.host.secureHost = YES;
    
    // 3
    if (!self.imageView) {
        self.imageView = [[AnimatedImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 88, screen_width, screen_width);
    
    _NetRequest *request = [self.host requestWithPath:@"s" params:@{
                                                                    @"wd": @"你",
                                                                    @"cf":@"rcmd",
                                                                    @"t":@"img",
                                                                    @"ptype":@"zici"
                                                                    } httpMethod:@"GET"];

    [request addCompletionHandler:^(_NetRequest *completedRequest) {
        NSString *htmlStr = completedRequest.responseAsString;
        
        GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithHTMLString:htmlStr error:NULL];
        NSArray<GDataXMLNode *> *nodes = [doc nodesForXPath:@"//img[@id=\"word_bishun\"]/@data-gif" error:NULL];
        
        if (nodes.count > 0) {
            GDataXMLNode *node = nodes[0];
            
            LOG(@"%@", [node stringValue])
            
            NSString *imgURLStr = [node stringValue];
            [self loadAnimatedImageWithURL:[NSURL URLWithString:imgURLStr] completion:^(AnimatedImage *animatedImage) {
                self.imageView.animatedImage = animatedImage;
                
                // Set up debug UI for image 3
                
                self.imageView.userInteractionEnabled = YES;
            }];
        }
        

    }];
    
    [self.host startRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(AnimatedImage *animatedImage))completion {
    NSString *const filename = url.lastPathComponent;
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    AnimatedImage * __block animatedImage = [[AnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[AnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}

@end
