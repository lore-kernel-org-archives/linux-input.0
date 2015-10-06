From: fcooper@ti.com
Subject: [PATCH] Input: edt-ft5x06 - Only call desc_to_gpio for valid gpios
Date: Tue,  6 Oct 2015 16:49:47 -0500
Message-ID: <1444168187-3542-1-git-send-email-fcooper@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33559 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbJFVt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 17:49:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>

From: Franklin S Cooper Jr <fcooper@ti.com>

Since reset and wake pin are optional the gpio structure for those
pins may be null. Therefore, they can't be blindly passed to
desc_to_gpio.

Only use desc_to_gpio for valid gpios.

This issue was detected by Smatch
http://permalink.gmane.org/gmane.linux.kernel.input/45927

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
This patch is based on top of the following patchset which already
is already in linux-next:
https://patchwork.kernel.org/patch/7166931/

 drivers/input/touchscreen/edt-ft5x06.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 7239c31..f877404 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -876,11 +876,13 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	struct edt_ft5x06_ts_data *tsdata;
 	struct input_dev *input;
 	unsigned long irq_flags;
-	int error;
+	int error, reset_pin, wake_pin;
 	char fw_version[EDT_NAME_LEN];
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
+	reset_pin = wake_pin = -1;
+
 	tsdata = devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
 	if (!tsdata) {
 		dev_err(&client->dev, "failed to allocate driver data.\n");
@@ -908,12 +910,14 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	if (tsdata->wake_gpio) {
 		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(tsdata->wake_gpio, 1);
+		wake_pin = desc_to_gpio(tsdata->wake_gpio);
 	}
 
 	if (tsdata->reset_gpio) {
 		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
 		msleep(300);
+		reset_pin = desc_to_gpio(tsdata->reset_gpio);
 	}
 
 	input = devm_input_allocate_device(&client->dev);
@@ -987,8 +991,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
-		client->irq, desc_to_gpio(tsdata->wake_gpio),
-		desc_to_gpio(tsdata->reset_gpio));
+		client->irq, wake_pin, reset_pin);
 
 	return 0;
 
-- 
2.6.1

