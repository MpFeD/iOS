//
//  MainView.h
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,readwrite,retain) UILabel* myLabel;
@property(nonatomic, readwrite,retain) UIButton* buttonD;
@property(nonatomic, readwrite,retain) UIButton* buttonG;
@property (nonatomic, readwrite,retain) UITextField* myTextField;
@property (nonatomic, readwrite,retain) UILabel* myName;
@property (nonatomic, readwrite,retain) UIPickerView *myPicker;

- (void) setPosition:(CGSize) format;

@end
