//
//  DetailsViewController.h
//  Activity
//
//  Created by Rakesh Kumar Sharma on 15/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "ViewController.h"

@interface DetailsViewController : ViewController
@property (weak, nonatomic) IBOutlet UITableView *tblDetailsView;

@property (weak, nonatomic) NSDictionary *collectionDic;
@property (weak, nonatomic) NSArray *dataArray;


@end
