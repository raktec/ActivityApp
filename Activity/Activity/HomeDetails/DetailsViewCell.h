//
//  DetailsViewCell.h
//  Activity
//
//  Created by Rakesh Kumar Sharma on 16/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewCell : UITableViewCell
@property (weak, nonatomic)IBOutlet UIImageView *img;
@property (weak, nonatomic)IBOutlet UILabel *lblTitle;
@property (weak, nonatomic)IBOutlet UILabel *lblDesc;

-(void)setData:(NSDictionary *)dicData;


@end
