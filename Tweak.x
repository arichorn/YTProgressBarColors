#import <UIKit/UIKit.h>

@interface YTCollectionViewCell : UICollectionViewCell
@end

@interface YTSettingsCell : YTCollectionViewCell
@end

@interface YTSettingsSectionItem : NSObject
@property BOOL hasSwitch;
@property BOOL switchVisible;
@property BOOL on;
@property BOOL (^switchBlock)(YTSettingsCell *, BOOL);
@property int settingItemId;
- (instancetype)initWithTitle:(NSString *)title titleDescription:(NSString *)titleDescription;
@end

%hook YTSettingsViewController
- (void)setSectionItems:(NSMutableArray <YTSettingsSectionItem *>*)sectionItems forCategory:(NSInteger)category title:(NSString *)title titleDescription:(NSString *)titleDescription headerHidden:(BOOL)headerHidden {
	if (category == 1) {
		NSInteger appropriateIdx = [sectionItems indexOfObjectPassingTest:^BOOL(YTSettingsSectionItem *item, NSUInteger idx, BOOL *stop) {
			return item.settingItemId == 294;
		}];
		if (appropriateIdx != NSNotFound) {
			YTSettingsSectionItem *ProgressBarColors = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Progress Bar Colors" titleDescription:@"Allows you to change a progress bar color other then plain red"];
			ProgressBarColors.hasSwitch = NO;
			ProgressBarColors.switchVisible = NO;
			ProgressBarColors.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"progress_bar_colors_enabled"];
			ProgressBarColors.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
				[[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"progress_bar_colors_enabled"];
				return YES;
			};
			[sectionItems insertObject:ProgressBarColors atIndex:appropriateIdx + 1];
		}
	}
	%orig;
}
%end

%hook YTProgressBar
- (void)setHidden:(BOOL)hidden {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"progress_bar_colors_enabled"])
		hidden = YES;
	%orig;
}
%end
