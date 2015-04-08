//
//  AddInterestViewController.m
//  Colidr
//
//  Created by Pongsakorn Cherngchaosil on 4/4/15.
//  Copyright (c) 2015 Location. All rights reserved.
//

#import "AddInterestViewController.h"

@interface AddInterestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;

@end

@implementation AddInterestViewController

-(instancetype)initForNewItem
{
   self = [super initWithNibName:nil bundle:nil];
   
   if (self) {
      UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(save:)];
      self.navigationItem.rightBarButtonItem = doneItem;
      
      UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancel:)];
      self.navigationItem.leftBarButtonItem = cancelItem;

   }
   return self;
}

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
   
   NSString *newItem = self.itemTextField.text;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
   NSLog(@"User dismissed popover");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
   return YES;
}
- (void)save:(id)sender
{
   [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
   // If the user cancelled, then remoce the BNRItem from the store
   
   [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
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
