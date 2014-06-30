//
//  HUHCheckinViewController.h
//  Huh
//
//  Created by Jurre Stender on 29/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUHCheckinViewController : UIViewController

@property (nonatomic, strong) NSDictionary *session;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *authorImageView;

@end
