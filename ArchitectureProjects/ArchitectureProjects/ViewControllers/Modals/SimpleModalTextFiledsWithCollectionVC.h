//
//  SimpleModalTextFiledsWithCollectionVC.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 12/8/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "ModalViewController.h"

@interface SimpleModalTextFiledsWithCollectionVC : ModalViewController

@property (strong, nonatomic) void(^closedWithData)(NSString *userPhoneNumber, NSString *address,NSString *projectNumber);

@end
