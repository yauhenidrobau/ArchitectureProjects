//
//  FontHelper.h
//  HAS
//
//  Created by Andrew Berillo on 5/17/16.
//  Copyright © 2016 Cogniteq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Smart.h"
#import <UIKit/UIKit.h>

typedef enum {
    FTCochin,
    FTCochinB
} FontType;

#define FONT(type, size) [[FontHelper sharedInstance] getFontByFontType:(type) andSize:(size)]

@interface FontHelper : NSObject
+(instancetype)sharedInstance;

- (UIFont *)getFontByFontType:(FontType)fontType andSize:(float)size;
@end
