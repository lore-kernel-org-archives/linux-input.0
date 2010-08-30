From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 2/6] HID: magicmouse: move features reports to static array
Date: Mon, 30 Aug 2010 13:20:54 -0400
Message-ID: <1283188858-4839-2-git-send-email-chase.douglas@canonical.com>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57676 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab0H3RVD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 13:21:03 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Oq82Y-000730-1p
	for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 18:21:02 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1Oq82X-0006Dh-LQ
	for linux-input@vger.kernel.org; Mon, 30 Aug 2010 18:21:02 +0100
In-Reply-To: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Chase Douglas <chase.douglas@ubuntu.com>

By moving the feature reports to an array, we can easily support
more products with different initialization reports. This will be
useful for enabling the Apple Magic Trackpad.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 2d8532d..d758061 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -377,14 +377,23 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 	}
 }
 
+struct feature {
+	__u8 data[3];
+	__u8 length;
+};
+
+static struct feature mouse_features[] = {
+	{ { 0xd7, 0x01 }, 2 },
+	{ { 0xf8, 0x01, 0x32 }, 3 }
+};
+
 static int magicmouse_probe(struct hid_device *hdev,
 	const struct hid_device_id *id)
 {
-	__u8 feature_1[] = { 0xd7, 0x01 };
-	__u8 feature_2[] = { 0xf8, 0x01, 0x32 };
 	struct input_dev *input;
 	struct magicmouse_sc *msc;
 	struct hid_report *report;
+	int i;
 	int ret;
 
 	msc = kzalloc(sizeof(*msc), GFP_KERNEL);
@@ -419,19 +428,15 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
-	ret = hdev->hid_output_raw_report(hdev, feature_1, sizeof(feature_1),
-			HID_FEATURE_REPORT);
-	if (ret != sizeof(feature_1)) {
-		dev_err(&hdev->dev, "unable to request touch data (1:%d)\n",
-				ret);
-		goto err_stop_hw;
-	}
-	ret = hdev->hid_output_raw_report(hdev, feature_2,
-			sizeof(feature_2), HID_FEATURE_REPORT);
-	if (ret != sizeof(feature_2)) {
-		dev_err(&hdev->dev, "unable to request touch data (2:%d)\n",
-				ret);
-		goto err_stop_hw;
+	for (i = 0; i < ARRAY_SIZE(mouse_features); i++) {
+		ret = hdev->hid_output_raw_report(hdev, mouse_features[i].data,
+				mouse_features[i].length, HID_FEATURE_REPORT);
+		if (ret != mouse_features[i].length) {
+			dev_err(&hdev->dev,
+				"unable to request touch data (%d:%d)\n",
+				i, ret);
+			goto err_stop_hw;
+		}
 	}
 
 	input = input_allocate_device();
-- 
1.7.1

