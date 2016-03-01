From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] hid: thingm: reorder calls in thingm_probe
Date: Tue, 1 Mar 2016 21:24:02 +0100
Message-ID: <56D5FA62.5000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35368 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbcCAUYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 15:24:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org

Based on a suggestion from Benjamin move hid_hw_start() after
thingm_version() to avoid potential races.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index f4196ac..847a497 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -216,17 +216,13 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	err = hid_parse(hdev);
 	if (err)
-		goto error;
-
-	err = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
-	if (err)
-		goto error;
+		return err;
 
 	mutex_init(&tdev->lock);
 
 	err = thingm_version(tdev);
 	if (err)
-		goto stop;
+		return err;
 
 	hid_dbg(hdev, "firmware version: %c.%c\n",
 			tdev->version.major, tdev->version.minor);
@@ -237,17 +233,18 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (!tdev->fwinfo) {
 		hid_err(hdev, "unsupported firmware %c\n", tdev->version.major);
-		err = -ENODEV;
-		goto stop;
+		return -ENODEV;
 	}
 
 	tdev->rgb = devm_kzalloc(&hdev->dev,
 			sizeof(struct thingm_rgb) * tdev->fwinfo->numrgb,
 			GFP_KERNEL);
-	if (!tdev->rgb) {
-		err = -ENOMEM;
-		goto stop;
-	}
+	if (!tdev->rgb)
+		return -ENOMEM;
+
+	err = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (err)
+		return err;
 
 	for (i = 0; i < tdev->fwinfo->numrgb; ++i) {
 		struct thingm_rgb *rgb = tdev->rgb + i;
@@ -255,15 +252,13 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		rgb->tdev = tdev;
 		rgb->num = tdev->fwinfo->first + i;
 		err = thingm_init_rgb(rgb);
-		if (err)
-			goto stop;
+		if (err) {
+			hid_hw_stop(hdev);
+			return err;
+		}
 	}
 
 	return 0;
-stop:
-	hid_hw_stop(hdev);
-error:
-	return err;
 }
 
 static const struct hid_device_id thingm_table[] = {
-- 
2.7.1

