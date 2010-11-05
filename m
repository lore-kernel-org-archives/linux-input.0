From: Bastien Nocera <hadess@hadess.net>
Subject: Touchpad toggle mess
Date: Fri, 05 Nov 2010 00:00:09 +0000
Message-ID: <1288915209.5418.72.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-F7mx7gEbBNw1wuPun4aV"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:33057 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0KEAAT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Nov 2010 20:00:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Martin Pitt <martin.pitt@ubuntu.com>


--=-F7mx7gEbBNw1wuPun4aV
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

In GNOME 2.32, we added support for touchpad toggle buttons, by
capturing the XF86TouchpadToggle button in gnome-settings-daemon,
showing a nice popup, and disabling the touchpad in software.

That works great for a number of laptops, but completely breaks a number
of others where the hardware handles the request, but still sends a key
event (usually separate ones for on and off). In those cases, we'd need
2 more key types, in the kernel, and in X.org.

The patches in https://bugs.freedesktop.org/show_bug.cgi?id=31300
implement this for the kernel, and for X.org.

Then we have the problem that udev's keymaps seem to use different
function keys depending on the hardware [1], when X.org (because of the
limitations of XKB) standardised on F22 for "XF86TouchpadToggle".

So we'll need to standardise on the keys used. I selected F21 for
XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
See the patch in:
https://bugs.freedesktop.org/show_bug.cgi?id=31333

The remaining fixes would need to be in udev's keymaps, to set hardware
handled keys to F22 and F23, and software ones to F21. Patch is attached
for that.

Questions, comments?

[1]: F21, F22, or F23 then?
$ grep -ri touchpad extras/keymap/keymaps/
extras/keymap/keymaps/lenovo-thinkpad-usb-keyboard-trackpoint:0x90017 f22 # Fn+F8  touchpadtoggle
extras/keymap/keymaps/zepto-znote:0xA5 f22                # Fn+F6 Disable Touchpad
extras/keymap/keymaps/zepto-znote:0xA6 f22                # Fn+F6 Enable Touchpad
extras/keymap/keymaps/hewlett-packard-pavilion:0xD8 f22 # touchpad off
extras/keymap/keymaps/hewlett-packard-pavilion:0xD9 f23 # touchpad on
extras/keymap/keymaps/dell:0x9E f22 #touchpad toggle
extras/keymap/keymaps/dell:0xD9 f22 # touchpad toggle
extras/keymap/keymaps/samsung-other:0xF7 f22 # Fn+F10 Touchpad on
extras/keymap/keymaps/samsung-other:0xF9 f22 # Fn+F10 Touchpad off
extras/keymap/keymaps/hewlett-packard-tx2:0xD8 f22 # Toggle touchpad button on tx2 (OFF)
extras/keymap/keymaps/hewlett-packard-tx2:0xD9 f22 # Toggle touchpad button on tx2 (ON)
extras/keymap/keymaps/everex-xt5000:0x65 f22 # Fn+F5 Touchpad toggle
extras/keymap/keymaps/samsung-sx20s:0x77 f21 # FIXME: Touchpad on
extras/keymap/keymaps/samsung-sx20s:0x79 f21 # FIXME: Touchpad off
extras/keymap/keymaps/onkyo:0xF7 f22 # Fn+Y (touchpad toggle)
extras/keymap/keymaps/toshiba-satellite_a110:0x9E f21 # FIXME: Touchpad on
extras/keymap/keymaps/toshiba-satellite_a110:0x9F f21 # FIXME: Touchpad off
extras/keymap/keymaps/toshiba-satellite_m30x:0x9e prog1 #touchpad_enable
extras/keymap/keymaps/toshiba-satellite_m30x:0x9f prog2 #touchpad_disable
extras/keymap/keymaps/acer:0xF1 f22 # Fn+F7 Touchpad toggle (off-to-on)
extras/keymap/keymaps/acer:0xF2 f22 # Fn+F7 Touchpad toggle (on-to-off)
extras/keymap/keymaps/micro-star:0xE4 f22 # Fn-F3   Touchpad disable
extras/keymap/keymaps/module-lenovo:0x7 f22 # Fn+F8 touchpadtoggle
extras/keymap/keymaps/lg-x110:0xE4 f22 # Fn-F5   Touchpad disable
extras/keymap/keymaps/hewlett-packard-2510p_2530p:0xD8 f22 # touchpad off
extras/keymap/keymaps/hewlett-packard-2510p_2530p:0xD9 f23 # touchpad on


--=-F7mx7gEbBNw1wuPun4aV
Content-Disposition: attachment; filename="0001-extras-keymap-Fix-touchpad-toggle-buttons-used.patch"
Content-Type: text/x-patch; name="0001-extras-keymap-Fix-touchpad-toggle-buttons-used.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 52118a82743e4ca65d5be01c304685d265b5f7a7 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 4 Nov 2010 23:58:56 +0000
Subject: [PATCH] extras/keymap: Fix touchpad toggle buttons used

See:
https://bugs.freedesktop.org/show_bug.cgi?id=31333
---
 extras/keymap/keymaps/acer                         |    2 +-
 extras/keymap/keymaps/dell                         |    4 ++--
 extras/keymap/keymaps/everex-xt5000                |    2 +-
 extras/keymap/keymaps/hewlett-packard-2510p_2530p  |    4 ++--
 extras/keymap/keymaps/hewlett-packard-pavilion     |    4 ++--
 extras/keymap/keymaps/hewlett-packard-tx2          |    2 +-
 .../lenovo-thinkpad-usb-keyboard-trackpoint        |    2 +-
 extras/keymap/keymaps/lg-x110                      |    4 ++--
 extras/keymap/keymaps/micro-star                   |    2 +-
 extras/keymap/keymaps/module-lenovo                |    2 +-
 extras/keymap/keymaps/onkyo                        |    2 +-
 extras/keymap/keymaps/samsung-other                |    2 +-
 extras/keymap/keymaps/samsung-sx20s                |    4 ++--
 extras/keymap/keymaps/toshiba-satellite_a110       |    4 ++--
 extras/keymap/keymaps/toshiba-satellite_m30x       |    4 ++--
 extras/keymap/keymaps/zepto-znote                  |    2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/extras/keymap/keymaps/acer b/extras/keymap/keymaps/acer
index 6abe39c..4e7c297 100644
--- a/extras/keymap/keymaps/acer
+++ b/extras/keymap/keymaps/acer
@@ -14,7 +14,7 @@
 0xEE brightnessup # Fn+Right
 0xEF brightnessdown # Fn+Left
 0xF1 f22 # Fn+F7 Touchpad toggle (off-to-on)
-0xF2 f22 # Fn+F7 Touchpad toggle (on-to-off)
+0xF2 f23 # Fn+F7 Touchpad toggle (on-to-off)
 0xF3 prog2 # "P2" programmable button
 0xF4 prog1 # "P1" programmable button
 0xF5 presentation
diff --git a/extras/keymap/keymaps/dell b/extras/keymap/keymaps/dell
index 1a2e433..fbbb903 100644
--- a/extras/keymap/keymaps/dell
+++ b/extras/keymap/keymaps/dell
@@ -21,9 +21,9 @@
 0x99 nextsong # Front panel next song
 0x9A setup # Tablet tools button
 0x9B switchvideomode # Display Toggle button
-0x9E f22 #touchpad toggle
+0x9E f21 #touchpad toggle
 0xA2 playpause # Front panel play/pause
 0xA4 stopcd # Front panel stop
 0xED media # MediaDirect button
 0xD8 screenlock # FIXME: Tablet lock button
-0xD9 f22 # touchpad toggle
+0xD9 f21 # touchpad toggle
diff --git a/extras/keymap/keymaps/everex-xt5000 b/extras/keymap/keymaps/everex-xt5000
index 53bdd7a..4823a83 100644
--- a/extras/keymap/keymaps/everex-xt5000
+++ b/extras/keymap/keymaps/everex-xt5000
@@ -1,5 +1,5 @@
 0x5C media
-0x65 f22 # Fn+F5 Touchpad toggle
+0x65 f21 # Fn+F5 Touchpad toggle
 0x67 prog3 # Fan Speed Control button
 0x6F brightnessup
 0x7F brightnessdown
diff --git a/extras/keymap/keymaps/hewlett-packard-2510p_2530p b/extras/keymap/keymaps/hewlett-packard-2510p_2530p
index 2bc70c2..41ad2e9 100644
--- a/extras/keymap/keymaps/hewlett-packard-2510p_2530p
+++ b/extras/keymap/keymaps/hewlett-packard-2510p_2530p
@@ -1,2 +1,2 @@
-0xD8 f22 # touchpad off
-0xD9 f23 # touchpad on
+0xD8 f23 # touchpad off
+0xD9 f22 # touchpad on
diff --git a/extras/keymap/keymaps/hewlett-packard-pavilion b/extras/keymap/keymaps/hewlett-packard-pavilion
index a55d2b7..3d3cefc 100644
--- a/extras/keymap/keymaps/hewlett-packard-pavilion
+++ b/extras/keymap/keymaps/hewlett-packard-pavilion
@@ -1,3 +1,3 @@
 0x88 media # FIXME: quick play
-0xD8 f22 # touchpad off
-0xD9 f23 # touchpad on
+0xD8 f23 # touchpad off
+0xD9 f22 # touchpad on
diff --git a/extras/keymap/keymaps/hewlett-packard-tx2 b/extras/keymap/keymaps/hewlett-packard-tx2
index 206c004..36a690f 100644
--- a/extras/keymap/keymaps/hewlett-packard-tx2
+++ b/extras/keymap/keymaps/hewlett-packard-tx2
@@ -1,3 +1,3 @@
 0xC2 media
-0xD8 f22 # Toggle touchpad button on tx2 (OFF)
+0xD8 f23 # Toggle touchpad button on tx2 (OFF)
 0xD9 f22 # Toggle touchpad button on tx2 (ON)
diff --git a/extras/keymap/keymaps/lenovo-thinkpad-usb-keyboard-trackpoint b/extras/keymap/keymaps/lenovo-thinkpad-usb-keyboard-trackpoint
index 7612f79..bc91470 100644
--- a/extras/keymap/keymaps/lenovo-thinkpad-usb-keyboard-trackpoint
+++ b/extras/keymap/keymaps/lenovo-thinkpad-usb-keyboard-trackpoint
@@ -2,7 +2,7 @@
 0x90013 battery # Fn+F3
 0x90014 wlan # Fn+F5
 0x90016 switchvideomode # Fn+F7
-0x90017 f22 # Fn+F8  touchpadtoggle
+0x90017 f21 # Fn+F8  touchpadtoggle
 0x90019 suspend # Fn+F12
 0x9001A brightnessup # Fn+Home
 0x9001B brightnessdown # Fn+End
diff --git a/extras/keymap/keymaps/lg-x110 b/extras/keymap/keymaps/lg-x110
index a61cf3d..ba08cba 100644
--- a/extras/keymap/keymaps/lg-x110
+++ b/extras/keymap/keymaps/lg-x110
@@ -6,7 +6,7 @@
 0xB3 suspend # Fn-F12
 0xDF sleep # Fn-F4
 # 0xE2 bluetooth # satellite dish2
-0xE4 f22 # Fn-F5   Touchpad disable
+0xE4 f21 # Fn-F5   Touchpad disable
 0xF6 wlan # Fn-F6
 0xF7 reserved # brightnessdown # Fn-Down
-0xF8 reserved # brightnessup # Fn-Up
\ No newline at end of file
+0xF8 reserved # brightnessup # Fn-Up
diff --git a/extras/keymap/keymaps/micro-star b/extras/keymap/keymaps/micro-star
index 0de5ae6..4a43869 100644
--- a/extras/keymap/keymaps/micro-star
+++ b/extras/keymap/keymaps/micro-star
@@ -4,7 +4,7 @@
 0xB2 www # e button
 0xDF sleep # Fn-F12
 0xE2 bluetooth # satellite dish2
-0xE4 f22 # Fn-F3   Touchpad disable
+0xE4 f21 # Fn-F3   Touchpad disable
 0xEC email # envelope button
 0xEE camera # Fn-F6 camera disable
 0xF6 wlan # satellite dish1
diff --git a/extras/keymap/keymaps/module-lenovo b/extras/keymap/keymaps/module-lenovo
index 7c597bd..9cb74b2 100644
--- a/extras/keymap/keymaps/module-lenovo
+++ b/extras/keymap/keymaps/module-lenovo
@@ -3,7 +3,7 @@
 0x3 sleep # Fn+F4
 0x4 wlan # Fn+F5
 0x6 switchvideomode # Fn+F7
-0x7 f22 # Fn+F8 touchpadtoggle
+0x7 f21 # Fn+F8 touchpadtoggle
 0x8 f24 # Fn+F9 undock
 0xB suspend # Fn+F12
 0xF brightnessup # Fn+Home
diff --git a/extras/keymap/keymaps/onkyo b/extras/keymap/keymaps/onkyo
index 7dd80a1..ee864ad 100644
--- a/extras/keymap/keymaps/onkyo
+++ b/extras/keymap/keymaps/onkyo
@@ -8,7 +8,7 @@
 0xF0 media # Fn+R
 0xF5 switchvideomode # Fn+E
 0xF6 camera # Fn+T
-0xF7 f22 # Fn+Y (touchpad toggle)
+0xF7 f21 # Fn+Y (touchpad toggle)
 0xF8 brightnessup # Fn+S
 0xF9 brightnessdown # Fn+A
 0xFB wlan # Fn+J
diff --git a/extras/keymap/keymaps/samsung-other b/extras/keymap/keymaps/samsung-other
index 6a0928c..3ac0c2f 100644
--- a/extras/keymap/keymaps/samsung-other
+++ b/extras/keymap/keymaps/samsung-other
@@ -11,4 +11,4 @@
 0xB3 prog3 # Fn+F8 switch power mode (battery/dynamic/performance)
 0xB4 wlan # Fn+F9 (X60P)
 0xF7 f22 # Fn+F10 Touchpad on
-0xF9 f22 # Fn+F10 Touchpad off
+0xF9 f23 # Fn+F10 Touchpad off
diff --git a/extras/keymap/keymaps/samsung-sx20s b/extras/keymap/keymaps/samsung-sx20s
index daf7d3e..9d954ee 100644
--- a/extras/keymap/keymaps/samsung-sx20s
+++ b/extras/keymap/keymaps/samsung-sx20s
@@ -1,4 +1,4 @@
 0x74 mute
 0x75 mute
-0x77 f21 # FIXME: Touchpad on
-0x79 f21 # FIXME: Touchpad off
+0x77 f22 # Touchpad on
+0x79 f23 # Touchpad off
diff --git a/extras/keymap/keymaps/toshiba-satellite_a110 b/extras/keymap/keymaps/toshiba-satellite_a110
index 0f2aaec..1429409 100644
--- a/extras/keymap/keymaps/toshiba-satellite_a110
+++ b/extras/keymap/keymaps/toshiba-satellite_a110
@@ -1,8 +1,8 @@
 0x92 stop
 0x93 www
 0x94 media
-0x9E f21 # FIXME: Touchpad on
-0x9F f21 # FIXME: Touchpad off
+0x9E f22 # Touchpad on
+0x9F f23 # Touchpad off
 0xB9 nextsong
 0xD9 brightnessup
 0xEE screenlock
diff --git a/extras/keymap/keymaps/toshiba-satellite_m30x b/extras/keymap/keymaps/toshiba-satellite_m30x
index cf6d912..9280ae0 100644
--- a/extras/keymap/keymaps/toshiba-satellite_m30x
+++ b/extras/keymap/keymaps/toshiba-satellite_m30x
@@ -2,6 +2,6 @@
 0xd9 brightnessup
 0xee screenlock
 0x93 media
-0x9e prog1 #touchpad_enable
-0x9f prog2 #touchpad_disable
+0x9e f22 #touchpad_enable
+0x9f f23 #touchpad_disable
 
diff --git a/extras/keymap/keymaps/zepto-znote b/extras/keymap/keymaps/zepto-znote
index e076516..cf72fda 100644
--- a/extras/keymap/keymaps/zepto-znote
+++ b/extras/keymap/keymaps/zepto-znote
@@ -1,7 +1,7 @@
 0x93 switchvideomode    # Fn+F3 Toggle Video Output
 0x95 brightnessdown     # Fn+F4 Brightness Down
 0x91 brightnessup       # Fn+F5 Brightness Up
-0xA5 f22                # Fn+F6 Disable Touchpad
+0xA5 f23                # Fn+F6 Disable Touchpad
 0xA6 f22                # Fn+F6 Enable Touchpad
 0xA7 bluetooth          # Fn+F10 Enable Bluetooth
 0XA9 bluetooth          # Fn+F10 Disable Bluetooth
-- 
1.7.3.2


--=-F7mx7gEbBNw1wuPun4aV--

