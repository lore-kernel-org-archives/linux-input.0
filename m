From: Richard Nauber <richard.nauber@googlemail.com>
Subject: Re: [PATCH v2] HID: Fix reporting of nonexistent HWheel for Elecom
 BM084 (bluetooth mouse).
Date: Mon, 28 Jun 2010 18:54:25 +0200
Message-ID: <4C28D3C1.7070307@googlemail.com>
References: <4C288B57.7060600@googlemail.com> <20100628163451.GB11670@core.coreip.homeip.net> <alpine.LNX.2.00.1006281837090.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48798 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0F1Qyo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 12:54:44 -0400
Received: by fxm14 with SMTP id 14so843063fxm.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 09:54:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1006281837090.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

Ok, how about this:

-snip-

This patch removes the annoying feature of Elecoms BM084 to constantly scroll to the right.
The device can be found at:
http://www.dealextreme.com/details.dx/sku.15402

Signed-off-by:  Richard Nauber <Richard.Nauber@gmail.com>
---
 drivers/hid/Kconfig      |    6 +++++
 drivers/hid/Makefile     |    1 +
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-elecom.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h    |    3 ++
 5 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-elecom.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 132278f..0eac193 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -148,6 +148,12 @@ config HID_EGALAX
 	---help---
 	Support for the eGalax dual-touch panel.
 
+config HID_ELECOM
+	tristate "ELECOM"
+	depends on BT_HIDP
+	---help---
+	Support for the ELECOM BM084 (bluetooth mouse).
+
 config HID_EZKEY
 	tristate "Ezkey" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 987fa06..2ec042f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-drff.o
 obj-$(CONFIG_HID_EGALAX)	+= hid-egalax.o
+obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index aa0f7dc..59ea24e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1294,6 +1294,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
new file mode 100644
index 0000000..7a40878
--- /dev/null
+++ b/drivers/hid/hid-elecom.c
@@ -0,0 +1,57 @@
+/*
+ *  HID driver for Elecom BM084 (bluetooth mouse).
+ *  Removes a non-existing horizontal wheel from
+ *  the HID descriptor.
+ *  (This module is based on "hid-ortek".)
+ *
+ *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
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
+static void elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int rsize)
+{
+	if (rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
+		dev_info(&hdev->dev, "Fixing up Elecom BM084 "
+				"report descriptor.\n");
+		rdesc[47] = 0x00;
+	}
+}
+
+static const struct hid_device_id elecom_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084)},
+	{ } heads up and
+};
+MODULE_DEVICE_TABLE(hid, elecom_devices);
+
+static struct hid_driver elecom_driver = {
+	.name = "elecom",
+	.id_table = elecom_devices,
+	.report_fixup = elecom_report_fixup
+};
+
+static int __init elecom_init(void)
+{
+	return hid_register_driver(&elecom_driver);
+}
+
+static void __exit elecom_exit(void)
+{
+	hid_unregister_driver(&elecom_driver);
+}
+
+module_init(elecom_init);
+module_exit(elecom_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6af77ed..55cecb7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -186,6 +186,9 @@
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
 
+#define USB_VENDOR_ID_ELECOM		0x056e
+#define USB_DEVICE_ID_ELECOM_BM084	0x0061
+
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020
 
-- 
1.6.4.2



Thanks for the review (and to Dmitry for pointing me into the right direction, spacibo!)
Richard


