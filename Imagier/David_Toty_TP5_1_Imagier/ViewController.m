//
//  ViewController.m
//  David_Toty_TP5_1_Imagier
//
//  Created by Knu on 01/11/16.
//  Copyright © 2016 Knu. All rights reserved.
//
#import "ViewController.h"
#import "MaVue.h"

MaVue *v;
int monIndex;
NSArray *tab;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    v = [[MaVue alloc] initWithFrame:[[UIScreen mainScreen] bounds]  andTitre:@"photo-1"];
    tab = [NSArray arrayWithObjects: @"photo-1", @"photo-2", @"photo-3", @"photo-4", @"photo-5", @"photo-6",
           @"photo-7", @"photo-8", @"photo-9", @"photo-10",@"photo-11", @"photo-12", @"photo-13", @"photo-14",
           @"photo-15", @"photo-16", @"photo-17", @"photo-18", @"photo-19", @"photo-20",nil];
    monIndex=0;
    
    [tab retain];
    [[v MonSlider] addTarget:self action:@selector(monAction:) forControlEvents:UIControlEventValueChanged];
    [[v buttonNext] setTarget:self];
    [[v buttonNext] setAction:@selector(nextPrevAction:)];
    [[v buttonBack] setTarget:self];
    [[v buttonBack] setAction:@selector(nextPrevAction:)];
    
    [v setBackgroundColor:[UIColor whiteColor]];
    [self setView:v];
    [v release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) monAction:(UIView *)sender{
    if (sender == [v MonSlider]){
        
        [[v monScrollView] setZoomScale: [[v MonSlider] value]];
    }
}
     

- (void) nextPrevAction:(UIBarButtonItem*)sender{
    if (sender == [v buttonNext]){
        monIndex=monIndex+1;
        if(monIndex == 20)
            monIndex=0;
    } else {
        monIndex=monIndex-1;
        if(monIndex==-1)
            monIndex=19;
    }
    
    v = [[MaVue alloc] initWithFrame:[[UIScreen mainScreen] bounds]  andTitre:[tab objectAtIndex:monIndex]];
    
    [[v MonSlider] addTarget:self action:@selector(monAction:) forControlEvents:UIControlEventValueChanged];
    [[v buttonNext] setTarget:self];
    [[v buttonNext] setAction:@selector(nextPrevAction:)];
    [[v buttonBack] setTarget:self];
    [[v buttonBack] setAction:@selector(nextPrevAction:)];
    [self setView:v];
    [v release];
}


@end

