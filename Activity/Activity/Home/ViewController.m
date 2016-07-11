//
//  ViewController.m
//  Activity
//
//  Created by Rakesh Kumar Sharma on 10/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "TrainersDasboardViewController.h"
#import "CommonUtility.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "UIView+Toast.h"
#import "UIImageView+WebCache.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KIImagePagerDelegate,KIImagePagerDataSource>

@property(weak,nonatomic) IBOutlet KIImagePager * imagePager;;

@property(weak,nonatomic) IBOutlet UICollectionView * cvActivity;
@property (strong, nonatomic) NSArray *collectionImages;;


//SEARCH BAR
@property (strong, nonatomic) NSMutableArray* filteredTableData;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar2;


@property (nonatomic, assign) bool isFiltered;


@end

static NSString * const reuseIdentifier = @"Cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CallApi];
    self.title = @"Activity App";
    self.cvActivity.delegate = self;
    
//
//    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Activity" ofType:@"plist"];
//    NSDictionary * contentDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    self.collectionImages  = [[contentDic valueForKey:@"data"] valueForKey:@"Activity"];

    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.imagePager.slideshowTimeInterval = 5.5f;
    self.imagePager.slideshowShouldCallScrollToDelegate = YES;
    
    // _imagePager.indicatorDisabled =YES;
    self.imagePager.bounces =YES;
    
    self.imagePager.imageCounterDisabled =YES;
    
    self.imagePager.hidePageControlForSinglePages =YES;
    
    self.imagePager.tileDisabled = YES;
    
    
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    return @[[UIImage imageNamed:@"first.jpg"],[UIImage imageNamed:@"london.jpg"],[UIImage imageNamed:@"paris.jpg"]
             ];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager *)pager
{
    return @[
             @"First screenshot",
             @"Another screenshot",
             @"Last one! ;-)"
             ][index];
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    int rowCount;
    if(self.isFiltered)
        rowCount = (int)self.filteredTableData.count;
    else
        rowCount = (int)self.collectionImages.count;
    
    return rowCount;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
       NSDictionary *dataDic;
    if(self.isFiltered)
        dataDic = [self.filteredTableData objectAtIndex:indexPath.row];
    else dataDic = [self.collectionImages objectAtIndex:indexPath.row];
    
    
    [cell setData:dataDic];
    

        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dataDic;
    if(self.isFiltered)
    dataDic = [self.filteredTableData objectAtIndex:indexPath.row];
    else dataDic = [self.collectionImages objectAtIndex:indexPath.row];
    
    UIStoryboard *stry = self.storyboard;
    
     TrainersDasboardViewController *svc = [stry instantiateViewControllerWithIdentifier:@"TrainersDasboardViewController"];
//    svc.collectionDic = dataDic;
     [self.navigationController pushViewController:svc animated:NO];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}



//*****************
// SEARCH BAR
//*****************

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    //NSLog(@"searchBar ... text.length: %d", text.length);
    
    if (searchBar.text.length == 0)
    {
        [searchBar performSelector:@selector(resignFirstResponder)
                        withObject:nil
                        afterDelay:0];
    }

    else
    {
        self.isFiltered = true;
        self.filteredTableData = [[NSMutableArray alloc] init];
        
        
        for (NSDictionary *dataDic in self.collectionImages)
        {
            NSString* item = [dataDic valueForKey:@"title"];
            //case insensative search - way cool
            if ([item rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [self.filteredTableData addObject:dataDic];
            }
            
        }

        
    }//end if-else
    
    [self.cvActivity reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //User hit Search button on Keyboard
    [self.searchBar2 resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar2 setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar2.text=@"";
    
    [self.searchBar2 setShowsCancelButton:NO animated:YES];
    [self.searchBar2 resignFirstResponder];
    
    self.isFiltered = FALSE;
    [self.cvActivity reloadData];
}

-(void)CallApi
{
    
        if([CommonUtility isInternetConnectionAvailable]){
            
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Activity";
        NSString *urlString = [[NSString alloc]initWithFormat:kAllCategoryApi];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        [manager.requestSerializer setValue:kAccesstokenValue forHTTPHeaderField:kAccesstoken];
//        NSString *emailId = self.txt_emailSignIn.text;
//        NSString *Password = self.txt_PassSignIn.text;
//        
//        
//        NSDictionary *parameters = @{@"email":emailId,@"password":Password};
        
        
        
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response login :: %@",responseObject);
            NSDictionary* _dictInfo = [responseObject valueForKey:@"data"];
            self.collectionImages  = [_dictInfo valueForKey:@"activity"];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                
                //Your code goes in here
                [self.cvActivity reloadData];
                
            }];

            // NSString* method_name = [_dictInfo objectForKey:@"method_name"];
//            int status = [[_dictInfo objectForKey:kApikeyStatus] intValue];
//            if(status == 1)
//            {
//                
//                
//            }
//            else
//            {
//                NSString *strmessage= [_dictInfo objectForKey:@"message"] ;
//                [self.view makeToast:strmessage duration:3.0 position:@"center"];
//                
//            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }];
        
        }else{
        [self.view makeToast:@"Please check your connection and try again" duration:3.0 position:@"CSToastPositionCenter"];
                    }
}


@end
