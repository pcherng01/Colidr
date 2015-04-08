//
//  FoundUserViewController.m
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/5/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import "FoundUserViewController.h"
#import "Moxtra.h"

@interface FoundUserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userPicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FoundUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSString *APP_CLIENT_ID = @"sxSccZpPol4";
   NSString *APP_CLIENT_SECRET = @"pom2gMmwh64";
   [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];
   
   // Initialize user using unique user identity
   MXUserIdentity *useridentity = [[MXUserIdentity alloc]init];
   useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
   useridentity.userIdentity = @"user unique identity";
   /*
   [[Moxtra sharedClient]initializeUserAccount:useridentity
                                         orgID:nil
                                     firstName:@"John"
                                      lastName:@"Doe"
                                        avatar:nil
                   devicePushNotificationToken:nil
                                       success:^{
                                          <#code#>
                                       } failure:<#^(NSError *error)failure#>]*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)chatUser:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
