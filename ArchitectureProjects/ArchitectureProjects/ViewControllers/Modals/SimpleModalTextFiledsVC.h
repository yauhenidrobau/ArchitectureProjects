//
//  SimpleModalTextFiledsVC.h
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/30/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "ModalViewController.h"

@interface SimpleModalTextFiledsVC : ModalViewController

@property (strong, nonatomic) void(^closedWithData)(NSString *userPhoneNumber, NSString *address,NSString *projectNumber);
@property (nonatomic) BOOL showProjectField;

@end
