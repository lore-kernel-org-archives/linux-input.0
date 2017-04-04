From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 13/37] docs: input/gamepad: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:13 -0300
Message-ID: <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34597
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753457AbdDDMXH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:07 -0400
In-Reply-To: <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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

