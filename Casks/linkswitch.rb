cask "linkswitch" do
  version "1.1.0"
  sha256 "990b572a8b6abb849698c6af1a4559464f904ba157e24db1b750400788b26bca"

  url "https://github.com/kriuchkov/linkswitch/releases/download/v1.1.0/LinkSwitch.zip"
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

