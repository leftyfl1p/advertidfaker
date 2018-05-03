#define kPrefPath @"/User/Library/Preferences/com.leftyfl1p.advertidfaker.plist"

int main(int argc, char **argv, char **envp) {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:kPrefPath];
	NSString *newID = [[NSUUID UUID] UUIDString];
	[prefs setObject:newID forKey:@"fakeUUID"];
	[prefs writeToFile:kPrefPath atomically:YES];

	[prefs release];

	HBLogInfo(@"Set new Advertising UUID to: %@", newID);




	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.leftyfl1p.advertidfaker"), NULL, NULL, YES);
	return 0;
}

// vim:ft=objc
