From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 10/25] HID: multitouch: optimize Stantum panels
Date: Fri, 25 Jan 2013 14:22:55 +0100
Message-ID: <1359120190-18281-11-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Not very different in terms of processing time. However, this
uniformizes the handling of devices.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f715045..0c62f90 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1168,7 +1168,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008) },
 
 	/* Stantum panels */
-	{ .driver_data = MT_CLS_CONFIDENCE,
+	{ .driver_data = MT_CLS_ALWAYS_TRUE,
 		MT_USB_DEVICE(USB_VENDOR_ID_STANTUM,
 			USB_DEVICE_ID_MTP)},
 	{ .driver_data = MT_CLS_CONFIDENCE,
-- 
1.8.1
