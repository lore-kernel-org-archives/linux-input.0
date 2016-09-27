From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/2] Input: add motion-tracking ABS_* bits and docs
Date: Tue, 27 Sep 2016 16:38:52 -0700
Message-ID: <1475019532-16876-3-git-send-email-roderick@gaikai.com>
References: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38633 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756686AbcI0X5I (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 19:57:08 -0400
Received: by mail-it0-f48.google.com with SMTP id n143so29851716ita.1
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2016 16:57:07 -0700 (PDT)
In-Reply-To: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, Input Tools <input-tools@lists.freedesktop.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

This patch introduces new axes for acceleration and angular velocity.
David Herrmann's work served as a base, but we extended the specification
with various changes inspired by real devices and challenges we see
when doing motion tracking.

- Changed unit of acceleration to G instead of m/s^2. We felt that m/s^2
  is not the appropriate unit to return, because accelerometers are most
  often calibrated based on gravity. They return values in multiples of
  G and since we don't know the device location on earth, we should not
  blindly multiply by '9.8' for accuracy reasons. Such conversion is left
  to userspace.
- Resolution field is used for acceleration and gyro to report precision.
  The previous spec, specified to map 1 unit to e.g. 0.001 deg/s or 0.001 m/s^2.
  This is of course simpler for applications, but unit definition is a bit
  arbitrary. Previous axes definitions used the resolution field, which
  felt more consistent.
- Added section on timestamps, which are important for accurate motion
  tracking purposes. The use of MSC_TIMESTAMP was recommended in this
  situation to get access to the hardware timestamp if available.
- Changed motion axes to be defined as a right-handed coordinate system.
  Due to this change the gyro vectors are now defined as counter-clockwise.
  The overall changes makes the definitions consistent with computer graphics.

[PATCH 4/4] Input: add motion-tracking ABS_* bits and docs
David Herrmann <dh.herrmann@gmail.com>
Tue Dec 17 07:48:54 PST 2013

Motion sensors are getting quite common in mobile devices. To avoid
returning accelerometer data via ABS_X/Y/Z and irritating the Xorg
mouse-driver, this adds separate ABS_* bits for that.

This is needed if gaming devices want to report their normal data plus
accelerometer/gyro data. Usually, ABS_X/Y are already used by analog
sticks, so need separate definitions, anyway.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 Documentation/input/gamepad.txt         |   9 +-
 Documentation/input/motion-tracking.txt | 176 ++++++++++++++++++++++++++++++++
 include/uapi/linux/input-event-codes.h  |   7 ++
 3 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/input/motion-tracking.txt

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index 3f6d8a5..ed13782 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -57,6 +57,9 @@ Most gamepads have the following features:
   - Rumble
     Many devices provide force-feedback features. But are mostly just
     simple rumble motors.
+  - Motion-tracking
+    Gamepads may include motion-tracking sensors like accelerometers and
+    gyroscopes.
 
 3. Detection
 ~~~~~~~~~~~~
@@ -138,8 +141,6 @@ Triggers:
   Upper trigger buttons are reported as BTN_TR or ABS_HAT1X (right) and BTN_TL
   or ABS_HAT1Y (left). Lower trigger buttons are reported as BTN_TR2 or
   ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
-  If only one trigger-button combination is present (upper+lower), they are
-  reported as "right" triggers (BTN_TR/ABS_HAT1X).
     (ABS trigger values start at 0, pressure is reported as positive values)
 
 Menu-Pad:
@@ -155,5 +156,9 @@ Menu-Pad:
 Rumble:
   Rumble is advertised as FF_RUMBLE.
 
+Motion-tracking:
+  Motion-tracking is defined in ./Documentation/input/motion-tracking.txt and
+  gamepads shall comply to the rules defined there.
+
 ----------------------------------------------------------------------------
   Written 2013 by David Herrmann <dh.herrmann@gmail.com>
diff --git a/Documentation/input/motion-tracking.txt b/Documentation/input/motion-tracking.txt
new file mode 100644
index 0000000..d34a290
--- /dev/null
+++ b/Documentation/input/motion-tracking.txt
@@ -0,0 +1,176 @@
+                           Motion Tracking API
+----------------------------------------------------------------------------
+
+1. Intro
+~~~~~~~~
+Motion tracking devices produce device motion events generated from an
+accelerometer, gyroscope or compass. These data can be returned to user-space
+via input events. This document defines how these data are reported.
+
+2. Devices
+~~~~~~~~~~
+In this document, a "device" is one of:
+ - accelerometer
+ - gyroscope
+ - compass
+
+These devices returned their information via different APIs in the past. To
+unify them and define a common API, a set of input evdev codes was created. Old
+drivers might continue using their API, but developers are encouraged to use
+the input evdev API for new drivers.
+
+2.1 Axes
+~~~~~~~~
+Movement data is usually returned as absolute data for the 3 axes of a device.
+In this context, the three axes are defined in a right-handed coordinate
+system as:
+ - X: Axis goes from the left to the right side of the device
+ - Y: Axis goes from the bottom to the top of the device
+ - Z: Axis goes from the back to the front of the device
+
+The front of a device is the side faced to the user. For a mobile-phone it
+would be the screen. For devices without a screen, the top is usually the
+side with the most buttons on it.
+
+                           Example: Mobile-Phone
+  +-------------------------------------------------------------------------+
+  |                      TOP                                                |
+  |                                                                         |
+  |                                                                         |
+  |          +---------------------------+                                  |
+  |          |\  ________________________ \      .__                        |
+  |          \ \ \                       \ \     |\                         |
+  |           \ \ \              __       \ \      \                   RIGHT|
+  |            \ \ \              /|       \ \      \__                     |
+  |             \ \ \          __/          \ \     |\                      |
+  |              \ \ \          /|           \ \      \ (Y Axis)            |
+  |               \ \ \      __/  (Z axis)    \ \      \__                  |
+  |                \ \ \      /|               \ \     |\                   |
+  | LEFT            \ \ \    /                  \ \      \                  |
+  |                  \ \ \         FRONT         \ \      \                 |
+  |                   \ \ \                       \ \                       |
+  |                    \ \ \_______________________\ \                      |
+  |                     \ \             ___           \                     |
+  |                     /\ \            \__\           \                    |
+  |                  __/  \ +---------------------------+                   |
+  |                   /|   \|___________________________|                   |
+  |                  / BACK                                                 |
+  |                                      (X axis)                           |
+  |                        ------->------->------->------->                 |
+  |                                                                         |
+  |                                                                         |
+  |                                         BOTTOM                          |
+  +-------------------------------------------------------------------------+
+
+Rotation-data is reported as counter-clockwise rotation on an axis when viewed
+from the top of the axis, as given by the right hand rule. For a given axis,
+the reported rotation would be:
+                                        ____
+                                          //|
+                                         // | (axis)
+                                        //
+                                       //
+                                  .   // __
+                                 /   // /\
+                                |   //    |
+                                 \ //    /  (counter-clockwise rotation)
+                                  *.___.*
+                                 //
+                                //
+
+2.2 Calibration
+~~~~~~~~~~~~~~~
+Motion sensors are often highly sensitive and need precise calibration. Users
+are advised to perform neutral-point calibration themselves or to implement a
+state-machine to normalize input data automatically.
+
+Kernel devices may perform their own calibration and/or normalization. However,
+this is usually sparse and, if implemented, transparent to the user.
+
+There is currently no way to feed calibration data into the kernel in a generic
+way. Proposals welcome!
+
+2.3 Units
+~~~~~~~~~
+(NOTE: This section describes an experimental API. Currently, no device complies
+to these rules so this might change in the future.)
+
+Reported data shall be returned as:
+ - Acceleration: 1/(input_absinfo.resolution) G
+ - Rotation: 1/(input_absinfo.resolution) degree per second
+
+Acceleration is reported in units of G as opposed to m/s^2, because acceleration
+sensors internally work based on gravitation. Since the conversion to m/s^2 is
+location dependent, applications should either approximate the conversion
+factor as 9.8 m/s^2 or if more precision is desired obtain a scaling factor
+by other means e.g. GPS.
+
+However, for most devices the reported units are unknown (more precisely: no
+one has the time to measure them and figure them out). Therefore, user-space
+shall use abs-minimum and abs-maximum to calculate relative data and use that
+instead. Devices which return wrong units may be fixed in the future to comply
+to these rules.
+
+2.4 Timestamps
+~~~~~~~~~~~~~~
+For motion tracking purposes the time delta between consecutive motion events
+is important for mathematical operations such as differentiation and integration.
+The time delta could be derived from the 'time' field in 'struct input_event' by
+subtracting the time between consecutive events. However, this timestamp may not
+provide enough accuracy depending on the use case, since it is based upon time of
+processing within the input layer versus time of arrival in the kernel or the
+time the hardware sent the data. There is often a small variable time difference
+between these.
+
+Optionally, hardware may provide a hardware timestamp produced at the time it
+sampled the motion sensors. This timestamp is is exposed through
+'MSC_TIMESTAMP' event, which provides timing information in microseconds.
+If available, MSC_TIMESTAMP is the recommended approach for calculation of time
+deltas.
+
+3.1 Accelerometer
+~~~~~~~~~~~~~~~~~
+Accelerometers measure movement acceleration of devices. Any combination of the
+three available axes can be used. Usually, all three are supported.
+
+Data is provided as absolute acceleration. A positive integer defines the
+acceleration in the direction of an axis. A negative integer defines
+acceleration in the opposite direction.
+
+The evdev ABS codes used are:
+ - ABS_ACCEL_X: X axis
+ - ABS_ACCEL_Y: Y axis
+ - ABS_ACCEL_Z: Z axis
+
+3.2 Gyroscope
+~~~~~~~~~~~~~
+A gyroscope measures rotational speed (*not* acceleration!). Any combination of
+the three available axes can be used. Usually, all three are supported.
+
+Data is provided as absolute speed. A positive integer defines the rotational
+speed in counter-clockwise order around a given axis when viewed from the top of
+the axis. A negative integer defines it in clockwise order.
+
+The evdev ABS codes used are:
+ - ABS_GYRO_X: X axis (also: Pitch)
+ - ABS_GYRO_Y: Y axis (also: Roll)
+ - ABS_GYRO_Z: Z axis (also: Azimuth/Yaw)
+
+3.3 Compass
+~~~~~~~~~~~
+(NOTE: No compass device currently uses the evdev input subsystem. Thus, this
+API is only a proposal, it hasn't been implemented, yet.)
+
+A compass measures the ambient magnetic field of the three defined axes. This
+makes the data self-contained and independent of the current device position.
+Any combination of the three axes can be used. Usually all three are supported,
+otherwise, it's not really useful as a compass.
+
+Proposed evdev ABS codes are:
+ - ABS_COMPASS_X: X axis
+ - ABS_COMPASS_Y: Y axis
+ - ABS_COMPASS_Z: Z axis
+
+----------------------------------------------------------------------------
+  (c) 2013 David Herrmann <dh.herrmann at gmail.com>
+  (c) 2016 Roderick Colenbrander <roderick.colenbrander@sony.com>
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7bf2a2e..0cacfe7 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -763,6 +763,13 @@
 #define ABS_MAX			0x3f
 #define ABS_CNT			(ABS_MAX+1)
 
+#define ABS_GYRO_X		0x40	/* Gyroscope X axis */
+#define ABS_GYRO_Y		0x41	/* Gyroscope Y axis */
+#define ABS_GYRO_Z		0x42	/* Gyroscope Z axis */
+#define ABS_ACCEL_X		0x43	/* Accelerometer X axis */
+#define ABS_ACCEL_Y		0x44	/* Accelerometer Y axis */
+#define ABS_ACCEL_Z		0x45	/* Accelerometer Z axis */
+
 /*
  * Due to API restrictions the legacy evdev API only supports ABS values up to
  * ABS_MAX/CNT. Use the extended *ABS2 ioctls to operate on the full range of
-- 
2.7.4

