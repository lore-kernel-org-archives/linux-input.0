From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 11/33] docs: input/event-codes: convert it to ReST
 format
Date: Sat, 1 Apr 2017 23:42:05 -0300
Message-ID: <20170401234151.64ae382f@vento.lan>
References: <cover.1491069870.git.mchehab@s-opensource.com>
        <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
        <20170402011635.GC5349@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170402011635.GC5349@jelly>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

Em Sun, 2 Apr 2017 11:16:35 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Sat, Apr 01, 2017 at 03:15:54PM -0300, Mauro Carvalho Chehab wrote:
> > This file require minimum adjustments to be a valid ReST file.
> > Do it, in order to be able to parse it with Sphinx.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>  
> 
> there's a  conflict markerleft in this file, see below


Gah! Sorry for that. The correct patch is enclosed.

I also updated the html for it:
	http://www.infradead.org/~mchehab/kernel_docs/input/event-codes.html

Thanks,
Mauro

[PATCH] docs: input/event-codes: convert it to ReST format

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 36ea940e5bb9..92db50954169 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -1,3 +1,8 @@
+=================
+Input event codes
+=================
+
+
 The input protocol uses a map of types and codes to express input device values
 to userspace. This document describes the types and codes and how and when they
 may be used.
@@ -17,82 +22,102 @@ reports supported by a device are also provided by sysfs in
 class/input/event*/device/capabilities/, and the properties of a device are
 provided in class/input/event*/device/properties.
 
-Event types:
+Event types
 ===========
+
 Event types are groupings of codes under a logical input construct. Each
 type has a set of applicable codes to be used in generating events. See the
 Codes section for details on valid codes for each type.
 
 * EV_SYN:
+
   - Used as markers to separate events. Events may be separated in time or in
     space, such as with the multitouch protocol.
 
 * EV_KEY:
+
   - Used to describe state changes of keyboards, buttons, or other key-like
     devices.
 
 * EV_REL:
+
   - Used to describe relative axis value changes, e.g. moving the mouse 5 units
     to the left.
 
 * EV_ABS:
+
   - Used to describe absolute axis value changes, e.g. describing the
     coordinates of a touch on a touchscreen.
 
 * EV_MSC:
+
   - Used to describe miscellaneous input data that do not fit into other types.
 
 * EV_SW:
+
   - Used to describe binary state input switches.
 
 * EV_LED:
+
   - Used to turn LEDs on devices on and off.
 
 * EV_SND:
+
   - Used to output sound to devices.
 
 * EV_REP:
+
   - Used for autorepeating devices.
 
 * EV_FF:
+
   - Used to send force feedback commands to an input device.
 
 * EV_PWR:
+
   - A special type for power button and switch input.
 
 * EV_FF_STATUS:
+
   - Used to receive force feedback device status.
 
-Event codes:
+Event codes
 ===========
+
 Event codes define the precise type of event.
 
-EV_SYN:
-----------
+EV_SYN
+------
+
 EV_SYN event values are undefined. Their usage is defined only by when they are
 sent in the evdev event stream.
 
 * SYN_REPORT:
+
   - Used to synchronize and separate events into packets of input data changes
     occurring at the same moment in time. For example, motion of a mouse may set
     the REL_X and REL_Y values for one motion, then emit a SYN_REPORT. The next
     motion will emit more REL_X and REL_Y values and send another SYN_REPORT.
 
 * SYN_CONFIG:
+
   - TBD
 
 * SYN_MT_REPORT:
+
   - Used to synchronize and separate touch events. See the
     multi-touch-protocol.txt document for more information.
 
 * SYN_DROPPED:
+
   - Used to indicate buffer overrun in the evdev client's event queue.
     Client should ignore all events up to and including next SYN_REPORT
     event and query the device (using EVIOCG* ioctls) to obtain its
     current state.
 
-EV_KEY:
-----------
+EV_KEY
+------
+
 EV_KEY events take the form KEY_<name> or BTN_<name>. For example, KEY_A is used
 to represent the 'A' key on a keyboard. When a key is depressed, an event with
 the key's code is emitted with value 1. When the key is released, an event is
@@ -103,6 +128,7 @@ BTN_<name> is used for other types of momentary switch events.
 A few EV_KEY codes have special meanings:
 
 * BTN_TOOL_<name>:
+
   - These codes are used in conjunction with input trackpads, tablets, and
     touchscreens. These devices may be used with fingers, pens, or other tools.
     When an event occurs and a tool is used, the corresponding BTN_TOOL_<name>
@@ -112,6 +138,7 @@ A few EV_KEY codes have special meanings:
     code when events are generated.
 
 * BTN_TOUCH:
+
     BTN_TOUCH is used for touch contact. While an input tool is determined to be
     within meaningful physical contact, the value of this property must be set
     to 1. Meaningful physical contact may mean any contact, or it may mean
@@ -132,6 +159,7 @@ future, this distinction will be deprecated and the device properties ioctl
 EVIOCGPROP, defined in linux/input.h, will be used to convey the device type.
 
 * BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP, BTN_TOOL_TRIPLETAP, BTN_TOOL_QUADTAP:
+
   - These codes denote one, two, three, and four finger interaction on a
     trackpad or touchscreen. For example, if the user uses two fingers and moves
     them on the touchpad in an effort to scroll content on screen,
@@ -147,8 +175,9 @@ a value of 1 in the same synchronization frame. This usage is deprecated.
 Note: In multitouch drivers, the input_mt_report_finger_count() function should
 be used to emit these codes. Please see multi-touch-protocol.txt for details.
 
-EV_REL:
-----------
+EV_REL
+------
+
 EV_REL events describe relative changes in a property. For example, a mouse may
 move to the left by a certain number of units, but its absolute position in
 space is unknown. If the absolute position is known, EV_ABS codes should be used
@@ -157,17 +186,20 @@ instead of EV_REL codes.
 A few EV_REL codes have special meanings:
 
 * REL_WHEEL, REL_HWHEEL:
+
   - These codes are used for vertical and horizontal scroll wheels,
     respectively.
 
-EV_ABS:
-----------
+EV_ABS
+------
+
 EV_ABS events describe absolute changes in a property. For example, a touchpad
 may emit coordinates for a touch location.
 
 A few EV_ABS codes have special meanings:
 
 * ABS_DISTANCE:
+
   - Used to describe the distance of a tool from an interaction surface. This
     event should only be emitted while the tool is hovering, meaning in close
     proximity of the device and while the value of the BTN_TOUCH code is 0. If
@@ -179,11 +211,13 @@ A few EV_ABS codes have special meanings:
     hardware and is otherwise independent of ABS_DISTANCE and/or BTN_TOUCH.
 
 * ABS_MT_<name>:
+
   - Used to describe multitouch input events. Please see
     multi-touch-protocol.txt for details.
 
-EV_SW:
-----------
+EV_SW
+-----
+
 EV_SW events describe stateful binary switches. For example, the SW_LID code is
 used to denote when a laptop lid is closed.
 
@@ -195,14 +229,16 @@ Upon resume, if the switch state is the same as before suspend, then the input
 subsystem will filter out the duplicate switch state reports. The driver does
 not need to keep the state of the switch at any time.
 
-EV_MSC:
-----------
+EV_MSC
+------
+
 EV_MSC events are used for input and output events that do not fall under other
 categories.
 
 A few EV_MSC codes have special meaning:
 
 * MSC_TIMESTAMP:
+
   - Used to report the number of microseconds since the last reset. This event
     should be coded as an uint32 value, which is allowed to wrap around with
     no special consequence. It is assumed that the time difference between two
@@ -211,39 +247,46 @@ A few EV_MSC codes have special meaning:
     unknown.  If the device does not provide this information, the driver must
     not provide it to user space.
 
-EV_LED:
-----------
+EV_LED
+------
+
 EV_LED events are used for input and output to set and query the state of
 various LEDs on devices.
 
-EV_REP:
-----------
+EV_REP
+------
+
 EV_REP events are used for specifying autorepeating events.
 
-EV_SND:
-----------
+EV_SND
+------
+
 EV_SND events are used for sending sound commands to simple sound output
 devices.
 
-EV_FF:
-----------
+EV_FF
+-----
+
 EV_FF events are used to initialize a force feedback capable device and to cause
 such device to feedback.
 
-EV_PWR:
-----------
+EV_PWR
+------
+
 EV_PWR events are a special type of event used specifically for power
 management. Its usage is not well defined. To be addressed later.
 
-Device properties:
+Device properties
 =================
+
 Normally, userspace sets up an input device based on the data it emits,
 i.e., the event types. In the case of two devices emitting the same event
 types, additional information can be provided in the form of device
 properties.
 
-INPUT_PROP_DIRECT + INPUT_PROP_POINTER:
+INPUT_PROP_DIRECT + INPUT_PROP_POINTER
 --------------------------------------
+
 The INPUT_PROP_DIRECT property indicates that device coordinates should be
 directly mapped to screen coordinates (not taking into account trivial
 transformations, such as scaling, flipping and rotating). Non-direct input
@@ -260,8 +303,9 @@ If neither INPUT_PROP_DIRECT or INPUT_PROP_POINTER are set, the property is
 considered undefined and the device type should be deduced in the
 traditional way, using emitted event types.
 
-INPUT_PROP_BUTTONPAD:
+INPUT_PROP_BUTTONPAD
 --------------------
+
 For touchpads where the button is placed beneath the surface, such that
 pressing down on the pad causes a button click, this property should be
 set. Common in clickpad notebooks and macbooks from 2009 and onwards.
@@ -270,8 +314,9 @@ Originally, the buttonpad property was coded into the bcm5974 driver
 version field under the name integrated button. For backwards
 compatibility, both methods need to be checked in userspace.
 
-INPUT_PROP_SEMI_MT:
+INPUT_PROP_SEMI_MT
 ------------------
+
 Some touchpads, most common between 2008 and 2011, can detect the presence
 of multiple contacts without resolving the individual positions; only the
 number of contacts and a rectangular shape is known. For such
@@ -285,9 +330,10 @@ gestures can normally be extracted from it.
 If INPUT_PROP_SEMI_MT is not set, the device is assumed to be a true MT
 device.
 
-INPUT_PROP_TOPBUTTONPAD:
+INPUT_PROP_TOPBUTTONPAD
 -----------------------
-Some laptops, most notably the Lenovo *40 series provide a trackstick
+
+Some laptops, most notably the Lenovo 40 series provide a trackstick
 device but do not have physical buttons associated with the trackstick
 device. Instead, the top area of the touchpad is marked to show
 visual/haptic areas for left, middle, right buttons intended to be used
@@ -299,26 +345,30 @@ The kernel does not provide button emulation for such devices but treats
 them as any other INPUT_PROP_BUTTONPAD device.
 
 INPUT_PROP_ACCELEROMETER
--------------------------
+------------------------
+
 Directional axes on this device (absolute and/or relative x, y, z) represent
 accelerometer data. All other axes retain their meaning. A device must not mix
 regular directional axes and accelerometer axes on the same event node.
 
-Guidelines:
+Guidelines
 ==========
+
 The guidelines below ensure proper single-touch and multi-finger functionality.
 For multi-touch functionality, see the multi-touch-protocol.txt document for
 more information.
 
-Mice:
-----------
+Mice
+----
+
 REL_{X,Y} must be reported when the mouse moves. BTN_LEFT must be used to report
 the primary button press. BTN_{MIDDLE,RIGHT,4,5,etc.} should be used to report
 further buttons of the device. REL_WHEEL and REL_HWHEEL should be used to report
 scroll wheel events where available.
 
-Touchscreens:
-----------
+Touchscreens
+------------
+
 ABS_{X,Y} must be reported with the location of the touch. BTN_TOUCH must be
 used to report when a touch is active on the screen.
 BTN_{MOUSE,LEFT,MIDDLE,RIGHT} must not be reported as the result of touch
@@ -326,8 +376,9 @@ contact. BTN_TOOL_<name> events should be reported where possible.
 
 For new hardware, INPUT_PROP_DIRECT should be set.
 
-Trackpads:
-----------
+Trackpads
+---------
+
 Legacy trackpads that only provide relative position information must report
 events like mice described above.
 
@@ -338,8 +389,9 @@ be used to report the number of touches active on the trackpad.
 
 For new hardware, INPUT_PROP_POINTER should be set.
 
-Tablets:
-----------
+Tablets
+-------
+
 BTN_TOOL_<name> events must be reported when a stylus or other tool is active on
 the tablet. ABS_{X,Y} must be reported with the location of the tool. BTN_TOUCH
 should be used to report when the tool is in contact with the tablet.


