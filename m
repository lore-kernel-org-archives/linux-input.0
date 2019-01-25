From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/4] input: misc: gp2a: Add support for light sensor
Date: Fri, 25 Jan 2019 18:50:43 +0100
Message-ID: <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The gp2a driver previously only supported the proximity part of the
sensor while the hardware supports both.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/Kconfig         |  2 +
 drivers/input/misc/gp2ap002a00f.c  | 71 +++++++++++++++++++++++++++++-
 include/linux/input/gp2ap002a00f.h |  4 ++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2be9bc5..a532efb4e6d8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -252,6 +252,8 @@ config INPUT_GP2A
 	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
 	depends on I2C
 	depends on GPIOLIB || COMPILE_TEST
+	depends on IIO
+	select INPUT_POLLDEV
 	help
 	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
 	  hooked to an I2C bus.
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 79c8c4c56d1a..090c8c313295 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -10,9 +10,12 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
@@ -20,7 +23,9 @@
 #include <linux/input/gp2ap002a00f.h>
 
 struct gp2a_data {
+	struct iio_channel *channel;
 	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	const struct gp2a_platform_data *pdata;
 	struct i2c_client *i2c_client;
 };
@@ -58,6 +63,19 @@ static irqreturn_t gp2a_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static void gp2a_poll(struct input_polled_dev *dev)
+{
+	struct gp2a_data *dt = dev->private;
+	int ret, value;
+
+	ret = iio_read_channel_processed(dt->channel, &value);
+	if (ret < 0)
+		dev_err(&dt->i2c_client->dev, "failed to read value!");
+
+	input_report_abs(dev->input, ABS_MISC, value);
+	input_sync(dev->input);
+}
+
 static int gp2a_enable(struct gp2a_data *dt)
 {
 	return i2c_smbus_write_byte_data(dt->i2c_client, GP2A_ADDR_OPMOD,
@@ -127,7 +145,7 @@ static int gp2a_probe(struct i2c_client *client,
 {
 	const struct gp2a_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct gp2a_data *dt;
-	int error;
+	int error, value;
 
 	if (!pdata)
 		return -EINVAL;
@@ -152,6 +170,49 @@ static int gp2a_probe(struct i2c_client *client,
 	dt->pdata = pdata;
 	dt->i2c_client = client;
 
+	dt->channel = devm_iio_channel_get(&client->dev, "light");
+	if (!IS_ERR(dt->channel)) {
+		if (!dt->channel->indio_dev) {
+			error = -ENXIO;
+			goto err_hw_shutdown;
+		}
+
+		if (dt->pdata->light_adc_max <= 0 ||
+			dt->pdata->light_adc_fuzz <= 0) {
+			error = -EINVAL;
+			goto err_hw_shutdown;
+		}
+
+		dt->poll_dev = devm_input_allocate_polled_device(&client->dev);
+		if (!dt->poll_dev) {
+			dev_err(&client->dev,
+				"failed to allocate polled input device");
+			error = -ENOMEM;
+			goto err_hw_shutdown;
+		}
+
+		if (!device_property_read_u32(&client->dev, "poll-interval",
+					      &value))
+			dt->poll_dev->poll_interval = value;
+
+		dt->poll_dev->poll = gp2a_poll;
+		dt->poll_dev->private = dt;
+
+		dt->poll_dev->input->name = GP2A_I2C_NAME;
+
+		input_set_capability(dt->poll_dev->input, EV_ABS, ABS_MISC);
+		input_set_abs_params(dt->poll_dev->input, ABS_MISC, 0,
+				     dt->pdata->light_adc_max,
+				     dt->pdata->light_adc_fuzz, 0);
+
+		error = input_register_polled_device(dt->poll_dev);
+		if (error)
+			goto err_hw_shutdown;
+	} else if (PTR_ERR(dt->channel) == -EPROBE_DEFER) {
+		error = -EPROBE_DEFER;
+		goto err_hw_shutdown;
+	}
+
 	error = gp2a_initialize(dt);
 	if (error < 0)
 		goto err_hw_shutdown;
@@ -203,6 +264,8 @@ static int gp2a_remove(struct i2c_client *client)
 	const struct gp2a_platform_data *pdata = dt->pdata;
 
 	input_unregister_device(dt->input);
+	if (dt->poll_dev)
+		input_unregister_polled_device(dt->poll_dev);
 
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
@@ -243,6 +306,12 @@ static int __maybe_unused gp2a_resume(struct device *dev)
 		mutex_unlock(&dt->input->mutex);
 	}
 
+	if (dt->poll_dev) {
+		/* Out of range value so real value goes through next */
+		input_abs_set_val(dt->poll_dev->input, ABS_MISC,
+				  -dt->pdata->light_adc_max);
+	}
+
 	return retval;
 }
 
diff --git a/include/linux/input/gp2ap002a00f.h b/include/linux/input/gp2ap002a00f.h
index 3614a13a8297..0212948897b4 100644
--- a/include/linux/input/gp2ap002a00f.h
+++ b/include/linux/input/gp2ap002a00f.h
@@ -12,12 +12,16 @@
  * @wakeup: Set to true if the proximity can wake the device from suspend
  * @hw_setup: Callback for setting up hardware such as gpios and vregs
  * @hw_shutdown: Callback for properly shutting down hardware
+ * @light_adc_max: Maximum adc value the light sensor will read
+ * @light_adc_fuzz: Fuzz value for light adc sensor
  */
 struct gp2a_platform_data {
 	int vout_gpio;
 	bool wakeup;
 	int (*hw_setup)(struct i2c_client *client);
 	int (*hw_shutdown)(struct i2c_client *client);
+	int light_adc_max;
+	int light_adc_fuzz;
 };
 
 #endif
-- 
2.17.1
