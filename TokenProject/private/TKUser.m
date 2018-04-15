//
//  TKUser.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/14.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKUser.h"

@implementation TKUser

@end

@implementation TKUserManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static TKUserManager* manager = nil;
    dispatch_once(&onceToken, ^{
        TKUserManager *fileManager = [[self class] managerFromFile];
        if (fileManager) {
            manager = fileManager;
        }else {
            manager = [[TKUserManager alloc] init];
        }
    });
    return manager;
}

+ (TKUserManager *)managerFromFile
{
    NSString *filePath = [[[self class] libraryHomeDocument] stringByAppendingPathComponent:@"TKUserManager"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (!dic) return nil;
    
    TKUserManager *manager = [[TKUserManager alloc] initWithDictionary:dic error:nil];
    return manager;
}

+ (NSString *)libraryHomeDocument
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *library = [paths objectAtIndex:0];
    NSString *doc = [library stringByAppendingPathComponent:@"TKLibrary"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:doc]) {
        [fm createDirectoryAtPath:doc withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return doc;
}

- (BOOL)save
{
    NSString *filePath = [[[self class] libraryHomeDocument] stringByAppendingPathComponent:@"TKUserManager"];
    NSDictionary *dic = [self toDictionary];
    return [dic writeToFile:filePath atomically:YES] ? YES : NO;
}

@end
