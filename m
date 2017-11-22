From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 1/4] HID: multitouch: Fix alphabetic sorting of mt_devices table.
Date: Wed, 22 Nov 2017 12:57:07 +0100
Message-ID: <20171122115710.9978-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbdKVL5U (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 06:57:20 -0500
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
index 65ea23be9677..9ef24b518f12 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1649,14 +1649,6 @@ static const struct hid_device_id mt_devices[] = {
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
@@ -1667,6 +1659,14 @@ static const struct hid_device_id mt_devices[] = {
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

