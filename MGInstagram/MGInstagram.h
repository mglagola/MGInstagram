//
//  MGInstagram.h
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGInstagram : NSObject <UIDocumentInteractionControllerDelegate>

extern NSString* const kInstagramAppURLString;
extern NSString* const kInstagramPhotoFileName;

+ (MGInstagram *)sharedInstance;

- (BOOL) isAppInstalled;

- (void) postImage:(UIImage*)image inView:(UIView*)view;

@end
