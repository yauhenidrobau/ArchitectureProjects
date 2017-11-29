//
//  RecommendationsVC.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 11/16/17.
//  Copyright © 2017 Eugene Drobov. All rights reserved.
//

#import "RecommendationsVC.h"
#import <URBSegmentedControl.h>
#import "BuildingRecommendationsVC.h"
#import "UIColor+App.h"
#import "APConstants.h"
#import "Utils.h"
#import "DesignRecommendsVC.h"

@interface RecommendationsVC ()

@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *embededView;

@property (nonatomic) URBSegmentedControl *segmentedControl;
@property (nonatomic) NSInteger selectedIndex;

@property (strong,nonatomic) BuildingRecommendationsVC *buildingRecommendationsVC;
@property (strong,nonatomic) DesignRecommendsVC *designRecommendsVC;

@end

@implementation RecommendationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = [NSArray arrayWithObjects:[@"Строительство" uppercaseString], [@"Проектирование" uppercaseString], nil];
    NSArray *icons = [NSArray arrayWithObjects:[UIImage imageNamed:@"marker-icon"], [UIImage imageNamed:@"marker-icon"], nil];

    //
    // Basic horizontal segmented control
    //
    self.segmentedControl = [[URBSegmentedControl alloc] initWithTitles:titles icons:icons];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.segmentView.subviews.count) {
        [self prepareSegmentedControl];
        self.segmentedControl.selectedSegmentIndex = 0;
        self.selectedIndex = 0;
        [self segmentValueChanged:self.segmentedControl];
    }
}

#pragma mark --
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if ([self isViewLoaded]) {
        [self.segmentView setNeedsUpdateConstraints];
        [self prepareSegmentedControl];
    }
}

#pragma mark - Actions
- (void)segmentValueChanged:(URBSegmentedControl*)sender {
    UIViewController * nextVC = nil;
    self.selectedIndex = sender.selectedSegmentIndex;
    switch (sender.selectedSegmentIndex) {
        case 0:
        nextVC = [[BuildingRecommendationsVC alloc] initWithNibName:@"BuildingRecommendationsVC" bundle:nil];
            if (!self.buildingRecommendationsVC) {
                self.buildingRecommendationsVC = (BuildingRecommendationsVC*)nextVC;
            } else {
                nextVC = self.buildingRecommendationsVC;
            }
            break;
        case 1:
            nextVC = [[DesignRecommendsVC alloc] initWithNibName:@"DesignRecommendsVC" bundle:nil];
            if (!self.designRecommendsVC) {
                self.designRecommendsVC = (DesignRecommendsVC*)nextVC;
            } else {
                nextVC = self.designRecommendsVC;
            }
            break;
        default:
        break;
    }
    if (![self.childViewControllers containsObject:nextVC]) {
        [self addChildViewController:nextVC];
        nextVC.view.frame = self.embededView.bounds;
        nextVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.embededView addSubview:nextVC.view];
        [nextVC willMoveToParentViewController:self];
    } else {
        [self.embededView bringSubviewToFront:nextVC.view];
    }
}

#pragma mark - Private
- (void)prepareSegmentedControl {
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.segmentedControl.frame = self.segmentView.bounds;
    self.segmentedControl.layoutOrientation = URBSegmentedControlOrientationHorizontal;
    self.segmentedControl.imagePosition = URBSegmentImagePositionLeft;
    self.segmentedControl.baseGradient = [UIColor app_mainColor];
    self.segmentedControl.baseColor = [UIColor app_mainColor];
    self.segmentedControl.segmentBackgroundColor = [UIColor app_secondColor];
    //
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Heavy" size:10.0*[Utils deviceKoeff]]};
    [self.segmentedControl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    [self.segmentedControl setControlEventBlock:^(NSInteger index, URBSegmentedControl *segmentedControl) {
        NSLog(@"URBSegmentedControl: control block - index=%li", (long)index);
    }];
    [self.segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (!self.segmentView.subviews.count) {
        [self.segmentView addSubview:self.segmentedControl];
        [self.segmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.segmentedControl}]];
        [self.segmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.segmentedControl}]];

    }
    
}
@end
