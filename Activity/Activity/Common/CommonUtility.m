//
//  CommonUtility.m
//  Activity
//
//  Created by Rakesh Kumar Sharma on 17/06/16.
//  Copyright © 2016 Rakesh Kumar Sharma. All rights reserved.
//

#import "CommonUtility.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "Constants.h"


@implementation CommonUtility

+(BOOL)isInternetConnectionAvailable
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reach currentReachabilityStatus];
    
    if(internetStatus == NotReachable)
        return NO;
    else
        return YES;
    
    
}



+(void) PopUpAlertController : (id) sender : (NSString *) Message : (NSString *)title;
{
    UIAlertController * alert;
    alert =   [UIAlertController
               alertControllerWithTitle:title
               message:Message
               preferredStyle:UIAlertControllerStyleAlert];
    [sender presentViewController:alert animated:YES completion:nil];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    
}

+(BOOL)validateEmail:(NSString*)email :(UIView*)view{
    
    if(![email isEqualToString:@""])
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        //Valid email address
        if ([emailTest evaluateWithObject:email] == YES)
        {
            return TRUE;
        }
        else
        {
            [view makeToast:@"Enter Valid Email" duration:3.0 position:@"center"];
            return FALSE;
        }
    }
    else
    {
        [view makeToast:@"Enter Email" duration:3.0 position:@"center"];
        return FALSE;
    }
}

+(BOOL)validatePassword:(NSString*)password :(UIView*)view
{
    //Minimum 8 characters at least 1 symbol:
    if(![password isEqualToString:@""])
    {
        if(password.length>7)
        {
            NSString* passRegEx = @"^(?=.{8,})(?=.*[#@$%*&]).*$";
            NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegEx];
            //Valid Password
            if ([passTest evaluateWithObject:password] == YES)
            {
                return TRUE;
            }
            else
            {
                [view makeToast:@"Password must be 8 characters long and contain atleast one symbol.(*&%$#)" duration:3.0 position:@"center"];
                return FALSE;
            }
        }
        else
        {
            [view makeToast:@"Password should be atleast 8 characters long" duration:3.0 position:@"center"];
            return FALSE;
        }
    }
    else
    {
        [view makeToast:@"Password can not be blank" duration:3.0 position:@"center"];
        return FALSE;
    }
}



+(AppDelegate*)appDelagate
{
    return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}




+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}






+(NSString *)checkForHttpInUrlString:(NSString *)stringURL
{
    
    NSString *newURLString = [NSString stringWithFormat:@"%@",stringURL];
    
    
    BOOL result = [[stringURL lowercaseString] hasPrefix:@"http://"];
    
    if (!result)
        newURLString = [NSString stringWithFormat:@"http://%@",stringURL];
    
    
    return newURLString;
}






//#pragma marks - NSUserDefault


+(void)setDefaultContent:(id)content withKey:(NSString*)stringKey
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    [defaultUser setObject:content forKey:stringKey];
    [defaultUser synchronize];
    
}

+(NSString*)getDefaultContentForKey:(NSString*)stringKey
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    return [[defaultUser objectForKey:stringKey] mutableCopy];
}

+(void)removeDefaultContentForKey:(NSString*)stringKey
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    [defaultUser removeObjectForKey:stringKey];
    [defaultUser synchronize];
}


//-#pragma marks - Image Save to Documents Directory

+(void)saveImage:(UIImage*)image withImageName:(NSString*)imageName
{
    
    NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,@"png"]]; //add our image to the path
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
    //NSLog(@"image saved");
}


+(UIImage*)loadImageWithImageName:(NSString*)imageName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,@"png"]];
    return [UIImage imageWithContentsOfFile:fullPath];
}


+(void)removeImageWithImageName:(NSString*)imageName
{
    // Get the Documents directory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    // Delete the file using NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,@"png"]] error:nil];
}

+(BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate
{
    return [date compare:firstDate] == NSOrderedDescending && [date compare:lastDate]  == NSOrderedAscending;
}

+(CGSize)calculateSizeOfCellByString:(NSString*)string sizeWithFont:(UIFont*)font
{
    CGSize size;
    if(ISIOS7OrGreater)
    {
        NSString *cellText = string;
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        CGRect frame = [cellText boundingRectWithSize:constraintSize
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:attributesDictionary
                                              context:nil];
        size = frame.size;
    }
    else
    {
        NSString *cellText = string;
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        size = labelSize;
    }
    return size;
}




+(void)addToolBarOnKeyboard:(UITextField*)textfield
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kScreenBoundz.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    textfield.inputAccessoryView = numberToolbar;
}

-(void)clearNumberPad{
    [self.utilityDelegate clearKeypad];
}

-(void)doneWithNumberPad{
    [self.utilityDelegate downKeypad];
}


+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return documentsPath;
}

+ (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}


+(NSDate *)convertStringIntoDate:(NSString*)dateString with:(NSString*)formatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *strDate = [dateString stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    NSDate *date = [dateFormatter dateFromString:strDate];
    return date;
}

//+(NSString *)publishedDateString:(NSDate *)iDate{
//    NSString *aDateStringToReturn = kJustNowText;
//    
//    NSTimeInterval aTimeInternal = [iDate timeIntervalSinceNow];
//    if (aTimeInternal > -2592000 && aTimeInternal < 0) {
//        if (aTimeInternal > -60) {
//            aDateStringToReturn = kJustNowText;
//        } else if (aTimeInternal > -3600){
//            int aTime = aTimeInternal/-60;
//            aDateStringToReturn = [NSString stringWithFormat:@"%d %@",aTime,(aTime<2)?kMinuteAgoText:kMinutesAgoText];
//        } else if (aTimeInternal > -86400){
//            int aTime = aTimeInternal/-3600;
//            aDateStringToReturn = [NSString stringWithFormat:@"%d %@",aTime,(aTime<2)?kHourAgoText:kHoursAgoText];
//        } else if (aTimeInternal > -2592000){
//            int aTime = aTimeInternal/-86400;
//            aDateStringToReturn = [NSString stringWithFormat:@"%d %@",aTime,(aTime<2)?kDayAgoText:kDaysAgoText];
//        }
//    }else{
//        NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc]init];
//        [aDateFormatter setDateFormat:@"dd MMMM, yyyy"];
//        aDateStringToReturn = [aDateFormatter stringFromDate:iDate];
//    }
//    return aDateStringToReturn;
//}



@end
