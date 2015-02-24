//
//  ViewController.m
//  UIImageViewLettersSample
//
//  Created by Tom Bachant on 10/28/14.
//  Copyright (c) 2014 Coincidental Code. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+Letters.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     * Let's start with a sample
     */
    _nameField.text = @"Michael Bluth"; // everyone's favorite son
    _circularSwitch.on = NO;
    [self refreshSampleImage:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)refreshSampleImage:(id)sender {
    
    [_sampleImageView setImageWithString:_nameField.text color:nil circular:_circularSwitch.isOn];
    
}

@end
