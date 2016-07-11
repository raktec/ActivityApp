//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import <QuartzCore/QuartzCore.h>

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.arrayMenuData=@[@"Account",@"History", @"Scheduled",@"Notification", @"Invite Friends",@"Support",@"Logout"];
	
	
}

#pragma mark - UITableView Delegate & Datasrouce -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayMenuData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.arrayMenuData objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc ;
    
    switch (indexPath.row)
    {
            
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AccountViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            
            break;
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HistoryViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            
            break;
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ScheduledViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            
            break;
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"NotificationViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            
            break;
            
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InviteFriendsViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            return;
            break;
        case 5:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SupportViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
            return;
            break;
            
        case 6:{
            [self logout];
        }
            
            break;
            
    }
    
    
    
}


- (void)logout{
    
    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
    NSDictionary *dicUserDefault =[[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    for (NSString * key in [dicUserDefault allKeys]) {
        if ([key isEqualToString:@"autologin"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        }
    }


}



- (IBAction)onClickLogout:(UIButton *)sender {
    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
    NSDictionary *dicUserDefault =[[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    for (NSString * key in [dicUserDefault allKeys]) {
        if ([key isEqualToString:@"autologin"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        }
    }

}
@end
