//
//  HUHViewController.h
//  Huh
//
//  Created by Jurre Stender on 28/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"

@interface HUHViewController : UIViewController <JBLineChartViewDelegate, JBLineChartViewDataSource>

@property (nonatomic, weak) IBOutlet JBLineChartView *lineChart;

@property (nonatomic, weak) IBOutlet UILabel *statLabel;

@property (nonatomic, strong) NSString *sessionId;

- (IBAction)huhButtonTapped:(id)sender;

@end
