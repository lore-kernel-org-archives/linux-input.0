From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/3] HID: multitouch: Fix alphabetic sorting of mt_devices table.
Date: Mon,  6 Nov 2017 16:01:47 +0100
Message-ID: <20171106150149.13986-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753537AbdKFPBy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 10:01:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Fix alphabetic sorting of mt_devices hid_device_id table.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 9e8c4d2ba11d..bb939f6990f1 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1605,14 +1605,6 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_TURBOX,
 			USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) },
 
-	/* Panasonic panels */
-	{ .driver_data = MT_CLS_PANASONIC,
-		MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
-			USB_DEVICE_ID_PANABOARD_UBT780) },
-	{ .driver_data = MT_CLS_PANASONIC,
-		MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
-			USB_DEVICE_ID_PANABOARD_UBT880) },
-
 	/* Novatek Panel */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
@@ -1623,6 +1615,14 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_NTRIG, 0x1b05) },
 
+	/* Panasonic panels */
+	{ .driver_data = MT_CLS_PANASONIC,
+		MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
+			USB_DEVICE_ID_PANABOARD_UBT780) },
+	{ .driver_data = MT_CLS_PANASONIC,
+		MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
+			USB_DEVICE_ID_PANABOARD_UBT880) },
+
 	/* PixArt optical touch screen */
 	{ .driver_data = MT_CLS_INRANGE_CONTACTNUMBER,
 		MT_USB_DEVICE(USB_VENDOR_ID_PIXART,
-- 
2.14.3

