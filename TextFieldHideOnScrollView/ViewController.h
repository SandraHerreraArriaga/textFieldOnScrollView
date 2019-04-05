//
//  ViewController.h
//  TextFieldHideOnScrollView
//
//  Created by Sandra Herrera on 4/5/19.
//  Copyright © 2019 Edison Effect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITextFieldDelegate>
{
    UITextField* textFieldActive;
    UITextField* textFieldKeyboard;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (nonatomic) BOOL editingForAlertController;


@end

