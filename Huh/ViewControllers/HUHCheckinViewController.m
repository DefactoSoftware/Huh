//
//  HUHCheckinViewController.m
//  Huh
//
//  Created by Jurre Stender on 29/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "HUHCheckinViewController.h"
#import "HUHViewController.h"

static NSString *const HUHSegueIdentifierCheckin = @"SegueIdentifierCheckin";

@interface HUHCheckinViewController ()

@end

@implementation HUHCheckinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.session[@"title"];
    self.authorNameLabel.text = self.session[@"authorName"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http:%@", self.session[@"avatarUrl"]]];
    self.authorImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

- (IBAction)checkIn:(id)sender {
    [self performSegueWithIdentifier:HUHSegueIdentifierCheckin sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HUHViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.sessionId = self.session[@"sessionId"];
}

@end
