//
//  ImageDownloader.m
// fallen.ink
//
//  Created by fallen on 15/9/7.
//
//

#import "ImageDownloader.h"
#import <SDWebImage/SDWebImageManager.h>

static NSMutableArray* downloaderArray = nil;

@interface ImageDownloader ()

@property (nonatomic, copy) ImageBlock downloadSuccessBlock;
@property (nonatomic, copy) ErrorBlock downloadFailBlock;
@property (nonatomic, copy) FloatBlock downloadProgressBlock;

@end

@implementation ImageDownloader

@def_singleton( ImageDownloader )

+ (void)initialize {
    downloaderArray = [NSMutableArray new];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [downloaderArray addObject:self];
    }
    return self;
}

- (void)downloadWithUrl:(NSString*)url success:(ImageBlock)success fail:(ErrorBlock)fail progress:(FloatBlock)progress {
    LOG(@"下载图片URL:%@",url);
    
    self.downloadSuccessBlock = success;
    self.downloadFailBlock = fail;
    self.downloadProgressBlock = progress;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    SDWebImageOptions downloadOption = SDWebImageRetryFailed;
    if (self.downloadProgressBlock) {
        downloadOption |= SDWebImageProgressiveDownload;
    }
    [manager.imageDownloader downloadImageWithURL:[NSURL URLWithString:url]
                                          options:downloadOption
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                             if (self.downloadProgressBlock) {
                                                 [main_queue execute:^{
                                                     self.downloadProgressBlock((float)receivedSize/expectedSize);
                                                 }];
                                             }
                                         } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                             if (finished) {
                                                 if (image) {
                                                     //下载成功
                                                     if(self.downloadSuccessBlock){
                                                         [main_queue execute:^{
                                                             self.downloadSuccessBlock(image);
                                                             [self downloadDone];
                                                         }];
                                                     }
                                                 }else if(error){
                                                     //下载失败
                                                     if(self.downloadFailBlock){
                                                         [main_queue execute:^{
                                                             self.downloadFailBlock(error);
                                                             [self downloadDone];
                                                         }];
                                                     }
                                                 }
                                             }
                                         }];
}

#pragma mark - Private Method

- (void)downloadDone {
    self.downloadFailBlock = nil;
    self.downloadProgressBlock = nil;
    self.downloadSuccessBlock = nil;
    [downloaderArray removeObject:self];
}

@end
