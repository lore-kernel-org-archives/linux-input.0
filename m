From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] hid: remove duplicate for D-WAV eGalax 0x7224
Date: Tue,  7 May 2013 17:29:04 +0300
Message-ID: <1367936944-16249-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1367936944-16249-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48888 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab3EGO3L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 May 2013 10:29:11 -0400
In-Reply-To: <1367936944-16249-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is actually not clear which driver_data ahall be used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-ids.h        | 1 -
 drivers/hid/hid-multitouch.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2378a0b..a5520ba 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -268,7 +268,6 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 895d140..383adc9 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1126,9 +1126,6 @@ static const struct hid_device_id mt_devices[] = {
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

