cask "iacls-time-tracker" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/markwbennett/TimeTrackButton/archive/refs/heads/main.zip"
  name "IACLS Time Tracker"
  desc "macOS time tracking GUI application with floating button interface"
  homepage "https://github.com/markwbennett/TimeTrackButton"

  # Only install the GUI app bundle
  app "TimeTrackButton-main/IACLS Time Tracker.app"

  caveats <<~EOS
    IACLS Time Tracker GUI app has been installed.

    To launch:
      open "/Applications/IACLS Time Tracker.app"

    On first run, you'll be prompted to choose a folder for your time tracking data.

    For SketchyBar integration (advanced users):
      Clone the full repository: https://github.com/markwbennett/TimeTrackButton
  EOS
end 