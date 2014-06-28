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

static NSString *const HUHFirebaseSessionsURL = @"https://huh.firebaseio.com/sessions";
static NSString *const HUHSessionTableCellIdentifier = @"HUHSessionTableCellIdentifier";

@interface HUHSessionsTableViewController ()

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) NSMutableArray *sessions;

@end

@implementation HUHSessionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.firebase = [[Firebase alloc] initWithUrl:HUHFirebaseSessionsURL];

    NSLog(@"Firebase: %@", self.firebase);
    self.sessions = [[NSMutableArray alloc] init];

    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Shit went down: %@: %@", snapshot.name, snapshot.value);
        [self.sessions removeAllObjects];
        
        for (FDataSnapshot *session in snapshot.children) {
            [self.sessions addObject:session.value];
        }
        [self.tableView reloadData];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

@end
