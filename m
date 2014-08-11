From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/2] HID: huion: Fail on parameter retrieval errors
Date: Mon, 11 Aug 2014 20:45:31 +0300
Message-ID: <1407779132-26749-2-git-send-email-spbnick@gmail.com>
References: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36187 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaHKRp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 13:45:57 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so4652771wib.15
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 10:45:56 -0700 (PDT)
In-Reply-To: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Fail Huion tablet interface enabling and probing, if parameter retrieval
fails. Move the main code path out of the else block accordingly.

This should prevent devices appearing in a half-working state due to
original report descriptor being used, simplifying diagnostics. This
also makes it easier to add cleanup in later commits, as error handling
is simplified.
---
 drivers/hid/hid-huion.c | 96 +++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 60f44cd..a683d4b 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -116,6 +116,10 @@ static int huion_tablet_enable(struct hid_device *hdev)
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
 	__le16 buf[6];
+	s32 params[HUION_PH_ID_NUM];
+	s32 resolution;
+	__u8 *p;
+	s32 v;
 
 	/*
 	 * Read string descriptor containing tablet parameters. The specific
@@ -128,56 +132,54 @@ static int huion_tablet_enable(struct hid_device *hdev)
 				(USB_DT_STRING << 8) + 0x64,
 				0x0409, buf, sizeof(buf),
 				USB_CTRL_GET_TIMEOUT);
-	if (rc == -EPIPE)
-		hid_warn(hdev, "device parameters not found\n");
-	else if (rc < 0)
-		hid_warn(hdev, "failed to get device parameters: %d\n", rc);
-	else if (rc != sizeof(buf))
-		hid_warn(hdev, "invalid device parameters\n");
-	else {
-		s32 params[HUION_PH_ID_NUM];
-		s32 resolution;
-		__u8 *p;
-		s32 v;
+	if (rc == -EPIPE) {
+		hid_err(hdev, "device parameters not found\n");
+		return -ENODEV;
+	} else if (rc < 0) {
+		hid_err(hdev, "failed to get device parameters: %d\n", rc);
+		return -ENODEV;
+	} else if (rc != sizeof(buf)) {
+		hid_err(hdev, "invalid device parameters\n");
+		return -ENODEV;
+	}
 
-		/* Extract device parameters */
-		params[HUION_PH_ID_X_LM] = le16_to_cpu(buf[1]);
-		params[HUION_PH_ID_Y_LM] = le16_to_cpu(buf[2]);
-		params[HUION_PH_ID_PRESSURE_LM] = le16_to_cpu(buf[4]);
-		resolution = le16_to_cpu(buf[5]);
-		if (resolution == 0) {
-			params[HUION_PH_ID_X_PM] = 0;
-			params[HUION_PH_ID_Y_PM] = 0;
-		} else {
-			params[HUION_PH_ID_X_PM] = params[HUION_PH_ID_X_LM] *
-							1000 / resolution;
-			params[HUION_PH_ID_Y_PM] = params[HUION_PH_ID_Y_LM] *
-							1000 / resolution;
-		}
+	/* Extract device parameters */
+	params[HUION_PH_ID_X_LM] = le16_to_cpu(buf[1]);
+	params[HUION_PH_ID_Y_LM] = le16_to_cpu(buf[2]);
+	params[HUION_PH_ID_PRESSURE_LM] = le16_to_cpu(buf[4]);
+	resolution = le16_to_cpu(buf[5]);
+	if (resolution == 0) {
+		params[HUION_PH_ID_X_PM] = 0;
+		params[HUION_PH_ID_Y_PM] = 0;
+	} else {
+		params[HUION_PH_ID_X_PM] = params[HUION_PH_ID_X_LM] *
+						1000 / resolution;
+		params[HUION_PH_ID_Y_PM] = params[HUION_PH_ID_Y_LM] *
+						1000 / resolution;
+	}
 
-		/* Allocate fixed report descriptor */
-		drvdata->rdesc = devm_kmalloc(&hdev->dev,
-					sizeof(huion_tablet_rdesc_template),
-					GFP_KERNEL);
-		if (drvdata->rdesc == NULL) {
-			hid_err(hdev, "failed to allocate fixed rdesc\n");
-			return -ENOMEM;
-		}
-		drvdata->rsize = sizeof(huion_tablet_rdesc_template);
+	/* Allocate fixed report descriptor */
+	drvdata->rdesc = devm_kmalloc(&hdev->dev,
+				sizeof(huion_tablet_rdesc_template),
+				GFP_KERNEL);
+	if (drvdata->rdesc == NULL) {
+		hid_err(hdev, "failed to allocate fixed rdesc\n");
+		return -ENOMEM;
+	}
+	drvdata->rsize = sizeof(huion_tablet_rdesc_template);
 
-		/* Format fixed report descriptor */
-		memcpy(drvdata->rdesc, huion_tablet_rdesc_template,
-			drvdata->rsize);
-		for (p = drvdata->rdesc;
-		     p <= drvdata->rdesc + drvdata->rsize - 4;) {
-			if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
-			    p[3] < sizeof(params)) {
-				v = params[p[3]];
-				put_unaligned(cpu_to_le32(v), (s32 *)p);
-				p += 4;
-			} else {
-				p++;
-			}
+	/* Format fixed report descriptor */
+	memcpy(drvdata->rdesc, huion_tablet_rdesc_template,
+		drvdata->rsize);
+	for (p = drvdata->rdesc;
+	     p <= drvdata->rdesc + drvdata->rsize - 4;) {
+		if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
+		    p[3] < sizeof(params)) {
+			v = params[p[3]];
+			put_unaligned(cpu_to_le32(v), (s32 *)p);
+			p += 4;
+		} else {
+			p++;
 		}
 	}
 
-- 
2.0.1

