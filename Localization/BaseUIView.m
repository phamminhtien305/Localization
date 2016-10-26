//
//  BaseUIView.m
//  Localization
//
//  Created by Pham Tien on 10/25/16.
//  Copyright © 2016 Pham Minh Tien. All rights reserved.
//

#import "BaseUIView.h"
#import "Language.h"


@interface BaseUIView () {
    NSMutableArray *listLanguageView, *listLanguageText;
}

@end

@implementation BaseUIView

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setupLanguage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerDidChangeLanguage:) name:@"Did selected language" object:nil];
}

- (void) observerDidChangeLanguage:(NSNotification*)notification {
    [self setupLanguage];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) getLanguageForView:(UIView *)parentView {
    for (UIView *view in parentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [listLanguageView addObject:view];
            NSString *text = [(UILabel*)view text];
            if (!text) text = @"";
            [listLanguageText addObject:text];
        }
        else if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)view;
            [listLanguageView addObject:view];
            NSString *text = textField.placeholder;
            if (!text) text = @"";
            [listLanguageText addObject:text];
        }
        else if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [listLanguageView addObject:view];
            NSString *text = [button titleForState:UIControlStateNormal];
            if (!text) text = @"";
            [listLanguageText addObject:text];
        }
        else
            [self getLanguageForView:view];
    }
}

- (void) setupLanguage {
    if (!listLanguageView) {
        listLanguageView = [NSMutableArray array];
        listLanguageText = [NSMutableArray array];
        [self getLanguageForView:self];
    }
    for (int i=0; i<listLanguageView.count; i++) {
        UIView *view = listLanguageView[i];
        if ([view isKindOfClass:[UILabel class]]) {
            [(UILabel *)view setText:[Language get:listLanguageText[i]]];
        }
        else if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)view;
            textField.placeholder = [Language get:listLanguageText[i]];
        }
        else if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitle:[Language get:listLanguageText[i]] forState:UIControlStateNormal];
        }
    }
}

@end
