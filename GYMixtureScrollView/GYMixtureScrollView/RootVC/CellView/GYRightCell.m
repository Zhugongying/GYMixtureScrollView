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

@property (nonatomic, strong, nullable)  CAShapeLayer *labelLayer;

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

- (void)addBoard {
    CGRect lableRect = self.bsLabel.bounds;
    lableRect = CGRectMake(lableRect.origin.x + 5, lableRect.origin.y + 5, lableRect.size.width - 10, lableRect.size.height - 10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:lableRect cornerRadius:10];
    
    _labelLayer = [CAShapeLayer layer];
    _labelLayer.lineWidth = 1;
    _labelLayer.path = path.CGPath;
    _labelLayer.fillColor = UIColor.clearColor.CGColor;
    _labelLayer.lineCap = kCALineCapRound;
    _labelLayer.borderColor = UIColor.clearColor.CGColor;
    _labelLayer.strokeColor = _bordColor.CGColor;
    [self.contentView.layer addSublayer:_labelLayer];
}

- (void)setBordColor:(UIColor *)bordColor {
    _bordColor = bordColor;
    
    [self layoutIfNeeded];
    [self addBoard];
}


- (UILabel *)bsLabel {
    if (_bsLabel == nil) {
        _bsLabel = [[UILabel alloc] init];
        _bsLabel.text = @"个说明";
        _bsLabel.backgroundColor = UIColor.gy_paleGrey;
        _bsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bsLabel;
}


@end
