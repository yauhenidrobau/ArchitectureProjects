//
//  Macros.h
//  BelarusNews
//
//  Created by YAUHENI DROBAU on 22/11/2016.
//  Copyright © 2016 YAUHENI DROBAU. All rights reserved.
//
#define SINGLETON(classname) \
+ (classname *)sharedInstance { \
static dispatch_once_t pred; \
__strong static classname * shared##classname = nil; \
dispatch_once( &pred, ^{ \
shared##classname = [[self alloc] init]; }); \
return shared##classname; \
}

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]

#define OUR_LOCATION CLLocationCoordinate2DMake(52.710527, 25.341690)

#define WEAK(var) __weak typeof(var) weak_##var = var;
#define STRONG(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop") \

#define NN_NETWORK_STATE_OK @"NN_NETWORK_STATE_OK"
#define NN_USER_AUTH_CHANGED @"NN_USER_AUTH_CHANGED"
#define NN_NETWORK_STATE_OFFLINE @"NN_NETWORK_STATE_OFFLINE"


#define BASE_EMAIL @"proektydomow@mail.ru"
//#define BASE_EMAIL @"zheka-88_94@mail.ru"

#define VK_URL @"https://vk.com/architectureidesign"
#define INSTAGRAM_URL @"https://www.instagram.com/proektydomow/"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_PRO (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

typedef enum {
    MenuTypeProjects = 0,
    MenuTypeStart = 1,
    MenuTypeCost = 2,
    MenuTypeQuestion = 3,
    MenuTypeContact = 4
}MenuTypes;

typedef void(^RealmDataManagerSaveCallback)(NSError *error);
typedef void(^APUserManagerLoginCompletion)(NSError *error);
