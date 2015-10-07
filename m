From: fcooper@ti.com
Subject: [RFC 2/4] Input: edt-ft5x06 - Add support for different max support points
Date: Wed,  7 Oct 2015 07:21:39 -0500
Message-ID: <1444220501-23623-3-git-send-email-fcooper@ti.com>
References: <1444220501-23623-1-git-send-email-fcooper@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33660 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbJGMWM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 08:22:12 -0400
In-Reply-To: <1444220501-23623-1-git-send-email-fcooper@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, fcooper@ti.com, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com

From: Franklin S Cooper Jr <fcooper@ti.com>

Update the code so that the maximum supported points aren't hard coded but
can be changed.

Set the maximum support points based on the data passed along side the
compatible field.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 56 ++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 1e0ed6e..8031152 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -38,8 +38,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
-
-#define MAX_SUPPORT_POINTS		5
+#include <linux/of_device.h>
 
 #define WORK_REGISTER_THRESHOLD		0x00
 #define WORK_REGISTER_REPORT_RATE	0x08
@@ -105,6 +104,7 @@ struct edt_ft5x06_ts_data {
 	int gain;
 	int offset;
 	int report_rate;
+	int max_support_points;
 
 	char name[EDT_NAME_LEN];
 
@@ -112,6 +112,10 @@ struct edt_ft5x06_ts_data {
 	enum edt_ver version;
 };
 
+struct edt_i2c_chip_data {
+	int  max_support_points;
+};
+
 static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
 				   u16 wr_len, u8 *wr_buf,
 				   u16 rd_len, u8 *rd_buf)
@@ -180,14 +184,14 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		tplen = 4;  /* data comes in so called frames */
 
 		/* how many bytes to listen for */
-		datalen = tplen * MAX_SUPPORT_POINTS + offset + 1;
+		datalen = tplen * tsdata->max_support_points + offset + 1;
 		break;
 
 	case M09:
 		cmd = 0x02;
 		offset = 1;
 		tplen = 6;
-		datalen = tplen * MAX_SUPPORT_POINTS - cmd + 1;
+		datalen = tplen * tsdata->max_support_points - cmd + 1;
 		break;
 
 	default:
@@ -219,7 +223,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 			goto out;
 	}
 
-	for (i = 0; i < MAX_SUPPORT_POINTS; i++) {
+	for (i = 0; i < tsdata->max_support_points; i++) {
 		u8 *buf = &rdbuf[i * tplen + offset];
 		bool down;
 
@@ -872,6 +876,32 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
+#ifdef CONFIG_OF
+
+static const struct of_device_id edt_ft5x06_of_match[];
+
+static void edt_ft5x06_ts_set_max_support_points(struct device *dev,
+					struct edt_ft5x06_ts_data *tsdata)
+{
+	struct edt_i2c_chip_data *chip_data;
+	const struct of_device_id *match;
+
+	match = of_match_device(of_match_ptr(edt_ft5x06_of_match), dev);
+
+	if (match) {
+		chip_data = (struct edt_i2c_chip_data *)match->data;
+		tsdata->max_support_points = chip_data->max_support_points;
+	} else {
+		tsdata->max_support_points = 5;
+	}
+}
+#else
+static void edt_ft5x06_ts_set_max_support_points(struct device *dev,
+					struct edt_ft5x06_ts_data *tsdata)
+{
+}
+#endif
+
 static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -889,6 +919,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
+	edt_ft5x06_ts_set_max_support_points(&client->dev, tsdata);
+
 	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						     "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(tsdata->reset_gpio)) {
@@ -954,7 +986,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	touchscreen_parse_properties(input, true);
 
-	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
+	error = input_mt_init_slots(input, tsdata->max_support_points,
+				INPUT_MT_DIRECT);
 	if (error) {
 		dev_err(&client->dev, "Unable to init MT slots.\n");
 		return error;
@@ -1039,10 +1072,15 @@ static const struct i2c_device_id edt_ft5x06_ts_id[] = {
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
 
 #ifdef CONFIG_OF
+
+static const struct edt_i2c_chip_data edt_ft5x06_data = {
+	.max_support_points = 5,
+};
+
 static const struct of_device_id edt_ft5x06_of_match[] = {
-	{ .compatible = "edt,edt-ft5206", },
-	{ .compatible = "edt,edt-ft5306", },
-	{ .compatible = "edt,edt-ft5406", },
+	{ .compatible = "edt,edt-ft5206", .data = &edt_ft5x06_data},
+	{ .compatible = "edt,edt-ft5306", .data = &edt_ft5x06_data},
+	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
-- 
2.6.1

