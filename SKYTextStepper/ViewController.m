//
//  ViewController.m
//  SKYTextStepper
//
//  Created by sky on 15/4/24.
//  Copyright (c) 2015年 bluesky. All rights reserved.
//

#import "ViewController.h"
#import "SKYTextStepper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SKYTextStepper *textStepper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textStepper.editableText = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
