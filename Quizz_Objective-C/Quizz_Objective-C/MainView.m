//
//  MainView.m
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainView.h"
#import "Modele.h"


@implementation MainView: UIView

Modele *m;
UIVisualEffectView *myEffect;
NSArray *data;
NSString *selectedClass;
NSTimer *myTimer;

- (id) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];

    if(self){
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _myLabel = [[UILabel alloc]init];
        _myName = [[UILabel alloc]init];
        _buttonD = [UIButton buttonWithType: UIButtonTypeSystem];
        _buttonG = [UIButton buttonWithType: UIButtonTypeSystem];
        
        _myLabel.text = @"";
        _myLabel.textAlignment = NSTextAlignmentCenter;
        
        _myName.text = @"MyName?";
        _myName.textAlignment = NSTextAlignmentCenter;
        
        _myTextField = [[UITextField alloc] init];
        [_myTextField setBackgroundColor:[UIColor grayColor]];
        _myTextField.delegate = self;
        
        [_buttonG addTarget:self action:@selector(buttonGAction:) forControlEvents:UIControlEventTouchDown];
        
        [_buttonD addTarget:self action:@selector(buttonDAction:) forControlEvents:UIControlEventTouchDown];
        
        UIImage *img = [UIImage imageNamed:@"droite.png"];
        [_buttonD setImage:img forState:UIControlStateNormal];
        
        img = [UIImage imageNamed:@"gauche.png"];
        [_buttonG setImage:img forState:UIControlStateNormal];
        
        m = [[Modele alloc] init];
        UIBlurEffect *mystyle = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        myEffect =[[UIVisualEffectView alloc]initWithEffect:mystyle];
        myEffect.hidden = true;
        
        data = [NSArray arrayWithObjects: @"Warrior",@"Paladin",@"Sorceress",nil];
        selectedClass = [data objectAtIndex:1];
        [data retain];
        
        _myPicker = [[UIPickerView alloc]init];
        [_myPicker setDelegate:self];
        [_myPicker setDataSource:self];
        [_myPicker setBackgroundColor: [UIColor redColor]];
        [_myPicker setShowsSelectionIndicator:YES];
        [_myPicker selectedRowInComponent:0];
        
        myTimer = [[NSTimer alloc] init];
        [myTimer invalidate];
        myTimer=nil;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                    target:self
                                  selector:@selector(blesser:)
                                                 userInfo:@{@"p1":@1}
                                   repeats:true];
        
        [self addSubview:_myLabel];
        [self addSubview:myEffect];
        [self addSubview:_buttonD];
        [self addSubview:_buttonG];
        [self addSubview:_myTextField];
        [self addSubview:_myName];
        [self addSubview:_myPicker];
        
        
        
        [self setPosition:frame.size];
    }
    return self;
}
                    
-(void) blesser:(NSTimer *)timer{
    int n = [[[timer userInfo] objectForKey:@"p1"]intValue];
    m.hearthP = m.hearthP - n;
    NSLog(@"hit : %d", m.hearthP);
                        
}

-(void) buttonGAction:(UIButton*)sender{
    myEffect.hidden = false;
    [m levelUP];
}

-(void) buttonDAction:(UIButton*)sender{
    myEffect.hidden = true;
    NSLog(@"%@",[m toString]);
}

-(void) setPosition:(CGSize)format{
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
       [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        
    }else{
        _buttonD.frame = CGRectMake(format.width-format.width/8, format.height/16, format.width/8,  format.height/8);
        _buttonG.frame = CGRectMake(0, format.height/16, format.width/8,  format.height/8);
        _myLabel.frame = CGRectMake(0, format.height/16, format.width,  format.height/16);
        _myTextField.frame = CGRectMake(format.width/3, format.height/8, format.width/3,  format.height/16);
        _myName.frame = CGRectMake(0, 3*format.height/16, format.width,  format.height/16);
        myEffect.frame= CGRectMake(0, 0, format.width,  format.height);
        
        _myPicker.frame = CGRectMake(0, format.height/4, format.width,  2*format.height/16);
    }
}

//UIPickerViewDelegate

//contenu composant picker
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return data[row];
}

//appel lorsque élément picker selectionné
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m.myClass = [data objectAtIndex:row];
    NSLog(@"choix : %@",[data objectAtIndex:row] );
}

//UIPickerViewDataSource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 	[data count];
}

//colonnes
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


//UITextField Delegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}


//dismiss return
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@",textField.text);
    
    if(textField.text.length >10){
        [_myTextField resignFirstResponder];
        return false;
    }
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"debut");
    _myName.text = @"";
    _myName.text = textField.text;
    _myTextField.text =@"Pseudo ?";
    m.myName = _myName.text;
}




@end