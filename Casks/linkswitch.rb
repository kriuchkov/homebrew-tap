cask "linkswitch" do
  version "1.0.4"
  sha256 "7b02b9571e5edc3ebdf0b518363535a7eaadccc053471db87a7f44c8e53f2104"

  url "https://github.com/kriuchkov/linkswitch/releases/download/v#{version}/LinkSwitch.zip"
  name "LinkSwitch"
  desc "Ultra-lightweight native link router for macOS"
  homepage "https://github.com/kriuchkov/linkswitch"

  app "LinkSwitch.app"

  postflight do
    # Remove quarantine attribute so the app can be opened
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/LinkSwitch.app"],
                   sudo: false

    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
                   args: ["-f", "#{appdir}/LinkSwitch.app"]
  end

  uninstall_preflight do
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
                   args: ["-u", "#{appdir}/LinkSwitch.app"]
  end

  zap trash: [
    "~/.config/linkswitch",
    "~/Library/Preferences/com.kriuchkov.linkswitch.plist",
  ]
end

