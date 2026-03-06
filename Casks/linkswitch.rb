cask "linkswitch" do
  version "1.0.9"
  sha256 "d74250d9a38aeaa172aa909b8b08217c73dba7b4b053ebdf37d7a8f141b3555d"

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

