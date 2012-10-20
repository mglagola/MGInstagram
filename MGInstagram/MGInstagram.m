//
//  MGInstagram.m
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import "MGInstagram.h"

@interface MGInstagram ()
{
    UIDocumentInteractionController *documentInteractionController;
}
@end

@implementation MGInstagram

NSString* const kInstagramAppURLString = @"instagram://app";
NSString* const kInstagramPhotoFileName = @"tempinstgramphoto.igo";

+ (MGInstagram *)sharedInstance
{
    static MGInstagram* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MGInstagram alloc] init];
    });
    return sharedInstance;
}

- (BOOL) isAppInstalled
{
    NSURL *appURL = [NSURL URLWithString:@"instagram://app"];
    return [[UIApplication sharedApplication] canOpenURL:appURL];
}

- (NSString*) photoFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],kInstagramPhotoFileName];
}

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void) postImage:(UIImage*)image inView:(UIView*)view
{
    if (!image)
        [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[self photoFilePath] atomically:YES];
    
    NSURL *fileURL = [NSURL fileURLWithPath:[self photoFilePath]];
    documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    documentInteractionController.UTI = @"com.instagram.exclusivegram";
    documentInteractionController.delegate = self;
    [documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:view animated:YES];
}

@end
