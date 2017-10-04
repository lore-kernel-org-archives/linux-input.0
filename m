From: nolsen@jabra.com
Subject: [PATCH v2] HID: Add special driver for Jabra devices
Date: Wed,  4 Oct 2017 12:31:22 +0200
Message-ID: <1507113082-31678-1-git-send-email-nolsen@jabra.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prime.nsonet.eu ([178.63.75.197]:49505 "EHLO prime.nsonet.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdJDKbp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Oct 2017 06:31:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, Niels Skou Olsen <nolsen@jabra.com>

From: Niels Skou Olsen <nolsen@jabra.com>

Add a hid-jabra driver to the list of special drivers in hid-core. The
driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
from being mapped to input events, that become unintended mouse events
in the X11 server.

Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
---
v2: Rebase on patch set "Quirks cleanup and hid-generic niceness", v2
    (http://www.spinics.net/lists/linux-input/msg53428.html)
---

 drivers/hid/Kconfig      | 11 +++++++++
 drivers/hid/Makefile     |  1 +
 drivers/hid/hid-jabra.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c |  3 +++
 4 files changed, 73 insertions(+)
 create mode 100644 drivers/hid/hid-jabra.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d95c1ab..429e53e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -395,6 +395,17 @@ config HID_ITE
 	---help---
 	Support for ITE devices not fully compliant with HID standard.
 
+config HID_JABRA
+	tristate "Jabra USB HID Driver"
+	depends on HID
+	---help---
+	Support for Jabra USB HID devices.
+
+	Prevents mapping of vendor defined HID usages to input events. Without
+	this driver HID	reports from Jabra devices may incorrectly be seen as
+	mouse button events.
+	Say M here if you may ever plug in a Jabra USB device.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 276094b5..0ba44d9 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
 obj-$(CONFIG_HID_ITE)		+= hid-ite.o
+obj-$(CONFIG_HID_JABRA)		+= hid-jabra.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
diff --git a/drivers/hid/hid-jabra.c b/drivers/hid/hid-jabra.c
new file mode 100644
index 0000000..1f52daf
--- /dev/null
+++ b/drivers/hid/hid-jabra.c
@@ -0,0 +1,58 @@
+/*
+ *  Jabra USB HID Driver
+ *
+ *  Copyright (c) 2017 Niels Skou Olsen <nolsen@jabra.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define HID_UP_VENDOR_DEFINED_MIN	0xff000000
+#define HID_UP_VENDOR_DEFINED_MAX	0xffff0000
+
+static int jabra_input_mapping(struct hid_device *hdev,
+			       struct hid_input *hi,
+			       struct hid_field *field,
+			       struct hid_usage *usage,
+			       unsigned long **bit, int *max)
+{
+	int is_vendor_defined =
+		((usage->hid & HID_USAGE_PAGE) >= HID_UP_VENDOR_DEFINED_MIN &&
+		 (usage->hid & HID_USAGE_PAGE) <= HID_UP_VENDOR_DEFINED_MAX);
+
+	dbg_hid("hid=0x%08x appl=0x%08x coll_idx=0x%02x usage_idx=0x%02x: %s\n",
+		usage->hid,
+		field->application,
+		usage->collection_index,
+		usage->usage_index,
+		is_vendor_defined ? "ignored" : "defaulted");
+
+	/* Ignore vendor defined usages, default map standard usages */
+	return is_vendor_defined ? -1 : 0;
+}
+
+static const struct hid_device_id jabra_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, jabra_devices);
+
+static struct hid_driver jabra_driver = {
+	.name = "jabra",
+	.id_table = jabra_devices,
+	.input_mapping = jabra_input_mapping,
+};
+module_hid_driver(jabra_driver);
+
+MODULE_AUTHOR("Niels Skou Olsen <nolsen@jabra.com>");
+MODULE_DESCRIPTION("Jabra USB HID Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 69a0e0b..9e9518d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -381,6 +381,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_ICADE)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 #endif
+#if IS_ENABLED(CONFIG_HID_JABRA)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
+#endif
 #if IS_ENABLED(CONFIG_HID_KENSINGTON)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 #endif
-- 
2.7.4

