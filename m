From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH] hid: flesh out support for tivo slide remote
Date: Tue, 24 May 2011 13:54:16 -0400
Message-ID: <1306259656-11391-1-git-send-email-jarod@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229Ab1EXRyb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 13:54:31 -0400
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

CC: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/hid/Kconfig    |    6 +++
 drivers/hid/Makefile   |    1 +
 drivers/hid/hid-ids.h  |    3 ++
 drivers/hid/hid-tivo.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-tivo.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2560f01..30a8cfd 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -492,6 +492,12 @@ config SMARTJOYPLUS_FF
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
index 6efc2a0..7c1efa3 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_HID_STANTUM)	+= hid-stantum.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
+obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ca32ecb..9316df0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -536,6 +536,9 @@
 
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

