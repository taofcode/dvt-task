// Generated by Apple Swift version 2.3 (swiftlang-800.10.13 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreLocation;
@import CoreGraphics;
@import ObjectiveC;
@import SystemConfiguration;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC18WeatherApplication11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface AppDelegate (SWIFT_EXTENSION(WeatherApplication))
@end

@class CLLocationManager;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC18WeatherApplication22HomePageViewController")
@interface HomePageViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager * _Nonnull locationManager;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface HomePageViewController (SWIFT_EXTENSION(WeatherApplication))
- (void)loadView;
- (void)viewDidLoad;
- (BOOL)locationStatusCheck:(BOOL)locationactived;
@end


SWIFT_CLASS("_TtC18WeatherApplication21LoadingViewController")
@interface LoadingViewController : UIViewController
- (void)loadView;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface LoadingViewController (SWIFT_EXTENSION(WeatherApplication))
- (void)didPressRetryButton:(id _Nonnull)sender;
@end


@interface LoadingViewController (SWIFT_EXTENSION(WeatherApplication))
@end


@interface LoadingViewController (SWIFT_EXTENSION(WeatherApplication))
- (void)startLoading:(BOOL)loading;
- (void)stopLoading:(NSString * _Nullable)text retryAction:(void (^ _Nullable)(void))retryAction;
@end

@class UILabel;
@class UIImageView;

SWIFT_CLASS("_TtC18WeatherApplication18MainViewController")
@interface MainViewController : UINavigationController <CLLocationManagerDelegate>
@property (nonatomic, strong) UILabel * _Nonnull dateLabel;
@property (nonatomic, strong) UILabel * _Nonnull labelMaxTemp;
@property (nonatomic, strong) UILabel * _Nonnull labelMinTemp;
@property (nonatomic, strong) UILabel * _Nonnull labelLocale;
@property (nonatomic, strong) UIImageView * _Nonnull labelImageView;
@property (nonatomic, strong) CLLocationManager * _Nonnull locationManager;
@property (nonatomic, copy) NSString * _Nullable locale;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSError;
@class CLLocation;
@class CLPlacemark;

@interface MainViewController (SWIFT_EXTENSION(WeatherApplication))
- (BOOL)locationStatusCheck:(BOOL)locationactived;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nonnull)error;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
- (void)displayLocationInfo:(CLPlacemark * _Nullable)placemark;
- (BOOL)hasConnectivity;
- (void)didPressRefreshButton:(id _Nonnull)sender;
@end

@class UIButton;

SWIFT_CLASS("_TtC18WeatherApplication6NavBar")
@interface NavBar : UINavigationBar
@property (nonatomic, strong) UIImageView * _Nonnull imageView;
@property (nonatomic, strong) UIButton * _Nonnull accountButton;
- (CGSize)sizeThatFits:(CGSize)size;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18WeatherApplication20NavigationController")
@interface NavigationController : UINavigationController
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NavigationController (SWIFT_EXTENSION(WeatherApplication))
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
@end

@class NSNotificationCenter;

SWIFT_CLASS("_TtC18WeatherApplication12Reachability")
@interface Reachability : NSObject
@property (nonatomic, copy) void (^ _Nullable whenReachable)(Reachability * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable whenUnreachable)(Reachability * _Nonnull);
@property (nonatomic) BOOL reachableOnWWAN;
@property (nonatomic, strong) NSNotificationCenter * _Nonnull notificationCenter;
@property (nonatomic, readonly, copy) NSString * _Nonnull currentReachabilityString;
- (nonnull instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef _Nonnull)reachabilityRef OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithHostname:(NSString * _Nonnull)hostname error:(NSError * _Nullable * _Null_unspecified)error;
+ (Reachability * _Nullable)reachabilityForInternetConnectionAndReturnError:(NSError * _Nullable * _Null_unspecified)error;
+ (Reachability * _Nullable)reachabilityForLocalWiFiAndReturnError:(NSError * _Nullable * _Null_unspecified)error;
- (BOOL)startNotifierAndReturnError:(NSError * _Nullable * _Null_unspecified)error;
- (void)stopNotifier;
- (BOOL)isReachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;
- (BOOL)isConnectionOnTrafficOrDemand:(SCNetworkReachabilityFlags)flags;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
@end


@interface UIColor (SWIFT_EXTENSION(WeatherApplication))
- (nonnull instancetype)initWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
- (nonnull instancetype)initWithHex:(NSInteger)hex;
- (nonnull instancetype)initWithHexString:(NSString * _Nonnull)hexString;
@end

#pragma clang diagnostic pop
