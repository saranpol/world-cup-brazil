//
//  ViewUtil.m
//  Panda
//
//  Created by saranpol on 10/13/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "ViewUtil.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation ViewUtil

+ (void)loadImage:(UIImageView*)v url:(NSString*)url {
    UIImageView *iv = v;
    [v setImageWithURL:[NSURL URLWithString:url]
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
                 if(cacheType!=SDImageCacheTypeMemory){
                     [iv setAlpha:0.0];
                     [UIView animateWithDuration:0.3 animations:^{
                         [iv setAlpha:1.0];
                     }];
                 }
             }];
}

+ (void)loadButtonImage:(UIButton*)v url:(NSString*)url {
    UIButton *iv = v;
    [v setImageWithURL:[NSURL URLWithString:url]
              forState:UIControlStateNormal
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
                 if(cacheType!=SDImageCacheTypeMemory){
                     [iv setAlpha:0.0];
                     [UIView animateWithDuration:0.3 animations:^{
                         [iv setAlpha:1.0];
                     }];
                 }
             }];
}


+ (void)addViewFade:(UIView*)parent view:(UIView*)v {
    [ViewUtil addViewFade:parent view:v finalAlpha:1.0];
}

+ (void)addViewFade:(UIView*)parent view:(UIView*)v finalAlpha:(CGFloat)finalAlpha {
    [parent addSubview:v];
    [v setAlpha:0.0];
    [parent setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [v setAlpha:finalAlpha];
    }completion:^(BOOL finished){
        [parent setUserInteractionEnabled:YES];
    }];
}

+ (void)removeViewFade:(UIView*)v completion:(RemoveViewDone)completion {
    [v setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [v setAlpha:0.0];
    }completion:^(BOOL finished){
        [v setUserInteractionEnabled:YES];
        [v removeFromSuperview];
        if(completion)
            completion();
    }];
}

+ (void)setFrameHeight:(UIView*)v h:(CGFloat)h {
    CGRect f = v.frame;
    f.size.height = h;
    [v setFrame:f];
}

+ (void)setFrameWidth:(UIView*)v w:(CGFloat)w {
    CGRect f = v.frame;
    f.size.width = w;
    [v setFrame:f];
}

+ (void)setFrame:(UIView*)v x:(CGFloat)x y:(CGFloat)y {
    CGRect f = v.frame;
    f.origin.y = y;
    f.origin.x = x;
    [v setFrame:f];
}

+ (void)setFrame:(UIView*)v x:(CGFloat)x {
    CGRect f = v.frame;
    f.origin.x = x;
    [v setFrame:f];
}

+ (void)setFrame:(UIView*)v y:(CGFloat)y {
    CGRect f = v.frame;
    f.origin.y = y;
    [v setFrame:f];
}

+ (void)setOriginY:(UIView*)v y:(float)y{
	CGRect frame = v.frame;
	frame.origin.y = y;
	v.frame = frame;
}

+ (UIImage*)getInsetImage:(UIImage*)image {
    return [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
}

+ (CGFloat)getLabelHeight:(UILabel*)label {
    CGSize maxSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    CGRect labelRect = [label.text boundingRectWithSize:maxSize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:label.font}
                                                context:nil];
    return labelRect.size.height;
}

@end
