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

@property (nonatomic, strong, nullable) UIView *leftTopView;
@property (nonatomic, strong, nullable) GYLeftTableView *leftTableView;

@property (nonatomic, strong, nullable) UIScrollView *rightTopScrollView;
@property (nonatomic, strong, nullable) NSMutableArray <__kindof UIView *> *rightTopViewArr;
@property (nonatomic, strong, nullable) UIScrollView *rightScrollView;

@property (nonatomic, strong, nullable) NSMutableArray <__kindof UITableView *>  *rightTableViewArr;

@end

static NSInteger leftItemWidth = 90;
static NSUInteger tableCount = 5;

@implementation GYMixtureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.leftTopView];
    [self.view addSubview:self.rightTopScrollView];
    [self.view addSubview:self.rightScrollView];
    [self.view addSubview:self.leftTableView];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"球员";
    topLable.textColor = UIColor.whiteColor;
    topLable.font = [UIFont systemFontOfSize:13];
    
    [self.leftTopView addSubview:topLable];
    [topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.leftTopView);
    }];
    
    
    [self.leftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(leftItemWidth, 60));
    }];
    [self.rightTopScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTopView.mas_right);
        make.top.right.equalTo(self.view);
        make.height.equalTo(self.leftTopView.mas_height);
    }];
    [self.rightScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(leftItemWidth);
        make.top.equalTo(self.rightTopScrollView.mas_bottom);
        make.bottom.right.equalTo(self.view);
    }];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTopView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.leftTableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize contentSize = self.rightScrollView.contentSize;
    contentSize.height = self.leftTableView.frame.size.height;
    contentSize.width = leftItemWidth * tableCount;
    self.rightScrollView.contentSize = contentSize;
    self.rightTopScrollView.contentSize = CGSizeMake(leftItemWidth * tableCount, self.rightTopScrollView.contentSize.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, leftItemWidth, self.leftTableView.contentSize.height)];
    self.leftTableView.path = path;
    
    for (NSInteger i = 0; i < tableCount; i++) {
        UITableView *tableView = [self _creatTableView];
        tableView.frame = CGRectMake(leftItemWidth * i, 0, leftItemWidth, contentSize.height);
        [self.rightScrollView addSubview:tableView];
        [self.rightTableViewArr addObject:tableView];
        
        UIView *topHeadView = [[UIView alloc] initWithFrame:CGRectMake((leftItemWidth * i) + 15, 5, leftItemWidth - 30, 50)];
        [self.rightTopScrollView addSubview:topHeadView];
        UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:topHeadView.bounds cornerRadius:30];
        CAShapeLayer *roudLayer = [CAShapeLayer layer];
        roudLayer.path = round.CGPath;
        roudLayer.fillColor = UIColor.gy_warmGrey.CGColor;
        [topHeadView.layer addSublayer:roudLayer];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        for (UITableView *tableView in self.rightTableViewArr) {
            tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        }
    } else if (scrollView == self.rightScrollView) {
        self.rightTopScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    } else if (scrollView == self.rightTopScrollView) {
        self.rightScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        GYLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GYLeftCell.class) forIndexPath:indexPath];
        return cell;
    } else {
        GYRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GYRightCell.class) forIndexPath:indexPath];
        NSInteger index = [self.rightTableViewArr indexOfObject:tableView];
        
        if (index % 2 == 0) {
            cell.bordColor = UIColor.gy_blackColor;
        } else {
            cell.bordColor = UIColor.gy_salmon;
        }
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
        if (section % 2 == 0) {
            [headView fillTextWithStr:@"这个标题还可以很长很长，很长"];
        } else {
            [headView fillTextWithStr:@"这是个小标题"];
        }
        
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
    tableView.backgroundColor = UIColor.whiteColor;
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

- (UIView *)leftTopView {
    if (_leftTopView == nil) {
        _leftTopView = [[UIView alloc] init];
        _leftTopView.backgroundColor = UIColor.gy_clayBrown;
    }
    return _leftTopView;
}

- (UIScrollView *)rightTopScrollView {
    if (_rightTopScrollView == nil) {
        _rightTopScrollView = [[UIScrollView alloc] init];
        _rightTopScrollView.showsHorizontalScrollIndicator = NO;
        _rightTopScrollView.backgroundColor = UIColor.gy_greyish;
        _rightTopScrollView.delegate = self;
        _rightTopScrollView.bounces = NO;
    }
    return _rightTopScrollView;
}

- (NSMutableArray<__kindof UITableView *> *)rightTableViewArr {
    if (_rightTableViewArr == nil) {
        _rightTableViewArr = @[].mutableCopy;
    }
    return _rightTableViewArr;
}

@end


