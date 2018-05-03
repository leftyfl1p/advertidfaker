#import <Foundation/Foundation.h>

@interface ASIdentifierManager : NSObject

@property (nonatomic, readonly) NSUUID *advertisingIdentifier;
@property (getter=isAdvertisingTrackingEnabled, nonatomic, readonly) BOOL advertisingTrackingEnabled;

+ (id)sharedManager;

- (id)advertisingIdentifier;
- (BOOL)isAdvertisingTrackingEnabled;

@end

#define kPrefPath @"/User/Library/Preferences/com.leftyfl1p.advertidfaker.plist"


static NSUUID *fakeUUID = nil;
static NSMutableDictionary *prefs = nil;
static NSString *fakeUUIDstr = nil;

%hook ASIdentifierManager

- (id)advertisingIdentifier {
	return fakeUUID;
}

%end

static void loadPrefs() {
	prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:kPrefPath];

	if (!prefs) {
		prefs = [NSMutableDictionary new];
		[prefs writeToFile:kPrefPath atomically:YES];
	}
	
	

	fakeUUIDstr = ([prefs objectForKey:@"fakeUUID"] ? [prefs objectForKey:@"fakeUUID"] : nil);

	if (!fakeUUIDstr) {
		fakeUUIDstr = [[NSUUID UUID] UUIDString];
	}

	fakeUUID = [[NSUUID alloc] initWithUUIDString:fakeUUIDstr];
	
	
}

static void RegenID() {

	loadPrefs();
	fakeUUID = [[NSUUID alloc] initWithUUIDString:fakeUUIDstr];

}

static void receivedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	RegenID();
}



%ctor {

	loadPrefs();

	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		receivedNotification,
		CFSTR("com.leftyfl1p.advertidfaker"),
		NULL,
		CFNotificationSuspensionBehaviorCoalesce);

}
