//
//  ViewController.m
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import "ViewController.h"
#import "MGInstagram.h"

@interface ViewController ()
- (IBAction)postToInstagramPressed:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)postToInstagramPressed:(id)sender
{
    if ([[MGInstagram sharedInstance] isAppInstalled])
        [[MGInstagram sharedInstance] postImage:imageView.image inView:self.view];
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instagram Not Installed!" message:@"Instagram must be installed on the device in order to post images" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

@end
