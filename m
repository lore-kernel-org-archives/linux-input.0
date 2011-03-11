From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: ACRUX - activate the device immediately after binding
Date: Fri, 11 Mar 2011 00:27:34 -0800
Message-ID: <20110311082734.GF10807@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53116 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1CKIdY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 03:33:24 -0500
Received: by pwi15 with SMTP id 15so475503pwi.19
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 00:33:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Input <linux-input@vger.kernel.org>, Sergei Kolzun <x0r@dv-life.ru>

This device does not tolerate delayed opening and goes into a coma if
we try to that. Ubuntu even has a crutch for udev that opened the device
upon seeing it for the first time, but it did not work if we happened to
boot with the device attached, since by the time userspace got around
opening the device it was too late. Let's start the device immediately
to deal with this issue.

Reported-by: Sergei Kolzun <x0r@dv-life.ru>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Jiri,

Sergei reports that his friend was able to test the patch and it fixes
the issue for him so I believe we can now apply the patch.

Thanks.

 drivers/hid/Kconfig    |   10 ++++++++--
 drivers/hid/Makefile   |    2 +-
 drivers/hid/hid-axff.c |   31 ++++++++++++++++++++++++++++---
 drivers/hid/hid-core.c |    2 --
 4 files changed, 37 insertions(+), 8 deletions(-)


diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2560f01..b7d4133 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -68,9 +68,15 @@ config HID_A4TECH
 	---help---
 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
 
-config HID_ACRUX_FF
-	tristate "ACRUX force feedback"
+config HID_ACRUX
+	tristate "ACRUX game controller support"
 	depends on USB_HID
+	---help---
+	Say Y here if you want to enable support for ACRUX game controllers.
+
+config HID_ACRUX_FF
+	tristate "ACRUX force feedback support"
+	depends on HID_ACRUX
 	select INPUT_FF_MEMLESS
 	---help---
 	Say Y here if you want to enable force feedback support for ACRUX
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6efc2a0..13e6248 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -27,7 +27,7 @@ endif
 
 obj-$(CONFIG_HID_3M_PCT)	+= hid-3m-pct.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
-obj-$(CONFIG_HID_ACRUX_FF)	+= hid-axff.o
+obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_CANDO)		+= hid-cando.o
diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index e5b961d..b455428 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -33,6 +33,8 @@
 #include <linux/hid.h>
 
 #include "hid-ids.h"
+
+#ifdef CONFIG_HID_ACRUX_FF
 #include "usbhid/usbhid.h"
 
 struct axff_device {
@@ -109,6 +111,12 @@ err_free_mem:
 	kfree(axff);
 	return error;
 }
+#else
+static inline int axff_init(struct hid_device *hid)
+{
+	return 0;
+}
+#endif
 
 static int ax_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
@@ -139,9 +147,25 @@ static int ax_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 error);
 	}
 
+	/*
+	 * We need to start polling device right away, otherwise
+	 * it will go into a coma.
+	 */
+	error = hid_hw_open(hdev);
+	if (error) {
+		dev_err(&hdev->dev, "hw open failed\n");
+		return error;
+	}
+
 	return 0;
 }
 
+static void ax_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
 static const struct hid_device_id ax_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802), },
 	{ }
@@ -149,9 +173,10 @@ static const struct hid_device_id ax_devices[] = {
 MODULE_DEVICE_TABLE(hid, ax_devices);
 
 static struct hid_driver ax_driver = {
-	.name = "acrux",
-	.id_table = ax_devices,
-	.probe = ax_probe,
+	.name		= "acrux",
+	.id_table	= ax_devices,
+	.probe		= ax_probe,
+	.remove		= ax_remove,
 };
 
 static int __init ax_init(void)
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d678cf3..758c080 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1256,9 +1256,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
-#if defined(CONFIG_HID_ACRUX_FF) || defined(CONFIG_HID_ACRUX_FF_MODULE)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
-#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },



-- 
Dmitry
