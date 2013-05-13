From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Mon, 13 May 2013 19:03:58 +0200
Message-ID: <CANq1E4S7F9tZJxXX2i+1h1hkPfiCNhSTkqLw14NhPQ-vJjBtFg@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
	<CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
	<CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
	<CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
	<20130508170536.GA30057@core.coreip.homeip.net>
	<CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
	<20130508172604.GB30057@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:61353 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab3EMREB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 13:04:01 -0400
Received: by mail-ia0-f177.google.com with SMTP id z13so495300iaz.36
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 10:04:00 -0700 (PDT)
In-Reply-To: <20130508172604.GB30057@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Showalter <todd@electronjump.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Todd & Dmitry

On Wed, May 8, 2013 at 7:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> We should take existing in-kernel mapping (that would be XBOX and other
> less advanced gamepads in drivers/input/joystick), alias
> NORTH/SOUTH/EAST/WEST accordingly, have new users use NSEW button
> definitions.

I tried to put up some documentation. Comments welcome. If no problems
arise with it, I will send a proper series later.

Regards
David

(As a hint: read this with a monospace font)

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index e69de29..6afb1dc 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -0,0 +1,154 @@
+                            Linux Gamepad API
+----------------------------------------------------------------------------
+
+1. Intro
+~~~~~~~~
+Linux provides many different input drivers for gamepad hardware. To avoid
+having user-space deal with different button-mappings for each gamepad, this
+document defines how gamepads are supposed to report their data.
+
+2. Geometry
+~~~~~~~~~~~
+As "gamepad" we define devices which roughly look like this:
+
+            ____________________________              __
+           / [__ZL__]          [__ZR__] \               |
+          / [__ TL __]        [__ TR __] \              | Front Triggers
+       __/________________________________\__         __|
+      /                                  _   \          |
+     /      /\                          (N)   \         |
+    /       ||      __   __   __     _       _ \        | Main Pad
+   |    <===DP===> |SE| |MO| |ST|   (W) -|- (E) |       |
+    \       ||    ___          ___       _     /        |
+    /\      \/   /   \        /   \     (S)   /\      __|
+   /  \________ | LS  | ____ |  RS | ________/  \       |
+  |         /  \ \___/ /    \ \___/ /  \         |      | Control Sticks
+  |        /    \_____/      \_____/    \        |    __|
+  |       /                              \       |
+   \_____/                                \_____/
+
+       |________|______|    |______|___________|
+         D-Pad    Left       Right   Action Pad
+                 Stick       Stick
+
+                   |_____________|
+                      Menu Pad
+
+Most gamepads have the following features:
+  - Action-Pad
+    4 buttons in diamonds-layout (on the right side). The buttons are
+    differently labeled on most devices so we define them as NORTH,
+    SOUTH, WEST and EAST.
+  - D-Pad (Direction-pad)
+    4 buttons (on the left side) that point up, down, left and right.
+  - Menu-Pad
+    Different constellations, but most-times 3 buttons: SELECT - MODE - START
+  - Analog-Sticks
+    Analog-sticks provide freely moveable sticks to control directions. Not
+    all devices have both or any, but they are present at most times.
+    Analog-sticks may also provide a digital button if you press them.
+  - Triggers
+    Triggers are located on the upper-side of the pad in vertical direction.
+    Not all devices provide them, but the upper buttons are normally named
+    Left- and Right-Triggers, the lower buttons Z-Left and Z-Right.
+  - Rumble
+    Many devices provide force-feedback features. But are mostly just
+    simple rumble motors.
+
+3. Detection
+~~~~~~~~~~~~
+All gamepads that follow the protocol described here map BTN_GAMEPAD. This is
+an alias for BTN_NORTH/BTN_A. It can be used to identify a gamepad as such.
+However, not all gamepads provide all features, so you need to test for all
+features that you need, first. How each feature is mapped is described below.
+
+Legacy drivers often don't comply to these rules. As we cannot change them
+for backwards-compatibility reasons, you need to provide fixup mappings in
+user-space yourself. Some of them might also provide module-options that
+change the mappings so you can adivce users to set these.
+
+All new gamepads are supposed to comply with this mapping. Please report any
+bugs, if they don't.
+
+There are a lot of less-featured/less-powerful devices out there, which re-use
+the buttons from this protocol. However, they try to do this in a compatible
+fashion. For example, the "Nintendo Wii Nunchuk" provides two trigger buttons
+and one analog stick. It reports them as if it were a gamepad with only one
+analog stick and two trigger buttons on the right side.
+But that means, that if you only support "real" gamepads, you must test
+devices for _all_ reported events that need. Otherwise, you will also get
+devices that report a small subset of the events.
+
+No other devices, that do not look/feel like a gamepad, shall report these
+events.
+
+4. Events
+~~~~~~~~~
+Gamepads report the following events:
+
+Action-Pad:
+  Every gamepad device has at least 2 action buttons. This means, that every
+  device reports BTN_NORTH (which BTN_GAMEPAD is an alias for). Regardless
+  of the labels on the buttons, the codes are sent according to the
+  physical position of the buttons.
+  Please note that 2- and 3-button pads are fairly rare and old. You might
+  want to filter gamepads that do not report all four.
+    2-Button Pad:
+      If only 2 action-buttons are present, they are reported as BTN_NORTH and
+      BTN_SOUTH. For vertical layouts, the upper button is BTN_NORTH. For
+      horizontal layouts, the button more on the left is BTN_NORTH.
+    3-Button Pad:
+      If only 3 action-buttons are present, they are reported as (from left
+      to right): BTN_WEST, BTN_NORTH, BTN_EAST
+      If the buttons are aligned perfectly vertically, they are reported as
+      (from bottom up): BTN_WEST, BTN_NORTH, BTN_EAST
+    4-Button Pad:
+      If all 4 action-buttons are present, they can be aligned in two
+      different formations. If diamond-shaped, they are reported as BTN_NORTH,
+      BTN_WEST, BTN_SOUTH, BTN_EAST according to their physical location.
+      If rectangular-shaped, the upper-left button is BTN_NORTH, lower-left
+      is BTN_WEST, lower-right is BTN_SOUTH and upper-right is BTN_EAST.
+
+D-Pad:
+  Every gamepad provides a D-Pad with four directions: Up, Down, Left, Right
+  Some of these are available as digital buttons, some as analog buttons. Some
+  may even report both. The kernel does not convert between these so
+  applications should support both and choose what is more appropriate if
+  both are reported.
+  Digital buttons are reported as BTN_TRIGGER_HAPPY_X, with:
+    Left is BTN_TRIGGER_HAPPY1, right is BTN_TRIGGER_HAPPY2, up is
+    BTN_TRIGGER_HAPPY3 and down is BTN_TRIGGER_HAPPY4.
+  Analog buttons are reported as:
+    ABS_HAT0X and ABS_HAT0Y
+
+Analog-Sticks:
+  The first (left) analog-stick is reported as ABS_X, ABS_Y. The second (right)
+  analog stick is reported as ABS_RX, ABS_RY. If only one stick is present,
+  ABS_RX and ABS_RY will be unmapped.
+  If analog-sticks provide digital buttons, they are mapped accordingly as
+  BTN_THUMBL (first/left) and BTN_THUMBR (second/right).
+
+Triggers:
+  Trigger buttons can be available as digital or analog buttons or both. User-
+  space must correctly deal with any situation and choose the most appropriate
+  mode.
+  Upper trigger buttons are reported as BTN_TR or ABS_HAT1X (right) and BTN_TL
+  or ABS_HAT1Y (left). Lower trigger buttons are reported as BTN_TR2 or
+  ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
+  If only one trigger-button combination is present (upper+lower), they are
+  reported as "right" triggers (BTN_TR/ABS_HAT1X).
+
+Menu-Pad:
+  Menu buttons are always digital and are mapped according to their location
+  instead of their labels. That is:
+    1-button Pad: Mapped as BTN_START
+    2-button Pad: Left button mapped as BTN_SELECT, right button mapped as
+                  BTN_START
+    3-button Pad: Mapped (from left to right) as BTN_SELECT, BTN_MODE,
+                  BTN_START
+
+Rumble:
+  Rumble is advertices as FF_RUMBLE.
+
+----------------------------------------------------------------------------
+  Written 2013 by David Herrmann <dh.herrmann@gmail.com>
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 935119c..f6c18b2 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -507,10 +507,14 @@ struct input_keymap_entry {

 #define BTN_GAMEPAD 0x130
 #define BTN_A 0x130
+#define BTN_NORTH 0x130
 #define BTN_B 0x131
+#define BTN_SOUTH 0x131
 #define BTN_C 0x132
 #define BTN_X 0x133
+#define BTN_EAST 0x133
 #define BTN_Y 0x134
+#define BTN_WEST 0x134
 #define BTN_Z 0x135
 #define BTN_TL 0x136
 #define BTN_TR 0x137
