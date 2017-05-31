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

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define WS() __weak typeof(self) wself = self;

#define NN_NETWORK_STATE_OK @"NN_NETWORK_STATE_OK"
#define NN_USER_AUTH_CHANGED @"NN_USER_AUTH_CHANGED"
#define NN_NETWORK_STATE_OFFLINE @"NN_NETWORK_STATE_OFFLINE"

#define LOGIN_IS_ALREADY_EXISTS_CODE 17007

//#define BASE_EMAIL @"proektydomow@mail.ru"
#define BASE_EMAIL @"zheka-88_94@mail.ru"

#define VK_URL @"https://vk.com/architectureidesign"
#define INSTAGRAM_URL @"https://www.instagram.com/proektydomow/"
typedef enum {
    MenuTypeProjects = 0,
    MenuTypeStart = 1,
    MenuTypeCost = 2,
    MenuTypeQuestion = 3,
    MenuTypeContact = 4
}MenuTypes;

typedef void(^RealmDataManagerSaveCallback)(NSError *error);
typedef void(^APUserManagerLoginCompletion)(NSError *error);
