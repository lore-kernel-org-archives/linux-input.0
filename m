From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 04/37] docs: input/appletouch: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:04 -0300
Message-ID: <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/appletouch.txt | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/input/appletouch.txt b/Documentation/input/appletouch.txt
index b13de3f89108..d56bd383d99c 100644
--- a/Documentation/input/appletouch.txt
+++ b/Documentation/input/appletouch.txt
@@ -1,12 +1,17 @@
+.. include:: <isonum.txt>
+
+----------------------------------
 Apple Touchpad Driver (appletouch)
 ----------------------------------
-	Copyright (C) 2005 Stelian Pop <stelian@popies.net>
+
+:Copyright: |copy| 2005 Stelian Pop <stelian@popies.net>
 
 appletouch is a Linux kernel driver for the USB touchpad found on post
 February 2005 and October 2005 Apple Aluminium Powerbooks.
 
-This driver is derived from Johannes Berg's appletrackpad driver[1], but it has
-been improved in some areas:
+This driver is derived from Johannes Berg's appletrackpad driver [#f1]_,
+but it has been improved in some areas:
+
 	* appletouch is a full kernel driver, no userspace program is necessary
 	* appletouch can be interfaced with the synaptics X11 driver, in order
 	  to have touchpad acceleration, scrolling, etc.
@@ -27,13 +32,13 @@ In X11, you can configure the touchpad to use the synaptics X11 driver, which
 will give additional functionalities, like acceleration, scrolling, 2 finger
 tap for middle button mouse emulation, 3 finger tap for right button mouse
 emulation, etc. In order to do this, make sure you're using a recent version of
-the synaptics driver (tested with 0.14.2, available from [2]), and configure a
-new input device in your X11 configuration file (take a look below for an
-example). For additional configuration, see the synaptics driver documentation.
+the synaptics driver (tested with 0.14.2, available from [#f2]_), and configure
+a new input device in your X11 configuration file (take a look below for an
+example). For additional configuration, see the synaptics driver documentation::
 
 	Section "InputDevice"
-        	Identifier      "Synaptics Touchpad"
-	        Driver          "synaptics"
+		Identifier      "Synaptics Touchpad"
+		Driver          "synaptics"
 		Option          "SendCoreEvents"        "true"
 		Option          "Device"                "/dev/input/mice"
 		Option          "Protocol"              "auto-dev"
@@ -73,13 +78,15 @@ the driver.
 
 You can activate debugging using the 'debug' module parameter. A value of 0
 deactivates any debugging, 1 activates tracing of invalid samples, 2 activates
-full tracing (each sample is being traced):
+full tracing (each sample is being traced)::
+
 	modprobe appletouch debug=1
 		or
 	echo "1" > /sys/module/appletouch/parameters/debug
 
-Links:
-------
 
-[1]: http://johannes.sipsolutions.net/PowerBook/touchpad/
-[2]: http://web.archive.org/web/*/http://web.telia.com/~u89404340/touchpad/index.html
+.. Links:
+
+.. [#f1] http://johannes.sipsolutions.net/PowerBook/touchpad/
+
+.. [#f2] `<http://web.archive.org/web/*/http://web.telia.com/~u89404340/touchpad/index.html>`_
-- 
2.9.3

