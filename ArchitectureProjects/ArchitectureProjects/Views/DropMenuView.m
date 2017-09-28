//
//  DropMenuView.m
//  ArchitectureProjects
//
//  Created by Evgene Drobov on 9/25/17.
//  Copyright © 2017 Yauheni Drobau. All rights reserved.
//

#import "DropMenuView.h"
#import "UIImageView+Rotation.h"
#import "CustomButton.h"
#import "FontHelper.h"

@interface DropMenuView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *menuArrowImageView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *menuContainer;
@property (weak, nonatomic) IBOutlet CustomButton *filterButton;
@property (weak, nonatomic) IBOutlet UIButton *garageButton;
@property (weak, nonatomic) IBOutlet UILabel *garageLabel;

@property (weak, nonatomic) IBOutlet UISlider *floorSlider;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaMinTF;
@property (weak, nonatomic) IBOutlet UILabel *areaBeforeLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaMaxTF;

@property (nonatomic) BOOL isMenuVisible;
@property (nonatomic) CGFloat menuClosedY;
@property (nonatomic) CGFloat menuOpenedY;
@property (strong, nonatomic) NSMutableDictionary *filterSettings;
@end

@implementation DropMenuView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.menuOpenedY = 0.f;
    [self rotateMenuArrowToTop:YES animated:NO];
    
    self.filterButton.layer.cornerRadius = self.filterButton.frame.size.height / 2;
    [self.garageButton setImage:[UIImage imageNamed:@"unchecked-icon"] forState:UIControlStateNormal];
    [self.garageButton setImage:[UIImage imageNamed:@"checked-icon"] forState:UIControlStateSelected];
    [self.filterButton setTitle:NSLocalizedString(@"dropmenu_filter",nil) forState:UIControlStateNormal];
    self.garageLabel.text = NSLocalizedString(@"dropmenu_garage", nil);
    self.floorLabel.text = NSLocalizedString(@"dropmenu_floors", nil);
    self.areaLabel.text = NSLocalizedString(@"dropmenu_area", nil);
    self.filterSettings = [@{}mutableCopy];
    self.floorValueLabel.text = [NSString stringWithFormat:@"%ld",(long)@(self.floorSlider.minimumValue).integerValue];
    
    self.floorValueLabel.font = FONT(FTCochin, 17);
    self.garageLabel.font = FONT(FTCochin, 17);
    self.areaLabel.font = FONT(FTCochin, 17);
    self.floorLabel.font = FONT(FTCochin, 17);
    self.areaBeforeLabel.font = FONT(FTCochin, 17);
    self.filterButton.titleLabel.font = FONT(FTCochin, 19);

}

- (void)setSuperTopConstant:(CGFloat)superTopConstant {
    _superTopConstant = superTopConstant;
    self.menuClosedY = superTopConstant;
}

#pragma mark - IBActions
- (IBAction)filterTouched:(id)sender {
    [self.filterSettings setObject:@(self.garageButton.isSelected) forKey:@"garageSettings"];
    [self.filterSettings setObject:@(self.areaMinTF.text.integerValue) forKey:@"areaMinValue"];
    [self.filterSettings setObject:@(self.areaMaxTF.text.integerValue ?: NSIntegerMax) forKey:@"areaMaxValue"];
    [self.delegate filterTouched:self.filterSettings];
}
- (IBAction)garageTouched:(id)sender {
    self.garageButton.selected = !self.garageButton.selected;
}

- (IBAction)sliderValueChanged:(id)sender {
    self.floorValueLabel.text = [NSString stringWithFormat:@"%ld",(long)@(self.floorSlider.value).integerValue];
    [self.filterSettings setObject:@(@(self.floorSlider.value).integerValue) forKey:@"floorSettings"];
}

- (IBAction)menuPanGesture:(id)sender {
    UIPanGestureRecognizer* panGesture = sender;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            [self closeAllSortMenus];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat delta = [panGesture translationInView:_menuContainer].y;
            if (!_isMenuVisible) {
                delta += _menuClosedY;
            }
            [self changeMenuYPosition:delta animated:NO];
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            [self makeMenuVisible:NO animated:YES];
            break;
        case UIGestureRecognizerStateEnded: {
            CGFloat delta = [panGesture translationInView:_menuContainer].y;
            CGFloat velocityY = [panGesture velocityInView:_menuContainer].y * 0.3;
            delta += 0.3 * velocityY;
            if (_isMenuVisible) {
                delta -= _menuClosedY;
            }
            BOOL hidden = delta + _menuClosedY < _menuOpenedY;
            [self makeMenuVisible:!hidden animated:YES];
            
            [self rotateMenuArrowToTop:hidden animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UItextFieldDelegate

#pragma mark - Private
- (void)closeAllSortMenus {
}

- (void)makeMenuVisible:(BOOL)visible animated:(BOOL)animated {
    _isMenuVisible = visible;
    CGFloat newY = visible ? _menuOpenedY : _menuClosedY;
    [self changeMenuYPosition:newY animated:animated];
    [self rotateMenuArrowToTop:!visible animated:animated];
}

- (void)rotateMenuArrowToTop:(BOOL)top animated:(BOOL)animated {
    [self.menuArrowImageView rotateOnAngle:(M_PI * (top ? 1 : 0)) animated:YES];
}

- (void)changeMenuYPosition:(CGFloat)newY animated:(BOOL)animated {
    CGFloat temp = newY;
    if (newY <= _menuClosedY) {
        newY = _menuClosedY;
        temp = 0;
    }
    
    if (newY > 0) {
        newY = 0;
        temp = 0;
    }
    
    [UIView animateWithDuration:(animated ? 0.3f : 0.f) delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        _menuTopSpace.constant = temp;
        [self.delegate changeMenuYPosition:newY animated:animated];
        [self layoutIfNeeded];
    } completion:nil];
}

@end
