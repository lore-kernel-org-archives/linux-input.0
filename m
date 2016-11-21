From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] HID: lg: make transfer buffers DMA capable
Date: Mon, 21 Nov 2016 11:48:40 +0100
Message-ID: <1479725322-30863-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Kernel v4.9 strictly enforces DMA capable buffers, so we need to remove
buffers allocated on the stack.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-lg.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 76f644d..d4c72a5 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -756,11 +756,16 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Setup wireless link with Logitech Wii wheel */
 	if (hdev->product == USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
-		unsigned char buf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+		const unsigned char cbuf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+		u8 *buf = kmemdup(cbuf, sizeof(cbuf), GFP_KERNEL);
 
-		ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(buf),
-					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
 
+		ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(cbuf),
+					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 		if (ret >= 0) {
 			/* insert a little delay of 10 jiffies ~ 40ms */
 			wait_queue_head_t wait;
@@ -775,6 +780,7 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(buf),
 					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 		}
+		kfree(buf);
 	}
 
 	if (drv_data->quirks & LG_FF)
-- 
2.7.4
