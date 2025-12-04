cask "linkswitch" do
  version "1.0.0"
  sha256 "f50e1d20f5722cc31812fe80d396483c5a935b96247f36a58e436516d8ac2a51"

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
  end

  zap trash: [
    "~/.config/linkswitch",
  ]
end
