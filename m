From: JD Cole <jd@jdc.me>
Subject: Re: [PATCH 1/2] Introduces Plantronics driver to fix errant mouse events.
Date: Fri, 31 Oct 2014 17:34:42 -0700
Message-ID: <2DDA39F7-7F05-474E-BA9C-106B53006953@jdc.me>
References: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com> <20141031235342.GA11631@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65531 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaKAAev convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 20:34:51 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so8161613pdb.35
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 17:34:50 -0700 (PDT)
In-Reply-To: <20141031235342.GA11631@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "bleung@chromium.org" <bleung@chromium.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>

Dmitry,

On Oct 31, 2014, at 4:53 PM, dmitry.torokhov@gmail.com wrote:

> Hi JD,
>=20
> On Fri, Oct 31, 2014 at 07:20:13PM +0000, Cole, JD wrote:
>> This version of the driver prevents Telephony pages which are not
>> mapped as Consumer Control applications AND are not on the Consumer =
Page
>> from being registered by the hid-input driver.
>>=20
>> Signed-off-by: JD Cole <jd.cole@plantronics.com>
>> ---
>> drivers/hid/Kconfig           |    7 ++++
>> drivers/hid/Makefile          |    1 +
> It looks like your MUA or MTA converted all TABs into spaces. Could y=
ou
> please try resending?

I=92ll update the second patch once the formatting is known good.


This version of the driver prevents Telephony pages which are not
mapped as Consumer Control applications AND are not on the Consumer Pag=
e
from being registered by the hid-input driver.

Signed-off-by: JD Cole <jd.cole@plantronics.com>
---
 drivers/hid/Kconfig           |    7 ++++
 drivers/hid/Makefile          |    1 +
 drivers/hid/hid-core.c        |    1 +
 drivers/hid/hid-ids.h         |    2 ++
 drivers/hid/hid-plantronics.c |   78 +++++++++++++++++++++++++++++++++=
++++++++
 include/linux/hid.h           |    3 ++
 6 files changed, 92 insertions(+)
 create mode 100644 drivers/hid/hid-plantronics.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f42df4d..bf1c74e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -613,6 +613,13 @@ config HID_PICOLCD_CIR
 	---help---
 	  Provide access to PicoLCD's CIR interface via remote control (LIRC)=
=2E
=20
+config HID_PLANTRONICS
+	tristate "Plantronics USB HID Driver"
+	default !EXPERT
+	depends on HID
+	---help---
+	Provides HID support for Plantronics telephony devices.
+
 config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e2850d8..5e7ac59 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -94,6 +94,7 @@ ifdef CONFIG_DEBUG_FS
 hid-picolcd-y			+=3D hid-picolcd_debugfs.o
 endif
=20
+obj-$(CONFIG_HID_PLANTRONICS)	+=3D hid-plantronics.o
 obj-$(CONFIG_HID_PRIMAX)	+=3D hid-primax.o
 obj-$(CONFIG_HID_ROCCAT)	+=3D hid-roccat.o hid-roccat-common.o \
 	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 73bd9e2..d50313c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1886,6 +1886,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000)=
 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTE=
R_REMOTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD)=
 },
 #if IS_ENABLED(CONFIG_HID_ROCCAT)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ARVO) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e23ab8b..f9f476d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -715,6 +715,8 @@
 #define USB_DEVICE_ID_ORTEK_PKB1700	0x1700
 #define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
=20
+#define USB_VENDOR_ID_PLANTRONICS	0x047f
+
 #define USB_VENDOR_ID_PANASONIC		0x04da
 #define USB_DEVICE_ID_PANABOARD_UBT780	0x1044
 #define USB_DEVICE_ID_PANABOARD_UBT880	0x104d
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronic=
s.c
new file mode 100644
index 0000000..215cdbd
--- /dev/null
+++ b/drivers/hid/hid-plantronics.c
@@ -0,0 +1,78 @@
+/*
+ *  Plantronics USB HID Driver
+ *
+ *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
+ *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
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
+#include "hid-ids.h"
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+static int plantronics_input_mapping(struct hid_device *hdev,
+				     struct hid_input *hi,
+				     struct hid_field *field,
+				     struct hid_usage *usage,
+				     unsigned long **bit, int *max)
+{
+	if (field->application =3D=3D HID_CP_CONSUMERCONTROL
+	    && (usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_CONSUMER) {
+		hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
+			 usage->hid, field->application);
+		return 0;
+	}
+
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
+		usage->hid, field->application);
+
+	return -1;
+}
+
+static int plantronics_probe(struct hid_device *hdev,
+			     const struct hid_device_id *id)
+{
+	int ret;
+
+	ret =3D hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err;
+	}
+
+	return 0;
+ err:
+	return ret;
+}
+
+static const struct hid_device_id plantronics_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, plantronics_devices);
+
+static struct hid_driver plantronics_driver =3D {
+	.name =3D "plantronics",
+	.id_table =3D plantronics_devices,
+	.input_mapping =3D plantronics_input_mapping,
+	.probe =3D plantronics_probe,
+};
+module_hid_driver(plantronics_driver);
+
+MODULE_AUTHOR("JD Cole <jd.cole@plantronics.com>");
+MODULE_AUTHOR("Terry Junge <terry.junge@plantronics.com>");
+MODULE_DESCRIPTION("Plantronics USB HID Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 78ea9bf..a63f2aa 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -234,6 +234,9 @@ struct hid_item {
 #define HID_DG_BARRELSWITCH	0x000d0044
 #define HID_DG_ERASER		0x000d0045
 #define HID_DG_TABLETPICK	0x000d0046
+
+#define HID_CP_CONSUMERCONTROL	0x000c0001
+
 #define HID_DG_CONFIDENCE	0x000d0047
 #define HID_DG_WIDTH		0x000d0048
 #define HID_DG_HEIGHT		0x000d0049
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
