cask "iacls-time-tracker" do
  version "1.0.0"
  sha256 :no_check  # Will be calculated automatically when you create a release

  url "https://github.com/markwbennett/TimeTrackButton/archive/refs/heads/main.zip"
  name "IACLS Time Tracker"
  desc "macOS time tracking application with SketchyBar integration"
  homepage "https://github.com/markwbennett/TimeTrackButton"

  depends_on formula: "python@3.11"
  depends_on cask: "sketchybar"

  # Install Python dependencies
  preflight do
    system_command "/usr/bin/python3",
                   args: ["-m", "pip", "install", "--user", "PyQt6", "pandas"],
                   sudo: false
  end

  # Copy the app bundle
  app "IACLS Time Tracker.app"

  # Install plugins and scripts
  artifact "plugins/time_tracker.sh", target: "#{Dir.home}/.config/sketchybar/plugins/time_tracker.sh"
  artifact "plugins/time_tracker_click.sh", target: "#{Dir.home}/.config/sketchybar/plugins/time_tracker_click.sh"
  artifact "floating_button.py", target: "#{Dir.home}/.local/bin/iacls-time-tracker"
  artifact "bells-2-31725.mp3", target: "#{Dir.home}/.local/share/iacls-time-tracker/bells-2-31725.mp3"

  # Make scripts executable
  postflight do
    system_command "/bin/chmod",
                   args: ["+x", "#{Dir.home}/.config/sketchybar/plugins/time_tracker.sh"],
                   sudo: false
    system_command "/bin/chmod",
                   args: ["+x", "#{Dir.home}/.config/sketchybar/plugins/time_tracker_click.sh"],
                   sudo: false
    system_command "/bin/chmod",
                   args: ["+x", "#{Dir.home}/.local/bin/iacls-time-tracker"],
                   sudo: false
  end

  uninstall delete: [
    "#{Dir.home}/.config/sketchybar/plugins/time_tracker.sh",
    "#{Dir.home}/.config/sketchybar/plugins/time_tracker_click.sh",
    "#{Dir.home}/.local/bin/iacls-time-tracker",
    "#{Dir.home}/.local/share/iacls-time-tracker"
  ]

  caveats <<~EOS
    To complete the installation:

    1. Add this line to your ~/.config/sketchybar/sketchybarrc:
       sketchybar --add item time_tracker right \\
                  --set time_tracker update_freq=10 \\
                                    script="$PLUGIN_DIR/time_tracker.sh" \\
                                    click_script="$PLUGIN_DIR/time_tracker_click.sh"

    2. Reload SketchyBar:
       sketchybar --reload

    3. Launch the app:
       open "/Applications/IACLS Time Tracker.app"

    See the example configuration at:
    https://github.com/markwbennett/TimeTrackButton/blob/main/example_sketchybarrc
  EOS
end 