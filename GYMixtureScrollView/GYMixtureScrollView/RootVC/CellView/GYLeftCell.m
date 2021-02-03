//
//  GYLeftCell.m
//  GYMixtureScrollView
//
//  Created by zhugy781 on 2021/1/29.
//

#import "GYLeftCell.h"
#import <Masonry/Masonry.h>
#import <GYBaseKit/UIColor+Works.h>

@interface GYLeftCell ()

@property (nonatomic, strong, nullable) UILabel *bsLabel;

@end

@implementation GYLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGRect lableRect = self.bsLabel.bounds;
    lableRect = CGRectMake(lableRect.origin.x + 5, lableRect.origin.y + 5, lableRect.size.width - 10, lableRect.size.height - 10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:lableRect cornerRadius:10];
    
    CAShapeLayer *labelLayer = [CAShapeLayer layer];
    labelLayer.lineWidth = 1;
    labelLayer.path = path.CGPath;
    labelLayer.fillColor = UIColor.clearColor.CGColor;
    labelLayer.lineCap = kCALineCapRound;
    labelLayer.borderColor = UIColor.clearColor.CGColor;
    labelLayer.strokeColor = UIColor.redColor.CGColor;
    [self.contentView.layer addSublayer:labelLayer];
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
        _bsLabel.text = @"说明";
        _bsLabel.backgroundColor = UIColor.whiteColor;
        _bsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bsLabel;
}


@end
