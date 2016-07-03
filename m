From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] HID: hid-led: remove report id from struct hidled_config
Date: Sun, 3 Jul 2016 17:33:04 +0200
Message-ID: <7f2bfc4f-ba5e-dacd-3c60-6bd0f7ac7237@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34030 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbcGCPs6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2016 11:48:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so16367470wmz.1
        for <linux-input@vger.kernel.org>; Sun, 03 Jul 2016 08:48:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Delcom uses the report id to submit command information. To be able to
use the hidled framework also for Delcom devices we have to remove the
report id from struct hidled_config.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-led.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index e11b645..fce2a03 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -54,7 +54,6 @@ struct hidled_config {
 	int			num_leds;
 	size_t			report_size;
 	enum hidled_report_type	report_type;
-	u8			report_id;
 	int (*init)(struct hidled_device *ldev);
 	int (*write)(struct led_classdev *cdev, enum led_brightness br);
 };
@@ -93,8 +92,6 @@ static int hidled_send(struct hidled_device *ldev, __u8 *buf)
 {
 	int ret;
 
-	buf[0] = ldev->config->report_id;
-
 	mutex_lock(&ldev->lock);
 
 	if (ldev->config->report_type == RAW_REQUEST)
@@ -124,8 +121,6 @@ static int hidled_recv(struct hidled_device *ldev, __u8 *buf)
 	if (ldev->config->report_type != RAW_REQUEST)
 		return -EINVAL;
 
-	buf[0] = ldev->config->report_id;
-
 	mutex_lock(&ldev->lock);
 
 	ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
@@ -203,7 +198,7 @@ static int _thingm_write(struct led_classdev *cdev, enum led_brightness br,
 			 u8 offset)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
-	__u8 buf[MAX_REPORT_SIZE] = { [1] = 'c' };
+	__u8 buf[MAX_REPORT_SIZE] = { 1, 'c' };
 
 	buf[2] = led->rgb->red.cdev.brightness;
 	buf[3] = led->rgb->green.cdev.brightness;
@@ -230,13 +225,12 @@ static const struct hidled_config hidled_config_thingm_v1 = {
 	.num_leds = 1,
 	.report_size = 9,
 	.report_type = RAW_REQUEST,
-	.report_id = 1,
 	.write = thingm_write_v1,
 };
 
 static int thingm_init(struct hidled_device *ldev)
 {
-	__u8 buf[MAX_REPORT_SIZE] = { [1] = 'v' };
+	__u8 buf[MAX_REPORT_SIZE] = { 1, 'v' };
 	int ret;
 
 	ret = hidled_recv(ldev, buf);
@@ -259,7 +253,6 @@ static const struct hidled_config hidled_configs[] = {
 		.num_leds = 1,
 		.report_size = 6,
 		.report_type = OUTPUT_REPORT,
-		.report_id = 0,
 		.write = riso_kagaku_write,
 	},
 	{
@@ -270,7 +263,6 @@ static const struct hidled_config hidled_configs[] = {
 		.num_leds = 1,
 		.report_size = 9,
 		.report_type = RAW_REQUEST,
-		.report_id = 0,
 		.init = dream_cheeky_init,
 		.write = dream_cheeky_write,
 	},
@@ -282,7 +274,6 @@ static const struct hidled_config hidled_configs[] = {
 		.num_leds = 2,
 		.report_size = 9,
 		.report_type = RAW_REQUEST,
-		.report_id = 1,
 		.init = thingm_init,
 		.write = thingm_write,
 	},
-- 
2.9.0

