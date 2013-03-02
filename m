From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: mms114 - Fix regulator enable and disable paths
Date: Sat,  2 Mar 2013 16:20:56 +0800
Message-ID: <1362212456-21941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35073 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208Ab3CBIV2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Mar 2013 03:21:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

When it uses regulators the mms114 driver checks to see if it managed to
acquire regulators and ignores errors. This is not the intended usage and
not great style in general.

Since the driver already refuses to probe if it fails to allocate the
regulators simply make the enable and disable calls unconditional and
add appropriate error handling, including adding cleanup of the
regulators if setup_reg() fails.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/mms114.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 4a29ddf..662e34b 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -314,15 +314,27 @@ static int mms114_start(struct mms114_data *data)
 	struct i2c_client *client = data->client;
 	int error;
 
-	if (data->core_reg)
-		regulator_enable(data->core_reg);
-	if (data->io_reg)
-		regulator_enable(data->io_reg);
+	error = regulator_enable(data->core_reg);
+	if (error != 0) {
+		dev_err(&client->dev, "Failed to enable avdd: %d\n", error);
+		return error;
+	}
+
+	error = regulator_enable(data->io_reg);
+	if (error != 0) {
+		dev_err(&client->dev, "Failed to enable vdd: %d\n", error);
+		regulator_disable(data->core_reg);
+		return error;
+	}
+
 	mdelay(MMS114_POWERON_DELAY);
 
 	error = mms114_setup_regs(data);
-	if (error < 0)
+	if (error < 0) {
+		regulator_disable(data->io_reg);
+		regulator_disable(data->core_reg);
 		return error;
+	}
 
 	if (data->pdata->cfg_pin)
 		data->pdata->cfg_pin(true);
@@ -335,16 +347,20 @@ static int mms114_start(struct mms114_data *data)
 static void mms114_stop(struct mms114_data *data)
 {
 	struct i2c_client *client = data->client;
+	int error;
 
 	disable_irq(client->irq);
 
 	if (data->pdata->cfg_pin)
 		data->pdata->cfg_pin(false);
 
-	if (data->io_reg)
-		regulator_disable(data->io_reg);
-	if (data->core_reg)
-		regulator_disable(data->core_reg);
+	error = regulator_disable(data->io_reg);
+	if (error != 0)
+		dev_warn(&client->dev, "Failed to disable vdd: %d\n", error);
+
+	error = regulator_disable(data->core_reg);
+	if (error != 0)
+		dev_warn(&client->dev, "Failed to disable avdd: %d\n", error);
 }
 
 static int mms114_input_open(struct input_dev *dev)
-- 
1.7.10.4

