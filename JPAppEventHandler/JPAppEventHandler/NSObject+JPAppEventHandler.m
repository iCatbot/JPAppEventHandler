//
//  NSObject+JPAppEventHandler.m
//
//  Created by iCatbot on 2019/5/22.
//  Copyright © 2019 Stone888. All rights reserved.
//

#import "NSObject+JPAppEventHandler.h"
#import <objc/runtime.h>

static inline const void * keyWithNotificationName(NSNotificationName notificationName) {
    if ([notificationName isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        return &UIApplicationDidEnterBackgroundNotification;
    }else if ([notificationName isEqualToString:UIApplicationWillEnterForegroundNotification]) {
        return &UIApplicationWillEnterForegroundNotification;
    }else if ([notificationName isEqualToString:UIApplicationDidFinishLaunchingNotification]) {
        return &UIApplicationDidFinishLaunchingNotification;
    }else if ([notificationName isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        return &UIApplicationDidBecomeActiveNotification;
    }else if ([notificationName isEqualToString:UIApplicationWillResignActiveNotification]) {
        return &UIApplicationWillResignActiveNotification;
    }else if ([notificationName isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        return &UIApplicationDidReceiveMemoryWarningNotification;
    }else if ([notificationName isEqualToString:UIApplicationWillTerminateNotification]) {
        return &UIApplicationWillTerminateNotification;
    }else if ([notificationName isEqualToString:UIApplicationSignificantTimeChangeNotification]) {
        return &UIApplicationSignificantTimeChangeNotification;
    }else if ([notificationName isEqualToString:UIApplicationWillChangeStatusBarOrientationNotification]) {
        return &UIApplicationWillChangeStatusBarOrientationNotification;
    }else if ([notificationName isEqualToString:UIApplicationDidChangeStatusBarOrientationNotification]) {
        return &UIApplicationDidChangeStatusBarOrientationNotification;
    }else if ([notificationName isEqualToString:UIApplicationWillChangeStatusBarFrameNotification]) {
        return &UIApplicationWillChangeStatusBarFrameNotification;
    }else if ([notificationName isEqualToString:UIApplicationDidChangeStatusBarFrameNotification]) {
        return &UIApplicationDidChangeStatusBarFrameNotification;
    }else if ([notificationName isEqualToString:UIApplicationBackgroundRefreshStatusDidChangeNotification]) {
        return &UIApplicationBackgroundRefreshStatusDidChangeNotification;
    }else if ([notificationName isEqualToString:UIApplicationProtectedDataWillBecomeUnavailable]) {
        return &UIApplicationProtectedDataWillBecomeUnavailable;
    }else if ([notificationName isEqualToString:UIApplicationProtectedDataDidBecomeAvailable]) {
        return &UIApplicationProtectedDataDidBecomeAvailable;
    }else if ([notificationName isEqualToString:UIApplicationUserDidTakeScreenshotNotification]) {
        return &UIApplicationUserDidTakeScreenshotNotification;
    }
    return NULL;
}

@implementation NSObject (JPAppEventHandler)

- (void)handleAppNotification:(NSNotificationName)notificationName withBlock:(HandleBlock)block {
    if (!notificationName || !block) {
        return;
    }
    
    [self unobserveNotification:notificationName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:notificationName object:nil];
    objc_setAssociatedObject(self, keyWithNotificationName(notificationName), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)unobserveNotification:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
    objc_setAssociatedObject(self, keyWithNotificationName(notificationName), nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleNotification:(NSNotification *)notification {
    NSNotificationName notificationName = notification.name;
    
    HandleBlock block = objc_getAssociatedObject(self, keyWithNotificationName(notificationName));
    if (block) {
        block(notification);
    }
}

@end
