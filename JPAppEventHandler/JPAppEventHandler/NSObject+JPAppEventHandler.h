//
//  NSObject+JPAppEventHandler.h
//
//  Created by iCatbot on 2019/5/22.
//  Copyright © 2019 Stone888. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HandleBlock)(NSNotification *notification);

@interface NSObject (JPAppEventHandler)

- (void)handleAppNotification:(NSNotificationName)notificationName withBlock:(HandleBlock)block;
- (void)unobserveNotification:(NSNotificationName)notificationName;

@end

NS_ASSUME_NONNULL_END
