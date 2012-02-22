From: =?UTF-8?q?Andreas=20H=C3=BCbner?= <andreas@k4n.de>
Subject: [PATCH 1/1] HID: new driver for non-compliant Saitek devices
Date: Wed, 22 Feb 2012 02:10:06 +0100
Message-ID: <1329873006-29473-1-git-send-email-andreas@k4n.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:49035 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab2BVBKJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 20:10:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

The driver currently only supports the PS1000 controller.
It fixes the report descriptor by removing a non-existing axis and
clearing the constant bit on the d-pad and button input reports.

Signed-off-by: Andreas H=C3=BCbner <andreas@k4n.de>
---
 drivers/hid/Kconfig      |    9 ++++++
 drivers/hid/Makefile     |    1 +
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-saitek.c |   70 ++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-saitek.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a421abd..3619985 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -530,6 +530,15 @@ config HID_ROCCAT_PYRA
 	---help---
 	Support for Roccat Pyra mouse.
=20
+config HID_SAITEK
+	tristate "Saitek non-fully HID-compliant devices"
+	depends on USB_HID
+	---help---
+	Support for Saitek devices that are not fully compliant with the
+	HID standard.
+
+	Currently only supports the PS1000 controller.
+
 config HID_SAMSUNG
 	tristate "Samsung InfraRed remote control or keyboards"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8aefdc9..c14029c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_HID_ROCCAT_KONE)	+=3D hid-roccat-kone.o
 obj-$(CONFIG_HID_ROCCAT_KONEPLUS)	+=3D hid-roccat-koneplus.o
 obj-$(CONFIG_HID_ROCCAT_KOVAPLUS)	+=3D hid-roccat-kovaplus.o
 obj-$(CONFIG_HID_ROCCAT_PYRA)	+=3D hid-roccat-pyra.o
+obj-$(CONFIG_HID_SAITEK)	+=3D hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+=3D hid-samsung.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+=3D hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+=3D hid-sony.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index af08ce7..5260421 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1516,6 +1516,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KOVAPLUS)=
 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_PYRA_WIRE=
D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_PYRA_WIRE=
LESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) }=
,
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMO=
TE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELES=
S_KBD_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIREL=
ESS_PRESENTER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b8574cd..dc3dee5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -613,6 +613,7 @@
=20
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
+#define USB_DEVICE_ID_SAITEK_PS1000	0xff17
=20
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
new file mode 100644
index 0000000..45aea77
--- /dev/null
+++ b/drivers/hid/hid-saitek.c
@@ -0,0 +1,70 @@
+/*
+ *  HID driver for Saitek devices, currently only the PS1000 (USB game=
pad).
+ *  Fixes the HID report descriptor by removing a non-existent axis an=
d
+ *  clearing the constant bit on the input reports for buttons and d-p=
ad.
+ *  (This module is based on "hid-ortek".)
+ *
+ *  Copyright (c) 2012 Andreas H=C3=BCbner
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
+#include <linux/kernel.h>
+
+#include "hid-ids.h"
+
+static __u8 *saitek_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	if (*rsize =3D=3D 137 && rdesc[20] =3D=3D 0x09 && rdesc[21] =3D=3D 0x=
33
+			&& rdesc[94] =3D=3D 0x81 && rdesc[95] =3D=3D 0x03
+			&& rdesc[110] =3D=3D 0x81 && rdesc[111] =3D=3D 0x03) {
+
+		hid_info(hdev, "Fixing up Saitek PS1000 report descriptor\n");
+
+		/* convert spurious axis to a "noop" Logical Minimum (0) */
+		rdesc[20] =3D 0x15;
+		rdesc[21] =3D 0x00;
+
+		/* clear constant bit on buttons and d-pad */
+		rdesc[95] =3D 0x02;
+		rdesc[111] =3D 0x02;
+
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id saitek_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000)},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, saitek_devices);
+
+static struct hid_driver saitek_driver =3D {
+	.name =3D "saitek",
+	.id_table =3D saitek_devices,
+	.report_fixup =3D saitek_report_fixup
+};
+
+static int __init saitek_init(void)
+{
+	return hid_register_driver(&saitek_driver);
+}
+
+static void __exit saitek_exit(void)
+{
+	hid_unregister_driver(&saitek_driver);
+}
+
+module_init(saitek_init);
+module_exit(saitek_exit);
+MODULE_LICENSE("GPL");
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
