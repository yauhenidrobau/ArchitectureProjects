//
//  FormDataSource.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/27/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "FormDataSource.h"
#import <UIKit/UIKit.h>
#import "FormCell.h"
#import "UIColor+App.h"

@interface FormDataSource()

@property (strong, nonatomic) NSDictionary *formValues;

@end

@implementation FormDataSource

#pragma mark Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.formValues = @{};
    }
    return self;
}

#pragma mark UItableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor app_mainColor];
    [cell updateCellWithTitle:self.formValues.allKeys[indexPath.row] andValue:self.formValues[self.formValues.allKeys[indexPath.row]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.formValues.allKeys.count;
}

#pragma mark - Public
- (void)updateValues:(NSDictionary *)dict {
    self.formValues = dict;
}
@end
