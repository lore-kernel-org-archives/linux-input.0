From: Austin Zhang <zhang.austin@gmail.com>
Subject: HID: hid-multitouch: add support for Ilitek dual-touch panel
Date: Mon, 9 May 2011 23:54:14 +0800
Message-ID: <BANLkTinZWKw_YNTswC0OHRNDf1FQ+s8BKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55719 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1EIPyP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2011 11:54:15 -0400
Received: by pvg12 with SMTP id 12so2406625pvg.19
        for <linux-input@vger.kernel.org>; Mon, 09 May 2011 08:54:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Added ILITEK hid dual touch panel support into hid-multitouch.

Signed-off-by: Austin Zhang <zhang.austin@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 Kconfig          |    1 +
 hid-core.c       |    1 +
 hid-ids.h        |    3 +++
 hid-multitouch.c |    5 +++++
 4 files changed, 10 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d2d4e5f..d9635d6 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -306,6 +306,7 @@ config HID_MULTITOUCH
 	  - Cando dual touch panel
 	  - Cypress TrueTouch panels
 	  - Hanvon dual touch panels
+	  - Ilitek dual touch panel
 	  - IrTouch Infrared USB panels
 	  - MosArt dual-touch panels
 	  - PenMount dual touch panels
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6e31b9f..c0ea857 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1377,6 +1377,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HANVON, USB_DEVICE_ID_HANVON_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_ILITEK_MULTITOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS,
USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 252aeba..0f29b3f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -330,6 +330,9 @@
 #define USB_DEVICE_ID_UGCI_FLYING	0x0020
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030

+#define USB_VENDOR_ID_ILITEK		0x222a
+#define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
+
 #define USB_VENDOR_ID_IMATION		0x0718
 #define USB_DEVICE_ID_DISC_STAKKA	0xd000

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index bf46804..b21251b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -589,6 +589,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
 			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },

+	/* Ilitek dual touch panel */
+	{  .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_ILITEK,
+			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
+
 	/* IRTOUCH panels */
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
 		HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS,
