//
//  GYHeadCell.m
//  GYBaseKit
//
//  Created by zhugy781 on 2021/1/29.
//

#import "GYHeadCell.h"
#import <Masonry/Masonry.h>
#import <GYBaseKit/UIColor+Works.h>

@interface GYHeadCell()

@property (nonatomic, strong, nullable) UILabel *bsLabel;

@end

@implementation GYHeadCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.contentView.backgroundColor = UIColor.gy_fadedBlue;
    }
    return self;
}

- (void)fillTextWithStr:(NSString *)str {
    self.bsLabel.text = str;
}

- (void)setupUI {
    [self.contentView addSubview:self.bsLabel];
    [self.bsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.bottom.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}

- (UILabel *)bsLabel {
    if (_bsLabel == nil) {
        _bsLabel = [[UILabel alloc] init];
        _bsLabel.text = @"这是个说明";
    }
    return _bsLabel;
}


@end
