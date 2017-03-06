//
//  ViewController.m
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view = [[MainView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    MainView *mv = (MainView*)self.view;
    [mv setPosition:size];
}


@end
