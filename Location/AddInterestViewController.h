//
//  AddInterestViewController.h
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInterestViewController : UIViewController

@property (nonatomic,copy) NSString *theNewItem;

@property (nonatomic,copy) void (^dismissBlock)(void);

-(instancetype)initForNewItem;

@end
