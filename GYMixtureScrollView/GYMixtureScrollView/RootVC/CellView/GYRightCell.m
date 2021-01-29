//
//  GYRightCell.m
//  GYMixtureScrollView
//
//  Created by zhugy781 on 2021/1/29.
//

#import "GYRightCell.h"
#import <Masonry/Masonry.h>
#import <GYBaseKit/UIColor+Works.h>

@interface GYRightCell ()
@property (nonatomic, strong, nullable) UILabel *bsLabel;
@end

@implementation GYRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.bsLabel];
    [self.bsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90, 35));
        make.centerY.equalTo(self.contentView);
    }];
}

- (UILabel *)bsLabel {
    if (_bsLabel == nil) {
        _bsLabel = [[UILabel alloc] init];
        _bsLabel.text = @"个说明";
        _bsLabel.backgroundColor = UIColor.gy_paleGrey;
    }
    return _bsLabel;
}


@end
