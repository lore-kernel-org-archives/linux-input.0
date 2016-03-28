From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH] HID: lenovo: Don't use stack variables for DMA buffers
Date: Mon, 28 Mar 2016 09:22:14 -0400
Message-ID: <1459171334-22943-2-git-send-email-jwboyer@fedoraproject.org>
References: <1459171334-22943-1-git-send-email-jwboyer@fedoraproject.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34705 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbcC1NWb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2016 09:22:31 -0400
In-Reply-To: <1459171334-22943-1-git-send-email-jwboyer@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The lenovo_send_cmd_cptkbd function uses a stack variable to submit
commands via hid_hw_raw_request.  Eventually this gets to the
usb_hcd_map_urb_for_dma function, which causes a warning to be thrown
if the CONFIG_DMA_API_DEBUG option is enabled.

Fix this by allocating a temporary buffer instead.

Reported-by: lejeczek <peljasz@yahoo.co.uk>
Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 drivers/hid/hid-lenovo.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 0125e356bd8d..2ba5e8ea66a4 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -184,21 +184,31 @@ static int lenovo_send_cmd_cptkbd(struct hid_device *hdev,
 			unsigned char byte2, unsigned char byte3)
 {
 	int ret;
-	unsigned char buf[] = {0x18, byte2, byte3};
+	unsigned char *buf = NULL;
+
+	buf = kzalloc(3, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = 0x18;
+	buf[1] = byte2;
+	buf[2] = byte3;
 
 	switch (hdev->product) {
 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
-		ret = hid_hw_raw_request(hdev, 0x13, buf, sizeof(buf),
+		ret = hid_hw_raw_request(hdev, 0x13, buf, 3,
 					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 		break;
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
-		ret = hid_hw_output_report(hdev, buf, sizeof(buf));
+		ret = hid_hw_output_report(hdev, buf, 3);
 		break;
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
+	kfree(buf);
+
 	return ret < 0 ? ret : 0; /* BT returns 0, USB returns sizeof(buf) */
 }
 
-- 
2.5.5

