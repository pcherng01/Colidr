//
//  ColidrLogInViewController.m
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import "ColidrLogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "CollidrProfileViewController.h"
#import "ColidrAppDelegate.h"

@interface ColidrLogInViewController ()

@end

@implementation ColidrLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]init];
   loginButton.center = self.view.center;
   [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)printAccessToken:(id)sender {
   NSLog(@"%@",[[FBSDKAccessToken currentAccessToken] tokenString]);
}

// Go to editing profile VC
- (IBAction)goEditProfile:(id)sender {
   NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
   NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:accessToken,@"access_token", nil];
   NSError *error = [[NSError alloc]init];
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
   NSURL *theURL = [NSURL URLWithString:@"http://collidr.ngrok.com/auth/facebook/token"];
   [request setURL:theURL];
   [request setHTTPMethod:@"POST"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setHTTPBody:jsonData];
   
   NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
   [connection start];
   NSLog(@"Send post: %@", accessToken);
   CollidrProfileViewController *profileVC = [[CollidrProfileViewController alloc]init];
   
   [self.navigationController pushViewController:profileVC animated:YES];
}
-(void)connection:(NSConnection *)connection didReceiveData:(NSData *)data
{
   NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
   self.dataFromWebServer = jsonObject;
   ColidrAppDelegate *appDelegate = (ColidrAppDelegate *)[[UIApplication sharedApplication]delegate];
   // update location along with accessToken
   [appDelegate.locationTracker updateLocationToServer:@"Hi"];
   NSLog(@"FacebookLogIn didReceiveData gets called");
   NSLog(@"%@",self.dataFromWebServer);
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
