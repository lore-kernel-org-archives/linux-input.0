From: linux@simon-woerner.de
Subject: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Thu, 29 Jan 2015 01:43:15 +0100
Message-ID: <1422492195-11492-1-git-send-email-linux@simon-woerner.de>
References: <54C85FB5.9050404@simon-woerner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from brief.guru ([176.9.109.100]:51805 "EHLO brief.guru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbbA2BT7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2015 20:19:59 -0500
In-Reply-To: <54C85FB5.9050404@simon-woerner.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?q?Simon=20W=C3=B6rner?= <mail@simon-woerner.de>

=46rom: Simon W=C3=B6rner <mail@simon-woerner.de>

HID: Add driver for acer keybard with broken rdesc

Signed-off-by: Simon W=C3=B6rner <mail@simon-woerner.de>
---
 drivers/hid/Kconfig    |  6 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-acer.c | 70 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-ids.h  |  3 +++
 4 files changed, 80 insertions(+)
 create mode 100644 drivers/hid/hid-acer.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index dfdc269..f3ae543 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -98,6 +98,12 @@ config HID_A4TECH
 	---help---
 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
=20
+config HID_ACER
+        tristate "Acer keyboard support"
+        depends on HID
+        ---help---
+        Support for acer keyboard with invalid rdesc.
+
 config HID_ACRUX
 	tristate "ACRUX game controller support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index debd15b..143602b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -34,6 +34,7 @@ ifdef CONFIG_DEBUG_FS
 endif
=20
 obj-$(CONFIG_HID_A4TECH)	+=3D hid-a4tech.o
+obj-$(CONFIG_HID_ACER)		+=3D hid-acer.o
 obj-$(CONFIG_HID_ACRUX)		+=3D hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
 obj-$(CONFIG_HID_APPLEIR)	+=3D hid-appleir.o
diff --git a/drivers/hid/hid-acer.c b/drivers/hid/hid-acer.c
new file mode 100644
index 0000000..b3ccd8b
--- /dev/null
+++ b/drivers/hid/hid-acer.c
@@ -0,0 +1,70 @@
+/*
+ *  HID driver for acer devices
+ *
+ *  Copyright (c) 2015 Simon W=C3=B6rner
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License as published by t=
he Free
+ * Software Foundation; either version 2 of the License, or (at your o=
ption)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+/* Acer keyboards e.g. in Acer SW5-012 use synaptics touchpad USB ID (=
06cb:2968)
+ * and have the following issue:
+ * - The report descriptor specifies an excessively large number of us=
ages
+ *   and logical max (2^16), which is more than HID_MAX_USAGES. This p=
revents
+ *   proper parsing of the report descriptor.
+ *
+ * The byte replace in the descriptor below fixes the size.
+ */
+
+#define ACER_KBD_RDESC_ORIG_SIZE	188
+#define ACER_KBD_RDESC_CHECK_POS	(150 * sizeof(__u8))
+#define ACER_KBD_RDESC_CHECK_DATA	0x2AFFFF150026FFFF
+#define ACER_KBD_RDESC_FIX_POS1		152
+#define ACER_KBD_RDESC_FIX_POS2		157
+
+static __u8 *acer_kbd_report_fixup(struct hid_device *hdev, __u8 *rdes=
c,
+		unsigned int *rsize)
+{
+	/* check for invalid descriptor */
+	if (*rsize =3D=3D ACER_KBD_RDESC_ORIG_SIZE) {
+		__u64 check =3D be64_to_cpu(*(__be64 *)(rdesc + ACER_KBD_RDESC_CHECK=
_POS));
+
+		/* check for invalid max usages and logical 0xFFFF (2^16) */
+		if (check =3D=3D ACER_KBD_RDESC_CHECK_DATA) {
+			hid_info(hdev, "fixing up acer keybaord report descriptor\n");
+
+			/* fix max values with 0xFF00 (2^8) */
+			rdesc[ACER_KBD_RDESC_FIX_POS1] =3D 0x00;
+			rdesc[ACER_KBD_RDESC_FIX_POS2] =3D 0x00;
+		}
+	}
+
+	return rdesc;
+}
+
+static const struct hid_device_id acer_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ACER_SYNAPTICS,
+		USB_VENDOR_ID_ACER_SYNAPTICS_TP) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, acer_devices);
+
+static struct hid_driver acer_driver =3D {
+	.name =3D "acer",
+	.id_table =3D acer_devices,
+	.report_fixup =3D acer_kbd_report_fixup,
+};
+module_hid_driver(acer_driver);
+
+MODULE_AUTHOR("Simon W=C3=B6rner");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..5d9482b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -35,6 +35,9 @@
 #define USB_DEVICE_ID_ACECAD_FLAIR	0x0004
 #define USB_DEVICE_ID_ACECAD_302	0x0008
=20
+#define USB_VENDOR_ID_ACER_SYNAPTICS	0x06cb
+#define USB_VENDOR_ID_ACER_SYNAPTICS_TP 0x2968
+
 #define USB_VENDOR_ID_ACRUX		0x1a34
=20
 #define USB_VENDOR_ID_ACTIONSTAR	0x2101
--=20
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
