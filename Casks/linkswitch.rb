cask "linkswitch" do
  version "1.0.8"
  sha256 "e2ef41dd3ff55a7c6a59814f857a6a8892a963e6313907a1d1dc12ce12f37ddf"

  url "https://github.com/kriuchkov/linkswitch/releases/download/v1.0.8/LinkSwitch.zip"
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

