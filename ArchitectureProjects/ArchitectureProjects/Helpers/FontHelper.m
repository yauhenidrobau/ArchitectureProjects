//
//  FontHelper.m
//  HAS
//
//  Created by Andrew Berillo on 5/17/16.
//  Copyright © 2016 Cogniteq. All rights reserved.
//

#import "FontHelper.h"
#import "NSObject+Smart.h"

@interface FontHelper ()
@property (nonatomic, strong) NSDictionary *fontDict;
@end


@implementation FontHelper
SINGLETON(FontHelper)

- (NSDictionary *)fontDict {
    if (!_fontDict) {
        _fontDict = @{@(FTCochin) : @"Cochin",
                      @(FTCochinB) : @"Cochin Bold"};
    }
    return _fontDict;
}

- (UIFont *)getFontByName:(NSString *)fontName andSize:(float)size {
    return [UIFont fontWithName:fontName size:size];
}

- (UIFont *)getFontByFontType:(FontType)fontType andSize:(float)size {
    return [self getFontByName:self.fontDict[@(fontType)] andSize:size];
}

@end
