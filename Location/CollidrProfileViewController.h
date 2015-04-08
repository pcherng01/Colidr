//
//  CollidrProfileViewController.h
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollidrProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSMutableArray *offerArray;
@property (nonatomic) NSMutableArray *wantArray;
+(UIImage *)imageWithView:(UIView *)view;
@end
