cask "linkswitch" do
  version "1.0.1"
  sha256 "a24c2e8afd226f029cd9c02df7e5454904c145a25a2ddbb65c6b6768ebc6f9cb"

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
