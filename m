From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Mon, 14 Nov 2011 17:41:45 +0100
Message-ID: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55778 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1KNQly (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 11:41:54 -0500
Received: by fagn18 with SMTP id n18so3190424fag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 08:41:53 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, chris@cnpbagwell.com

This patch adds USB ID for the touchpanel in Acer Iconia W500. The panel
supports up to five fingers, therefore the need for a new addition of panel
types.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: chris@cnpbagwell.com
---
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |   12 ++++++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

NOTE: That checkpatch warning is there because I followed the pattern in
hid-core.c

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 242353d..6600ac7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1377,6 +1377,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2515) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7484e1b..c2e9369 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -225,6 +225,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2	0x72a1
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3	0x480e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4	0x726b
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5	0x7302
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 58d0e7a..35c53db 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -96,6 +96,7 @@ struct mt_class {
 #define MT_CLS_3M				0x0101
 #define MT_CLS_CYPRESS				0x0102
 #define MT_CLS_EGALAX				0x0103
+#define MT_CLS_EGALAX_5FINGER			0x0104
 
 #define MT_DEFAULT_MAXCONTACT	10
 
@@ -173,6 +174,13 @@ struct mt_class mt_classes[] = {
 		.sn_move = 4096,
 		.sn_pressure = 32,
 	},
+	{ .name = MT_CLS_EGALAX_5FINGER,
+		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_VALID_IS_INRANGE |
+			MT_QUIRK_EGALAX_XYZ_FIXUP,
+		.sn_move = 4096,
+		.sn_pressure = 32,
+	},
 
 	{ }
 };
@@ -646,6 +655,9 @@ static const struct hid_device_id mt_devices[] = {
 	{  .driver_data = MT_CLS_EGALAX,
 		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+	{  .driver_data = MT_CLS_EGALAX_5FINGER,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
 
 	/* Elo TouchSystems IntelliTouch Plus panel */
 	{ .driver_data = MT_CLS_DUAL_NSMU_CONTACTID,
-- 
1.7.5.4

