From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Thu, 28 Dec 2017 17:33:35 +0100
Message-ID: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, quentin.schulz@free-electrons.com
List-Id: linux-input@vger.kernel.org

Add the support of regulator to use it as VCC source.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
 drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 025cf8c9324a..48e975b9c1aa 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -30,6 +30,7 @@ Required properties:
 Optional properties:
  - reset-gpios: GPIO specification for the RESET input
  - wake-gpios:  GPIO specification for the WAKE input
+ - vcc-supply:  Regulator that supplies the touchscreen
 
  - pinctrl-names: should be "default"
  - pinctrl-0:   a phandle pointing to the pin settings for the
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c53a3d7239e7..5ee14a25a382 100644
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
+	struct regulator *vcc;
 
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
@@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	tsdata->max_support_points = chip_data->max_support_points;
 
+	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(tsdata->vcc)) {
+		error = PTR_ERR(tsdata->vcc);
+		dev_err(&client->dev, "failed to request regulator: %d\n",
+			error);
+		return error;
+	};
+
+	if (tsdata->vcc) {
+		error = regulator_enable(tsdata->vcc);
+		if (error < 0) {
+			dev_err(&client->dev, "failed to enable vcc: %d\n",
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
 
+	if (tsdata->vcc)
+		regulator_disable(tsdata->vcc);
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
 
+	if (tsdata->vcc) {
+		ret = regulator_enable(tsdata->vcc);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable vcc: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.11.0
