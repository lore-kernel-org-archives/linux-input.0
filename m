From: =?UTF-8?q?Simon=20W=C3=B6rner?= <linux@simon-woerner.de>
Subject: [PATCH] HID: Add driver for synaptics keybard with broken rdesc
Date: Fri, 23 Jan 2015 20:03:30 +0100
Message-ID: <1422039810-26327-2-git-send-email-linux@simon-woerner.de>
References: <1422039810-26327-1-git-send-email-linux@simon-woerner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from brief.guru ([176.9.109.100]:45287 "EHLO brief.guru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbAWTKc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 14:10:32 -0500
In-Reply-To: <1422039810-26327-1-git-send-email-linux@simon-woerner.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, =?UTF-8?q?Simon=20W=C3=B6rner?= <mail@simon-woerner.de>

=46rom: Simon W=C3=B6rner <mail@simon-woerner.de>

Signed-off-by: Simon W=C3=B6rner <mail@simon-woerner.de>
---
 drivers/hid/Kconfig         |   6 ++
 drivers/hid/Makefile        |   1 +
 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-synaptics.c | 190 ++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 drivers/hid/hid-synaptics.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index dfdc269..9f4124e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -708,6 +708,12 @@ config HID_SUNPLUS
 	---help---
 	Support for Sunplus wireless desktop.
=20
+config HID_SYNAPTICS
+	tristate "Synaptics keyboard support"
+	depends on HID
+	---help---
+	Support for Synaptics keyboard with invalid rdesc
+
 config HID_RMI
 	tristate "Synaptics RMI4 device support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index debd15b..01bda39 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_HID_SONY)		+=3D hid-sony.o
 obj-$(CONFIG_HID_SPEEDLINK)	+=3D hid-speedlink.o
 obj-$(CONFIG_HID_STEELSERIES)	+=3D hid-steelseries.o
 obj-$(CONFIG_HID_SUNPLUS)	+=3D hid-sunplus.o
+obj-$(CONFIG_HID_SYNAPTICS)	+=3D hid-synaptics.o
 obj-$(CONFIG_HID_GREENASIA)	+=3D hid-gaff.o
 obj-$(CONFIG_HID_THINGM)	+=3D hid-thingm.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+=3D hid-tmff.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..976ab39 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -873,6 +873,7 @@
 #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
 #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
 #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
+#define USB_VENDOR_ID_SYNAPTICS_KBD	0x2968
 #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
=20
 #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
diff --git a/drivers/hid/hid-synaptics.c b/drivers/hid/hid-synaptics.c
new file mode 100644
index 0000000..3dab405
--- /dev/null
+++ b/drivers/hid/hid-synaptics.c
@@ -0,0 +1,190 @@
+/*
+ *  HID driver for synaptics devices
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
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+/* Synaptics keyboards (USB ID 06cb:2968) e.g. in Acer SW5-012
+ * have the following issue:
+ * - The report descriptor specifies an excessively large number of co=
nsumer
+ *   usages (2^15), which is more than HID_MAX_USAGES. This prevents p=
roper
+ *   parsing of the report descriptor.
+ *
+ * The replacement descriptor below fixes the number of consumer usage=
s.
+ */
+
+static __u8 synaptics_kbd_rdesc_fixed[] =3D {
+	/* Application Collection */
+	0x06, 0x85, 0xFF,	/* (GLOBAL) USAGE_PAGE (Vendor-defined)       */
+	0x09, 0x95,		/* (LOCAL)  USAGE (0xFF850095)                */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x5A,		/*   (GLOBAL) REPORT_ID (0x5A (90) 'Z')       */
+	0x09, 0x01,		/*   (LOCAL)  USAGE (0xFF850001)              */
+	0x26, 0xFF, 0x00,	/*   (GLOBAL) LOGICAL_MAXIMUM 0x00FF (255)    */
+	0x75, 0x08,		/*   (GLOBAL) REPORT_SIZE 0x08 (8)            */
+	0x95, 0x10,		/*   (GLOBAL) REPORT_COUNT 0x10 (16)          */
+	0xB1, 0x00,		/*   (MAIN)   FEATURE 0x00                    */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+
+	/* Application Collection */
+	0x05, 0x01,		/* (GLOBAL) USAGE_PAGE (Desktop)              */
+	0x09, 0x06,		/* (LOCAL)  USAGE 0x06 (Keyboard)             */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x01,		/*   (GLOBAL) REPORT_ID 0x01 (1)              */
+	0x75, 0x01,		/*   (GLOBAL) REPORT_SIZE 0x01 (1)            */
+	0x95, 0x08,		/*   (GLOBAL) REPORT_COUNT 0x08 (8)           */
+	0x05, 0x07,		/*   (GLOBAL) USAGE_PAGE 0x07 (Keyboard)      */
+	0x19, 0xE0,		/*   (LOCAL)  USAGE_MINIMUM 0xE0              */
+	0x29, 0xE7,		/*   (LOCAL)  USAGE_MAXIMUM 0xE7              */
+	0x25, 0x01,		/*   (GLOBAL) LOGICAL_MAXIMUM 0x01 (1)        */
+	0x81, 0x02,		/*   (MAIN)   INPUT 0x02                      */
+	0x95, 0x01,		/*   (GLOBAL) REPORT_COUNT 0x01 (1)           */
+	0x75, 0x08,		/*   (GLOBAL) REPORT_SIZE 0x08 (8)            */
+	0x81, 0x03,		/*   (MAIN)   INPUT 0x03                      */
+	0x95, 0x05,		/*   (GLOBAL) REPORT_COUNT 0x05 (5)           */
+	0x75, 0x01,		/*   (GLOBAL) REPORT_SIZE 0x01 (1)            */
+	0x05, 0x08,		/*   (GLOBAL) USAGE_PAGE 0x08 (LED Indicator) */
+	0x19, 0x01,		/*   (LOCAL)  USAGE_MINIMUM 0x01              */
+	0x29, 0x05,		/*   (LOCAL)  USAGE_MAXIMUM 0x05              */
+	0x91, 0x02,		/*   (MAIN)   OUTPUT 0x02                     */
+	0x95, 0x01,		/*   (GLOBAL) REPORT_COUNT 0x01 (1)           */
+	0x75, 0x03,		/*   (GLOBAL) REPORT_SIZE 0x03 (3)            */
+	0x91, 0x03,		/*   (MAIN)   OUTPUT 0x03                     */
+	0x95, 0x06,		/*   (GLOBAL) REPORT_COUNT 0x06 (6)           */
+	0x75, 0x08,		/*   (GLOBAL) REPORT_SIZE 0x08 (8)            */
+	0x26, 0xFF, 0x00,	/*   (GLOBAL) LOGICAL_MAXIMUM 0x00FF (255)    */
+	0x05, 0x07,		/*   (GLOBAL) USAGE_PAGE 0x0007 (Keyboard)    */
+	0x19, 0x00,		/*   (LOCAL)  USAGE_MINIMUM 0x00              */
+	0x2A, 0xFF, 0x00,	/*   (LOCAL)  USAGE_MAXIMUM 0xFF              */
+	0x81, 0x00,		/*   (MAIN)   INPUT 0x00                      */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+
+	/* Application Collection */
+	0x05, 0x0C,		/* (GLOBAL) USAGE_PAGE (Consumer)             */
+	0x09, 0x01,		/* (LOCAL)  USAGE 0x01 (Consumer Control)     */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x02,		/*   (GLOBAL) REPORT_ID 0x02 (2)              */
+	0x19, 0x00,		/*   (LOCAL)  USAGE_MINIMUM 0x00              */
+	0x2A, 0x3C, 0x02,	/*   (LOCAL)  USAGE_MAXIMUM 0x023C            */
+	0x26, 0x3C, 0x02,	/*   (GLOBAL) LOGICAL_MAXIMUM 0x023C (572)    */
+	0x75, 0x10,		/*   (GLOBAL) REPORT_SIZE 0x10 (16)           */
+	0x95, 0x01,		/*   (GLOBAL) REPORT_COUNT 0x01 (1)           */
+	0x81, 0x00,		/*   (MAIN)   INPUT 0x00                      */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+
+	/* Application Collection */
+	0x05, 0x01,		/* (GLOBAL) USAGE_PAGE (Desktop)              */
+	0x09, 0x0C,		/* (LOCAL)  USAGE (Wireless Radio Controls)   */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x03,		/*   (GLOBAL) REPORT_ID 0x03 (3)              */
+	0x25, 0x01,		/*   (GLOBAL) LOGICAL_MAXIMUM 0x01 (1)        */
+	0x09, 0xC6,		/*   (LOCAL)  USAGE 0xC6                      */
+	0x75, 0x01,		/*   (GLOBAL) REPORT_SIZE 0x01 (1)            */
+	0x81, 0x06,		/*   (MAIN)   INPUT 0x06                      */
+	0x75, 0x07,		/*   (GLOBAL) REPORT_SIZE 0x07 (7)            */
+	0x81, 0x03,		/*   (MAIN)   INPUT 0x03                      */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+
+	/* Application Collection */
+	0x05, 0x88,		/* (GLOBAL) USAGE_PAGE (0x88)                 */
+	0x09, 0x01,		/* (LOCAL)  USAGE (0x01)                      */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x04,		/*   (GLOBAL) REPORT_ID 0x04 (4)              */
+	0x19, 0x00,		/*   (LOCAL)  USAGE_MINIMUM 0x00              */
+	0x2A, 0xFF, 0x00,	/*   (LOCAL)  USAGE_MAXIMUM 0x00FF            */
+	0x26, 0xFF, 0x00,	/*   (GLOBAL) LOGICAL_MAXIMUM 0x00FF          */
+	0x75, 0x08,		/*   (GLOBAL) REPORT_SIZE 0x08 (8)            */
+	0x95, 0x02,		/*   (GLOBAL) REPORT_COUNT 0x02 (2)           */
+	0x81, 0x02,		/*   (MAIN)   INPUT 0x02                      */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+
+	/* Application Collection */
+	0x05, 0x01,		/* (GLOBAL) USAGE_PAGE (Desktop)              */
+	0x09, 0x80,		/* (LOCAL)  USAGE (System Control)            */
+	0xA1, 0x01,		/* (MAIN)   COLLECTION (Application)          */
+	0x85, 0x05,		/*   (GLOBAL) REPORT_ID 0x05 (5)              */
+	0x19, 0x81,		/*   (LOCAL)  USAGE_MINIMUM 0x81              */
+	0x29, 0x83,		/*   (LOCAL)  USAGE_MAXIMUM 0x83              */
+	0x25, 0x01,		/*   (GLOBAL) LOGICAL_MAXIMUM 0x01 (1)        */
+	0x95, 0x08,		/*   (GLOBAL) REPORT_COUNT 0x08 (8)           */
+	0x75, 0x01,		/*   (GLOBAL) REPORT_SIZE 0x01 (1)            */
+	0x81, 0x02,		/*   (MAIN)   INPUT 0x02                      */
+	0xC0,			/* (MAIN)   END_COLLECTION (Application)      */
+};
+
+static __u8 *synaptics_kbd_report_fixup(struct hid_device *hdev, __u8 =
*rdesc,
+		unsigned int *rsize)
+{
+	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
+
+	if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0) {
+		rdesc =3D synaptics_kbd_rdesc_fixed;
+		*rsize =3D sizeof(synaptics_kbd_rdesc_fixed);
+	}
+	return rdesc;
+}
+
+static int synaptics_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	int ret;
+
+	ret =3D hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err_free;
+	}
+
+	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err_free;
+	}
+
+	if (ret < 0)
+		goto err_stop;
+
+	return 0;
+err_stop:
+	hid_hw_stop(hdev);
+err_free:
+	return ret;
+}
+
+static void synaptics_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id synaptics_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS,
+		USB_VENDOR_ID_SYNAPTICS_KBD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, synaptics_devices);
+
+static struct hid_driver synaptics_driver =3D {
+	.name =3D "synaptics",
+	.id_table =3D synaptics_devices,
+	.report_fixup =3D synaptics_kbd_report_fixup,
+	.probe =3D synaptics_probe,
+	.remove =3D synaptics_remove,
+};
+module_hid_driver(synaptics_driver);
+
+MODULE_LICENSE("GPL");
--=20
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
