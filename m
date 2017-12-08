From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 4/5] Input: edt-ft5x06 - Add support for regulator
Date: Fri,  8 Dec 2017 22:54:18 +0100
Message-ID: <20171208215419.30396-5-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51833 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbdLHVzA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 16:55:00 -0500
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: simon.budig@kernelconcepts.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com

Add the support of regulator to use them as VCC source.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c53a3d7239e7..44b0e04a8f35 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -39,6 +39,7 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
 
 #define WORK_REGISTER_THRESHOLD		0x00
 #define WORK_REGISTER_REPORT_RATE	0x08
@@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
 	struct touchscreen_properties prop;
 	u16 num_x;
 	u16 num_y;
+	struct regulator *supply;
 
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
@@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	tsdata->max_support_points = chip_data->max_support_points;
 
+	tsdata->supply = devm_regulator_get_optional(&client->dev, "power");
+	if (IS_ERR(tsdata->supply)) {
+		error = PTR_ERR(tsdata->supply);
+		dev_err(&client->dev, "failed to request regulator: %d\n",
+			error);
+		return error;
+	};
+
+	if (tsdata->supply) {
+		error = regulator_enable(tsdata->supply);
+		if (error < 0) {
+			dev_err(&client->dev, "failed to enable supply: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						     "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(tsdata->reset_gpio)) {
@@ -1122,20 +1141,34 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
 static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
 
+	if (tsdata->supply)
+		regulator_disable(tsdata->supply);
+
 	return 0;
 }
 
 static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	int ret;
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
 
+	if (tsdata->supply) {
+		ret = regulator_enable(tsdata->supply);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable supply: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.11.0

