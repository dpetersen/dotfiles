import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce

myStartupHook = do
  --spawnOnce "$XDG_CONFIG_HOME/polybar/launch.sh"
  spawnOnce "/home/dpetersen/polybar/launch.sh"

main=do
  xmonad $ defaultConfig
    {
    terminal = "alacritty",
    layoutHook=avoidStruts $ layoutHook defaultConfig,
    manageHook=manageHook defaultConfig <+> manageDocks,
    startupHook = myStartupHook
    }
