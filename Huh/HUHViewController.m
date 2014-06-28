//
//  HUHViewController.m
//  Huh
//
//  Created by Jurre Stender on 28/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "HUHViewController.h"
#import <Firebase/Firebase.h>

@interface HUHViewController ()

@property (nonatomic, strong) Firebase *firebase;

@end

@implementation HUHViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.firebase = [[Firebase alloc] initWithUrl:@"https://huh.firebaseio.com/huh_list"];

    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Shit went down: %@: %@", snapshot.name, snapshot.value);
    }];

    self.lineChart.delegate = self;
    self.lineChart.dataSource = self;
    [self.lineChart reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - User Interaction

- (IBAction)huhButtonTapped:(id)sender {
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [[self dateFormatter] stringFromDate:now];
    NSString *deviceId = [[[UIDevice currentDevice]identifierForVendor] UUIDString];
    Firebase *huh = [self.firebase childByAutoId];
    [huh setValue:@{ @"createdAt": [NSString stringWithFormat:@"%@", dateString], @"udid": deviceId }];
}

#pragma mark - JBChart Delegate/Datasource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    return 10;
}

-           (CGFloat)lineChartView:(JBLineChartView *)lineChartView
   verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
                       atLineIndex:(NSUInteger)lineIndex {
    return (CGFloat)rand() / RAND_MAX;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex {
    return [UIColor whiteColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    return [UIColor whiteColor];
}

#pragma mark - Date Formatting

- (NSDate *)dateFromISO8601String:(NSString *)dateString {

    NSDate *dateFromString = [[self dateFormatter] dateFromString:dateString];
    return dateFromString;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }
    return dateFormatter;
}

@end
