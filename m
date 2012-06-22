From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] HID: Make the HID bus visible in the Kconfig options
Date: Fri, 22 Jun 2012 11:18:51 +0200
Message-ID: <1340356731-4745-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:34577 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab2FVJQY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jun 2012 05:16:24 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 2C134CA06
	for <linux-input@vger.kernel.org>; Fri, 22 Jun 2012 11:16:22 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The HID subsystem was made a proper bus in 2008, but the config
options do not reflect this. Modify the HID and USB_HID entries
to better explain what they do.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Jiri,

As the HID subsystem moves more and more towards a regular bus, the
config options become less and less apt. This patch, for next, only
scratches the surface but hopefully in the right direction.

Cheers,
Henrik

 drivers/hid/Kconfig        |    9 +++++----
 drivers/hid/usbhid/Kconfig |    8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index fabf817..adfcc29 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -14,7 +14,7 @@ menuconfig HID_SUPPORT
 if HID_SUPPORT
 
 config HID
-	tristate "Generic HID support"
+	tristate "HID bus support"
 	depends on INPUT
 	default y
 	---help---
@@ -23,9 +23,10 @@ config HID
 	  most commonly used to refer to the USB-HID specification, but other
 	  devices (such as, but not strictly limited to, Bluetooth) are
 	  designed using HID specification (this involves certain keyboards,
-	  mice, tablets, etc). This option compiles into kernel the generic
-	  HID layer code (parser, usages, etc.), which can then be used by
-	  transport-specific HID implementation (like USB or Bluetooth).
+	  mice, tablets, etc). This option adds the HID bus to the kernel,
+	  together with generic HID layer code. The HID devices are added and
+	  removed from the HID bus by the transport-layer drivers, such as
+	  usbhid (USB_HID) and hidp (BT_HIDP).
 
 	  For docs and specs, see http://www.usb.org/developers/hidpage/
 
diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
index 0f20fd1..0108c59 100644
--- a/drivers/hid/usbhid/Kconfig
+++ b/drivers/hid/usbhid/Kconfig
@@ -1,13 +1,13 @@
-comment "USB Input Devices"
+menu "USB HID support"
 	depends on USB
 
 config USB_HID
-	tristate "USB Human Interface Device (full HID) support"
+	tristate "USB HID transport layer"
 	default y
 	depends on USB && INPUT
 	select HID
 	---help---
-	  Say Y here if you want full HID support to connect USB keyboards,
+	  Say Y here if you want to connect USB keyboards,
 	  mice, joysticks, graphic tablets, or any other HID based devices
 	  to your computer via USB, as well as Uninterruptible Power Supply
 	  (UPS) and monitor control devices.
@@ -81,4 +81,4 @@ config USB_MOUSE
 
 endmenu
 
-
+endmenu
-- 
1.7.10.4

