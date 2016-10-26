//
//  ViewController.m
//  Localization
//
//  Created by Pham Minh Tien on 10/24/16.
//  Copyright © 2016 Pham Minh Tien. All rights reserved.
//

#import "ViewController.h"
#import "Language.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Ở đây mình hardcod list danh sách các ngôn ngữ hỗ trợ trong ứng dụng.
    language = [[NSArray alloc] initWithObjects:@"English",@"Japanese",@"Thái Lan",@"Indonesia",@"Việt Nam", nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [lbTitle setText:[Language get:@"Developed by"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeLanguage:(id)sender {   
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Language" message:@"Select language" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    for (NSString * item in language) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:item
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
        {
            // Set language
            NSString *langCode = [Language getLanguageCode:action.title];
            [Language setLanguage:langCode];
            //
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Did selected language"
                                                                object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}



@end
