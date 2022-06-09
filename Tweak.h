@interface YTProgressBar
@property(readonly, nonatomic) YTQTMButton *progressBar;
@end

@interface YTProgressBarIcon : UIButton
@end

@interface YTProgressBarUI
@property(readonly, nonatomic) YTQTMButton *ProgressBarButton;
@end

@interface YTUserDefaults : NSObject
- (long long)appThemeSetting;
@end
