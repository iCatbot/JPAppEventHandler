# JPAppEventHandler
Easy to handle iOS Application Notification with block.

## 使用
将NSObject+JPAppEventHandler.h和NSObject+JPAppEventHandler.m添加进你的项目中,在需要使用的地方

```objc
#import "NSObject+JPAppEventHandler.h"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听通知
    __weak typeof(self) weak = self;
    [self handleAppNotification:UIApplicationDidEnterBackgroundNotification withBlock:^(NSNotification * _Nonnull notification) {
        __strong typeof(weak) strong = weak;
        if (strong) {
            NSLog(@"Application did enter background");
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除通知处理
    [self unobserveNotification:UIApplicationUserDidTakeScreenshotNotification];
}

```
