From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 5/5] Input: elantech - Update the documentation: trackpoint,v3/v4,crc_enabled
Date: Sat, 30 Aug 2014 16:10:46 +0200
Message-ID: <1409407846-15449-6-git-send-email-ulrik.debie-os@e2big.org>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:47776 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaH3OLr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Aug 2014 10:11:47 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

A chapter is added to describe the trackpoint packets.

A section is added to describe the behaviour of the knob crc_enabled in
sysfs.

The introduction of the documentation only mentioned v1/v2, but in the
last part it already contains explanation of v3 and v4. The introduction
is updated.

Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 Documentation/input/elantech.txt | 85 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/elantech.txt
index e1ae127..1ec228a 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -38,22 +38,38 @@ Contents
         7.2.1 Status packet
         7.2.2 Head packet
         7.2.3 Motion packet
+ 8. Trackpoint (for Hardware version 3 and 4)
+    8.1 Registers
+    8.2 Native relative mode 6 byte packet format
+        8.2.1 Status Packet
 
 
 
 1. Introduction
    ~~~~~~~~~~~~
 
-Currently the Linux Elantech touchpad driver is aware of two different
-hardware versions unimaginatively called version 1 and version 2. Version 1
-is found in "older" laptops and uses 4 bytes per packet. Version 2 seems to
-be introduced with the EeePC and uses 6 bytes per packet, and provides
-additional features such as position of two fingers, and width of the touch.
+Currently the Linux Elantech touchpad driver is aware of four different
+hardware versions unimaginatively called version 1,version 2, version 3
+and version 4. Version 1 is found in "older" laptops and uses 4 bytes per
+packet. Version 2 seems to be introduced with the EeePC and uses 6 bytes
+per packet, and provides additional features such as position of two fingers,
+and width of the touch.  Hardware version 3 uses 6 bytes per packet (and
+for 2 fingers the concatenation of two 6 bytes packets) and allows tracking
+of up to 3 fingers. Hardware version 4 uses 6 bytes per packet, and can
+combine a status packet with multiple head or motion packets. Hardware version
+4 allows tracking up to 5 fingers.
+
+Some Hardware version 3 and version 4 also have a trackpoint which uses a
+separate packet format. It is also 6 bytes per packet.
 
 The driver tries to support both hardware versions and should be compatible
 with the Xorg Synaptics touchpad driver and its graphical configuration
 utilities.
 
+Note that a mouse button is also associated with either the touchpad or the
+trackpoint when a trackpoint is available.  Disabling the Touchpad in xorg
+(TouchPadOff=0) will also disable the buttons associated with the touchpad.
+
 Additionally the operation of the touchpad can be altered by adjusting the
 contents of some of its internal registers. These registers are represented
 by the driver as sysfs entries under /sys/bus/serio/drivers/psmouse/serio?
@@ -78,7 +94,7 @@ completeness sake.
 2. Extra knobs
    ~~~~~~~~~~~
 
-Currently the Linux Elantech touchpad driver provides two extra knobs under
+Currently the Linux Elantech touchpad driver provides three extra knobs under
 /sys/bus/serio/drivers/psmouse/serio? for the user.
 
 * debug
@@ -112,6 +128,23 @@ Currently the Linux Elantech touchpad driver provides two extra knobs under
    data consistency checking can be done. For now checking is disabled by
    default. Currently even turning it on will do nothing.
 
+* crc_enabled
+
+   Sets crc_enabled to 0/1 or autodetect the crc_enabled. The name
+   "crc_enabled" is the official name of this integrity check, even though
+   it is not an actual cyclic redundancy check.
+
+   Depending on the state of crc_enabled, certain basic data integrity
+   verification is done by the driver on hardware version 3 and 4. The
+   driver will reject any packet that appears corrupted. Using this knob,
+   The state of crc_enabled can be altered with this knob.
+
+   Reading the crc_enabled value will show the active value. Echoing
+   "0" or "1" to this file will set the state to "0" or "1".
+   When echoing "2" to this file, the elantech driver will perform an auto
+   detect again (similar as during startup of the driver) of the value and
+   sets the state "0" or "1" depending on the result of the auto detect.
+
 /////////////////////////////////////////////////////////////////////////////
 
 3. Differentiating hardware versions
@@ -746,3 +779,43 @@ byte 5:
 
         byte 0 ~ 2 for one finger
         byte 3 ~ 5 for another
+
+
+8. Trackpoint (for Hardware version 3 and 4)
+   =========================================
+8.1 Registers
+    ~~~~~~~~~
+No special registers have been identified.
+
+8.2 Native relative mode 6 byte packet format
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+8.2.1 Status Packet
+      ~~~~~~~~~~~~~
+
+byte 0:
+   bit   7   6   5   4   3   2   1   0
+         0   0  sx  sy   0   M   R   L
+byte 1:
+   bit   7   6   5   4   3   2   1   0
+       ~sx   0   0   0   0   0   0   0
+byte 2:
+   bit   7   6   5   4   3   2   1   0
+       ~sy   0   0   0   0   0   0   0
+byte 3:
+   bit   7   6   5   4   3   2   1   0
+         0   0 ~sy ~sx   0   1   1   0
+byte 4:
+   bit   7   6   5   4   3   2   1   0
+        x7  x6  x5  x4  x3  x2  x1  x0
+byte 5:
+   bit   7   6   5   4   3   2   1   0
+        y7  y6  y5  y4  y3  y2  y1  y0
+
+
+         x and y are written in two's complement spread
+             over 9 bits with sx/sy the relative top bit and
+             x7..x0 and y7..y0 the lower bits.
+	 ~sx is the inverse of sx, ~sy is the inverse of sy.
+         The sign of y is opposite to what the input driver
+             expects for a relative movement
+
-- 
2.1.0

