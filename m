From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 04/33] docs: input/appletouch: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:47 -0300
Message-ID: <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35465 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdDASQl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:41 -0400
In-Reply-To: <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/appletouch.txt | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/input/appletouch.txt b/Documentation/input/appletouch.txt
index b13de3f89108..8d4c1ac4e3f7 100644
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
@@ -27,9 +32,9 @@ In X11, you can configure the touchpad to use the synaptics X11 driver, which
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
         	Identifier      "Synaptics Touchpad"
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


