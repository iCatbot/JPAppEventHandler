//
//  ViewController.m
//  JPAppEventHandler
//
//  Created by iCatbot on 2019/5/23.
//  Copyright © 2019 iCatbot. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+JPAppEventHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weak = self;
    [self handleAppNotification:UIApplicationDidEnterBackgroundNotification withBlock:^(NSNotification * _Nonnull notification) {
        __strong typeof(weak) strong = weak;
        if (strong) {
            NSLog(@"Application did enter background");
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weak = self;
    [self handleAppNotification:UIApplicationUserDidTakeScreenshotNotification withBlock:^(NSNotification * _Nonnull notification) {
        __strong typeof(weak) strong = weak;
        if (strong) {
            NSLog(@"User did take screenshot");
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self unobserveNotification:UIApplicationUserDidTakeScreenshotNotification];
}

@end
