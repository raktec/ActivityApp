//
//  TrainersDasboardViewController.m
//  Activity
//
//  Created by Rakesh Kumar Sharma on 16/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "TrainersDasboardViewController.h"
#import "CarbonKit.h"

#import "TrainerAllViewController.h"
#import "TrainersViewController.h"
#import "TrainerClubsViewController.h"
#import "TrainerEventsViewController.h"






@interface TrainersDasboardViewController ()<CarbonTabSwipeNavigationDelegate> {
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
}

@end

@implementation TrainersDasboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CarbonKit";
    
    items = @[
              @"All",
              @"Trainers",
              @"Clubs",
              @"Events",
              ];
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    [self style];
    
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:23.0/255 green:113.0/255 blue:234.0/255 alpha:1.0] ;
    self.navigationItem.title = @"Available Trainers";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    ///////////back button
    UIImage *buttonImage = [UIImage imageNamed:@"arrowright.png"];
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    Button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width,   buttonImage.size.height);
    
    UIBarButtonItem *BarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Button];
    
    [Button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:BarButtonItem];
    
    
}









-(void)selectButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)style {
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:[UIColor colorWithRed:83.0/255 green:215.0/255 blue:60.0/255 alpha:1.0]];
    //[carbonTabSwipeNavigation setIndicatorColor:[UIColor redColor]];
    //    83,215,60

    [carbonTabSwipeNavigation setTabExtraWidth:30];
    
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:14]];
}


#pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:
(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"TrainerAllViewController"];
            
        case 1:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"TrainersViewController"];
        case 2:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"TrainerClubsViewController"];
            
        default:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"TrainerEventsViewController"];
    }
}


- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:
(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
