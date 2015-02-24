//
//  ViewController.h
//  UIImageViewLettersSample
//
//  Created by Tom Bachant on 10/28/14.
//  Copyright (c) 2014 Coincidental Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *sampleImageView;

@property (nonatomic, weak) IBOutlet UITextField *nameField;

@property (nonatomic, weak) IBOutlet UISwitch *circularSwitch;

- (IBAction)refreshSampleImage:(id)sender;

@end

