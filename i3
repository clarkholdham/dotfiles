# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Constants
# Alex Booker's colours
# set $base00 #101218
# set $base01 #1f222d
# set $base02 #252936
# set $base03 #7780a1
# set $base04 #C0C5CE
# set $base05 #d1d4e0
# set $base06 #C9CCDB
# set $base07 #ffffff
# set $base08 #ee829f
# set $base09 #f99170
# set $base0A #ffefcc
# set $base0B #a5ffe1
# set $base0C #97e0ff
# set $base0D #97bbf7
# set $base0E #c0b7f9
# set $base0F #fcc09e

# base16-default dark
# set $base00 #181818
# set $base01 #282828
# set $base02 #383838
# set $base03 #585858
# set $base04 #b8b8b8
# set $base05 #d8d8d8
# set $base06 #e8e8e8
# set $base07 #f8f8f8
# set $base08 #ab4642
# set $base09 #dc9656
# set $base0A #f7ca88
# set $base0B #a1b56c
# set $base0C #86c1b9
# set $base0D #7cafc2
# set $base0E #ba8baf
# set $base0F #a16946

# base16-flat dark
set $base00 #2C3E50
set $base01 #34495E
set $base02 #7F8C8D
set $base03 #95A5A6
set $base04 #BDC3C7
set $base05 #e0e0e0
set $base06 #f5f5f5
set $base07 #ECF0F1
set $base08 #E74C3C
set $base09 #E67E22
set $base0A #F1C40F
set $base0B #2ECC71
set $base0C #1ABC9C
set $base0D #3498DB
set $base0E #9B59B6
set $base0F #be643c

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:System San Francisco Display 10

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn???t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
# bindsym $mod+Return exec i3-sensible-terminal
set $terminal urxvt
bindsym $mod+Return exec $terminal

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# shortcut to move a workspace to a monitor to the right
bindsym $mod+m move workspace to output right

set $workspace1 "1: Editor ??? "
set $workspace2 "2: Chrome ??? "
set $workspace3 "3: Project ??? "

# switch to workspace
bindsym $mod+1 workspace $workspace1
bindsym $mod+2 workspace $workspace2
bindsym $mod+3 workspace $workspace3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $workspace1
bindsym $mod+Shift+2 move container to workspace $workspace2
bindsym $mod+Shift+3 move container to workspace $workspace3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# Program workspaces
assign [class="google-chrome"] $workspace2

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window???s width.
        # Pressing right will grow the window???s width.
        # Pressing up will shrink the window???s height.
        # Pressing down will grow the window???s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Widow Colours
#                         border  background text    indicator
  client.focused          $base01 $base01    $base07 $base0F
  client.focused_inactive $base02 $base02    $base03 $base0F
  client.unfocused        $base02 $base02    $base03 $base0F
  client.urgent           $base02 $base08    $base00 $base0F

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3blocks
        colors {
              separator $base03
              background $base01
              statusline $base05
        #                        border  background text
              focused_workspace  $base01 $base01    $base07
              active_workspace   $base01 $base02    $base03
              inactive_workspace $base01 $base01    $base03
              urgent_workspace   $base01 $base01    $base08
         }
}

bindsym $mod+shift+x exec i3lock

# Pulse Audio controls. The pkill signals here are to tell i3blocks to update
# the volume blocklet.
# increase sound volume
bindsym XF86AudioRaiseVolume exec --no-startup-id "pactl set-sink-volume 0 +5%; pkill -RTMIN+10 i3blocks" 
# Note, I had to add the -- to the command below to get this to
# work in Ubuntu 14.04. From what I read online, this may have to be
# removed for newer versions of Ubuntu.
# decrease sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id "pactl set-sink-volume 0 -- -5%; pkill -RTMIN+10 i3blocks" 
# mute sound
bindsym XF86AudioMute exec --no-startup-id "pactl set-sink-mute 0 toggle; pkill -RTMIN+10 i3blocks" 

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

# Startup applications:
exec google-chrome
exec --no-startup-id nm-applet
# Start up terminals on multiple workspaces. Since we
# launch the same application on multiple workspaces like
# this, we need to use i3-msg and explicitly switch
# workspaces
exec --no-startup-id i3-msg 'workspace $workspace1; exec $terminal' 
exec --no-startup-id i3-msg 'workspace $workspace3; exec $terminal' 

