cask "linkswitch" do
  version "1.0.5"
  sha256 "9daddeeba97bfd9fd1c8dea5399ba3de2e1a0bc5582d8783d4de9475dc882432"

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

