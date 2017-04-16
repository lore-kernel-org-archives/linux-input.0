From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/8] Input: docs - update joystick documentation a bit
Date: Sat, 15 Apr 2017 22:11:42 -0700
Message-ID: <20170416051145.13618-5-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33192 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdDPFLw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 16 Apr 2017 01:11:52 -0400
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Consolidate use instructions and userspace API notes into the same chapter;
remove completely obsolete references, move into a separate subdirectory.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/index.rst                     |  6 +-
 Documentation/input/joydev/index.rst              | 18 +++++
 Documentation/input/{ => joydev}/joystick-api.rst | 30 ++++++--
 Documentation/input/{ => joydev}/joystick.rst     | 88 ++++++-----------------
 Documentation/input/joystick-parport.rst          | 12 ++--
 5 files changed, 71 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/input/joydev/index.rst
 rename Documentation/input/{ => joydev}/joystick-api.rst (89%)
 rename Documentation/input/{ => joydev}/joystick.rst (86%)

diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 5887c79173b8..b25a67198a65 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -2,8 +2,7 @@
 The Linux Input Documentation
 =============================
 
-Core API
-========
+Contents:
 
 .. toctree::
    :maxdepth: 2
@@ -12,8 +11,7 @@ Core API
    input
    input-programming
    event-codes
-   joystick
-   joystick-api
+   joydev/index
    multi-touch-protocol
    gamepad
    gameport-programming
diff --git a/Documentation/input/joydev/index.rst b/Documentation/input/joydev/index.rst
new file mode 100644
index 000000000000..8d9666c7561c
--- /dev/null
+++ b/Documentation/input/joydev/index.rst
@@ -0,0 +1,18 @@
+.. include:: <isonum.txt>
+
+======================
+Linux Joystick support
+======================
+
+:Copyright: |copy| 1996-2000 Vojtech Pavlik <vojtech@ucw.cz> - Sponsored by SuSE
+
+.. class:: toc-title
+
+	Table of Contents
+
+.. toctree::
+	:maxdepth: 3
+	:numbered:
+
+	joystick
+	joystick-api
diff --git a/Documentation/input/joystick-api.rst b/Documentation/input/joydev/joystick-api.rst
similarity index 89%
rename from Documentation/input/joystick-api.rst
rename to Documentation/input/joydev/joystick-api.rst
index 9b9d26833086..42edcfc6e8af 100644
--- a/Documentation/input/joystick-api.rst
+++ b/Documentation/input/joydev/joystick-api.rst
@@ -1,16 +1,36 @@
-==========================
-Joystick API Documentation
-==========================
+=====================
+Programming Interface
+=====================
 
 :Author: Ragnar Hojland Espinosa <ragnar@macula.net> - 7 Aug 1998
 
+Introduction
+============
+
+.. important::
+   This document describes legacy ``js`` interface. Newer clients are
+   encouraged to switch to the generic event (``evdev``) interface.
+
+The 1.0 driver uses a new, event based approach to the joystick driver.
+Instead of the user program polling for the joystick values, the joystick
+driver now reports only any changes of its state. See joystick-api.txt,
+joystick.h and jstest.c included in the joystick package for more
+information. The joystick device can be used in either blocking or
+nonblocking mode, and supports select() calls.
+
+For backward compatibility the old (v0.x) interface is still included.
+Any call to the joystick driver using the old interface will return values
+that are compatible to the old interface. This interface is still limited
+to 2 axes, and applications using it usually decode only 2 buttons, although
+the driver provides up to 32.
+
 Initialization
 ==============
 
 Open the joystick device following the usual semantics (that is, with open).
 Since the driver now reports events instead of polling for changes,
 immediately after the open it will issue a series of synthetic events
-(JS_EVENT_INIT) that you can read to check the initial state of the
+(JS_EVENT_INIT) that you can read to obtain the initial state of the
 joystick.
 
 By default, the device is opened in blocking mode::
@@ -182,7 +202,7 @@ the actual state of the joystick.
 
 .. note::
 
- As for version 1.2.8, the queue is circular and able to hold 64
+ As of version 1.2.8, the queue is circular and able to hold 64
  events. You can increment this size bumping up JS_BUFF_SIZE in
  joystick.h and recompiling the driver.
 
diff --git a/Documentation/input/joystick.rst b/Documentation/input/joydev/joystick.rst
similarity index 86%
rename from Documentation/input/joystick.rst
rename to Documentation/input/joydev/joystick.rst
index c9c175ffc2ff..b90705eb69b1 100644
--- a/Documentation/input/joystick.rst
+++ b/Documentation/input/joydev/joystick.rst
@@ -1,56 +1,17 @@
 .. include:: <isonum.txt>
 
-============================
-Linux Joystick driver v2.0.0
-============================
-
-:Copyright: |copy| 1996-2000 Vojtech Pavlik <vojtech@ucw.cz> - Sponsored by SuSE
-
-
-Disclaimer
-==========
-
-This program is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the Free
-Software Foundation; either version 2 of the License, or (at your option)
-any later version.
-
-This program is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-more details.
-
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc., 59
-Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
-Should you need to contact me, the author, you can do so either by e-mail
-- mail your message to <vojtech@ucw.cz>, or by paper mail: Vojtech Pavlik,
-Simunkova 1594, Prague 8, 182 00 Czech Republic
-
-For your convenience, the GNU General Public License version 2 is included
-in the package: See the file COPYING.
-
-Intro
-=====
+Introduction
+============
 
 The joystick driver for Linux provides support for a variety of joysticks
 and similar devices. It is based on a larger project aiming to support all
 input devices in Linux.
 
-Should you encounter any problems while using the driver, or joysticks
-this driver can't make complete use of, I'm very interested in hearing about
-them. Bug reports and success stories are also welcome.
-
-The input project website is at:
-
-	http://atrey.karlin.mff.cuni.cz/~vojtech/input/
-
-There is also a mailing list for the driver at:
+The mailing list for the project is:
 
-	listproc@atrey.karlin.mff.cuni.cz
+	linux-input@vger.kernel.org
 
-send "subscribe linux-joystick Your Name" to subscribe to it.
+send "subscribe linux-input" to majordomo@vger.kernel.org to subscribe to it.
 
 Usage
 =====
@@ -58,18 +19,22 @@ Usage
 For basic usage you just choose the right options in kernel config and
 you should be set.
 
-inpututils
-----------
+Utilities
+---------
 
-For testing and other purposes (for example serial devices), a set of
-utilities is available at the abovementioned website. I suggest you download
-and install it before going on.
+For testing and other purposes (for example serial devices), there is a set
+of utilities, such as ``jstest``, ``jscal``, and ``evtest``,
+usually packaged as ``joystick``, ``input-utils``, ``evtest``, and so on.
+
+``inputattach`` utility is required if your joystick is connected to a
+serial port.
 
 Device nodes
 ------------
 
-For applications to be able to use the joysticks,
-you'll have to manually create these nodes in /dev::
+For applications to be able to use the joysticks, device nodes should be
+created in /dev. Normally it is done automatically by the system, but
+it can also be done by hand::
 
     cd /dev
     rm js*
@@ -166,7 +131,6 @@ And add a line to your rc script executing that file::
 This way, after the next reboot your joystick will remain calibrated. You
 can also add the ``jscal -p`` line to your shutdown script.
 
-
 HW specific driver information
 ==============================
 
@@ -467,6 +431,10 @@ future if I get an Amiga in the reach of my fingers.
 Game console and 8-bit pads and joysticks
 -----------------------------------------
 
+These pads and joysticks are not designed for PCs and other computers
+Linux runs on, and usually require a special connector for attaching
+them through a parallel port.
+
 See :ref:`joystick-parport` for more info.
 
 SpaceTec/LabTec devices
@@ -613,19 +581,3 @@ FAQ
 :Q: My joystick doesn't work with Quake / Quake 2. What's the cause?
 :A: Quake / Quake 2 don't support joystick. Use joy2key to simulate keypresses
     for them.
-
-Programming Interface
-=====================
-
-The 1.0 driver uses a new, event based approach to the joystick driver.
-Instead of the user program polling for the joystick values, the joystick
-driver now reports only any changes of its state. See joystick-api.txt,
-joystick.h and jstest.c included in the joystick package for more
-information. The joystick device can be used in either blocking or
-nonblocking mode and supports select() calls.
-
-For backward compatibility the old (v0.x) interface is still included.
-Any call to the joystick driver using the old interface will return values
-that are compatible to the old interface.  This interface is still limited
-to 2 axes, and applications using it usually decode only 2 buttons, although
-the driver provides up to 32.
diff --git a/Documentation/input/joystick-parport.rst b/Documentation/input/joystick-parport.rst
index fa8cab584793..cc2ab871e701 100644
--- a/Documentation/input/joystick-parport.rst
+++ b/Documentation/input/joystick-parport.rst
@@ -2,9 +2,9 @@
 
 .. _joystick-parport:
 
-===================================
-Linux Joystick parport drivers v2.0
-===================================
+==============================
+Parallel port Joystick Drivers
+==============================
 
 :Copyright: |copy| 1998-2000 Vojtech Pavlik <vojtech@ucw.cz>
 :Copyright: |copy| 1998 Andree Borrmann <a.borrmann@tu-bs.de>
@@ -20,8 +20,8 @@ it will be true. So, use it at your own risk. The possible damages that can
 happen include burning your parallel port, and/or the sticks and joystick
 and maybe even more. Like when a lightning kills you it is not our problem.
 
-Intro
-=====
+Introduction
+============
 
 The joystick parport drivers are used for joysticks and gamepads not
 originally designed for PCs and other computers Linux runs on. Because of
@@ -582,7 +582,7 @@ use turbografx.map2 and turbografx.map3 as additional command line parameters
 for two more interfaces.
 
 PC parallel port pinout
------------------------
+=======================
 
 ::
 
-- 
2.12.2.762.g0e3151a226-goog

