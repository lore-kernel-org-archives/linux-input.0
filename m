From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Thu, 18 Feb 2010 14:50:16 +0200
Message-ID: <1266497417.4787.2923.camel@tema>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
	 <alpine.LNX.2.00.1002171333460.30967@pobox.suse.cz>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yeSi/UqE444FNhVmWtjs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49394 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab0BRMu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 07:50:29 -0500
In-Reply-To: <alpine.LNX.2.00.1002171333460.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--=-yeSi/UqE444FNhVmWtjs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2010-02-17 at 13:41 +0100, ext Jiri Kosina wrote:
> On Wed, 17 Feb 2010, Jari Vanhala wrote:
> As the device doesn't seem to be registering itself on the HID bus at all, 
> I am not sure we want to put it together with all the HID drivers. Maybe 
> drivers/input/misc would be more appropriate?

I felt like I forgot something.. Well, moving it to input/misc is easy
(commit attached), but I (still) wanted to try getting it to use
hid-functions. Results weren't that nice. Looking hid-core just shows,
it's thought to connect (hotplug) usb or bt devices and i2c doesn't fit
nicely to that. Making it to use hid_allocate_device(), hid_connect()
etc takes actually more code..

Leaving it as-is in hid would look little odd, so probably moving it to
drivers/input/misc is best thing. What you think? Dmitry?

	++Jam


--=-yeSi/UqE444FNhVmWtjs
Content-Disposition: attachment; filename="hidmove"
Content-Type: text/plain; name="hidmove"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

    Input: Change hid to misc
    
    Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>

----------------------------- drivers/hid/Kconfig -----------------------------
index 9bb4e0a..71d4c07 100644
@@ -372,14 +372,6 @@ config ZEROPLUS_FF
 	  Say Y here if you have a Zeroplus based game controller and want
 	  to have force feedback support for it.
 
-config HID_TWL4030_VIBRA
-	tristate "HID Support for TWL4030 Vibrator"
-	depends on TWL4030_CORE
-	select TWL4030_CODEC
-	select INPUT_FF_MEMLESS
-	---help---
-	  This option enables support for TWL4030 Vibrator Driver.
-
 endmenu
 
 endif # HID_SUPPORT

----------------------------- drivers/hid/Makefile -----------------------------
index 192cde6..0b2618f 100644
@@ -55,7 +55,6 @@ obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
-obj-$(CONFIG_HID_TWL4030_VIBRA)	+= hid-twl4030-vibra.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/

-------------------------- drivers/input/misc/Kconfig --------------------------
index 16ec523..2646ce8 100644
@@ -204,6 +204,14 @@ config INPUT_TWL4030_PWRBUTTON
 	  To compile this driver as a module, choose M here. The module will
 	  be called twl4030_pwrbutton.
 
+config INPUT_TWL4030_VIBRA
+	tristate "Support for TWL4030 Vibrator"
+	depends on TWL4030_CORE
+	select TWL4030_CODEC
+	select INPUT_FF_MEMLESS
+	help
+	  This option enables support for TWL4030 Vibrator Driver.
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	help

------------------------- drivers/input/misc/Makefile -------------------------
index a8b8485..1ab002e 100644
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
+obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o

---------------------- drivers/input/misc/twl4030-vibra.c ----------------------
similarity index 97%
rename from drivers/hid/hid-twl4030-vibra.c
rename to drivers/input/misc/twl4030-vibra.c
index 1009dfb..4fa4c33 100644
@@ -1,11 +1,11 @@
 /*
- * hid-twl4030-vibra.c - TWL4030 Vibrator driver
+ * twl4030-vibra.c - TWL4030 Vibrator driver
  *
  * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Henrik Saari <henrik.saari@nokia.com>
  * Updates by Felipe Balbi <felipe.balbi@nokia.com>
- * HID by Jari Vanhala <ext-jari.vanhala@nokia.com>
+ * Input by Jari Vanhala <ext-jari.vanhala@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -29,8 +29,6 @@
 #include <linux/workqueue.h>
 #include <linux/i2c/twl.h>
 #include <linux/mfd/twl4030-codec.h>
-
-#include <linux/hid.h>
 #include <linux/input.h>
 
 /* MODULE ID2 */
@@ -287,6 +285,6 @@ module_exit(twl4030_vibra_exit);
 
 MODULE_ALIAS("platform:twl4030_codec_vibra");
 
-MODULE_DESCRIPTION("HID TWL4030 Vibra driver");
+MODULE_DESCRIPTION("TWL4030 Vibra driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nokia Corporation");

--=-yeSi/UqE444FNhVmWtjs--

