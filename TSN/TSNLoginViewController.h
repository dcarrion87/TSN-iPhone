//
//  TSNLoginViewController.h
//  TSN
//
//  Created by Daniel Carrion on 13/08/13.
//  Copyright (c) 2013 Daniel Carrion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSNLoginViewController : UIViewController

@property(strong,nonatomic) IBOutlet UITextField *idTextField;
@property(weak) IBOutlet UILabel *errorLabel;

// For keyboard
-(IBAction)textFieldReturn:(id)sender;


@end
