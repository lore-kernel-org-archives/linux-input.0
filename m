From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 23/25] HID: multitouch: optimize Nexio panels
Date: Fri, 25 Jan 2013 14:23:08 +0100
Message-ID: <1359120190-18281-24-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The slot can be extracted using by MINUS_ONE.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 34153f9..e019608 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1137,7 +1137,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) },
 
 	/* Nexio panels */
-	{ .driver_data = MT_CLS_ALWAYS_TRUE,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_NEXIO,
 			USB_DEVICE_ID_NEXIO_MULTITOUCH_420)},
 
-- 
1.8.1
