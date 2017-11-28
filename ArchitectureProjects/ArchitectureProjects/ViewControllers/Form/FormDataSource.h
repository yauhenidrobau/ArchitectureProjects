//
//  FormDataSource.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface FormDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)updateValues:(NSDictionary*)dict;

@end
