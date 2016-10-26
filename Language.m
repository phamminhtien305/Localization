//
//  Language.m
//  Localization
//
//  Created by Pham Tien on 10/25/16.
//  Copyright © 2016 Pham Minh Tien. All rights reserved.
//

#import "Language.h"

@implementation Language

static NSBundle *bundle = nil;

+(void)initialize {
    NSString *current = [self getCurrentLanguage];
    [self setLanguage:current];
}

+(void)setLanguage:(NSString *)language {
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"curren_language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.lproj", [self appDocumentDirectory], language];
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
    if (!exists)
        filePath = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:filePath];
}

+(NSString*)getCurrentLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSString *lang = [defs objectForKey:@"curren_language"];
    if (lang) return lang;
    else return @"vi";
}

+(NSString *)get:(NSString *)key {
    NSString *result = [bundle localizedStringForKey:key value:nil table:nil];
    if (!result) result = key;
    return result;
}

+ (NSString*) appDocumentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
}

+ (NSString *)getLanguageCode:(NSString *)language{
    if([language isEqualToString:@"Indonesia"]){
        return @"id";
    }else if([language isEqualToString:@"English"]){
        return @"en";
    }else if([language isEqualToString:@"Japanese"]){
        return @"ja";
    }else if([language isEqualToString:@"Thái Lan"]){
        return @"th";
    }
    return @"vi";
}

@end
