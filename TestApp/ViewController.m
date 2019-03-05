//
//  ViewController.m
//  TestApp
//
//  Created by maoge on 2019/2/27.
//  Copyright © 2019 maoge. All rights reserved.
//

#import "ViewController.h"
#import "CCPCalendarManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 定义一个遵循某个历法的日历对象 NSGregorianCalendar国际历法
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // 通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter |
    NSCalendarUnitWeekOfMonth |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitYearForWeekOfYear |
    NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar |
    NSCalendarUnitTimeZone;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSLog(@"era(世纪): %li", (long)comps.era);
    NSLog(@"year(年份): %li", (long)comps.year);
    NSLog(@"quarter(季度):%li", (long)comps.quarter);
    NSLog(@"month(月份):%li", (long)comps.month);
    NSLog(@"day(日期):%li", (long)comps.day);
    NSLog(@"hour(小时):%li", (long)comps.hour);
    NSLog(@"minute(分钟):%li", (long)comps.minute);
    NSLog(@"second(秒):%li", (long)comps.second);
    
    //    Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5, Friday:6, Saturday:7
    NSLog(@"weekday(星期):%li", (long)comps.weekday);
    
    //    苹果官方不推荐使用week
    NSLog(@"week(该年第几周):%li", (long)comps.week);
    NSLog(@"weekOfYear(该年第几周):%li", (long)comps.weekOfYear);
    NSLog(@"weekOfMonth(该月第几周):%li", (long)comps.weekOfMonth);
    NSLog(@"yearForWeekOfYear(年):%li", (long)comps.yearForWeekOfYear);//不是很明白其含义
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.normal_text_color = normal_color;

    manager.selectDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *startDate = [formatter dateFromString:@"2019-03-07"];
    NSDate *endDate = [formatter dateFromString:@"2019-03-08"];
    NSDate *otherDate = [formatter dateFromString:@"2019-04-27"];

    manager.selectDate = startDate;

    
//    manager.dateEnableRange = @[startDate, endDate];
    manager.dateEnableTime = @[startDate, endDate, otherDate];
    
    [manager show_signal:^(NSArray<__kindof NSObject *> *stArr) {
        
    }];
}


@end
