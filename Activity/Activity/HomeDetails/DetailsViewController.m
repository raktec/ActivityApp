//
//  DetailsViewController.m
//  Activity
//
//  Created by Rakesh Kumar Sharma on 15/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsViewCell.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.collectionDic valueForKey:@"title"];
    self.dataArray = [self.collectionDic valueForKey:@"list"];

    // Do any additional setup after loading the view.
}- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [self.dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSDictionary* dicData = [self.dataArray objectAtIndex:indexPath.row];
    
    static NSString* identifier = @"dvCell";
    DetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[DetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell  setData:dicData];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}






@end
