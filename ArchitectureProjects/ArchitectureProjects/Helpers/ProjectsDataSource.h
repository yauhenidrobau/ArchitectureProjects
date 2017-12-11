//
//  ProjectsDataSource.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 12/8/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ProjectsDataSourceStartLoadingProductsCallback)();
typedef void(^ProjectsDataSourceFinishedLoadingProductsCallback)();
typedef void(^ProjectsDataSourceReloadCallback)();

@interface ProjectsDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) ProjectsDataSourceStartLoadingProductsCallback startLoadingAction;
@property (strong, nonatomic) ProjectsDataSourceStartLoadingProductsCallback finishLoadingAction;
@property (strong, nonatomic) ProjectsDataSourceReloadCallback reloadAction;


-(void)loadProjects;

@end
