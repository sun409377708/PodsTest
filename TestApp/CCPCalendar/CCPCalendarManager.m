//
//  CCPCalendarManager.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarManager.h"
#import "CCPCalendarView.h"

@interface CCPCalendarManager()
@property (nonatomic, strong) CCPCalendarView *av;
@end

@implementation CCPCalendarManager
@synthesize av;

- (UIWindow *)appWindow {
    id delegate = [UIApplication sharedApplication].delegate;
    return [delegate window];
}

- (void)calendar {
    if (!av) {
        av = [[CCPCalendarView alloc] init];
        av.frame = CGRectMake(0, main_height, main_width, main_height);
        self.normal_text_color = normal_color;
        av.manager = self;
        av.backgroundColor = [UIColor whiteColor];
        [av initSubviews];
        [[self appWindow] addSubview:av];
    }
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self->av.frame = CGRectMake(0, 0, main_width, main_height);
    } completion:nil];
}

- (closeBlock)close {
    __weak typeof(av)weekAV = av;
    __weak typeof(self)ws = self;
    if (!_close) {
        _close = ^() {
            [UIView animateWithDuration:.35 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                weekAV.frame = CGRectMake(0, main_height, main_width, main_height);
            } completion:^(BOOL finished) {
                if (ws.clean) {
                    ws.clean();
                }
                
                [weekAV removeFromSuperview];
            }];
        };
    }
    return _close;
}


- (NSMutableArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

- (NSMutableArray *)selectBtns {
    if (!_selectBtns) {
        _selectBtns = [NSMutableArray array];
    }
    return _selectBtns;
}

- (NSDate *)createDate {
    if (!_createDate) {
        _createDate = [NSDate date];
    }
    return _createDate;
}

- (UIColor *)disable_text_color {
    if (!_disable_text_color) {
        _disable_text_color = rgba(165, 173, 172, 1);
    }
    return _disable_text_color;
}

- (UIColor *)normal_text_color {
    if (!_normal_bg_color) {
        _normal_bg_color = normal_color;
    }
    return _normal_text_color;
}

- (UIColor *)selected_text_color {
    if (!_selected_text_color) {
        _selected_text_color = rgba(255, 255, 255, 1);
    }
    return _selected_text_color;
}

- (NSString *)startTitle {
    if (!_startTitle) {
        _startTitle = @"选择日期";
    }
    return _startTitle;
}

- (NSArray<NSDate *> *)dateEnableRange {
    if (!_dateEnableRange) {
        _dateEnableRange = [NSArray array];
    }
    return _dateEnableRange;
}

- (NSArray<NSDate *> *)dateEnableTime {
    if (!_dateEnableTime) {
        _dateEnableTime = [NSArray array];
    }
    return _dateEnableTime;
}

- (NSString *)endTitle {
    if (!_endTitle) {
        _endTitle = [@"结束" stringByAppendingFormat:@"\n%@",@"日期"];
    }
    return _endTitle;
}


//单选有过去
+ (void)show_signal_past:(completeBlock)complete {
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.isShowPast = YES;
    manager.complete = complete;
    [manager calendar];
}
//多选有过去
+ (void)show_mutil_past:(completeBlock)complete {
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.isShowPast = YES;
    manager.selectType = select_type_multiple;
    manager.complete = complete;
    [manager calendar];
}
//单选没有过去
+ (void)show_signal:(completeBlock)complete {
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.isShowPast = NO;
    manager.complete = complete;
    [manager calendar];
}
//多选没有过去
+ (void)show_mutil:(completeBlock)complete {
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.isShowPast = NO;
    manager.selectType = select_type_multiple;
    manager.complete = complete;
    [manager calendar];
}


//单选有过去
- (void)show_signal_past:(completeBlock)complete {
    self.isShowPast = YES;
    self.selectType = select_type_single;
    self.complete = complete;
    [self calendar];
}
//多选邮过去
- (void)show_mutil_past:(completeBlock)complete {
    self.isShowPast = YES;
    self.selectType = select_type_multiple;
    self.complete = complete;
    [self calendar];
}
//单选没有过去
- (void)show_signal:(completeBlock)complete {
    self.isShowPast = NO;
    self.selectType = select_type_single;
    self.complete = complete;
    [self calendar];
}
//多选没有过去
- (void)show_mutil:(completeBlock)complete {
    self.isShowPast = NO;
    self.selectType = select_type_multiple;
    self.complete = complete;
    [self calendar];
}
@end
