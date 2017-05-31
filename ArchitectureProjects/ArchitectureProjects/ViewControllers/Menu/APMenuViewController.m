//
//  APMenuViewController.m
//  ArchitectureProjects
//
//  Created by YAUHENI DROBAU on 5/29/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "APMenuViewController.h"

#import "Macros.h"
#import "APMenuTableViewCell.h"
#import "SWRevealViewController.h"

@interface APMenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation APMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.revealViewController.rearViewRevealWidth = IS_IPHONE ? CGRectGetWidth(self.view.frame) - 53.0f : 300.f;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellID;
    NSString* title;
    switch (indexPath.row) {
        case MenuTypeProjects:
            cellID = @"MenuTypeProjectsCell";
            title = NSLocalizedString(@"menu.projects", nil);
            break;
        case MenuTypeStart:
            cellID = @"MenuTypeStartCell";
            title = NSLocalizedString(@"menu.start", nil);
            break;
        case MenuTypeCost:
            cellID = @"MenuTypeCostCell";
            title = NSLocalizedString(@"menu.cost", nil);
            break;
        case MenuTypeQuestion:
            cellID = @"MenuTypeQuestionCell";
            title = NSLocalizedString(@"menu.question", nil);
            break;
        case MenuTypeContact:
            cellID = @"MenuTypeContactCell";
            title = NSLocalizedString(@"menu.contact", nil);
            break;
        default:
            break;
    }
    APMenuTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    cell.cellTitleLabel.text = title;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* storyboardName;

    switch (indexPath.row) {
        case MenuTypeProjects:
            storyboardName = @"Projects";
            break;
        case MenuTypeStart:
            storyboardName = @"Start";
            break;
         case MenuTypeCost:
            storyboardName = @"Cost";
            break;
        case MenuTypeQuestion:
            storyboardName = @"Question";
            break;
        case MenuTypeContact:
            storyboardName = @"Contact";
            break;
        default:
            break;
    }
    if (!storyboardName.length) {
        [self closeMenu];
        return;
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController* rootVC = [storyboard instantiateInitialViewController];
    
    [self.revealViewController setFrontViewController:rootVC animated:YES];
    
    [self closeMenu];
}

#pragma mark - Private

- (void)closeMenu {
    [self.revealViewController rightRevealToggleAnimated:YES];
}

@end
