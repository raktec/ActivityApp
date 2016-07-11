//
//  CollectionViewCell.m
//  collevtionViewWithSearchBar
//
//  Created by Homam on 2015-01-02.
//  Copyright (c) 2015 Homam. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CollectionViewCell


-(void)setData:(NSDictionary *)dicData{

    NSString *title =[dicData valueForKey:@"title"];
    NSString *imageName =[dicData valueForKey:@"avatar"];
    self.laName.text = title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageName]
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

}

@end