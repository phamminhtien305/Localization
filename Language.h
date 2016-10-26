//
//  Language.h
//  Localization
//
//  Created by Pham Tien on 10/25/16.
//  Copyright © 2016 Pham Minh Tien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject

+(void)setLanguage:(NSString *)language;

+(NSString*)getCurrentLanguage;

+(NSString *)get:(NSString *)key;

+ (NSString *)getLanguageCode:(NSString *)language;

@end
