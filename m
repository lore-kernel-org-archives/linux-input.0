From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: mms114 - Fix regulator enable and disable paths
Date: Sat,  2 Mar 2013 15:00:40 +0800
Message-ID: <1362207641-25152-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42108 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab3CBHqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Mar 2013 02:46:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

When it uses regulators the mms114 driver checks to see if it managed to
acquire regulators and ignores errors. This is not the intended usage and
not great style in general.

Since the driver already refuses to probe if it fails to allocate the
regulators simply make the enable and disable calls unconditional and
add appropriate error handling.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/mms114.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 4a29ddf..bb95c89 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -314,10 +314,21 @@ static int mms114_start(struct mms114_data *data)
 	struct i2c_client *client = data->client;
 	int error;
 
-	if (data->core_reg)
-		regulator_enable(data->core_reg);
-	if (data->io_reg)
-		regulator_enable(data->io_reg);
+	error = regulator_enable(data->core_reg);
+	if (error != 0) {
+		dev_err(&client->dev, "Failed to enable avdd: %d\n",
+			error);
+		return error;
+	}
+
+	error = regulator_enable(data->io_reg);
+	if (error != 0) {
+		dev_err(&client->dev, "Failed to enable vdd: %d\n",
+			error);
+		regulator_disable(data->core_reg);
+		return error;
+	}
+
 	mdelay(MMS114_POWERON_DELAY);
 
 	error = mms114_setup_regs(data);
@@ -335,16 +346,20 @@ static int mms114_start(struct mms114_data *data)
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

