From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/2] Input: atmel_mxt_ts: Add support for reset line
Date: Mon,  3 Jul 2017 14:38:43 +0200
Message-ID: <20170703123843.19340-3-sebastian.reichel@collabora.co.uk>
References: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Provide support for controlling reset pin. If this is not driven
correctly the device will be held in reset and will not respond.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 1852906517ab..23e3abc3fdef 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -22,6 +22,8 @@ Optional properties for main touchpad device:
     experiment to determine which bit corresponds to which input. Use
     KEY_RESERVED for unused padding values.
 
+- reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
+
 Example:
 
 	touch@4b {
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9a7b8eba64a6..599f92363188 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ioctl.h>
@@ -300,6 +301,7 @@ struct mxt_data {
 	u8 multitouch;
 	struct t7_config t7_cfg;
 	struct mxt_dbg dbg;
+	struct gpio_desc *reset_gpio;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -3133,6 +3135,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(data->reset_gpio)) {
+		error = PTR_ERR(data->reset_gpio);
+		dev_err(&client->dev, "Failed to get reset gpio: %d\n", error);
+		return error;
+	}
+
 	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 				     mxt_interrupt,
 				     pdata->irqflags | IRQF_ONESHOT,
@@ -3142,6 +3152,18 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
+	if (data->reset_gpio) {
+		data->in_bootloader = true;
+		msleep(MXT_RESET_TIME);
+		reinit_completion(&data->bl_completion);
+		gpiod_set_value(data->reset_gpio, 1);
+		error = mxt_wait_for_completion(data, &data->bl_completion,
+						MXT_RESET_TIMEOUT);
+		if (error)
+			return error;
+		data->in_bootloader = false;
+	}
+
 	disable_irq(client->irq);
 
 	error = mxt_initialize(data);
-- 
2.13.2
