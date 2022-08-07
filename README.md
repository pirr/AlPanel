#  AlPanel

This is pet project. I'm looking into the macOS XPC service.
Currently the application shows the temperature of the processor in the status bar.
I took smc.c from https://github.com/lavoiesl/osx-cpu-temp/blob/master/smc.c .

Add in AlPanel Info.plist:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>XPCService</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>SMAuthorizedClients</key>
    <array>
        <string>identifier "al.AlPanel" and anchor apple generic and certificate leaf[subject.CN] = "Mac Developer: example@icloud.com (AAAAAAAA)"</string>
    </array>
    <key>XPCService</key>
    <dict>
        <key>ServiceType</key>
        <string>Application</string>
    </dict>
</dict>
</plist>
```

Add in XPCService Info.plist:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>XPCService</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>SMAuthorizedClients</key>
    <array>
        <string>identifier "al.AlPanel" and anchor apple generic and certificate leaf[subject.CN] = "Mac Developer: example@icloud.com (AAAAAAAA)"</string>
    </array>
    <key>XPCService</key>
    <dict>
        <key>ServiceType</key>
        <string>Application</string>
    </dict>
</dict>
</plist>
```

Mac Developer: example@icloud.com (AAAAAAAA) - change to your settings
