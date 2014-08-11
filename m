From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/2] HID: huion: Use allocated buffer for DMA
Date: Mon, 11 Aug 2014 20:45:32 +0300
Message-ID: <1407779132-26749-3-git-send-email-spbnick@gmail.com>
References: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59948 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaHKRp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 13:45:59 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so8984055wgh.9
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 10:45:58 -0700 (PDT)
In-Reply-To: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Allocate a buffer with kmalloc for receiving the parameters string
descriptor with usb_control_msg, instead of using a buffer on the stack,
as the latter is unsafe. Use an enum for indices into the buffer to
ensure the buffer size if sufficient.

This fixes the static checker error "doing dma on the stack (buf)".
---
 drivers/hid/hid-huion.c | 50 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index a683d4b..61b68ca 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -84,6 +84,15 @@ static const __u8 huion_tablet_rdesc_template[] = {
 	0xC0                    /*  End Collection                          */
 };
 
+/* Parameter indices */
+enum huion_prm {
+	HUION_PRM_X_LM		= 1,
+	HUION_PRM_Y_LM		= 2,
+	HUION_PRM_PRESSURE_LM	= 4,
+	HUION_PRM_RESOLUTION	= 5,
+	HUION_PRM_NUM
+};
+
 /* Driver data */
 struct huion_drvdata {
 	__u8 *rdesc;
@@ -115,7 +124,8 @@ static int huion_tablet_enable(struct hid_device *hdev)
 	int rc;
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
-	__le16 buf[6];
+	__le16 *buf = NULL;
+	size_t len;
 	s32 params[HUION_PH_ID_NUM];
 	s32 resolution;
 	__u8 *p;
@@ -127,27 +137,38 @@ static int huion_tablet_enable(struct hid_device *hdev)
 	 * driver traffic.
 	 * NOTE: This enables fully-functional tablet mode.
 	 */
+	len = HUION_PRM_NUM * sizeof(*buf);
+	buf = kmalloc(len, GFP_KERNEL);
+	if (buf == NULL) {
+		hid_err(hdev, "failed to allocate parameter buffer\n");
+		rc = -ENOMEM;
+		goto cleanup;
+	}
 	rc = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 				(USB_DT_STRING << 8) + 0x64,
-				0x0409, buf, sizeof(buf),
+				0x0409, buf, len,
 				USB_CTRL_GET_TIMEOUT);
 	if (rc == -EPIPE) {
 		hid_err(hdev, "device parameters not found\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto cleanup;
 	} else if (rc < 0) {
 		hid_err(hdev, "failed to get device parameters: %d\n", rc);
-		return -ENODEV;
-	} else if (rc != sizeof(buf)) {
+		rc = -ENODEV;
+		goto cleanup;
+	} else if (rc != len) {
 		hid_err(hdev, "invalid device parameters\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto cleanup;
 	}
 
 	/* Extract device parameters */
-	params[HUION_PH_ID_X_LM] = le16_to_cpu(buf[1]);
-	params[HUION_PH_ID_Y_LM] = le16_to_cpu(buf[2]);
-	params[HUION_PH_ID_PRESSURE_LM] = le16_to_cpu(buf[4]);
-	resolution = le16_to_cpu(buf[5]);
+	params[HUION_PH_ID_X_LM] = le16_to_cpu(buf[HUION_PRM_X_LM]);
+	params[HUION_PH_ID_Y_LM] = le16_to_cpu(buf[HUION_PRM_Y_LM]);
+	params[HUION_PH_ID_PRESSURE_LM] =
+		le16_to_cpu(buf[HUION_PRM_PRESSURE_LM]);
+	resolution = le16_to_cpu(buf[HUION_PRM_RESOLUTION]);
 	if (resolution == 0) {
 		params[HUION_PH_ID_X_PM] = 0;
 		params[HUION_PH_ID_Y_PM] = 0;
@@ -164,7 +185,8 @@ static int huion_tablet_enable(struct hid_device *hdev)
 				GFP_KERNEL);
 	if (drvdata->rdesc == NULL) {
 		hid_err(hdev, "failed to allocate fixed rdesc\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto cleanup;
 	}
 	drvdata->rsize = sizeof(huion_tablet_rdesc_template);
 
@@ -183,7 +205,11 @@ static int huion_tablet_enable(struct hid_device *hdev)
 		}
 	}
 
-	return 0;
+	rc = 0;
+
+cleanup:
+	kfree(buf);
+	return rc;
 }
 
 static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
-- 
2.0.1

