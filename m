From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/3] input: mpu3050: Support for polled input device
Date: Thu, 15 Dec 2011 22:18:34 +0000
Message-ID: <20111215221829.8657.37926.stgit@bob.linux.org.uk>
References: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58665 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606Ab1LOWWu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 17:22:50 -0500
In-Reply-To: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The driver does not need to depend on interrupts.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/misc/mpu3050.c |  189 +++++++++++++++++++++++++++++++-----------
 1 files changed, 141 insertions(+), 48 deletions(-)


diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index f71dc72..da47b10 100644
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
@@ -53,6 +54,8 @@
 #define MPU3050_MIN_VALUE	-32768
 #define MPU3050_MAX_VALUE	32767
 
+#define MPU3050_DEFAULT_POLL_INTERVAL	200
+
 struct axis_data {
 	s16 x;
 	s16 y;
@@ -63,6 +66,7 @@ struct mpu3050_sensor {
 	struct i2c_client *client;
 	struct device *dev;
 	struct input_dev *idev;
+	struct input_polled_dev *input_polled;
 };
 
 /**
@@ -168,6 +172,38 @@ static void mpu3050_input_close(struct input_dev *input)
 	pm_runtime_put(sensor->dev);
 }
 
+static void mpu3050_poll_open(struct input_polled_dev *ipoll_dev)
+{
+	struct mpu3050_sensor *sensor = ipoll_dev->private;
+
+	mpu3050_set_power_mode(sensor->client, 1);
+	msleep(100);  /* wait for gyro chip resume */
+}
+
+static void mpu3050_poll_close(struct input_polled_dev *ipoll_dev)
+{
+	struct mpu3050_sensor *sensor = ipoll_dev->private;
+
+	mpu3050_set_power_mode(sensor->client, 1);
+}
+
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
+static void mpu3050_poll(struct input_polled_dev *dev)
+{
+	mpu3050_report_xyz(dev->private);
+}
+
 /**
  *	mpu3050_interrupt_thread	-	handle an IRQ
  *	@irq: interrupt numner
@@ -178,17 +214,82 @@ static void mpu3050_input_close(struct input_dev *input)
  */
 static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
 {
-	struct mpu3050_sensor *sensor = data;
-	struct axis_data axis;
+	mpu3050_report_xyz(data);
 
-	mpu3050_read_xyz(sensor->client, &axis);
+	return IRQ_HANDLED;
+}
 
-	input_report_abs(sensor->idev, ABS_X, axis.x);
-	input_report_abs(sensor->idev, ABS_Y, axis.y);
-	input_report_abs(sensor->idev, ABS_Z, axis.z);
-	input_sync(sensor->idev);
+static void __devinit mpu3050_init_idev(struct mpu3050_sensor *sensor,
+						struct input_dev *idev)
+{
+	idev->name = "MPU3050";
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &sensor->client->dev;
 
-	return IRQ_HANDLED;
+	__set_bit(EV_ABS, idev->evbit);
+	input_set_abs_params(idev, ABS_X,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Y,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Z,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+}
+
+static int __devinit mpu3050_create_idev(struct mpu3050_sensor *sensor)
+{
+	struct input_dev *idev;
+	int err;
+
+	idev = input_allocate_device();
+	if (!idev)
+		return -ENODEV;
+
+	mpu3050_init_idev(sensor, idev);
+
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
+static int __devinit mpu3050_create_polled_idev(struct mpu3050_sensor *sensor)
+{
+	struct input_polled_dev *ipoll_dev;
+	int err;
+
+	ipoll_dev = input_allocate_polled_device();
+	if (!ipoll_dev)
+		return -ENOMEM;
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
+	sensor->input_polled = ipoll_dev;
+	sensor->idev = ipoll_dev->input;
+
+	return 0;
 }
 
 /**
@@ -205,21 +306,17 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
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
@@ -237,39 +334,31 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
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
 
-	error = request_threaded_irq(client->irq,
-				     NULL, mpu3050_interrupt_thread,
-				     IRQF_TRIGGER_RISING,
-				     "mpu_int", sensor);
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
+	if (client->irq > 0) {
+		error = mpu3050_create_idev(sensor);
+		if (error) {
+			dev_err(&client->dev, "failed to register input device\n");
+			goto err_free_irq;
+		}
+
+		error = request_threaded_irq(client->irq,
+				NULL, mpu3050_interrupt_thread,
+				IRQF_TRIGGER_RISING,
+				"mpu_int", sensor);
+		if (error) {
+			dev_err(&client->dev, "can't get IRQ %d, error %d\n",
+					client->irq, error);
+			goto err_pm_set_suspended;
+		}
+	} else {
+		error = mpu3050_create_polled_idev(sensor);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to register polled input device");
+			goto err_pm_set_suspended;
+		}
 	}
 
 	pm_runtime_enable(&client->dev);
@@ -282,7 +371,6 @@ err_free_irq:
 err_pm_set_suspended:
 	pm_runtime_set_suspended(&client->dev);
 err_free_mem:
-	input_free_device(idev);
 	kfree(sensor);
 	return error;
 }
@@ -300,8 +388,13 @@ static int __devexit mpu3050_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-	free_irq(client->irq, sensor);
-	input_unregister_device(sensor->idev);
+	if (client->irq > 0) {
+		free_irq(client->irq, sensor);
+		input_unregister_device(sensor->idev);
+	} else {
+		input_unregister_polled_device(sensor->input_polled);
+		input_free_polled_device(sensor->input_polled);
+	}
 	kfree(sensor);
 
 	return 0;

