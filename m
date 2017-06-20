From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v5] HID: Add driver for Retrode2 joypad adapter
Date: Tue, 20 Jun 2017 18:13:37 +0200
Message-ID: <20170620161337.14492-1-hadess@hadess.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50516 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTQNm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 12:13:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>

This driver does 2 things:
 - Apply the MULTI_INPUT quirk to create separate joypad device nodes
   for each one of the 4 connectors.
 - Rename the input devices so that their names are different, and allow
   users to recognise which device corresponds to which physical port,
   including the SNES (Mario Paint) Mouse.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---

New in v5:
 - Rebased
 - Mask out SNES mouse's middle button

New in v4:
 - Add guard around special Retrode driver, so it still works
   as it used to if the driver isn't compiled in

New in v3:
 - Use devm_kasprintf()
 - Return -ENOMEM on failure

New in v2:
 - Removed error paths in probe
 - Added device to hid_have_special_driver
 - Mark N64 ports as using the same device as the SNES joypads

 drivers/hid/Kconfig       |   8 ++++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-core.c    |   3 ++
 drivers/hid/hid-ids.h     |   3 ++
 drivers/hid/hid-retrode.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 drivers/hid/hid-retrode.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 687705c50794..d409435fc0c2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -741,6 +741,14 @@ config HID_PRIMAX
 	Support for Primax devices that are not fully compliant with the
 	HID standard.
 
+config HID_RETRODE
+	tristate "Retrode"
+	depends on USB_HID
+	---help---
+	Support for
+
+	  * Retrode 2 cartridge and controller adapter
+
 config HID_ROCCAT
 	tristate "Roccat device support"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index fef027bc7fa3..9ac08e7ed887 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -81,6 +81,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
 
 obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
+obj-$(CONFIG_HID_RETRODE)	+= hid-retrode.o
 obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
 	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
 	hid-roccat-koneplus.o hid-roccat-konepure.o hid-roccat-kovaplus.o \
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6e040692f1d8..49b9b4e8bfb4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2151,6 +2151,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 #endif
+#if IS_ENABLED(CONFIG_HID_RETRODE)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY, USB_DEVICE_ID_RETRODE2) },
+#endif
 #if IS_ENABLED(CONFIG_HID_RMI)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8ca1e8ce0af2..eabf33199fb2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -383,6 +383,9 @@
 #define USB_VENDOR_ID_FUTABA            0x0547
 #define USB_DEVICE_ID_LED_DISPLAY       0x7000
 
+#define USB_VENDOR_ID_FUTURE_TECHNOLOGY	0x0403
+#define USB_DEVICE_ID_RETRODE2		0x97c1
+
 #define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
 #define USB_DEVICE_ID_ESSENTIAL_REALITY_P5 0x0100
 
diff --git a/drivers/hid/hid-retrode.c b/drivers/hid/hid-retrode.c
new file mode 100644
index 000000000000..30cc7ebb4d75
--- /dev/null
+++ b/drivers/hid/hid-retrode.c
@@ -0,0 +1,100 @@
+/*
+ *  HID driver for Retrode 2 controller adapter and plug-in extensions
+ *
+ *  Copyright (c) 2017 Bastien Nocera <hadess@hadess.net>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include "hid-ids.h"
+
+#define CONTROLLER_NAME_BASE "Retrode"
+
+static int retrode_input_configured(struct hid_device *hdev,
+					struct hid_input *hi)
+{
+	struct hid_field *field = hi->report->field[0];
+	const char *suffix;
+	int number = 0;
+	char *name;
+
+	switch (field->report->id) {
+	case 0:
+		suffix = "SNES Mouse";
+		break;
+	case 1:
+	case 2:
+		suffix = "SNES / N64";
+		number = field->report->id;
+		break;
+	case 3:
+	case 4:
+		suffix = "Mega Drive";
+		number = field->report->id - 2;
+		break;
+	default:
+		hid_err(hdev, "Got unhandled report id %d\n", field->report->id);
+		suffix = "Unknown";
+	}
+
+	if (number)
+		name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+				"%s %s #%d", CONTROLLER_NAME_BASE,
+				suffix, number);
+	else
+		name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+				"%s %s", CONTROLLER_NAME_BASE, suffix);
+
+	if (!name)
+		return -ENOMEM;
+
+	hi->input->name = name;
+
+	return 0;
+}
+
+static int retrode_probe(struct hid_device *hdev,
+			const struct hid_device_id *id)
+{
+
+	int ret;
+
+	/* Has no effect on the mouse device */
+	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct hid_device_id retrode_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY, USB_DEVICE_ID_RETRODE2) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, retrode_devices);
+
+static struct hid_driver retrode_driver = {
+	.name             = "hid-retrode",
+	.id_table         = retrode_devices,
+	.input_configured = retrode_input_configured,
+	.probe            = retrode_probe,
+};
+
+module_hid_driver(retrode_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.13.0

