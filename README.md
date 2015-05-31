UIImageView+Letters
===================

An easy, helpful UIImageView category that generates letter initials as a placeholder for user profile images, with a randomized background color

![Example screenshot](http://i.imgur.com/xSBjVQ7.png)

### Installation

##### CocoaPods

Add this spec to your podfile:

`pod "UIImageView-Letters"`

Check out the [official guide](http://guides.cocoapods.org/using/index.html) for getting started with CocoaPods.

##### Manual

1. Drag the `UIImageView+Letters.{h,m}` files into your project
2. Enjoy!

### Usage

In the file where you want to use the category, be sure to import the file. 

`#import "UIImageView+Letters.h"`

##### Methods

Call the following methods on any `UIImageView` instance to set the image:

+ `- (void)setImageWithString:(NSString *)string`
+ `- (void)setImageWithString:(NSString *)string color:(UIColor *)color`
+ `- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular`
+ `- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName`
+ `- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes`

`string` is the string used to generate the initials. This should be a user's full name if available.

`color` is an optional parameter that sets the background color of the image. Pass in `nil` to have a color automatically generated for you.

`isCircular` is a boolean parameter that will automatically clip the image to a circle if enabled.

`fontName` is a string that specifies a custom font. Pass in `nil` to use the system font by default. The list of provided font identifiers can be found [here](http://iosfonts.com). 

`textAttributes` is an NSDictionary that allows you to specify font, text color, shadow properties, etc., for the letters text, using the keys found in `NSAttributedString.h`.

##### Example

```
NSString *userName = @"Michael Bluth";
UIImageView *myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
[myImgView setImageWithString:userName color:nil circular:YES];
```

### Saying Thanks

If you like this tool, show your support by downloading the free [Reach Contact List](https://itunes.apple.com/us/app/reach-your-contact-list/id898802540?mt=8) app that inspired it!

### License

Using the MIT license. See license file for details.
