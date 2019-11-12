import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops

myTerminal = "alacritty"
myLocker = "slock"
myLauncher = "$(yeganesh -x -- -fn 'monospace-8' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"
myBrowser = "google-chrome-stable"

myStartupHook = do
  spawnOnce "$HOME/.config/polybar/launch.sh"
  spawnOnce "nitrogen --restore"

main=do
  xmonad $ desktopConfig
    {
    terminal = myTerminal,
    startupHook = do
      startupHook desktopConfig
      myStartupHook
    }
    `additionalKeysP`
    [
      ("xK_p", spawn myLauncher),
      ("xK_g", spawn myBrowser),
      ("xK_b", spawn myLocker)
    ]
