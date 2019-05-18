#import <_Foundation/_Foundation.h>
#import "ShareHelper.h"

@interface ShareHelper ()

@property (nonatomic, strong) NSString *originUrl;

@end

@implementation ShareHelper

#pragma mark - Url helper

+ (instancetype)withUrl:(NSString *)url {
    ShareHelper *h = [ShareHelper new];
    h.originUrl = url;
    
    return h;
}

- (NSString *)getUrlWithChannelled {
    __block NSString *channelId = nil;
    
    return [self.class convertUrl:self.originUrl withChannelId:channelId enabled:YES];
}

+ (NSString *)convertUrl:(NSString *)originUrl withChannelId:(NSString *)channelId enabled:(BOOL)enabled {
    if (!enabled) {
        return originUrl;
    }
    
    NSString *url = nil;
    NSRange questionMarkRange = [originUrl rangeOfString:@"?"];
    
    if (questionMarkRange.location != NSNotFound) {
        url = [originUrl stringByAppendingString:[NSString stringWithFormat:@"&channelId=%@", channelId]];
    } else {
        url = [originUrl stringByAppendingString:[NSString stringWithFormat:@"?channelId=%@", channelId]];
    }
    
    return url;
}
    

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
    
+ (NSData *)compressThumbImage:(UIImage *)desImage {
    NSData *thumbData = nil;
    if (desImage) {
        UIImage* thumbImg = [self scaleToSize:desImage size:CGSizeMake(150, 150)];
        //缩略图数据大小不能超过32K
        float compressRate = 1.0f;
        thumbData = UIImageJPEGRepresentation(thumbImg, compressRate);
        while(thumbData.length > 32*1024) {
            compressRate = compressRate * 0.5;
            thumbData = UIImageJPEGRepresentation(thumbImg, compressRate);
            if(compressRate < 0.1)
            break;
        }
    }
    
    LOG(@"微信缩略图大小%tu", thumbData.length);
    
    return thumbData;
}

@end
