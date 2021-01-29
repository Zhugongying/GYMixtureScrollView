//
//  ViewController.m
//  GYMixtureScrollViewDemo
//
//  Created by zhugy781 on 2021/1/28.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <GYMixtureScrollView/GYMixtureViewController.h>
#import <GYBaseKit/GYUIAssistant.h>

@interface ViewController ()

@property (nonatomic, strong, nullable) GYMixtureViewController *vc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vc = [[GYMixtureViewController alloc] init];
    [self addChildViewController:self.vc];
    [self.view addSubview:self.vc.view];
    [self.vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(44 + gy_status_bar_height());
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


@end
