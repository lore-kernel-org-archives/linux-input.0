From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: edt-ft5x06 - drop parsing of irq gpio
Date: Sat, 12 Sep 2015 10:45:47 -0700
Message-ID: <03f40f56533bf28d5d15ade083f5b6400b1c4432.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34107 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbbILRpz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2015 13:45:55 -0400
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

The driver does not use irq gpio as gpio, but rather relies on I2C core or
board code to set up client's structure IRQ line, so let's stop trying to
locate the resource and parse it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5738722..df76f19 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -92,7 +92,6 @@ struct edt_ft5x06_ts_data {
 
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
-	struct gpio_desc *irq_gpio;
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *debug_dir;
@@ -927,15 +926,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	tsdata->irq_gpio = devm_gpiod_get_optional(&client->dev,
-						   "irq", GPIOD_IN);
-	if (IS_ERR(tsdata->irq_gpio)) {
-		error = PTR_ERR(tsdata->irq_gpio);
-		dev_err(&client->dev,
-			"Failed to request GPIO irq pin, error %d\n", error);
-		return error;
-	}
-
 	if (tsdata->wake_gpio) {
 		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(tsdata->wake_gpio, 1);
-- 
2.6.0.rc0.131.gf624c3d

