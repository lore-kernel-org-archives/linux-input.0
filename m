From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 2/2] input: goodix: Add device tree support for 5-finger chips
Date: Wed,  4 Mar 2015 11:34:13 +0300
Message-ID: <1425458053-4559-1-git-send-email-mamlinav@gmail.com>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:45295 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbbCDIe4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 03:34:56 -0500
In-Reply-To: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>, Aleksei Mamlin <mamlinav@gmail.com>

This patch adds device tree support for 5-finger chips, like GT911 and GT912.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/input/touchscreen/goodix.txt          |  4 ++-
 drivers/input/touchscreen/goodix.c                 | 40 +++++++++++++++++-----
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index cbaf085..368e57f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -2,7 +2,9 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 
 Required properties:
 
- - compatible		: Should be "goodix,gt9110"
+ - compatible		: Should be "goodix,gt911"
+				 or "goodix,gt9110"
+				 or "goodix,gt912"
 				 or "goodix,gt927"
 				 or "goodix,gt9271"
 				 or "goodix,gt928"
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 16f016a..3da31d1 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
@@ -101,7 +102,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 	}
 
 	touch_num = data[0] & 0x0f;
-	if (touch_num > GOODIX_MAX_CONTACTS)
+	if (touch_num > ts->max_touch_num)
 		return -EPROTO;
 
 	if (touch_num > 1) {
@@ -143,7 +144,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
  */
 static void goodix_process_events(struct goodix_ts_data *ts)
 {
-	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
+	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
 	int touch_num;
 	int i;
 
@@ -297,7 +298,7 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
-	input_mt_init_slots(ts->input_dev, GOODIX_MAX_CONTACTS,
+	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
 			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 
 	ts->input_dev->name = "Goodix Capacitive TouchScreen";
@@ -317,9 +318,16 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id goodix_of_match[];
+#endif
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
+#ifdef CONFIG_OF
+	const struct of_device_id *match;
+#endif
 	struct goodix_ts_data *ts;
 	unsigned long irq_flags;
 	int error;
@@ -336,6 +344,20 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
+	ts->max_touch_num = GOODIX_MAX_CONTACTS;
+
+#ifdef CONFIG_OF
+	if (client->dev.of_node) {
+		match = of_match_device(of_match_ptr(goodix_of_match),
+							&client->dev);
+		if (!match) {
+			dev_err(&client->dev, "Unknown device model\n");
+			return -EINVAL;
+		}
+		ts->max_touch_num = (unsigned int)match->data;
+	}
+#endif
+
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
 
@@ -384,11 +406,13 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 
 #ifdef CONFIG_OF
 static struct of_device_id goodix_of_match[] = {
-	{ .compatible = "goodix,gt9110" },
-	{ .compatible = "goodix,gt927" },
-	{ .compatible = "goodix,gt9271" },
-	{ .compatible = "goodix,gt928" },
-	{ .compatible = "goodix,gt967" },
+	{ .compatible = "goodix,gt911",  .data = (void *) 5 },
+	{ .compatible = "goodix,gt9110", .data = (void *) 10 },
+	{ .compatible = "goodix,gt912",  .data = (void *) 5 },
+	{ .compatible = "goodix,gt927",  .data = (void *) 10 },
+	{ .compatible = "goodix,gt9271", .data = (void *) 10 },
+	{ .compatible = "goodix,gt928",  .data = (void *) 10 },
+	{ .compatible = "goodix,gt967",  .data = (void *) 10 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, goodix_of_match);
-- 
2.0.5

