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
     * Make the image look a little nicer
     */
    
    // Set corner radius
    _sampleImageView.layer.cornerRadius = CGRectGetHeight(_sampleImageView.frame) / 2;
    _sampleImageView.clipsToBounds = YES;

    // Add border
    _sampleImageView.layer.borderColor = [[UIColor colorWithWhite:0.84f alpha:1.0f] CGColor];
    _sampleImageView.layer.borderWidth = 3.0f;
    
    // Add shadow
    _sampleImageView.layer.shadowOffset = CGSizeMake(0, 0);
    _sampleImageView.layer.shadowRadius = 1.5;
    _sampleImageView.layer.shadowOpacity = 0.3;
    
    /**
     * Let's start with a sample
     */
    _nameField.text = @"Michael Bluth"; // everyone's favorite son
    [self refreshSampleImage:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)refreshSampleImage:(id)sender {
    
    [_sampleImageView setImageWithString:_nameField.text];
    
}

@end
