#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static void *kBlurViewKey = &kBlurViewKey;

%hook CCUIContentModuleContainerView

- (void)layoutSubviews {
    %orig;

    self.backgroundColor = [UIColor clearColor];

    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;

    UIVisualEffectView *blurView = objc_getAssociatedObject(self, kBlurViewKey);
    if (!blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
        blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:blurView atIndex:0];
        objc_setAssociatedObject(self, kBlurViewKey, blurView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

%end


%hook CCUIRoundButton

- (void)layoutSubviews {
    %orig;

    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 3.5;
    self.layer.masksToBounds = YES;

    if (self.backgroundColor) {
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.35];
    }
}

%end


%hook CCUIControlCenterPageContainerModuleViewController

- (void)viewDidLoad {
    %orig;
}

%end
