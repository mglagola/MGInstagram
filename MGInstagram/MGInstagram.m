//
//  MGInstagram.m
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import "MGInstagram.h"

@interface MGInstagram ()

@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

@end

@implementation MGInstagram

NSString* const kInstagramAppURLString = @"instagram://app";
NSString* const kInstagramOnlyPhotoFileName = @"tempinstgramphoto.igo";

- (instancetype)init {
    if (self = [super init]) {
        self.photoFileName = kInstagramOnlyPhotoFileName;
    }
    return self;
}

+ (BOOL)isAppInstalled {
    NSURL *appURL = [NSURL URLWithString:kInstagramAppURLString];
    return [[UIApplication sharedApplication] canOpenURL:appURL];
}

//Technically the instagram allows for photos to be published under the size of 612x612
//BUT if you want nice quality pictures, I recommend checking the image size.
+ (BOOL)isImageCorrectSize:(UIImage*)image {
    CGImageRef cgImage = [image CGImage];
    return (CGImageGetWidth(cgImage) >= 612 && CGImageGetHeight(cgImage) >= 612);
}

- (NSString*)photoFilePath {
    return [NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],self.photoFileName];
}

- (void)postImage:(UIImage*)image fromBarButtonItem:(UIBarButtonItem*)button inView:(UIView*)view {
    [self postImage:image withCaption:nil fromBarButtonItem:(UIBarButtonItem*)button inView:view];
}
- (void)postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view {
    [self postImage:image withCaption:caption fromBarButtonItem:(UIBarButtonItem*)button inView:view delegate:nil];
}

- (void)postImage:(UIImage*)image withCaption:(NSString*)caption fromBarButtonItem:(UIBarButtonItem*)button inView:(UIView*)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate {
    NSParameterAssert(image);
    
    if (!image) {
        return;
    }
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[self photoFilePath] atomically:YES];
    
    NSURL *fileURL = [NSURL fileURLWithPath:[self photoFilePath]];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentInteractionController.UTI = @"com.instagram.exclusivegram";
    self.documentInteractionController.delegate = delegate;
    if (caption) {
        self.documentInteractionController.annotation = @{@"InstagramCaption" : caption};
    }
    if (button) {
        [self.documentInteractionController presentOpenInMenuFromBarButtonItem:button animated:YES];
    }
    else {
        [self.documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:view animated:YES];
    }
}


@end
