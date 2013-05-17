From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Fri, 17 May 2013 14:34:49 +0300
Message-ID: <1368790489-21792-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42441 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab3EQLe6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 May 2013 07:34:58 -0400
In-Reply-To: <1368790489-21792-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch also removes the duplicate entry in the hid-multitouch.c as
suggested by Benjamin Tissoires.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-ids.h        | 1 -
 drivers/hid/hid-multitouch.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5b7e148..8add4ae 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -271,7 +271,6 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 590aa37..d99b959 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1131,9 +1131,6 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
-	{ .driver_data = MT_CLS_EGALAX,
-		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
-			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A) },
-- 
1.8.2.rc0.22.gb3600c3

