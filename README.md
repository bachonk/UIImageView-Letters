UIImageView+Letters
===================

An easy, helpful UIImageView category that generates letter initials as a placeholder for user profile images, with a randomized background color

![Example screenshot](http://i.imgur.com/nlH7ig0.png)

### Installation

1. Drag the `UIImageView+Letter.{h,m}` files into your project
2. Enjoy!

### Usage

In the file where you want to use the category, be sure to import the file. 

`#importUIImageView+Letter.h`

Call the method `setImageWithString:color:` on any `UIImageView` instance to set the image.

The string will be interpreted as a name, and will use the initials of the first and last word in the string provided
If a color is not provided, a random color will be generated.

### License

Using the MIT license. See license file for details.
