//
//  Modele.h
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

@interface Modele : NSObject 

@property(nonatomic,readwrite,retain) NSString* myName;
@property(nonatomic,readwrite,retain) NSString* myClass;
@property(nonatomic,readwrite) int hearthP;

-(NSString*) toString;
-(void) levelUP;

@end
