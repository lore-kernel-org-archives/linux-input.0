From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/8] Input: docs - split input docs into kernel- and user-facing
Date: Sat, 15 Apr 2017 22:11:44 -0700
Message-ID: <20170416051145.13618-7-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

Split input documentation into several groups: kernel- and user-facing, and
notes about individual device drivers. Move device drivers docs into a
separate subdirectory.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/{ => devices}/alps.rst         |  2 +-
 Documentation/input/{ => devices}/amijoy.rst       |  0
 Documentation/input/{ => devices}/appletouch.rst   |  0
 Documentation/input/{ => devices}/atarikbd.rst     |  0
 Documentation/input/{ => devices}/bcm5974.rst      |  0
 Documentation/input/{ => devices}/cma3000_d0x.rst  |  4 +-
 Documentation/input/{ => devices}/cs461x.rst       |  8 +---
 Documentation/input/{ => devices}/edt-ft5x06.rst   |  0
 Documentation/input/{ => devices}/elantech.rst     |  0
 Documentation/input/{ => devices}/gpio-tilt.rst    |  8 ++--
 .../input/{ => devices}/iforce-protocol.rst        |  0
 Documentation/input/devices/index.rst              | 19 +++++++++
 .../input/{ => devices}/joystick-parport.rst       |  2 +-
 Documentation/input/{ => devices}/ntrig.rst        |  0
 .../input/{ => devices}/rotary-encoder.rst         |  0
 Documentation/input/{ => devices}/sentelic.rst     | 10 ++---
 Documentation/input/{ => devices}/walkera0701.rst  |  0
 Documentation/input/{ => devices}/xpad.rst         | 22 +++++-----
 Documentation/input/{ => devices}/yealink.rst      | 47 ++++++++--------------
 Documentation/input/gamepad.rst                    | 10 ++---
 Documentation/input/index.rst                      | 39 ++----------------
 Documentation/input/input-programming.rst          |  5 +--
 Documentation/input/input_kapi.rst                 | 17 ++++++++
 Documentation/input/input_uapi.rst                 | 21 ++++++++++
 24 files changed, 107 insertions(+), 107 deletions(-)
 rename Documentation/input/{ => devices}/alps.rst (99%)
 rename Documentation/input/{ => devices}/amijoy.rst (100%)
 rename Documentation/input/{ => devices}/appletouch.rst (100%)
 rename Documentation/input/{ => devices}/atarikbd.rst (100%)
 rename Documentation/input/{ => devices}/bcm5974.rst (100%)
 rename Documentation/input/{ => devices}/cma3000_d0x.rst (97%)
 rename Documentation/input/{ => devices}/cs461x.rst (88%)
 rename Documentation/input/{ => devices}/edt-ft5x06.rst (100%)
 rename Documentation/input/{ => devices}/elantech.rst (100%)
 rename Documentation/input/{ => devices}/gpio-tilt.rst (98%)
 rename Documentation/input/{ => devices}/iforce-protocol.rst (100%)
 create mode 100644 Documentation/input/devices/index.rst
 rename Documentation/input/{ => devices}/joystick-parport.rst (99%)
 rename Documentation/input/{ => devices}/ntrig.rst (100%)
 rename Documentation/input/{ => devices}/rotary-encoder.rst (100%)
 rename Documentation/input/{ => devices}/sentelic.rst (99%)
 rename Documentation/input/{ => devices}/walkera0701.rst (100%)
 rename Documentation/input/{ => devices}/xpad.rst (95%)
 rename Documentation/input/{ => devices}/yealink.rst (94%)
 create mode 100644 Documentation/input/input_kapi.rst
 create mode 100644 Documentation/input/input_uapi.rst

diff --git a/Documentation/input/alps.rst b/Documentation/input/devices/alps.rst
similarity index 99%
rename from Documentation/input/alps.rst
rename to Documentation/input/devices/alps.rst
index 76a71a146e50..6779148e428c 100644
--- a/Documentation/input/alps.rst
+++ b/Documentation/input/devices/alps.rst
@@ -5,7 +5,7 @@ ALPS Touchpad Protocol
 Introduction
 ------------
 Currently the ALPS touchpad driver supports seven protocol versions in use by
-ALPS touchpads, called versions 1, 2, 3, 4, 5, 6 and 7.
+ALPS touchpads, called versions 1, 2, 3, 4, 5, 6, 7 and 8.
 
 Since roughly mid-2010 several new ALPS touchpads have been released and
 integrated into a variety of laptops and netbooks.  These new touchpads
diff --git a/Documentation/input/amijoy.rst b/Documentation/input/devices/amijoy.rst
similarity index 100%
rename from Documentation/input/amijoy.rst
rename to Documentation/input/devices/amijoy.rst
diff --git a/Documentation/input/appletouch.rst b/Documentation/input/devices/appletouch.rst
similarity index 100%
rename from Documentation/input/appletouch.rst
rename to Documentation/input/devices/appletouch.rst
diff --git a/Documentation/input/atarikbd.rst b/Documentation/input/devices/atarikbd.rst
similarity index 100%
rename from Documentation/input/atarikbd.rst
rename to Documentation/input/devices/atarikbd.rst
diff --git a/Documentation/input/bcm5974.rst b/Documentation/input/devices/bcm5974.rst
similarity index 100%
rename from Documentation/input/bcm5974.rst
rename to Documentation/input/devices/bcm5974.rst
diff --git a/Documentation/input/cma3000_d0x.rst b/Documentation/input/devices/cma3000_d0x.rst
similarity index 97%
rename from Documentation/input/cma3000_d0x.rst
rename to Documentation/input/devices/cma3000_d0x.rst
index 6f40c17c1aca..8bc8e61487b0 100644
--- a/Documentation/input/cma3000_d0x.rst
+++ b/Documentation/input/devices/cma3000_d0x.rst
@@ -1,5 +1,5 @@
-Kernel driver for CMA3000-D0x
-=============================
+CMA3000-D0x Accelerometer
+=========================
 
 Supported chips:
 * VTI CMA3000-D0x
diff --git a/Documentation/input/cs461x.rst b/Documentation/input/devices/cs461x.rst
similarity index 88%
rename from Documentation/input/cs461x.rst
rename to Documentation/input/devices/cs461x.rst
index 1450436dcc9e..b1e6d508ad26 100644
--- a/Documentation/input/cs461x.rst
+++ b/Documentation/input/devices/cs461x.rst
@@ -1,9 +1,6 @@
 Crystal SoundFusion CS4610/CS4612/CS461 joystick
 ================================================
 
-Preface
--------
-
 This is a new low-level driver to support analog joystick attached to
 Crystal SoundFusion CS4610/CS4612/CS4615. This code is based upon
 Vortex/Solo drivers as an example of decoration style, and ALSA
@@ -25,11 +22,8 @@ screen in VJOYD); I have no documentation on my chip; and the existing
 behavior in my case was not raised the requirement of joystick calibration.
 So the driver have no code to perform hardware related calibration.
 
-The patch contains minor changes of Config.in and Makefile files. All
-needed code have been moved to one separate file cs461x.c like ns558.c
 This driver have the basic support for PCI devices only; there is no
-ISA or PnP ISA cards supported. AFAIK the ns558 have support for Crystal
-ISA and PnP ISA series.
+ISA or PnP ISA cards supported.
 
 The driver works with ALSA drivers simultaneously. For example, the xracer
 uses joystick as input device and PCM device as sound output in one time.
diff --git a/Documentation/input/edt-ft5x06.rst b/Documentation/input/devices/edt-ft5x06.rst
similarity index 100%
rename from Documentation/input/edt-ft5x06.rst
rename to Documentation/input/devices/edt-ft5x06.rst
diff --git a/Documentation/input/elantech.rst b/Documentation/input/devices/elantech.rst
similarity index 100%
rename from Documentation/input/elantech.rst
rename to Documentation/input/devices/elantech.rst
diff --git a/Documentation/input/gpio-tilt.rst b/Documentation/input/devices/gpio-tilt.rst
similarity index 98%
rename from Documentation/input/gpio-tilt.rst
rename to Documentation/input/devices/gpio-tilt.rst
index 23de9eff6a34..fa6e64570aa7 100644
--- a/Documentation/input/gpio-tilt.rst
+++ b/Documentation/input/devices/gpio-tilt.rst
@@ -7,8 +7,8 @@ i.e. each tilt switch providing one axis, and the number of axes
 is also not limited.
 
 
-Data structures:
-----------------
+Data structures
+---------------
 
 The array of struct gpio in the gpios field is used to list the gpios
 that represent the current tilt state.
@@ -24,8 +24,8 @@ In the same manner the values stored in the axes array correspond to
 the elements of the gpio_tilt_axis-array.
 
 
-Example:
---------
+Example
+-------
 
 Example configuration for a single TS1003 tilt switch that rotates around
 one axis in 4 steps and emits the current tilt via two GPIOs::
diff --git a/Documentation/input/iforce-protocol.rst b/Documentation/input/devices/iforce-protocol.rst
similarity index 100%
rename from Documentation/input/iforce-protocol.rst
rename to Documentation/input/devices/iforce-protocol.rst
diff --git a/Documentation/input/devices/index.rst b/Documentation/input/devices/index.rst
new file mode 100644
index 000000000000..95a453782bad
--- /dev/null
+++ b/Documentation/input/devices/index.rst
@@ -0,0 +1,19 @@
+Driver-specific documentation
+=============================
+
+This section provides information about various devices supported by the
+Linux kernel, their protocols, and driver details.
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+   :glob:
+
+   *
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/input/joystick-parport.rst b/Documentation/input/devices/joystick-parport.rst
similarity index 99%
rename from Documentation/input/joystick-parport.rst
rename to Documentation/input/devices/joystick-parport.rst
index cc2ab871e701..e8ce16ee799a 100644
--- a/Documentation/input/joystick-parport.rst
+++ b/Documentation/input/devices/joystick-parport.rst
@@ -3,7 +3,7 @@
 .. _joystick-parport:
 
 ==============================
-Parallel port Joystick Drivers
+Parallel Port Joystick Drivers
 ==============================
 
 :Copyright: |copy| 1998-2000 Vojtech Pavlik <vojtech@ucw.cz>
diff --git a/Documentation/input/ntrig.rst b/Documentation/input/devices/ntrig.rst
similarity index 100%
rename from Documentation/input/ntrig.rst
rename to Documentation/input/devices/ntrig.rst
diff --git a/Documentation/input/rotary-encoder.rst b/Documentation/input/devices/rotary-encoder.rst
similarity index 100%
rename from Documentation/input/rotary-encoder.rst
rename to Documentation/input/devices/rotary-encoder.rst
diff --git a/Documentation/input/sentelic.rst b/Documentation/input/devices/sentelic.rst
similarity index 99%
rename from Documentation/input/sentelic.rst
rename to Documentation/input/devices/sentelic.rst
index d1a476f973b1..1b6829b74ae8 100644
--- a/Documentation/input/sentelic.rst
+++ b/Documentation/input/devices/sentelic.rst
@@ -1,16 +1,16 @@
 .. include:: <isonum.txt>
 
-===============
-Sentelic Driver
-===============
+=================
+Sentelic Touchpad
+=================
 
 
 :Copyright: |copy| 2002-2011 Sentelic Corporation.
 
 :Last update: Dec-07-2011
 
-Finger Sensing Pad Intellimouse Mode(scrolling wheel, 4th and 5th buttons)
-==========================================================================
+Finger Sensing Pad Intellimouse Modei (scrolling wheel, 4th and 5th buttons)
+============================================================================
 
 A) MSID 4: Scrolling wheel mode plus Forward page(4th button) and Backward
    page (5th button)
diff --git a/Documentation/input/walkera0701.rst b/Documentation/input/devices/walkera0701.rst
similarity index 100%
rename from Documentation/input/walkera0701.rst
rename to Documentation/input/devices/walkera0701.rst
diff --git a/Documentation/input/xpad.rst b/Documentation/input/devices/xpad.rst
similarity index 95%
rename from Documentation/input/xpad.rst
rename to Documentation/input/devices/xpad.rst
index 0bae002cf17a..80028433b460 100644
--- a/Documentation/input/xpad.rst
+++ b/Documentation/input/devices/xpad.rst
@@ -125,7 +125,7 @@ the controller device) with the only difference in a nonstandard connector
 You just need to solder a USB connector onto the cable and keep the
 yellow wire unconnected. The other pins have the same order on both
 connectors so there is no magic to it. Detailed info on these matters
-can be found on the net ([1], [2], [3]).
+can be found on the net ([1]_, [2]_, [3]_).
 
 Thanks to the trip splitter found on the cable you don't even need to cut the
 original one. You can buy an extension cable and cut that instead. That way,
@@ -138,7 +138,7 @@ Driver Installation
 
 Once you have the adapter cable, if needed, and the controller connected
 the xpad module should be auto loaded. To confirm you can cat
-/proc/bus/usb/devices. There should be an entry like the one at the end [4].
+/proc/bus/usb/devices. There should be an entry like the one at the end [4]_.
 
 
 
@@ -199,13 +199,12 @@ the basic functionality.
 References
 ==========
 
-[1]: http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
+.. [1] http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
+.. [2] http://xpad.xbox-scene.com/
+.. [3] http://www.markosweb.com/www/xboxhackz.com/
+.. [4] /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany):
 
-[2]: http://xpad.xbox-scene.com/
-
-[3]: http://www.markosweb.com/www/xboxhackz.com/
-
-[4]: /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany)::
+ ::
 
     T:  Bus=01 Lev=03 Prnt=04 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
     D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=32 #Cfgs=  1
@@ -214,8 +213,9 @@ References
     I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=(none)
     E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
     E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms
+.. [5] /proc/bus/usb/devices - dump from Redoctane Xbox Dance Pad (US):
 
-[5]: /proc/bus/usb/devices - dump from Redoctane Xbox Dance Pad (US)::
+ ::
 
     T:  Bus=01 Lev=02 Prnt=09 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
     D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
@@ -225,9 +225,7 @@ References
     I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=xpad
     E:  Ad=82(I) Atr=03(Int.) MxPS=  32 Ivl=4ms
     E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=4ms
-
-[6]: http://lxr.free-electrons.com/ident?i=xpad_device
-
+.. [6] http://lxr.free-electrons.com/ident?i=xpad_device
 
 
 Historic Edits
diff --git a/Documentation/input/yealink.rst b/Documentation/input/devices/yealink.rst
similarity index 94%
rename from Documentation/input/yealink.rst
rename to Documentation/input/devices/yealink.rst
index b231d8baf4bb..bb5a1aafeca2 100644
--- a/Documentation/input/yealink.rst
+++ b/Documentation/input/devices/yealink.rst
@@ -18,36 +18,6 @@ The p1k is a relatively cheap usb 1.1 phone with:
 For vendor documentation see http://www.yealink.com
 
 
-Compilation (stand alone version)
-=================================
-
-Currently only kernel 2.6.x.y versions are supported.
-In order to build the yealink.ko module do::
-
-  make
-
-If you encounter problems please check if in the MAKE_OPTS variable in
-the Makefile is pointing to the location where your kernel sources
-are located, default /usr/src/linux.
-
-
-Troubleshooting
-~~~~~~~~~~~~~~~
-
-:Q: Module yealink compiled and installed without any problem but phone
-    is not initialized and does not react to any actions.
-:A: If you see something like:
-    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
-    in dmesg, it means that the hid driver has grabbed the device first. Try to
-    load module yealink before any other usb hid driver. Please see the
-    instructions provided by your distribution on module configuration.
-
-:Q: Phone is working now (displays version and accepts keypad input) but I can't
-    find the sysfs files.
-:A: The sysfs files are located on the particular usb endpoint. On most
-    distributions you can do: "find /sys/ -name get_icons" for a hint.
-
-
 keyboard features
 =================
 
@@ -229,6 +199,23 @@ limit of the device.
     aplay foobar.wav
 
 
+Troubleshooting
+===============
+
+:Q: Module yealink compiled and installed without any problem but phone
+    is not initialized and does not react to any actions.
+:A: If you see something like:
+    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
+    in dmesg, it means that the hid driver has grabbed the device first. Try to
+    load module yealink before any other usb hid driver. Please see the
+    instructions provided by your distribution on module configuration.
+
+:Q: Phone is working now (displays version and accepts keypad input) but I can't
+    find the sysfs files.
+:A: The sysfs files are located on the particular usb endpoint. On most
+    distributions you can do: "find /sys/ -name get_icons" for a hint.
+
+
 Credits & Acknowledgments
 =========================
 
diff --git a/Documentation/input/gamepad.rst b/Documentation/input/gamepad.rst
index 1bc4555c0ccb..4d5e7fb80a84 100644
--- a/Documentation/input/gamepad.rst
+++ b/Documentation/input/gamepad.rst
@@ -1,12 +1,12 @@
------------------
-Linux Gamepad API
------------------
+---------------------------
+Linux Gamepad Specification
+---------------------------
 
 :Author: 2013 by David Herrmann <dh.herrmann@gmail.com>
 
 
-Intro
-~~~~~
+Introduction
+~~~~~~~~~~~~
 Linux provides many different input drivers for gamepad hardware. To avoid
 having user-space deal with different button-mappings for each gamepad, this
 document defines how gamepads are supposed to report their data.
diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index b25a67198a65..7a3e71c2bd00 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -8,42 +8,9 @@ Contents:
    :maxdepth: 2
    :numbered:
 
-   input
-   input-programming
-   event-codes
-   joydev/index
-   multi-touch-protocol
-   gamepad
-   gameport-programming
-   ff
-   notifier
-   userio
-
-Input drivers
-=============
-
-.. toctree::
-   :maxdepth: 2
-   :numbered:
-
-   alps
-   amijoy
-   appletouch
-   atarikbd
-   bcm5974
-   cma3000_d0x
-   cs461x
-   edt-ft5x06
-   elantech
-   iforce-protocol
-   joystick-parport
-   gpio-tilt
-   ntrig
-   rotary-encoder
-   sentelic
-   walkera0701
-   xpad
-   yealink
+   input_uapi
+   input_kapi
+   devices/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/input/input-programming.rst b/Documentation/input/input-programming.rst
index 4d3b22222e93..57dbab652cfa 100644
--- a/Documentation/input/input-programming.rst
+++ b/Documentation/input/input-programming.rst
@@ -1,7 +1,4 @@
-~~~~~~~~~~~~~~~~~~~~~~~~~
-Programming input drivers
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
+===============================
 Creating an input device driver
 ===============================
 
diff --git a/Documentation/input/input_kapi.rst b/Documentation/input/input_kapi.rst
new file mode 100644
index 000000000000..41f1b7e6b78e
--- /dev/null
+++ b/Documentation/input/input_kapi.rst
@@ -0,0 +1,17 @@
+.. include:: <isonum.txt>
+
+################################
+Linux Input Subsystem kernel API
+################################
+
+.. class:: toc-title
+
+        Table of Contents
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   input-programming
+   gameport-programming
+   notifier
diff --git a/Documentation/input/input_uapi.rst b/Documentation/input/input_uapi.rst
new file mode 100644
index 000000000000..12ef8974a773
--- /dev/null
+++ b/Documentation/input/input_uapi.rst
@@ -0,0 +1,21 @@
+.. include:: <isonum.txt>
+
+###################################
+Linux Input Subsystem userspace API
+###################################
+
+.. class:: toc-title
+
+        Table of Contents
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   input
+   event-codes
+   multi-touch-protocol
+   gamepad
+   ff
+   joydev/index
+   userio
-- 
2.12.2.762.g0e3151a226-goog
