From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] hid: sort IDs for D-WAV eGalax multitouch devices
Date: Fri, 17 May 2013 14:34:48 +0300
Message-ID: <1368790489-21792-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35059 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab3EQLfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 May 2013 07:35:17 -0400
In-Reply-To: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Just sort the list by IDs. There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-ids.h        |  8 ++++----
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0b4598a..5b7e148 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -271,20 +271,20 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B	0x726b
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72AA	0x72aa
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72A1	0x72a1
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72AA	0x72aa
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4	0x72c4
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0	0x72d0
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72FA	0x72fa
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7302	0x7302
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349	0x7349
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7	0x73f7
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224      0x7224
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0      0x72d0
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4      0x72c4
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 1bea657..590aa37 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1122,34 +1122,43 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480E) },
 
 	/* eGalax devices (capacitive) */
-	{ .driver_data = MT_CLS_EGALAX,
-		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207) },
-	{ .driver_data = MT_CLS_EGALAX_SERIAL,
+	{ .driver_data = MT_CLS_EGALAX,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E) },
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
+	{ .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A) },
-	{ .driver_data = MT_CLS_EGALAX,
+	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B) },
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262) },
 	{ .driver_data = MT_CLS_EGALAX,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B) },
+	{ .driver_data = MT_CLS_EGALAX,
+		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72A1) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72AA) },
 	{ .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4) },
+	{ .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0) },
+	{ .driver_data = MT_CLS_EGALAX,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72FA) },
 	{ .driver_data = MT_CLS_EGALAX,
@@ -1164,15 +1173,6 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
-	{ .driver_data = MT_CLS_EGALAX,
-		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
-	{ .driver_data = MT_CLS_EGALAX,
-		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0) },
-	{ .driver_data = MT_CLS_EGALAX,
-		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4) },
 
 	/* Elo TouchSystems IntelliTouch Plus panel */
 	{ .driver_data = MT_CLS_DUAL_CONTACT_ID,
-- 
1.8.2.rc0.22.gb3600c3

