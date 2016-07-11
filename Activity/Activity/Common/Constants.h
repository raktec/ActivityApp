//
//  Constants.h
//
//
//  Created by Rakesh Sharma on 09/09/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <Foundation/Foundation.h>

#define ISIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define ISIOS7OrGreater [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define loginLangSelectedColor [UIColor colorWithRed:23.0/255.0 green:89.0/255.0 blue:121.0/255.0 alpha:1.0]
#define ISIPHONE5 (([[UIScreen mainScreen] bounds].size.height >= 568) || ([[UIScreen mainScreen] bounds].size.width >= 568))

#define     kNotificationCenter  [NSNotificationCenter  defaultCenter]

#define   kNSUserDefaults  [NSUserDefaults standardUserDefaults]

#define kScreenBoundz  [UIScreen mainScreen].bounds


#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]






#define kAutoLogin                       @"autoLogin"







#define kBaseUrl                         @"http://demo.wdptechnologies.com/appelstar/api/"

// Api Name
#define kAllCategoryApi                 kBaseUrl@"allcategory"


// Api Key
#define kApikeyId                        @"id"
#define kApikeyTitle                     @"title"
#define kApikeyAvatar                    @"avatar"




//messages
#define kMsgError                       @"Unable to load data"
#define kMsgNoNetwork                   @"No Internet Connection"
#define kMsgEnterValidEmail             @"Please enter valid Email"
#define kMsgUnderConstruction           @"Under Construction"
#define kMsgLoginRequired               @"Please login to enable auto sync"
#define kMsgDeleteAdventure             @"Are you sure?"
#define kMsgFieldMandatory              @"All fields are mandatory"
#define kMsgProfileNameMandatory        @"Profile name is mandatory"
#define kPasswordMismatch               @"Re-do password do not match"










