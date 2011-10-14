From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH v2] hid: flesh out support for tivo slide remote
Date: Fri, 14 Oct 2011 16:57:42 -0400
Message-ID: <1318625862-26833-1-git-send-email-jarod@redhat.com>
References: <alpine.LNX.2.00.1110141942290.14768@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab1JNU6M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 16:58:12 -0400
In-Reply-To: <alpine.LNX.2.00.1110141942290.14768@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, Jiri Kosina <jkosina@suse.cz>

This patch finishes off adding full support for the TiVo Slide remote,
which is a mostly pure HID device from the perspective of the kernel.
There are a few mappings that use a vendor-specific usage page, and a
few keys in the consumer usage page that I think make sense to remap
slightly, to better fit their key labels' intended use. Doing this in a
stand-alone hid-tivo.c makes the modifications only matter for this
specific device.

What's actually connected to the computer is a Broadcom-made usb dongle,
which has an embedded hub, bluetooth adapter, mouse and keyboard
devices. You pair with the dongle, then the remote sends data that its
converted into HID on the keyboard interface (the mouse interface
doesn't do anything interesting, so far as I can tell).

lsusb for this device:
Bus 004 Device 005: ID 0a5c:2190 Broadcom Corp.
Bus 004 Device 004: ID 0a5c:4503 Broadcom Corp.
Bus 004 Device 003: ID 150a:1201
Bus 004 Device 002: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)

Speaking of the keyboard interface, the remote actually does contain a
keyboard as well. The top slides away, revealing a reasonably functional
qwerty keyboard (not unlike many slide cell phones), thus the product
name.

Applies cleanly to hid master, tested w/a 2.6.38.3-based Fedora kernel
and a 2.6.32-based Red Hat Enterprise Linux 6 kernel.

v2: add missing entry to hid_have_special_driver list

CC: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/hid/Kconfig    |    6 +++
 drivers/hid/Makefile   |    1 +
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    3 ++
 drivers/hid/hid-tivo.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-tivo.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1130a89..cee927b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -549,6 +549,12 @@ config SMARTJOYPLUS_FF
 	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
 	enable force feedback support for it.
 
+config HID_TIVO_SLIDE
+	tristate "TiVo Slide Bluetooth remote control support"
+	depends on USB_HID
+	---help---
+	Say Y if you have a TiVo Slide Bluetooth remote control.
+
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0a0a38e..3610001 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
+obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 242353d..c17eb2c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1488,6 +1488,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID_TOPSEED2_RF_COMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOUCH_INTL, USB_DEVICE_ID_TOUCH_INTL_MULTI_TOUCH) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7484e1b..8359808 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -616,6 +616,9 @@
 
 #define USB_VENDOR_ID_THRUSTMASTER	0x044f
 
+#define USB_VENDOR_ID_TIVO		0x150a
+#define USB_DEVICE_ID_TIVO_SLIDE	0x1201
+
 #define USB_VENDOR_ID_TOPSEED		0x0766
 #define USB_DEVICE_ID_TOPSEED_CYBERLINK	0x0204
 
diff --git a/drivers/hid/hid-tivo.c b/drivers/hid/hid-tivo.c
new file mode 100644
index 0000000..3d43c06
--- /dev/null
+++ b/drivers/hid/hid-tivo.c
@@ -0,0 +1,89 @@
+/*
+ *  HID driver for TiVo Slide Bluetooth remote
+ *
+ *  Copyright (c) 2011 Jarod Wilson <jarod@redhat.com>
+ *  based on the hid-topseed driver, which is in turn, based on hid-cherry...
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define HID_UP_TIVOVENDOR	0xffff0000
+#define tivo_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
+					EV_KEY, (c))
+
+static int tivo_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	switch (usage->hid & HID_USAGE_PAGE) {
+	case HID_UP_TIVOVENDOR:
+		switch (usage->hid & HID_USAGE) {
+		/* TiVo button */
+		case 0x3d: tivo_map_key_clear(KEY_MEDIA);	break;
+		/* Live TV */
+		case 0x3e: tivo_map_key_clear(KEY_TV);		break;
+		/* Red thumbs down */
+		case 0x41: tivo_map_key_clear(KEY_KPMINUS);	break;
+		/* Green thumbs up */
+		case 0x42: tivo_map_key_clear(KEY_KPPLUS);	break;
+		default:
+			return 0;
+		}
+		break;
+	case HID_UP_CONSUMER:
+		switch (usage->hid & HID_USAGE) {
+		/* Enter/Last (default mapping: KEY_LAST) */
+		case 0x083: tivo_map_key_clear(KEY_ENTER);	break;
+		/* Info (default mapping: KEY_PROPS) */
+		case 0x209: tivo_map_key_clear(KEY_INFO);	break;
+		default:
+			return 0;
+		}
+		break;
+	default:
+		return 0;
+	}
+
+	/* This means we found a matching mapping here, else, look in the
+	 * standard hid mappings in hid-input.c */
+	return 1;
+}
+
+static const struct hid_device_id tivo_devices[] = {
+	/* TiVo Slide Bluetooth remote, pairs with a Broadcom dongle */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, tivo_devices);
+
+static struct hid_driver tivo_driver = {
+	.name = "tivo_slide",
+	.id_table = tivo_devices,
+	.input_mapping = tivo_input_mapping,
+};
+
+static int __init tivo_init(void)
+{
+	return hid_register_driver(&tivo_driver);
+}
+
+static void __exit tivo_exit(void)
+{
+	hid_unregister_driver(&tivo_driver);
+}
+
+module_init(tivo_init);
+module_exit(tivo_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jarod Wilson <jarod@redhat.com>");
-- 
1.7.1

