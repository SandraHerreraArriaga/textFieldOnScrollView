//
//  ViewController.m
//  TextFieldHideOnScrollView
//
//  Created by Sandra Herrera on 4/5/19.
//  Copyright © 2019 Edison Effect. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGestureToScroll];
    [self createNotificationKeyboard];
    [self assignDelegate];
}


-(void)assignDelegate
{
    _textfield1.delegate=self;
    _textField2.delegate=self;
    _textField3.delegate=self;
    _textField4.delegate=self;
}

-(void)createNotificationKeyboard
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


/**
 Se llama cuando se manda  la notificación
 de UIKeyboardDidShowNotification
 @param aNotification notificacion
 */
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, textFieldActive.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, textFieldActive.frame.origin.y-kbSize.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

/**
 Para checar si hay un siguiente textField
 

 @param textField <#textField description#>
 @return <#return value description#>
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder *nextResponer = [textField.superview viewWithTag:nextTag];
    
    if (nextResponer)
        [nextResponer becomeFirstResponder];
    else
        [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _textfield1)
    {
        if (_editingForAlertController)
        {
            [textFieldActive resignFirstResponder];
            [self actionSheetMeasurementUnit:textField.self];
        }
        else
        {
            NSLog(@"entra en el else");
        }
        
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textFieldActive = textField;
    if (textField == _textfield1)
    {
        if (_editingForAlertController)
        {
            _editingForAlertController = NO;
        }
        else
        {
            _editingForAlertController=YES;
        }
        
        
    }
    return true;
}
/**
 Se llama cuando se manda la notificación
 UIKeyboardWillHideNotification

 @param aNotification <#aNotification description#>
 */
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}




-(void)addGestureToScroll
{
    //                                                      //Tamaño del scrollview de largo 20 posiciones abajo del
    //                                                      //      boton.
    [_scrollView setContentSize:[[self view] frame].size];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollview)];
    [tapGesture  setCancelsTouchesInView:NO];
    [_scrollView addGestureRecognizer:tapGesture];
}


/**
 Ocultar el teclado
 */
- (void)touchScrollview
{
    [[self view] endEditing:YES];
}


-(void)actionSheetMeasurementUnit :(UIControl *)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancelar", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Litros", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self->textFieldActive becomeFirstResponder];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Galones", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self->textFieldActive becomeFirstResponder];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }]];
    

    [self presentViewController:actionSheet animated:YES completion:nil];
}
@end
