//
//  Note.m
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "Note.h"

@implementation Note

    //  coreData 部份
@dynamic text;
@dynamic imageName;

    //  NSCoding 部份
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];     //  now's super is NSObject
    if (self) {
        self.text = [coder decodeObjectForKey:@"text"];
        self.imageName = [coder decodeObjectForKey:@"imageName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    
}


-(UIImage *) image{
    
    NSString *documentsPath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];   //   抓 home/Documents/ 的路徑
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:self.imageName];  //  抓"UUID" .jpg 路徑 在 home/Documents/底下
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

-(UIImage *) thumbnailImage {
    
    UIImage *image = [self image];
    if ( !image ){
        return nil;
    }
    CGSize thumbnailSize = CGSizeMake(50, 50);      //  畫布大小
    CGFloat scale = [UIScreen mainScreen].scale;    //  scale=> { 1x 2x 3x}
    UIGraphicsBeginImageContextWithOptions(thumbnailSize, NO, scale);   //  NO =>  表示不看底圖是否有alpha 4 Bytes => 3 Bytes
//    CGContextRef context = UIGraphicsGetCurrentContext();
            //  CGContextRef 是物件 雖然沒有 *
    CGFloat widthRatio = thumbnailSize.width / image.size.width;
    CGFloat heightRadio = thumbnailSize.height / image.size.height;     // 寬高 縮放比計算
    
    
    //for student if have time, create a circle    //  把縮圖裁成 圓形 或 橢圓形
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, thumbnailSize.width, thumbnailSize.height)];
    [circlePath addClip];
    
    
    //  取MAX會變成 AspectFill ; 短邊 縮成50, 長邊會大於 50 ,講義 p.284
    CGFloat ratio = MAX(widthRatio,heightRadio);    //  Maximum
    //  直接計算
    CGSize imageSize = CGSizeMake(image.size.width*ratio, image.size.height*ratio);
    
    [image drawInRect:CGRectMake(-(imageSize.width-50.0)/2.0, -(imageSize.height-50.0)/2.0, imageSize.width, imageSize.height)];
    // image 畫入 "畫布"
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSLog(@"imageSize after resize %@",NSStringFromCGSize(image.size));
    
    return image;
    
}

@end

