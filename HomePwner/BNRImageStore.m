//
//  BNRImageStore.m
//  HomePwner
//
//  Created by John Gallagher on 1/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });

    return sharedStore;
}

// No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRImageStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];

    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cleanCached:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }

    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
    
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    BOOL success = [data writeToFile:[self filePathWithKey:key] atomically:YES];
    NSLog(@"Image data write success %@",success?@"YES":@"NO");
}

- (UIImage *)imageForKey:(NSString *)key
{
    UIImage * anImage = self.dictionary[key];
    if (!anImage) {
        anImage = [UIImage imageWithContentsOfFile:[self filePathWithKey:key]];
        if (anImage) {
            self.dictionary[key] = anImage;
        } else {
            NSLog(@"fetch image error");
        }
    }
    
    return anImage;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    BOOL success =[[NSFileManager defaultManager] removeItemAtPath:[self filePathWithKey:key] error:nil];
    if (success) {
        NSLog(@"delete Image success");
    } else {
        NSLog(@"delete Image failed");
   
        
        
    }
}

- (NSString *)filePathWithKey:(NSString *)key {
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docPath = [[docPaths firstObject] stringByAppendingPathComponent:key];
    
    
    return docPath;
}

- (void)cleanCached:(NSNotification *) note {
    NSLog(@"Clean up BNRImageStore");
    [self.dictionary removeAllObjects];
}

@end
