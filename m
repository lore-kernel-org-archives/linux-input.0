From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: mark {corgi,spitz,tosa}kbd driver deprecated
Date: Thu, 4 Feb 2010 16:31:52 -0800
Message-ID: <f17812d71002041631o25e63574t4cf13d21dc759dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.221.202]:50971 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866Ab0BEAcO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Feb 2010 19:32:14 -0500
Received: by qyk40 with SMTP id 40so1539544qyk.14
        for <linux-input@vger.kernel.org>; Thu, 04 Feb 2010 16:32:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

commit a527bd8d900b77aa48fbc117b28f678e937275d7
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Thu Feb 4 16:25:19 2010 -0800

    input: mark {corgi,spitz,tosa}kbd driver deprecated

    Provided that now keyboards on these devices are now fully supported
    by generic GPIO based matrix keypad driver, mark these hardcoded, and
    difficult to maintain drivers deprecated in favour of this.

    Cc: Richard Purdie <rpurdie@rpsys.net>
    Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/Documentation/feature-removal-schedule.txt
b/Documentation/feature-removal-schedule.txt
index 0a46833..5860583 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -542,3 +542,15 @@ Why:	Duplicate functionality with the gspca_zc3xx
driver, zc0301 only
 	sensors) wich are also supported by the gspca_zc3xx driver
 	(which supports 53 USB-ID's in total)
 Who:	Hans de Goede <hdegoede@redhat.com>
+
+----------------------------
+
+What:	corgikbd, spitzkbd, tosakbd driver
+When:	2.6.35
+Files:	drivers/input/keyboard/{corgi,spitz,tosa}kbd.c
+Why:	We now have a generic GPIO based matrix keyboard driver that
+	are fully capable of handling all the keys on these devices.
+	The original drivers manipulate the GPIO registers directly
+	and so are difficult to maintain.
+Who:	Eric Miao <eric.y.miao@gmail.com>
+
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 02c836e..3d131cc 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -144,13 +144,16 @@ config KEYBOARD_BFIN
 	  module will be called bf54x-keys.

 config KEYBOARD_CORGI
-	tristate "Corgi keyboard"
+	tristate "Corgi keyboard (deprecated)"
 	depends on PXA_SHARPSL
 	default y
 	help
 	  Say Y here to enable the keyboard on the Sharp Zaurus SL-C7xx
 	  series of PDAs.

+	  This driver is now deprecated, use generic GPIO based matrix
+	  keyboard driver instead.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called corgikbd.

@@ -329,13 +332,16 @@ config KEYBOARD_PXA930_ROTARY
 	  module will be called pxa930_rotary.

 config KEYBOARD_SPITZ
-	tristate "Spitz keyboard"
+	tristate "Spitz keyboard (deprecated)"
 	depends on PXA_SHARPSL
 	default y
 	help
 	  Say Y here to enable the keyboard on the Sharp Zaurus SL-C1000,
 	  SL-C3000 and Sl-C3100 series of PDAs.

+	  This driver is now deprecated, use generic GPIO based matrix
+	  keyboard driver instead.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called spitzkbd.

@@ -402,12 +408,15 @@ config KEYBOARD_TWL4030
 	  module will be called twl4030_keypad.

 config KEYBOARD_TOSA
-	tristate "Tosa keyboard"
+	tristate "Tosa keyboard (deprecated)"
 	depends on MACH_TOSA
 	default y
 	help
 	  Say Y here to enable the keyboard on the Sharp Zaurus SL-6000x (Tosa)

+	  This driver is now deprecated, use generic GPIO based matrix
+	  keyboard driver instead.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called tosakbd.
