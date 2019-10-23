//
//  CCPCalendarHeader.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarHeader.h"
#import "UIView+CCPView.h"
#import "NSDate+CCPCalendar.h"

@interface CCPCalendarHeader()
{
    /*
     * l_gap,r_gap 左右距离
     * big_l_gap,big_r_gap 大字左右距离
     * t_gap 上方间距
     */
    CGFloat l_gap,r_gap,big_l_gap,big_r_gap,t_gap;
    
    UIButton *l_btn,*r_btn;
    UILabel *l_label, *r_label;
}
@end

@implementation CCPCalendarHeader

- (instancetype)init {
    if (self = [super init]) {
        l_gap = r_gap = scale_w * 20.0;
        big_l_gap = big_r_gap = scale_w * 35.0 + TOP_MARGIN;
        t_gap = scale_h * 15;
        self.backgroundColor = [UIColor clearColor];
        [self addObserver:self forKeyPath:@"manager.selectArr" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"manager.startTitle" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)initSubviews {
    [self functionBtns];
    [self showSelect];
    [self weeks];
    [self line];

    CGFloat h = [self getSupH];
    UIView *bLine = [[UIView alloc] initWithFrame:CGRectMake(0, h+10, main_width, 10)];
    bLine.backgroundColor = dyt_bg_color;
    [self addSubview:bLine];
}

/*
 * 最上方按钮
 */
- (void)functionBtns {
    l_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource: @"CCPCalendar" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageWithContentsOfFile:[resourceBundle pathForResource:@"calendar_return_img" ofType:@"png"]];
    
    if (self.manager.nav_back_img) {
        [l_btn setImage:self.manager.nav_back_img forState:UIControlStateNormal];
    }else {
        [l_btn setImage:image forState:UIControlStateNormal];
    }
    
    [l_btn setTitleColor:normal_color forState:UIControlStateNormal];
    l_btn.titleLabel.font = [UIFont systemFontOfSize:scale_w * 17];
    l_btn.frame = CGRectMake(l_gap, big_l_gap, scale_w * 50, scale_w * 25);
    [l_btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [l_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [self addSubview:l_btn];
    r_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [r_btn setTitle:@"确认修改" forState:UIControlStateNormal];
    r_btn.titleLabel.font = [UIFont systemFontOfSize:14.0 * scale_w];
    [r_btn setTitleColor:dyt_btn_color forState:UIControlStateNormal];;
    [r_btn addTarget:self action:@selector(actionChange:) forControlEvents:UIControlEventTouchUpInside];
    r_btn.frame = CGRectMake(main_width - r_gap - [self r_btn_w], big_l_gap, [self r_btn_w], scale_w * 25);
//    r_btn.hidden = YES;
    [self addSubview:r_btn];

}

//中间显示大字
- (void)showSelect {
    l_label = [[UILabel alloc] init];
    l_label.font = [UIFont systemFontOfSize:scale_w * 20];
    l_label.textColor = normal_color;
    l_label.textAlignment = NSTextAlignmentLeft;
    l_label.numberOfLines = 2;
    [self addSubview:l_label];
    if (self.manager.selectType == select_type_multiple) {
        r_label = [[UILabel alloc] init];
        r_label.font = l_label.font;
        r_label.textColor = normal_color;
        r_label.textAlignment = NSTextAlignmentRight;
        r_label.numberOfLines = 2;
        [self addSubview:r_label];
    }
    [self displayLabel];
}

//星期
- (void)weeks {
    NSArray *arr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];

    CGFloat w = main_width / 7;
    CGFloat y;
    for (int idx = 0; idx < arr.count; idx ++) {
        NSString *week = arr[idx];
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(w * idx , CGRectGetMaxY(l_label.frame) + 25 * scale_h, w, 25 * scale_h)];
        y = CGRectGetMaxY(weekLabel.frame);
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = [UIFont systemFontOfSize:14 * scale_h];
        weekLabel.textColor = normal_color;
        weekLabel.text = week;
        [self addSubview:weekLabel];
    }
}

//中间斜线
- (void)line {
    if (self.manager.selectType == select_type_multiple) {
        CGFloat distance = 25 * scale_w;
        CGFloat centerX = main_width / 2;
        CGPoint startP = CGPointMake(centerX - distance, CGRectGetMaxY(l_label.frame) - 5);
        CGPoint endP = CGPointMake(centerX + distance, CGRectGetMinY(r_label.frame) + 5);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startP];
        [path addLineToPoint:endP];
        CAShapeLayer *shapeL = [CAShapeLayer layer];
        shapeL.path = path.CGPath;
        shapeL.lineWidth = 0.5;
        shapeL.strokeColor = normal_color.CGColor;
        [self.layer addSublayer:shapeL];
    }
}

- (CGFloat)r_btn_w {
    NSString *tt = r_btn.titleLabel.text;
    CGRect rect = [tt boundingRectWithSize:CGSizeMake(1000, 25 * scale_w) options:NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName : normal_color, NSFontAttributeName : [UIFont systemFontOfSize:14 * scale_w]} context:nil];
    return rect.size.width;
}

- (void)displayLabel {
    CGFloat top = big_l_gap;
    CGFloat h = 24 * scale_h;
    if (![self.manager.startTitle isEqualToString:l_label.text]) {
        l_label.text = self.manager.startTitle;
        CGFloat w = [l_label widthBy:h];
        CGFloat left = (main_width - w) * 0.5;
        l_label.frame = CGRectMake(left, top, w, h);
    }
    if (![self.manager.endTitle isEqualToString:r_label.text]) {
        r_label.text = self.manager.endTitle;
        CGFloat w = [r_label widthBy:h];
        r_label.frame = CGRectMake(main_width - big_r_gap - w, CGRectGetMaxY(l_btn.frame) + top, w, h);
    }
}

- (void)close {
    if (self.manager.close) {
        self.manager.close();
    }
}

- (void)actionChange:(UIButton *)sender {
//    [[self.manager mutableArrayValueForKey:@"selectArr"] removeAllObjects];
//    if (self.manager.clean) {
//        self.manager.clean();
//    }
    
    if (self.manager.complete) {
        NSMutableArray *marr = [NSMutableArray array];
        if (self.manager.selectType == select_type_single) {
            if (self.manager.selectArr.count == 0) {
                if (self.manager.close) {
                    self.manager.close();
                }
                return;
            }
        }
        for (NSDate *date in self.manager.selectArr) {
            NSString *year = [NSString stringWithFormat:@"%ld",(long)[date getYear]];
            NSString *month = [NSString stringWithFormat:@"%02ld",(long)[date getMonth]];
            NSString *day = [NSString stringWithFormat:@"%02ld",(long)[date getDay]];
            NSString *weekString = [date weekString];
            NSInteger week = [date getWeek];
            NSString *ccpDate = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            NSArray *arr = @[ccpDate,year,month,day,weekString,@(week)];
            CCPCalendarModel *model = [[CCPCalendarModel alloc] initWithArray:arr];
            [marr addObject:model];
        }
        self.manager.complete(marr);
        if (self.manager.close) {
            self.manager.close();
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"manager.selectArr"]) {
        NSArray *arr = self.manager.selectArr.copy;
        if (arr.count == 0) {
            self.manager.startTitle = self.manager.endTitle = nil;
        }
        else if (arr.count == 1) {
            self.manager.endTitle = nil;
            NSDate *date = arr.firstObject;
            self.manager.startTitle = [NSString stringWithFormat:@"%ld月%02ld日%@",[date getMonth],[date getDay],[date weekString]];
            
        }
        else if (arr.count == 2){
            NSDate *date1 = arr.firstObject;
            NSDate *date2 = arr[1];
            self.manager.startTitle = [NSString stringWithFormat:@"%ld月%02ld日%@",[date1 getMonth],[date1 getDay],[date1 weekString]];
            self.manager.endTitle = [NSString stringWithFormat:@"%ld月%02ld日%@",[date2 getMonth],[date2 getDay],[date2 weekString]];
        }
//        [self displayLabel];
    }
    else if ([keyPath isEqualToString:@"manager.startTitle"]) {
        if (![self.manager.startTitle isEqualToString:[@"开始" stringByAppendingFormat:@"%@",@"日期"]]) {
//            r_btn.hidden = NO;
        }
        else {
//            r_btn.hidden = YES;
        }
    }
}

@end
