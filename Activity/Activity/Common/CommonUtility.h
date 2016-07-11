//
//  CommonUtility.h
//  Activity
//
//  Created by Rakesh Kumar Sharma on 17/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AppDelegate;

@protocol keyPadDelegate <NSObject>
@optional
-(void)clearKeypad;
-(void)downKeypad;
@end


@interface CommonUtility : NSObject

@property(weak, nonatomic) id <keyPadDelegate> utilityDelegate;

+(BOOL)isInternetConnectionAvailable;

+(BOOL)validateEmail:(NSString*)email :(UIView*)view;
+(BOOL)validatePassword:(NSString*)password :(UIView*)view;
+(AppDelegate*)appDelagate;
+(UIColor*)colorWithHexString:(NSString*)hex;

// NSUserDefault
+(void)setDefaultContent:(id)content withKey:(NSString*)stringKey;
+(NSString*)getDefaultContentForKey:(NSString*)stringKey;
+(void)removeDefaultContentForKey:(NSString*)stringKey;

//Image Save to Documents Directory
+(void)saveImage:(UIImage*)image withImageName:(NSString*)imageName;
+(UIImage*)loadImageWithImageName:(NSString*)imageName;
+(void)removeImageWithImageName:(NSString*)imageName;

+(CGSize)calculateSizeOfCellByString:(NSString*)string sizeWithFont:(UIFont*)font;

+(void)addToolBarOnKeyboard:(UITextField*)textfield;
+ (NSString *)documentsPath;
+(NSDate *)convertStringIntoDate:(NSString*)dateString with:(NSString*)formatString;
//+(NSString *)publishedDateString:(NSDate *)iDate;
+(void) PopUpAlertController : (id) sender : (NSString *) Message : (NSString *)title;

@end
