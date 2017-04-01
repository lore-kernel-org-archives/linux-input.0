From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 13/33] docs: input/gamepad: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:56 -0300
Message-ID: <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/gamepad.txt | 43 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index 3f6d8a5e9cdc..8bc7fdea3705 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -1,5 +1,9 @@
-                            Linux Gamepad API
-----------------------------------------------------------------------------
+-----------------
+Linux Gamepad API
+-----------------
+
+:Author: 2013 by David Herrmann <dh.herrmann@gmail.com>
+
 
 1. Intro
 ~~~~~~~~
@@ -9,7 +13,7 @@ document defines how gamepads are supposed to report their data.
 
 2. Geometry
 ~~~~~~~~~~~
-As "gamepad" we define devices which roughly look like this:
+As "gamepad" we define devices which roughly look like this::
 
             ____________________________              __
            / [__ZL__]          [__ZR__] \               |
@@ -35,6 +39,7 @@ As "gamepad" we define devices which roughly look like this:
                       Menu Pad
 
 Most gamepads have the following features:
+
   - Action-Pad
     4 buttons in diamonds-shape (on the right side). The buttons are
     differently labeled on most devices so we define them as NORTH,
@@ -60,6 +65,7 @@ Most gamepads have the following features:
 
 3. Detection
 ~~~~~~~~~~~~
+
 All gamepads that follow the protocol described here map BTN_GAMEPAD. This is
 an alias for BTN_SOUTH/BTN_A. It can be used to identify a gamepad as such.
 However, not all gamepads provide all features, so you need to test for all
@@ -87,6 +93,7 @@ events.
 
 4. Events
 ~~~~~~~~~
+
 Gamepads report the following events:
 
 Action-Pad:
@@ -94,8 +101,10 @@ Action-Pad:
   device reports BTN_SOUTH (which BTN_GAMEPAD is an alias for). Regardless
   of the labels on the buttons, the codes are sent according to the
   physical position of the buttons.
+
   Please note that 2- and 3-button pads are fairly rare and old. You might
   want to filter gamepads that do not report all four.
+
     2-Button Pad:
       If only 2 action-buttons are present, they are reported as BTN_SOUTH and
       BTN_EAST. For vertical layouts, the upper button is BTN_EAST. For
@@ -118,42 +127,52 @@ D-Pad:
   may even report both. The kernel does not convert between these so
   applications should support both and choose what is more appropriate if
   both are reported.
+
     Digital buttons are reported as:
+
       BTN_DPAD_*
+
     Analog buttons are reported as:
+
       ABS_HAT0X and ABS_HAT0Y
-      (for ABS values negative is left/up, positive is right/down)
+
+  (for ABS values negative is left/up, positive is right/down)
 
 Analog-Sticks:
   The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
   reported as ABS_RX, ABS_RY. Zero, one or two sticks may be present.
   If analog-sticks provide digital buttons, they are mapped accordingly as
   BTN_THUMBL (first/left) and BTN_THUMBR (second/right).
-    (for ABS values negative is left/up, positive is right/down)
+
+  (for ABS values negative is left/up, positive is right/down)
 
 Triggers:
   Trigger buttons can be available as digital or analog buttons or both. User-
   space must correctly deal with any situation and choose the most appropriate
   mode.
+
   Upper trigger buttons are reported as BTN_TR or ABS_HAT1X (right) and BTN_TL
   or ABS_HAT1Y (left). Lower trigger buttons are reported as BTN_TR2 or
   ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
+
   If only one trigger-button combination is present (upper+lower), they are
   reported as "right" triggers (BTN_TR/ABS_HAT1X).
-    (ABS trigger values start at 0, pressure is reported as positive values)
+
+  (ABS trigger values start at 0, pressure is reported as positive values)
 
 Menu-Pad:
   Menu buttons are always digital and are mapped according to their location
   instead of their labels. That is:
-    1-button Pad: Mapped as BTN_START
-    2-button Pad: Left button mapped as BTN_SELECT, right button mapped as
-                  BTN_START
+
+    1-button Pad:
+	Mapped as BTN_START
+
+    2-button Pad:
+	Left button mapped as BTN_SELECT, right button mapped as BTN_START
+
   Many pads also have a third button which is branded or has a special symbol
   and meaning. Such buttons are mapped as BTN_MODE. Examples are the Nintendo
   "HOME" button, the XBox "X"-button or Sony "PS" button.
 
 Rumble:
   Rumble is advertised as FF_RUMBLE.
-
-----------------------------------------------------------------------------
-  Written 2013 by David Herrmann <dh.herrmann@gmail.com>
-- 
2.9.3


