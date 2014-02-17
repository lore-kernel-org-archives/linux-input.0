From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: cp2112: convert to use hid_hw_raw_request()
Date: Tue, 18 Feb 2014 00:43:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402180042120.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52151 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbaBQXnR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 18:43:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Barksdale <dbarksdale@uplogix.com>
Cc: linux-input@vger.kernel.org, fengguang.wu@intel.com

Commit cafebc0 ("HID: remove hid_get_raw_report in struct hid_device")
obsoletes the use of hdev->hid_get_raw_report(), as calling
hid_hw_raw_request() is functionally equivalent.

Convert cp2112 to use this notation.

Reported-by: fengguang.wu@intel.com
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-cp2112.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index f326726..6d679f1 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -174,8 +174,9 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	u8 buf[5];
 	int ret;
 
-	ret = hdev->hid_get_raw_report(hdev, CP2112_GPIO_CONFIG, buf,
-				       sizeof(buf), HID_FEATURE_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
+				       sizeof(buf), HID_FEATURE_REPORT,
+				       HID_REQ_GET_REPORT);
 	if (ret != sizeof(buf)) {
 		hid_err(hdev, "error requesting GPIO config: %d\n", ret);
 		return ret;
@@ -220,8 +221,8 @@ static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 	u8 buf[2];
 	int ret;
 
-	ret = hdev->hid_get_raw_report(hdev, CP2112_GPIO_GET, buf, sizeof(buf),
-				       HID_FEATURE_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_GET, buf, sizeof(buf),
+				       HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret != sizeof(buf)) {
 		hid_err(hdev, "error requesting GPIO values: %d\n", ret);
 		return ret;
@@ -241,8 +242,9 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 
 	cp2112_gpio_set(chip, offset, value);
 
-	ret = hdev->hid_get_raw_report(hdev, CP2112_GPIO_CONFIG, buf,
-				       sizeof(buf), HID_FEATURE_REPORT);
+	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
+				       sizeof(buf), HID_FEATURE_REPORT,
+				       HID_REQ_GET_REPORT);
 	if (ret != sizeof(buf)) {
 		hid_err(hdev, "error requesting GPIO config: %d\n", ret);
 		return ret;
@@ -271,8 +273,8 @@ static int cp2112_hid_get(struct hid_device *hdev, unsigned char report_number,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hdev->hid_get_raw_report(hdev, report_number, buf, count,
-				       report_type);
+	ret = hid_hw_raw_request(hdev, report_number, buf, count,
+				       report_type, HID_REQ_GET_REPORT);
 	memcpy(data, buf, count);
 	kfree(buf);
 	return ret;
-- 
Jiri Kosina
SUSE Labs
