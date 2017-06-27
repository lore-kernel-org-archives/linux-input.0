From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH] atmel_mxt_ts: Add support for reset line
Date: Tue, 27 Jun 2017 18:24:38 +0200
Message-ID: <20170627162438.10108-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martyn Welch <martyn.welch-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Martyn Welch <martyn.welch-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

At least some of the Atmel Maxtouch touchscreen controllers have a reset
pin. If this is not driven correctly the device will be held in reset
and will not respond.

Add support for driving the reset line via GPIO as is found in other
such drivers.

Signed-off-by: Martyn Welch <martyn.welch-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
[add reset cycle during probe, minor style fixes, add DT binding]
Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 27 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

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
index dd042a9b0aaa..b84bf973fe36 100644
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
@@ -3135,12 +3137,26 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
 
+	data->reset_gpio = gpiod_get_optional(&client->dev, "reset",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(data->reset_gpio)) {
+		error = PTR_ERR(data->reset_gpio);
+		dev_err(&client->dev, "Failed to get reset gpio: %d\n", error);
+		goto err_free_mem;
+	}
+
+	if (data->reset_gpio) {
+		msleep(MXT_RESET_TIME);
+		gpiod_set_value(data->reset_gpio, 1);
+		msleep(MXT_RESET_TIME);
+	}
+
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
 				     pdata->irqflags | IRQF_ONESHOT,
 				     client->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		goto err_free_gpio;
 	}
 
 	disable_irq(client->irq);
@@ -3163,6 +3179,11 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	mxt_free_object_table(data);
 err_free_irq:
 	free_irq(client->irq, data);
+err_free_gpio:
+	if (data->reset_gpio) {
+		gpiod_set_value(data->reset_gpio, 0);
+		gpiod_put(data->reset_gpio);
+	}
 err_free_mem:
 	kfree(data);
 	return error;
@@ -3174,6 +3195,10 @@ static int mxt_remove(struct i2c_client *client)
 
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	free_irq(data->irq, data);
+	if (data->reset_gpio) {
+		gpiod_set_value(data->reset_gpio, 0);
+		gpiod_put(data->reset_gpio);
+	}
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
 	kfree(data);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
