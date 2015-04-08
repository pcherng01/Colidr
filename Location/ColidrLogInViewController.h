//
//  ColidrLogInViewController.h
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColidrLogInViewController : UIViewController <NSURLConnectionDelegate>
@property (nonatomic,strong) NSDictionary *dataFromWebServer;
@end
