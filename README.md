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

`string` is the string used to generate the initials. This should be a user's full name if available.

`color` is an optional parameter that sets the background color of the image. Pass in `nil` to have a color automatically generated for you.

### License

Using the MIT license. See license file for details.
