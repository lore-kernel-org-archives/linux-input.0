From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 8/8] Input: docs - freshen up introduction
Date: Sat, 15 Apr 2017 22:11:45 -0700
Message-ID: <20170416051145.13618-8-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

Stop saying that API is experimental and that only USB is supported,
acknowledge that evdev is the preferred interface, and remove paragraph
encouraging people sending snail mail to Vojtech :) along with his email.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/event-codes.rst         |   2 +
 Documentation/input/input.rst               | 253 +++++++++++++---------------
 Documentation/input/joydev/joystick-api.rst |   2 +
 Documentation/input/joydev/joystick.rst     |   2 +
 4 files changed, 127 insertions(+), 132 deletions(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index 92db50954169..00b88f113bda 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -1,3 +1,5 @@
+.. _input-event-codes:
+
 =================
 Input event codes
 =================
diff --git a/Documentation/input/input.rst b/Documentation/input/input.rst
index ac7669ad3e76..3b3a22975106 100644
--- a/Documentation/input/input.rst
+++ b/Documentation/input/input.rst
@@ -1,25 +1,20 @@
 .. include:: <isonum.txt>
 
-===================
-Linux Input drivers
-===================
+============
+Introduction
+============
 
 :Copyright: |copy| 1999-2001 Vojtech Pavlik <vojtech@ucw.cz> - Sponsored by SuSE
 
-Should you need to contact me, the author, you can do so either by e-mail
-- mail your message to <vojtech@ucw.cz>, or by paper mail: Vojtech Pavlik,
-Simunkova 1594, Prague 8, 182 00 Czech Republic
-
-Introduction
+Architecture
 ============
 
-This is a collection of drivers that is designed to support all input
-devices under Linux. While it is currently used only on for USB input
-devices, future use (say 2.5/2.6) is expected to expand to replace
-most of the existing input system, which is why it lives in
-drivers/input/ instead of drivers/usb/.
+Input subsystem  a collection of drivers that is designed to support
+all input devices under Linux. Most of the drivers reside in
+drivers/input, although quite a few live in drivers/hid and
+drivers/platform.
 
-The centre of the input drivers is the input module, which must be
+The core of the input subsystem is the input module, which must be
 loaded before any other of the input modules - it serves as a way of
 communication between two groups of modules:
 
@@ -32,9 +27,9 @@ events (keystrokes, mouse movements) to the input module.
 Event handlers
 --------------
 
-These modules get events from input and pass them where needed via
-various interfaces - keystrokes to the kernel, mouse movements via a
-simulated PS/2 interface to GPM and X and so on.
+These modules get events from input core and pass them where needed
+via various interfaces - keystrokes to the kernel, mouse movements via
+a simulated PS/2 interface to GPM and X, and so on.
 
 Simple Usage
 ============
@@ -45,19 +40,18 @@ kernel)::
 
 	input
 	mousedev
-	keybdev
 	usbcore
 	uhci_hcd or ohci_hcd or ehci_hcd
 	usbhid
+	hid_generic
 
 After this, the USB keyboard will work straight away, and the USB mouse
 will be available as a character device on major 13, minor 63::
 
 	crw-r--r--   1 root     root      13,  63 Mar 28 22:45 mice
 
-This device has to be created.
-
-The commands to create it by hand are::
+This device usually created automatically by the system. The commands
+to create it by hand are::
 
 	cd /dev
 	mkdir input
@@ -81,100 +75,50 @@ When you do all of the above, you can use your USB mouse and keyboard.
 Detailed Description
 ====================
 
-Device drivers
+Event handlers
 --------------
 
-Device drivers are the modules that generate events. The events are
-however not useful without being handled, so you also will need to use some
-of the modules from section 3.2.
-
-usbhid
-~~~~~~
-
-usbhid is the largest and most complex driver of the whole suite. It
-handles all HID devices, and because there is a very wide variety of them,
-and because the USB HID specification isn't simple, it needs to be this big.
-
-Currently, it handles USB mice, joysticks, gamepads, steering wheels
-keyboards, trackballs and digitizers.
-
-However, USB uses HID also for monitor controls, speaker controls, UPSs,
-LCDs and many other purposes.
-
-The monitor and speaker controls should be easy to add to the hid/input
-interface, but for the UPSs and LCDs it doesn't make much sense. For this,
-the hiddev interface was designed. See Documentation/hid/hiddev.txt
-for more information about it.
-
-The usage of the usbhid module is very simple, it takes no parameters,
-detects everything automatically and when a HID device is inserted, it
-detects it appropriately.
-
-However, because the devices vary wildly, you might happen to have a
-device that doesn't work well. In that case #define DEBUG at the beginning
-of hid-core.c and send me the syslog traces.
+Event handlers distribute the events from the devices to userspace and
+in-kernel consumers, as needed.
 
-usbmouse
-~~~~~~~~
-
-For embedded systems, for mice with broken HID descriptors and just any
-other use when the big usbhid wouldn't be a good choice, there is the
-usbmouse driver. It handles USB mice only. It uses a simpler HIDBP
-protocol. This also means the mice must support this simpler protocol. Not
-all do. If you don't have any strong reason to use this module, use usbhid
-instead.
-
-usbkbd
-~~~~~~
-
-Much like usbmouse, this module talks to keyboards with a simplified
-HIDBP protocol. It's smaller, but doesn't support any extra special keys.
-Use usbhid instead if there isn't any special reason to use this.
-
-wacom
+evdev
 ~~~~~
 
-This is a driver for Wacom Graphire and Intuos tablets. Not for Wacom
-PenPartner, that one is handled by the HID driver. Although the Intuos and
-Graphire tablets claim that they are HID tablets as well, they are not and
-thus need this specific driver.
+``evdev`` is the generic input event interface. It passes the events
+generated in the kernel straight to the program, with timestamps. The
+event codes are the same on all architectures and are hardware
+independent.
 
-iforce
-~~~~~~
+This is the preferred interface for userspace to consume user
+input, and all clients are encouraged to use it.
 
-A driver for I-Force joysticks and wheels, both over USB and RS232.
-It includes ForceFeedback support now, even though Immersion
-Corp. considers the protocol a trade secret and won't disclose a word
-about it.
+See :ref:`event-interface` for notes on API.
 
-Event handlers
---------------
+The devices are in /dev/input::
 
-Event handlers distribute the events from the devices to userland and
-kernel, as needed.
+	crw-r--r--   1 root     root      13,  64 Apr  1 10:49 event0
+	crw-r--r--   1 root     root      13,  65 Apr  1 10:50 event1
+	crw-r--r--   1 root     root      13,  66 Apr  1 10:50 event2
+	crw-r--r--   1 root     root      13,  67 Apr  1 10:50 event3
+	...
 
-keybdev
-~~~~~~~
+There are two ranges of minors: 64 through 95 is the static legacy
+range. If there are more than 32 input devices in a system, additional
+evdev nodes are created with minors starting with 256.
 
-keybdev is currently a rather ugly hack that translates the input
-events into architecture-specific keyboard raw mode (Xlated AT Set2 on
-x86), and passes them into the handle_scancode function of the
-keyboard.c module. This works well enough on all architectures that
-keybdev can generate rawmode on, other architectures can be added to
-it.
+keyboard
+~~~~~~~~
 
-The right way would be to pass the events to keyboard.c directly,
-best if keyboard.c would itself be an event handler. This is done in
-the input patch, available on the webpage mentioned below.
+``keyboard`` is in-kernel input handler ad is a part of VT code. It
+consumes keyboard keystrokes and handles user input for VT consoles.
 
 mousedev
 ~~~~~~~~
 
-mousedev is also a hack to make programs that use mouse input
+``mousedev`` is a hack to make legacy programs that use mouse input
 work. It takes events from either mice or digitizers/tablets and makes
 a PS/2-style (a la /dev/psaux) mouse device available to the
-userland. Ideally, the programs could use a more reasonable interface,
-for example evdev
+userland.
 
 Mousedev devices in /dev/input (as shown above) are::
 
@@ -190,8 +134,9 @@ Mousedev devices in /dev/input (as shown above) are::
 Each ``mouse`` device is assigned to a single mouse or digitizer, except
 the last one - ``mice``. This single character device is shared by all
 mice and digitizers, and even if none are connected, the device is
-present.  This is useful for hotplugging USB mice, so that programs
-can open the device even when no mice are present.
+present.  This is useful for hotplugging USB mice, so that older programs
+that do not handle hotplug can open the device even when no mice are
+present.
 
 CONFIG_INPUT_MOUSEDEV_SCREEN_[XY] in the kernel configuration are
 the size of your screen (in pixels) in XFree86. This is needed if you
@@ -208,11 +153,10 @@ mouse and ExplorerPS/2 if you want to use extra (up to 5) buttons.
 joydev
 ~~~~~~
 
-Joydev implements v0.x and v1.x Linux joystick api, much like
-drivers/char/joystick/joystick.c used to in earlier versions. See
-joystick-api.txt in the Documentation subdirectory for details.  As
-soon as any joystick is connected, it can be accessed in /dev/input
-on::
+``joydev`` implements v0.x and v1.x Linux joystick API. See
+:ref:`joystick-api` for details.
+
+As soon as any joystick is connected, it can be accessed in /dev/input on::
 
 	crw-r--r--   1 root     root      13,   0 Apr  1 10:50 js0
 	crw-r--r--   1 root     root      13,   1 Apr  1 10:50 js1
@@ -220,56 +164,99 @@ on::
 	crw-r--r--   1 root     root      13,   3 Apr  1 10:50 js3
 	...
 
-And so on up to js31.
+And so on up to js31 in legacy range, and additional nodes with minors
+above 256 if there are more joystick devices.
 
-evdev
-~~~~~
+Device drivers
+--------------
 
-evdev is the generic input event interface. It passes the events
-generated in the kernel straight to the program, with timestamps. The
-API is still evolving, but should be usable now. It's described in
-section 5.
+Device drivers are the modules that generate events.
 
-This should be the way for GPM and X to get keyboard and mouse
-events. It allows for multihead in X without any specific multihead
-kernel support. The event codes are the same on all architectures and
-are hardware independent.
+hid-generic
+~~~~~~~~~~~
 
-The devices are in /dev/input::
+``hid-generic`` is one of the largest and most complex driver of the
+whole suite. It handles all HID devices, and because there is a very
+wide variety of them, and because the USB HID specification isn't
+simple, it needs to be this big.
 
-	crw-r--r--   1 root     root      13,  64 Apr  1 10:49 event0
-	crw-r--r--   1 root     root      13,  65 Apr  1 10:50 event1
-	crw-r--r--   1 root     root      13,  66 Apr  1 10:50 event2
-	crw-r--r--   1 root     root      13,  67 Apr  1 10:50 event3
-	...
+Currently, it handles USB mice, joysticks, gamepads, steering wheels
+keyboards, trackballs and digitizers.
+
+However, USB uses HID also for monitor controls, speaker controls, UPSs,
+LCDs and many other purposes.
+
+The monitor and speaker controls should be easy to add to the hid/input
+interface, but for the UPSs and LCDs it doesn't make much sense. For this,
+the hiddev interface was designed. See Documentation/hid/hiddev.txt
+for more information about it.
+
+The usage of the usbhid module is very simple, it takes no parameters,
+detects everything automatically and when a HID device is inserted, it
+detects it appropriately.
 
-And so on up to event31.
+However, because the devices vary wildly, you might happen to have a
+device that doesn't work well. In that case #define DEBUG at the beginning
+of hid-core.c and send me the syslog traces.
+
+usbmouse
+~~~~~~~~
+
+For embedded systems, for mice with broken HID descriptors and just any
+other use when the big usbhid wouldn't be a good choice, there is the
+usbmouse driver. It handles USB mice only. It uses a simpler HIDBP
+protocol. This also means the mice must support this simpler protocol. Not
+all do. If you don't have any strong reason to use this module, use usbhid
+instead.
+
+usbkbd
+~~~~~~
+
+Much like usbmouse, this module talks to keyboards with a simplified
+HIDBP protocol. It's smaller, but doesn't support any extra special keys.
+Use usbhid instead if there isn't any special reason to use this.
+
+psmouse
+~~~~~~~
+
+This is driver for all flavors of pointing devices using PS/2
+protocol, including Synaptics and ALPS touchpads, Intellimouse
+Explorer devices, Logitech PS/2 mice and so on.
+
+atkbd
+~~~~~
+
+This is driver for PS/2 (AT) keyboards.
+
+iforce
+~~~~~~
+
+A driver for I-Force joysticks and wheels, both over USB and RS232.
+It includes Force Feedback support now, even though Immersion
+Corp. considers the protocol a trade secret and won't disclose a word
+about it.
 
 Verifying if it works
 =====================
 
 Typing a couple keys on the keyboard should be enough to check that
-a USB keyboard works and is correctly connected to the kernel keyboard
+a keyboard works and is correctly connected to the kernel keyboard
 driver.
 
 Doing a ``cat /dev/input/mouse0`` (c, 13, 32) will verify that a mouse
 is also emulated; characters should appear if you move it.
 
 You can test the joystick emulation with the ``jstest`` utility,
-available in the joystick package (see Documentation/input/joystick.txt).
+available in the joystick package (see :ref:`joystick-doc`).
 
-You can test the event devices with the ``evtest`` utility available
-in the LinuxConsole project CVS archive (see the URL below).
+You can test the event devices with the ``evtest`` utility.
+
+.. _event-interface:
 
 Event interface
 ===============
 
-Should you want to add event device support into any application (X, gpm,
-svgalib ...) I <vojtech@ucw.cz> will be happy to provide you any help I
-can. Here goes a description of the current state of things, which is going
-to be extended, but not changed incompatibly as time goes:
-
-You can use blocking and nonblocking reads, also select() on the
+You can use blocking and nonblocking reads, and also select() on the
 /dev/input/eventX devices, and you'll always get a whole number of input
 events on a read. Their layout is::
 
@@ -290,3 +277,5 @@ list is in include/uapi/linux/input-event-codes.h.
 ``value`` is the value the event carries. Either a relative change for
 EV_REL, absolute new value for EV_ABS (joysticks ...), or 0 for EV_KEY for
 release, 1 for keypress and 2 for autorepeat.
+
+See :ref:`input-event-codes` for more information about various even codes.
diff --git a/Documentation/input/joydev/joystick-api.rst b/Documentation/input/joydev/joystick-api.rst
index 42edcfc6e8af..95803e2e8cd0 100644
--- a/Documentation/input/joydev/joystick-api.rst
+++ b/Documentation/input/joydev/joystick-api.rst
@@ -1,3 +1,5 @@
+.. _joystick-api:
+
 =====================
 Programming Interface
 =====================
diff --git a/Documentation/input/joydev/joystick.rst b/Documentation/input/joydev/joystick.rst
index b90705eb69b1..9746fd76cc58 100644
--- a/Documentation/input/joydev/joystick.rst
+++ b/Documentation/input/joydev/joystick.rst
@@ -1,5 +1,7 @@
 .. include:: <isonum.txt>
 
+.. _joystick-doc:
+
 Introduction
 ============
 
-- 
2.12.2.762.g0e3151a226-goog

