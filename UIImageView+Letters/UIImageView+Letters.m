//
//  UIImageView+Letters.m
//
//  Created by Tom Bachant on 6/17/14.
//  Copyright (c) 2014 Tom Bachant. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIImageView+Letters.h"

// This multiplier sets the font size based on the view bounds
static const CGFloat kFontResizingProportion = 0.42f;

@interface UIImageView (LettersPrivate)

+ (UIImage *)imageSnapshotFromText:(NSString *)text backgroundColor:(UIColor *)color circular:(BOOL)isCircular contentMode: (UIViewContentMode)contentMode targetSize: (CGSize)targetSize textAttributes:(NSDictionary *)textAttributes showGradient: (BOOL) showGradient;

@end

@implementation UIImageView (Letters)

- (void)setImageWithString:(NSString *)string {
    [self setImageWithString:string color:nil circular:NO textAttributes:nil];
}

- (void)setImageWithString:(NSString *)string color:(UIColor *)color {
    [self setImageWithString:string color:color circular:NO textAttributes:nil];
}

- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular {
    [self setImageWithString:string color:color circular:isCircular textAttributes:nil];
}

- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName {
    [self setImageWithString:string color:color circular:isCircular textAttributes:@{
                                                                                     NSFontAttributeName:[self fontForFontName:fontName],
                                                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                     }];
}

- (void)setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    if (!textAttributes) {
        textAttributes = @{
                           NSFontAttributeName: [self fontForFontName:nil],
                           NSForegroundColorAttributeName: [UIColor whiteColor]
                           };
    }
    
    UIColor *backgroundColor = color ? color : [self randomColor];
    
    self.image = [UIImageView imageSnapshotFromText:string backgroundColor:backgroundColor circular:isCircular contentMode: self.contentMode targetSize: self.bounds.size textAttributes:textAttributes showGradient: true];
}

#pragma mark - Helpers

- (UIFont *)fontForFontName:(NSString *)fontName {
    
    CGFloat fontSize = CGRectGetWidth(self.bounds) * kFontResizingProportion;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        return [UIFont systemFontOfSize:fontSize];
    }
    
}

- (UIColor *)randomColor {
    
    srand48(arc4random());
    
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIImage *)imageSnapshotFromText:(NSString *)string backgroundColor:(UIColor *)color circular:(BOOL)isCircular contentMode: (UIViewContentMode)contentMode targetSize: (CGSize)targetSize textAttributes:(NSDictionary *)textAttributes showGradient:(BOOL)showGradient {
    
    
    NSMutableString *displayString = [NSMutableString stringWithString:@""];
    
    NSMutableArray *words = [[[string  uppercaseString] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    
    //
    // Get first letter of the first and last word
    //
    if ([words count]) {
        NSString *firstWord = [words firstObject];
        if ([firstWord length]) {
            // Get character range to handle emoji (emojis consist of 2 characters in sequence)
            NSRange firstLetterRange = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
            [displayString appendString:[firstWord substringWithRange:firstLetterRange]];
        }
        
        if ([words count] >= 2) {
            NSString *lastWord = [words lastObject];
            
            while ([lastWord length] == 0 && [words count] >= 2) {
                [words removeLastObject];
                lastWord = [words lastObject];
            }
            
            if ([words count] > 1) {
                // Get character range to handle emoji (emojis consist of 2 characters in sequence)
                NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
                [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
            }
        }
    }
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize size = targetSize;
    if (contentMode == UIViewContentModeScaleToFill ||
        contentMode == UIViewContentModeScaleAspectFill ||
        contentMode == UIViewContentModeScaleAspectFit ||
        contentMode == UIViewContentModeRedraw)
    {
        size.width = floorf(size.width * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context == NULL) {
        UIGraphicsEndImageContext();
        return NULL;
    }
    
    if (isCircular) {
        //
        // Clip context to a circle
        //
        CGPathRef path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, size.width, size.height), NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    //
    // Fill background of context
    //
    if (!showGradient) {
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    } else {
        CGFloat hue, saturation, brightness;
        [color getHue:&hue saturation:&saturation brightness:&brightness alpha:0];
        brightness += 0.2;
        if (brightness>1) {
            brightness = 1;
        }
        NSArray *colors = @[(__bridge id) color.CGColor, (__bridge id) [UIColor colorWithHue:hue saturation: saturation brightness: brightness alpha: 1].CGColor];//[[UIColor whiteColor] CGColor]];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[] = { 0.0, 1.0 };
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
        
        CGPoint startPoint = CGPointMake(0, 0);
        CGPoint endPoint = CGPointMake(0, targetSize.height);
        CGContextSaveGState(context);
        CGContextAddRect(context, CGRectMake(0, 0, targetSize.width, targetSize.height));
        CGContextClip(context);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        CGContextRestoreGState(context);
    }
    
    
    //
    // Draw text in the context
    //
    CGSize textSize = [displayString sizeWithAttributes:textAttributes];
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    
    [displayString drawInRect:CGRectMake(bounds.size.width/2 - textSize.width/2,
                                         bounds.size.height/2 - textSize.height/2,
                                         textSize.width,
                                         textSize.height)
               withAttributes:textAttributes];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
