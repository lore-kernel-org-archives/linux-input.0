From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] hid: thingm: reorder calls in thingm_probe
Date: Thu, 10 Mar 2016 20:52:21 +0100
Message-ID: <56E1D075.1000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34755 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbcCJTwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 14:52:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org

When reviewing another thingm patch Benjamin Tissoires pointed out
the following: "The problem here is that hid_hw_start() is called
before thingm_version() which allows user space to briefly introduce
races between thingm_version() and any hidraw requests.
The mutex will not help here as it is initialized after hid_hw_start()
and only used for protecting the concurrent access of the rgb."

Avoid this possible issue by calling hid_hw_start() later in the
probe function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- make commit message more verbose
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

