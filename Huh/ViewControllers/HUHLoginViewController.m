//
//  HUHLoginViewController.m
//  Huh
//
//  Created by Jurre Stender on 29/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "HUHLoginViewController.h"
#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>
#import "CRToast.h"

static NSString *const HUHSegueIdentifierLogin = @"SegueIdentifierLogin";

@interface HUHLoginViewController ()

@end

@implementation HUHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)loginWithFacebook:(id)sender {

    Firebase* ref = [[Firebase alloc] initWithUrl:@"https://huh.firebaseio.com/"];
    FirebaseSimpleLogin* authClient = [[FirebaseSimpleLogin alloc] initWithRef:ref];
    
    [authClient loginToFacebookAppWithId:@"1426999820913857" permissions:@[@"email"]
                                audience:ACFacebookAudienceOnlyMe
                     withCompletionBlock:^(NSError *error, FAUser *user) {

                         if (error != nil) {
                             [CRToastManager showNotificationWithMessage:@"Something went wrong, please try again" completionBlock:nil];
                             NSLog(@"Error loggin in with facebook %@", error);
                         } else {
                             [self performSegueWithIdentifier:HUHSegueIdentifierLogin sender:self];
                         }
                     }];
}

@end
