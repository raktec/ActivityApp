//
//  DetailsViewCell.m
//  Activity
//
//  Created by Rakesh Kumar Sharma on 16/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "DetailsViewCell.h"

@implementation DetailsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(NSDictionary *)dicData{
    NSString *strTitle = [dicData valueForKey:@"title"];
    NSString *strImage = [dicData valueForKey:@"image"];
    NSString *strDesc = [dicData valueForKey:@"desc"];
    self.lblTitle.text = strTitle;
    self.lblDesc.text = strDesc;
    self.img.image = [UIImage imageNamed:strImage];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
