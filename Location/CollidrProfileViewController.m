//
//  CollidrProfileViewController.m
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import "CollidrProfileViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AddInterestViewController.h"
#import "AddOfferViewController.h"
#import "AddWantViewController.h"
#import <QuartzCore/QuartzCore.h> 
#import "FoundUserViewController.h"

static const CGFloat leftMargin = 54;
static const CGFloat topMargin = 32;
static const CGFloat pictureWidth = 240;
static const CGFloat pictureHeight = 128;

@interface CollidrProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (nonatomic,strong) NSURLSession *session;
@property (weak, nonatomic) IBOutlet UITableView *offerTable;
@property (weak, nonatomic) IBOutlet UITableView *wantTable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak,nonatomic) FBSDKProfilePictureView *profilePic;
@property (nonatomic) BOOL foundUser;

@end

@implementation CollidrProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   FBSDKProfilePictureView *profilePic = [[FBSDKProfilePictureView alloc]
                                          initWithFrame:self.imageView.frame];
   [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:nil]
    startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
       if (!error) {
          self.nameLabel.text = result[@"first_name"];
          self.lastNameLabel.text = result[@"last_name"];
       }
    }];
   self.profilePic = profilePic;
   [self.view addSubview:profilePic];
   self.foundUser = false;
   
    // Do any additional setup after loading the view from its nib.
   /*
   self.offerArray = @[@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",
                       @"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",@"Yo",];
   self.wantArray = @[@"Nah",@"Nah",@"Nah",@"Nah",@"Nah",@"Nah",@"Nah",@"Nah",
                      @"Nah",@"Nah",@"Nah",@"Nah",@"Nah",@"Nah",];*/
   _offerArray = [[NSMutableArray alloc]init];
   _wantArray = [[NSMutableArray alloc]init];
   [self.offerArray addObject:@"heh"];
   [self.wantArray addObject:@"YO"];
   NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
   _session = [NSURLSession sessionWithConfiguration:config
                                            delegate:nil
                                       delegateQueue:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   NSLog(@"%@",self.offerArray);
   NSLog(@"%@",self.wantArray);
   
   
   [self.offerTable reloadData];
   [self.wantTable reloadData];
   if (self.foundUser) {   
      FoundUserViewController *foundUserVC = [[FoundUserViewController alloc]init];
      [self.navigationController pushViewController:foundUserVC animated:YES];
   }
   NSArray *offerObjects = self.offerArray;
   NSArray *wantObjects = self.wantArray;
   NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:offerObjects,@"offer",wantObjects,@"want", nil];
   NSError *error = [[NSError alloc]init];
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
   NSURL *theURL = [NSURL URLWithString:@"http://collidr.ngrok.com/keywords/update"];
   [request setURL:theURL];
   [request setHTTPMethod:@"POST"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setHTTPBody:jsonData];
   
   NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
   [connection start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goAddOffer:(id)sender {
   AddOfferViewController *offerVC = [[AddOfferViewController alloc]init];
   offerVC.offerItems = self.offerArray;
   [self.navigationController pushViewController:offerVC animated:YES];
}
- (IBAction)goAddWant:(id)sender {
   AddWantViewController *wantVC = [[AddWantViewController alloc]init];
   wantVC.wantItems = self.wantArray;
   [self.navigationController pushViewController:wantVC animated:YES];
}


- (IBAction)sendRequest:(id)sender {
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

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (tableView.tag == 0) {
      return [self.offerArray count];
   }
   else if (tableView.tag == 1)
   {
      return [self.wantArray count];
   }
   return 0;
}

// Send user's interests to the web server
- (IBAction)startProcess:(id)sender {
   //NSLog(@"%@", [[FBSDKAccessToken currentAccessToken] userID]);
   

  
   //NSLog(@"%@",[[FBSDKAccessToken currentAccessToken]])
   /*
   UIImage *anImage = [self imageWithView:self.profilePic];
   NSData *imageData = UIImageJPEGRepresentation(anImage, 1.0);
   NSString *boundary = @"----------V2ymHFg03ehbqgZCaKO6jy";
   NSString* FileParamConstant = @"file";
   NSMutableData *body = [NSMutableData data];
   if (imageData) {
      [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:imageData];
      [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
   }
   [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
   NSURL *theURL = [NSURL URLWithString:@"http://collidr.ngrok.com/users/ping"];
   [request setURL:theURL];
   [request setHTTPMethod:@"PUT"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setHTTPBody:body];
   
   NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
   [connection start];
   NSLog(@"%@",body);*/
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
   NSArray *offerItems = self.offerArray;
   NSArray *wantItems = self.wantArray;
   
   if (tableView.tag == 0) {
      cell.textLabel.text = offerItems[indexPath.row];
      return cell;
   }
   else
   {
      cell.textLabel.text = wantItems[indexPath.row];
      return cell;
   }
   return cell;
}

- (UIImage *) imageWithView:(UIView *)view
{
   UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   
   UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
   
   UIGraphicsEndImageContext();
   
   return img;
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
