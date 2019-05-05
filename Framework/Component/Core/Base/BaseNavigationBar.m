//
#import "BaseNavigationBar.h"

@interface BaseNavigationBar ()

@property (nonatomic, strong) CALayer *colorLayer;

@end


@implementation BaseNavigationBar

@def_prop_class( CGFloat,       preferredBarAlpha, setPreferredBarAlpha )
@def_prop_class( UIColor *,     preferredBarTintColor, setPreferredBarTintColor )
@def_prop_class( UIColor *,     preferredTintColor, setPreferredTintColor )
@def_prop_class( UIColor *,     preferredForegroundColor, setPreferredForegroundColor )
@def_prop_class( UIFont *,      preferredForegroundFont, setPreferredForegroundFont )

@def_prop_assign( BOOL,         overrideOpacity )
@def_prop_assign( BOOL,         displayColorLayer )
- (void)setDisplayColorLayer:(BOOL)displayColorLayer {
    self.colorLayer.hidden = !displayColorLayer;
}

// MARK: - Init

- (void)initDefault {
    self.class.preferredBarAlpha = 0.7f;
    
    if (self.class.preferredBarTintColor) self.barTintColor = self.class.preferredBarTintColor;
    if (self.class.preferredTintColor) self.tintColor = self.class.preferredTintColor;
    
    UIFont *font = self.class.preferredForegroundFont;
    if (!font) {
        font = [UIFont boldSystemFontOfSize:20];
    }
    
    UIColor *color = self.class.preferredForegroundColor;
    if (!color) {
        color = [UIColor whiteColor];
    }
    
    NSDictionary *attr = @{ NSForegroundColorAttributeName : color, NSFontAttributeName : font };
    [self setTitleTextAttributes: attr];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefault];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDefault];
    }
    return self;
}

// MARK: - Setting

static CGFloat const kDefaultColorLayerOpacity = 0.5f;
static CGFloat const kSpaceToCoverStatusBars = 20.0f;

- (void)setBarTintColor:(UIColor *)barTintColor {
    
    [super setBarTintColor:barTintColor];
    
    // iOS 7.1 seems to completely ignore the alpha channel and any modifications to it.
    // Hence, adding an extra layer is moot.
    // Still looking into possible solutions for this, but for now, this method is empty.
    if (system_version_greater_than_or_equal_to(@"7.1")) {
    
    }
    // As of iOS 7.0.3, colors definitely seem a little bit more saturated.
    else if (system_version_greater_than_or_equal_to(@"7.0.3")) {
        
        // Override the opacity if wanted.
        if(self.overrideOpacity) {
            CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
            [barTintColor getRed:&red green:&green blue:&blue alpha:&alpha];
            [super setBarTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:self.class.preferredBarAlpha]];
        }
    }
    // iOS 7.0 benefits from the extra color layer.
    else {
        
        // Create a CALayer with some opacity, and add the layer.
        if (self.colorLayer == nil) {
            self.colorLayer = [CALayer layer];
            self.colorLayer.opacity = kDefaultColorLayerOpacity;
            [self.layer addSublayer:self.colorLayer];
        }
        
        self.colorLayer.backgroundColor = barTintColor.CGColor;
    }
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.colorLayer != nil) {
        self.colorLayer.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + kSpaceToCoverStatusBars);
        
        [self.layer insertSublayer:self.colorLayer atIndex:1];
    }
}

@end
