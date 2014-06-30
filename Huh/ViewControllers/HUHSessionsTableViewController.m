//
//  HUHSessionsTableViewController.m
//  Huh
//
//  Created by Jurre Stender on 28/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "HUHSessionsTableViewController.h"
#import <Firebase/Firebase.h>
#import "HUHSessionTableViewCell.h"
#import "HUHCheckinViewController.h"

static NSString *const HUHFirebaseSessionsURL = @"https://huh.firebaseio.com/sessions";
static NSString *const HUHSessionTableCellIdentifier = @"HUHSessionTableCellIdentifier";

@interface HUHSessionsTableViewController ()

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) NSMutableArray *sessions;

@end

@implementation HUHSessionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.hidesBackButton = YES;

    self.firebase = [[Firebase alloc] initWithUrl:HUHFirebaseSessionsURL];

    NSLog(@"Firebase: %@", self.firebase);
    self.sessions = [[NSMutableArray alloc] init];

    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Shit went down: %@: %@", snapshot.name, snapshot.value);
        [self.sessions removeAllObjects];
        
        for (FDataSnapshot *session in snapshot.children) {
            NSDictionary *sessionDictionary = session.value;
            [sessionDictionary setValue:session.name forKeyPath:@"sessionId"];
            if (!sessionDictionary[@"endedAt"]) {
                [self.sessions addObject:sessionDictionary];
            } else {
                NSLog(@"Session ended: %@", sessionDictionary);
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUHSessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HUHSessionTableCellIdentifier];
    NSDictionary *session = self.sessions[indexPath.row];
    cell.titleLabel.text = session[@"title"];
    cell.authorLabel.text = session[@"authorName"];
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HUHCheckinViewController *destinationViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *session = self.sessions[indexPath.row];
    destinationViewController.session = session;
}

@end
