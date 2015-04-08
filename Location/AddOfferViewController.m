//
//  AddOfferViewController.m
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/5/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import "AddOfferViewController.h"

@interface AddOfferViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
   [self.view endEditing:YES];
   
   [self.offerItems addObject:self.textField.text];
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
