# MGInstagram
MGInstagram is a iOS Utility for posting Images to Instagram from your app.

#### The Process
- An "openInMenu" is displayed when attempting to post a picture. (Currently the only way to post to instagram)
- The user will have a choice to cancel or to select Instagram
- If the user selects Instagram, the user will be taken to the Instagram app with their Image.

## Setup
CocoaPods is recommended.
#### CocoaPods
- Add `pod 'MGInstagram', 'X.X.X'` in your `Podfile`.  Fill in `X.X.X` with the latest pod spec version or `:head` if you live dangerously.
- import `#import <MGInstagram/MGInstagram.h>` Into your desired file.

#### Manual
- Drag and drop the MGInstagram Folder into your iOS project
- import `#import "MGInstagram.h"` into the file you plan on using MGInstagram

## MGInstagram Available Methods

```objc  
//Create an instance
self.instagram = [[MGInstagram alloc] init];

//Set the photo file name
//The following will present various options including Instagram
self.instagram.photoFileName = @"TempPhoto.png";
//The following will only show Instagram as an option
self.instagram.photoFileName = kInstagramOnlyPhotoFileName;

//Checks to see user has the instagram app installed
//Returns YES if user does have the app
[MGInstagram isAppInstalled];

//Post UIImage to Instagram
//Presents an "openInMenu" model in the UIView specified  
//User is only given Instagram as an option
[self.instagram postImage:image inView:self.view];

//You can also post with a caption!
[self.instagram postImage:image withCaption:@"This is an #MGInstagram Caption Test" inView:self.view];

//Checks if the UIImage is at least 612x612 pixels.
//Instagram upscales photos below this resolution, so it is
//recommended to ONLY allow for photos above 612x612 to ensure good quality.
//However, this is your choice whether or not to check.
//Returns YES if correct size
[MGInstagram isImageCorrectSize:image];
```

### Example Usage

```objc  
UIImage *image = [UIImage imageNamed:@"MyImageName.png"];
if ([MGInstagram isAppInstalled] && [MGInstagram isImageCorrectSize:image]) {
    [self.instagram postImage:image inView:self.view];
}
else {
   	NSLog(@"Error Instagram is either not installed or image is incorrect size");
}
```
