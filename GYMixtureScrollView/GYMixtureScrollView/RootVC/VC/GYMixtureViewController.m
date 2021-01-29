//
//  GYMixtureViewController.m
//  GYMixtureScrollView
//
//  Created by zhugy781 on 2021/1/29.
//

#import "GYMixtureViewController.h"
#import "GYLeftTableView.h"
#import <Masonry/Masonry.h>
#import <GYBaseKit/GYUIAssistant.h>
#import "GYHeadCell.h"
#import "GYLeftCell.h"
#import "GYRightCell.h"

@interface GYMixtureViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, nullable) GYLeftTableView *leftTableView;
@property (nonatomic, strong, nullable) UIScrollView *rightScrollView;

@property (nonatomic, strong, nullable) NSMutableArray <__kindof UITableView *>  *rightTableViewArr;

@end

@implementation GYMixtureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.rightScrollView];
    [self.view addSubview:self.leftTableView];
    
    [self.rightScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(90);
        make.top.bottom.right.equalTo(self.view);
    }];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.leftTableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize contentSize = self.rightScrollView.contentSize;
    contentSize.height = self.leftTableView.frame.size.height;
    contentSize.width = 90 * 4.0;
    self.rightScrollView.contentSize = contentSize;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 90, self.leftTableView.frame.size.height)];
    self.leftTableView.path = path;
    
    for (NSInteger i = 0; i < 4; i++) {
        UITableView *tableView = [self _creatTableView];
        tableView.frame = CGRectMake(90 * i, 0, 90, contentSize.height);
        [self.rightScrollView addSubview:tableView];
        [self.rightTableViewArr addObject:tableView];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        for (UITableView *tableView in self.rightTableViewArr) {
            tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        }
    } else if (scrollView == self.rightScrollView) {
        NSLog(@"rightScrollView");
    } else {
        UITableView *tableView = (UITableView *)scrollView;
        self.leftTableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        for (UITableView *itemTableView in self.rightTableViewArr) {
            if (itemTableView != tableView) {
                itemTableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        GYLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GYLeftCell.class) forIndexPath:indexPath];
        return cell;
    } else {
        GYRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GYRightCell.class) forIndexPath:indexPath];
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        GYHeadCell *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(GYHeadCell.class)];
        [headView fillTextWithStr:@"这是个说明"];
        return headView;
    } else {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
}



- (UITableView *)_creatTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.backgroundColor = UIColor.redColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:GYRightCell.class forCellReuseIdentifier:NSStringFromClass(GYRightCell.class)];
    return tableView;
}

- (UIScrollView *)rightScrollView {
    if (_rightScrollView == nil) {
        _rightScrollView = [[UIScrollView alloc] init];
        _rightScrollView.bounces = NO;
        _rightScrollView.delegate = self;
        _rightScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _rightScrollView;
}

- (GYLeftTableView *)leftTableView {
    if (_leftTableView == nil) {
        _leftTableView = [[GYLeftTableView alloc] init];
        [_leftTableView registerClass:GYLeftCell.class forCellReuseIdentifier:NSStringFromClass(GYLeftCell.class)];
        [_leftTableView registerClass:GYHeadCell.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(GYHeadCell.class)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.bounces = NO;
        _leftTableView.backgroundColor = [UIColor clearColor];
    }
    return _leftTableView;
}

- (NSMutableArray<__kindof UITableView *> *)rightTableViewArr {
    if (_rightTableViewArr == nil) {
        _rightTableViewArr = @[].mutableCopy;
    }
    return _rightTableViewArr;
}

@end


