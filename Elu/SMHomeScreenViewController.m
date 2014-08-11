//
//  SMHomeScreenViewController.m
//  Elu
//
//  Created by Shaun Merritt on 7/23/14.
//  Copyright (c) 2014 True Merit Development. All rights reserved.
//

#import "SMHomeScreenViewController.h"

@interface SMHomeScreenViewController ()

@end

@implementation SMHomeScreenViewController
@synthesize restrictionsLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Query for objects in class DietRestrictions with the same username as the current user
    PFQuery *query = [PFQuery queryWithClassName:@"DietRestrictions"];
    [query whereKey:@"user" equalTo:PFUser.currentUser];
    
    // Find the objects from the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // No error
                    NSLog(@"Successfully retrieved %lu objects.", (unsigned long)objects.count);
                    // For each of the objects that is returned
                    for (PFObject *object in objects) {
                        //log the objects that we got back to the NSLOG
                        NSDictionary *caps = [object valueForKey:@"caps"];
                        NSLog(@"%@", caps);
                        NSString *capsString = [NSString stringWithFormat:@"%@", caps];
                        restrictionsLabel.text = capsString;
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
