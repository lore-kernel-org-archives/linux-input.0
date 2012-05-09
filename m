From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mpu3050: set IRQF_ONESHOT when requesting the
 interrupt
Date: Tue, 8 May 2012 22:23:01 -0700
Message-ID: <20120509052301.GB10514@core.coreip.homeip.net>
References: <1335894406-27428-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41202 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab2EIFXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 01:23:07 -0400
Received: by pbbrp8 with SMTP id rp8so24847pbb.19
        for <linux-input@vger.kernel.org>; Tue, 08 May 2012 22:23:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335894406-27428-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Alan Cox <alan@linux.intel.com>

Hi Stephen,

On Tue, May 01, 2012 at 11:46:46AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 1c6c695 "genirq: Reject bogus threaded irq requests" requires
> that request_threaded_irq() either be passed an explicit handler, or
> that IRQF_ONESHOT be set. Set this flag.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thank you.

BTW, since it appears you have the hardware any chance you could try the
patch below? I had it in my queue for a while but Alan disappeared and
I didn't have anyone to test it.

Thanks.

-- 
Dmitry


Input: mpu3050 - Support for polled input device

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The driver does not need to depend on interrupts.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig   |    7 +
 drivers/input/misc/mpu3050.c |  268 +++++++++++++++++++++++++++++++++---------
 2 files changed, 219 insertions(+), 56 deletions(-)


diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7faf4a7..8d41bdc 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -177,6 +177,13 @@ config INPUT_MPU3050
 	  To compile this driver as a module, choose M here: the
 	  module will be called mpu3050.
 
+config INPUT_MPU3050_POLLED_MODE
+	bool "Enable polling mode support"
+	depends on INPUT_MPU3050
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you need gyroscope to work in polling mode.
+
 config INPUT_APANEL
 	tristate "Fujitsu Lifebook Application Panel buttons"
 	depends on X86 && I2C && LEDS_CLASS
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 306f84c..a229a4f 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -37,6 +37,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
@@ -102,6 +103,8 @@
 #define MPU3050_PWR_MGM_RESET		0x80
 #define MPU3050_PWR_MGM_MASK		0x40
 
+#define MPU3050_DEFAULT_POLL_INTERVAL	200
+
 struct axis_data {
 	s16 x;
 	s16 y;
@@ -112,6 +115,9 @@ struct mpu3050_sensor {
 	struct i2c_client *client;
 	struct device *dev;
 	struct input_dev *idev;
+#ifdef CONFIG_INPUT_MPU3050_POLLED_MODE
+	struct input_polled_dev *input_polled;
+#endif
 };
 
 /**
@@ -169,6 +175,40 @@ static void mpu3050_read_xyz(struct i2c_client *client,
 }
 
 /**
+ *	mpu3050_report_xyz	-	read and report coordinates
+ *	@sensor: the sensor
+ *
+ *	Reads coordinates from the device and reports them to input
+ *	core.
+ */
+static void mpu3050_report_xyz(struct mpu3050_sensor *sensor)
+{
+	struct axis_data axis;
+
+	mpu3050_read_xyz(sensor->client, &axis);
+
+	input_report_abs(sensor->idev, ABS_X, axis.x);
+	input_report_abs(sensor->idev, ABS_Y, axis.y);
+	input_report_abs(sensor->idev, ABS_Z, axis.z);
+	input_sync(sensor->idev);
+}
+
+/**
+ *	mpu3050_interrupt_thread	-	handle an IRQ
+ *	@irq: interrupt number
+ *	@data: the sensor
+ *
+ *	Called by the kernel single threaded after an interrupt occurs. Read
+ *	the sensor data and generate an input event for it.
+ */
+static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
+{
+	mpu3050_report_xyz(data);
+
+	return IRQ_HANDLED;
+}
+
+/**
  *	mpu3050_set_power_mode	-	set the power mode
  *	@client: i2c client for the sensor
  *	@val: value to switch on/off of power, 1: normal power, 0: low power
@@ -228,30 +268,154 @@ static void mpu3050_input_close(struct input_dev *input)
 	pm_runtime_put(sensor->dev);
 }
 
+static void __devinit mpu3050_init_idev(struct mpu3050_sensor *sensor,
+						struct input_dev *idev)
+{
+	idev->name = "MPU3050";
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &sensor->client->dev;
+
+	__set_bit(EV_ABS, idev->evbit);
+	input_set_abs_params(idev, ABS_X,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Y,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Z,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+}
+
 /**
- *	mpu3050_interrupt_thread	-	handle an IRQ
- *	@irq: interrupt numner
- *	@data: the sensor
+ *	mpu3050_create_polled_idev - creates input device for the sensor
+ *	@sensor: the sensor
  *
- *	Called by the kernel single threaded after an interrupt occurs. Read
- *	the sensor data and generate an input event for it.
+ *	Called from mpu3050_probe() when setting up device in interrupt-driven
+ *	mode.
  */
-static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
+static int __devinit mpu3050_create_idev(struct mpu3050_sensor *sensor)
 {
-	struct mpu3050_sensor *sensor = data;
-	struct axis_data axis;
+	struct input_dev *idev;
+	int err;
 
-	mpu3050_read_xyz(sensor->client, &axis);
+	idev = input_allocate_device();
+	if (!idev)
+		return -ENODEV;
 
-	input_report_abs(sensor->idev, ABS_X, axis.x);
-	input_report_abs(sensor->idev, ABS_Y, axis.y);
-	input_report_abs(sensor->idev, ABS_Z, axis.z);
-	input_sync(sensor->idev);
+	mpu3050_init_idev(sensor, idev);
 
-	return IRQ_HANDLED;
+	idev->open = mpu3050_input_open;
+	idev->close = mpu3050_input_close;
+	input_set_drvdata(idev, sensor);
+
+	err = input_register_device(idev);
+	if (err) {
+		input_free_device(idev);
+		return err;
+	}
+
+	sensor->idev = idev;
+
+	return 0;
+}
+
+#ifdef CONFIG_INPUT_MPU3050_POLLED_MODE
+/**
+ *	mpu3050_poll_open	-	called when opening polled device
+ *	@ipoll_dev: polled input device being opened
+ *
+ *	The input layer calls this function when polled device is opened.
+ *	The function will cause the device to resume. Then, the device is
+ *	ready to provide data.
+ */
+static void mpu3050_poll_open(struct input_polled_dev *ipoll_dev)
+{
+	struct mpu3050_sensor *sensor = ipoll_dev->private;
+
+	mpu3050_set_power_mode(sensor->client, 1);
+	msleep(100);  /* wait for gyro chip resume */
+}
+
+/**
+ *	mpu3050_poll_close	-	called when closing polled device
+ *	@ipoll_dev: polled input device being closed
+ *
+ *	The input layer calls this function when polled device is closed.
+ *	The function will push the device to suspend.
+ */
+static void mpu3050_poll_close(struct input_polled_dev *ipoll_dev)
+{
+	struct mpu3050_sensor *sensor = ipoll_dev->private;
+
+	mpu3050_set_power_mode(sensor->client, 0);
 }
 
 /**
+ *	mpu3050_poll	-	polls the device and reports coordinated
+ *	@dev: device that is being polled
+ *
+ *	Called by polled device core at specified intervals.
+ */
+static void mpu3050_poll(struct input_polled_dev *dev)
+{
+	mpu3050_report_xyz(dev->private);
+}
+
+/**
+ *	mpu3050_create_polled_idev - creates polled input device for the sensor
+ *	@sensor: the sensor
+ *
+ *	Called from mpu3050_probe() when setting up device in polled mode.
+ */
+static int __devinit mpu3050_create_polled_idev(struct mpu3050_sensor *sensor)
+{
+	struct input_polled_dev *ipoll_dev;
+	int err;
+
+	ipoll_dev = input_allocate_polled_device();
+	if (!ipoll_dev)
+		return -ENOMEM;
+
+	sensor->input_polled = ipoll_dev;
+	sensor->idev = ipoll_dev->input;
+
+	ipoll_dev->private = sensor;
+	ipoll_dev->open = mpu3050_poll_open;
+	ipoll_dev->close = mpu3050_poll_close;
+	ipoll_dev->poll = mpu3050_poll;
+	ipoll_dev->poll_interval = MPU3050_DEFAULT_POLL_INTERVAL;
+	ipoll_dev->poll_interval_min = 10;
+	ipoll_dev->poll_interval_max = MPU3050_DEFAULT_POLL_INTERVAL;
+
+	mpu3050_init_idev(sensor, ipoll_dev->input);
+
+	err = input_register_polled_device(ipoll_dev);
+	if (err) {
+		input_free_polled_device(ipoll_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __devexit mpu3050_teardown_polled_idev(struct mpu3050_sensor *sensor)
+{
+	input_unregister_polled_device(sensor->input_polled);
+	input_free_polled_device(sensor->input_polled);
+}
+
+#else
+
+static inline int mpu3050_create_polled_idev(struct mpu3050_sensor *sensor)
+{
+	return -ENOSYS;
+}
+
+static inline void mpu3050_teardown_polled_idev(struct mpu3050_sensor *sensor)
+{
+}
+
+#endif
+
+/**
  *	mpu3050_hw_init	-	initialize hardware
  *	@sensor: the sensor
  *
@@ -310,21 +474,17 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct mpu3050_sensor *sensor;
-	struct input_dev *idev;
 	int ret;
 	int error;
 
 	sensor = kzalloc(sizeof(struct mpu3050_sensor), GFP_KERNEL);
-	idev = input_allocate_device();
-	if (!sensor || !idev) {
+	if (!sensor) {
 		dev_err(&client->dev, "failed to allocate driver data\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	sensor->client = client;
 	sensor->dev = &client->dev;
-	sensor->idev = idev;
 
 	mpu3050_set_power_mode(client, 1);
 	msleep(10);
@@ -342,43 +502,35 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	idev->name = "MPU3050";
-	idev->id.bustype = BUS_I2C;
-	idev->dev.parent = &client->dev;
-
-	idev->open = mpu3050_input_open;
-	idev->close = mpu3050_input_close;
-
-	__set_bit(EV_ABS, idev->evbit);
-	input_set_abs_params(idev, ABS_X,
-			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
-	input_set_abs_params(idev, ABS_Y,
-			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
-	input_set_abs_params(idev, ABS_Z,
-			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
-
-	input_set_drvdata(idev, sensor);
-
 	pm_runtime_set_active(&client->dev);
 
 	error = mpu3050_hw_init(sensor);
 	if (error)
 		goto err_pm_set_suspended;
 
-	error = request_threaded_irq(client->irq,
-				     NULL, mpu3050_interrupt_thread,
-				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				     "mpu3050", sensor);
-	if (error) {
-		dev_err(&client->dev,
-			"can't get IRQ %d, error %d\n", client->irq, error);
-		goto err_pm_set_suspended;
-	}
-
-	error = input_register_device(idev);
-	if (error) {
-		dev_err(&client->dev, "failed to register input device\n");
-		goto err_free_irq;
+	if (client->irq) {
+		error = mpu3050_create_idev(sensor);
+		if (error) {
+			dev_err(&client->dev, "failed to create input device\n");
+			goto err_pm_set_suspended;
+		}
+
+		error = request_threaded_irq(client->irq,
+					     NULL, mpu3050_interrupt_thread,
+					     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					     "mpu3050", sensor);
+		if (error) {
+			dev_err(&client->dev, "can't get IRQ %d, error %d\n",
+					client->irq, error);
+			goto err_destroy_input;
+		}
+	} else {
+		error = mpu3050_create_polled_idev(sensor);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to create polled input device");
+			goto err_pm_set_suspended;
+		}
 	}
 
 	pm_runtime_enable(&client->dev);
@@ -386,12 +538,11 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 
 	return 0;
 
-err_free_irq:
-	free_irq(client->irq, sensor);
+err_destroy_input:
+	input_unregister_device(sensor->idev);
 err_pm_set_suspended:
 	pm_runtime_set_suspended(&client->dev);
 err_free_mem:
-	input_free_device(idev);
 	kfree(sensor);
 	return error;
 }
@@ -409,8 +560,13 @@ static int __devexit mpu3050_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	free_irq(client->irq, sensor);
-	input_unregister_device(sensor->idev);
+	if (client->irq) {
+		free_irq(client->irq, sensor);
+		input_unregister_device(sensor->idev);
+	} else {
+		mpu3050_teardown_polled_idev(sensor);
+	}
+
 	kfree(sensor);
 
 	return 0;
