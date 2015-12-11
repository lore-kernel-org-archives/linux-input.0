From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] hid: add support for Lilliput touchscreen
Date: Fri, 11 Dec 2015 19:47:44 +0000
Message-ID: <1449863264-14184-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Kiran Rudramuni <kchitrik@codeaurora.org>, Nicolas Dechesne <nicolas.dechesne@linaro.org>
List-Id: linux-input@vger.kernel.org

From: Kiran Rudramuni <kchitrik@codeaurora.org>

This patch adds support to Liliput capacitive touchscreeen.

Signed-off-by: Kiran Rudramuni <kchitrik@codeaurora.org>
Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
Hi

This patch has been in my local tree for long time, tested in
various Hackathons. Could you please take this for v4.5.

thanks,
srini

 drivers/hid/hid-core.c       | 1 +
 drivers/hid/hid-ids.h        | 4 ++++
 drivers/hid/hid-multitouch.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..4350376 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2051,6 +2051,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT, USB_PROD_ID_LILLIPUT) },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9024a3d..f87993f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1055,4 +1055,8 @@
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
 
+/* Lilliput Capacitive TouchScreen */
+#define USB_VENDOR_ID_LILLIPUT  0x1391
+#define USB_PROD_ID_LILLIPUT    0x2112
+
 #endif
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3d664d0..580749e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1209,6 +1209,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
 			USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040) },
 
+	/* Lilliput multitouch panels */
+	{  .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT,
+			USB_PROD_ID_LILLIPUT) },
+
 	/* CVTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
-- 
1.9.1
