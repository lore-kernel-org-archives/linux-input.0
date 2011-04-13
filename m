From: Alan Cox <alan@linux.jf.intel.com>
Subject: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope chip.
Date: Wed, 13 Apr 2011 10:51:40 +0100
Message-ID: <20110413095049.10407.35173.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54134 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757164Ab1DMKJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 06:09:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by localhost.localdomain (8.14.4/8.14.4) with ESMTP id p3D9peEx010439
	for <linux-input@vger.kernel.org>; Wed, 13 Apr 2011 10:51:41 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Joseph Lai <joseph_lai@wistron.com>

This driver is registered as an input device. An IRQ is required in this
basic driver configuration.

Signed-off-by: Joseph Lai <joseph_lai@wistron.com>

[Cleaned up PM_RUNTIME defines]

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/misc/Kconfig   |   10 +
 drivers/input/misc/Makefile  |    1 
 drivers/input/misc/mpu3050.c |  422 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/mpu3050.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 406a730..4f403ad 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -477,4 +477,14 @@ config INPUT_BMA023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma023.
 
+config INPUT_MPU3050
+	tristate "MPU3050 Triaxial gyroscope sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to support InvenSense MPU3050
+	  connected via an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mpu3050.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index b7100c2..1cc2132 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
+obj-$(CONFIG_INPUT_MPU3050)		+= mpu3050.o
 obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
 obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
new file mode 100644
index 0000000..bd9ab55
--- /dev/null
+++ b/drivers/input/misc/mpu3050.c
@@ -0,0 +1,422 @@
+/*
+ * mpu3050.c - MPU3050 Tri-axis gyroscope driver
+ *
+ * Copyright (C) 2011 Wistron Co.Ltd
+ * Joseph Lai <joseph_lai@wistron.com>
+ *
+ * Trimmed down by Alan Cox <alan@linux.intel.com> to produce this version
+ *
+ * This is a 'lite' version of the driver, while we consider the right way
+ * to present the other features to user space. In particular it requires the
+ * device has an IRQ, and it only provides an input interface, so is not much
+ * use for device orientation. A fuller version is available from the Meego
+ * tree.
+ *
+ * This program is based on bma023.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+
+#define MPU3050_CHIP_ID_REG	0x00
+#define MPU3050_CHIP_ID		0x69
+#define MPU3050_XOUT_H		0x1D
+#define MPU3050_PWR_MGM		0x3E
+#define MPU3050_PWR_MGM_POS	6
+#define MPU3050_PWR_MGM_MASK	0x40
+
+#define MPU3050_AUTO_DELAY	1000
+
+#define MPU3050_MIN_VALUE	-32768
+#define MPU3050_MAX_VALUE	32767
+
+struct axis_data {
+	s16 x;
+	s16 y;
+	s16 z;
+};
+
+struct mpu3050_sensor {
+	struct i2c_client *client;
+	struct device *dev;
+	struct input_dev *idev;
+	struct mutex lock;
+};
+
+/**
+ *	mpu3050_xyz_read_reg	-	read the axes values
+ *	@buffer: provide register addr and get register
+ *	@length: length of register
+ *
+ *	Reads the register values in one transaction or returns a negative
+ *	error code on failure/
+ */
+static int mpu3050_xyz_read_reg(struct i2c_client *client,
+			       u8 *buffer, int length)
+{
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = buffer,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = length,
+			.buf = buffer,
+		},
+	};
+	return i2c_transfer(client->adapter, msg, 2);
+}
+
+/**
+ *	mpu3050_read_xyz	-	get co-ordinates from device
+ *	@client: i2c address of sensor
+ *	@coords: co-ordinates to update
+ *
+ *	Return the converted X Y and Z co-ordinates from the sensor device
+ */
+static void mpu3050_read_xyz(struct i2c_client *client,
+				struct axis_data *coords)
+{
+	u8 buffer[6];
+	buffer[0] = MPU3050_XOUT_H;
+	mpu3050_xyz_read_reg(client, buffer, 6);
+	coords->x = buffer[0];
+	coords->x = coords->x << 8 | buffer[1];
+	coords->y = buffer[2];
+	coords->y = coords->y << 8 | buffer[3];
+	coords->z = buffer[4];
+	coords->z = coords->z << 8 | buffer[5];
+	dev_dbg(&client->dev, "%s: x %d, y %d, z %d\n", __func__,
+					coords->x, coords->y, coords->z);
+}
+
+/**
+ *	mpu3050_set_power_mode	-	set the power mode
+ *	@client: i2c client for the sensor
+ *	@val: value to switch on/off of power, 1: normal power, 0: low power
+ *
+ *	Put device to normal-power mode or low-power mode.
+ */
+static void mpu3050_set_power_mode(struct i2c_client *client, u8 val)
+{
+	u8 value;
+	value = i2c_smbus_read_byte_data(client, MPU3050_PWR_MGM);
+	value = (value & ~MPU3050_PWR_MGM_MASK) |
+		(((val << MPU3050_PWR_MGM_POS) & MPU3050_PWR_MGM_MASK) ^
+		 MPU3050_PWR_MGM_MASK);
+	i2c_smbus_write_byte_data(client, MPU3050_PWR_MGM, value);
+}
+
+/**
+ *	mpu3050_input_open	-	called on input event open
+ *	@input: input dev of opened device
+ *
+ *	The input layer calls this function when input event is opened. The
+ *	function will push the device to resume. Then, the device is ready
+ *	to provide data.
+ */
+static int mpu3050_input_open(struct input_dev *input)
+{
+	struct mpu3050_sensor *sensor = input_get_drvdata(input);
+	pm_runtime_get(sensor->dev);
+	return 0;
+}
+
+/**
+ *	mpu3050_input_close	-	called on input event close
+ *	@input: input dev of closed device
+ *
+ *	The input layer calls this function when input event is closed. The
+ *	function will push the device to suspend.
+ */
+static void mpu3050_input_close(struct input_dev *input)
+{
+	struct mpu3050_sensor *sensor = input_get_drvdata(input);
+	pm_runtime_put(sensor->dev);
+}
+
+/**
+ *	mpu3050_interrupt_thread	-	handle an IRQ
+ *	@irq: interrupt numner
+ *	@data: the sensor
+ *
+ *	Called by the kernel single threaded after an interrupt occurs. Read
+ *	the sensor data and generate an input event for it.
+ */
+static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
+{
+	struct mpu3050_sensor *sensor = data;
+	struct axis_data axis;
+
+	mutex_lock(&sensor->lock);
+	mpu3050_read_xyz(sensor->client, &axis);
+	mutex_unlock(&sensor->lock);
+
+	input_report_abs(sensor->idev, ABS_X, axis.x);
+	input_report_abs(sensor->idev, ABS_Y, axis.y);
+	input_report_abs(sensor->idev, ABS_Z, axis.z);
+	input_sync(sensor->idev);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ *	mpu3050_unregister_input_device	-	remove input dev
+ *	@sensor: sensor to remove from input
+ *
+ *	Free the interrupt and input device for the sensor. We must free
+ *	the interrupt first
+ */
+static void mpu3050_unregister_input_device(struct mpu3050_sensor *sensor)
+{
+	struct i2c_client *client = sensor->client;
+	free_irq(client->irq, sensor);
+	input_unregister_device(sensor->idev);
+	sensor->idev = NULL;
+}
+
+/**
+ *	mpu3050_register_input_device	-	remove input dev
+ *	@sensor: sensor to remove from input
+ *
+ *	Add an input device to the sensor. This will be used to report
+ *	events from the sensor itself.
+ */
+static int mpu3050_register_input_device(struct mpu3050_sensor *sensor)
+{
+	struct i2c_client *client = sensor->client;
+	struct input_dev *idev;
+	int ret;
+	sensor->idev = input_allocate_device();
+	idev = sensor->idev;
+	if (!idev) {
+		dev_err(&client->dev, "failed to allocate input device\n");
+		ret = -ENOMEM;
+		goto failed_alloc;
+	}
+	idev->name = "MPU3050";
+	idev->open = mpu3050_input_open;
+	idev->close = mpu3050_input_close;
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &client->dev;
+	idev->evbit[0] = BIT_MASK(EV_ABS);
+	input_set_abs_params(idev, ABS_X, MPU3050_MIN_VALUE,
+			MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Y, MPU3050_MIN_VALUE,
+			MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Z, MPU3050_MIN_VALUE,
+			MPU3050_MAX_VALUE, 0, 0);
+	input_set_drvdata(idev, sensor);
+	ret = input_register_device(idev);
+	if (ret) {
+		dev_err(&client->dev, "failed to register input device\n");
+		goto failed_reg;
+	}
+	ret = request_threaded_irq(client->irq, NULL,
+			mpu3050_interrupt_thread, IRQF_TRIGGER_RISING,
+				"mpu_int", sensor);
+	if (ret) {
+		dev_err(&client->dev, "can't get IRQ %d, ret %d\n",
+				client->irq, ret);
+		goto failed_irq;
+	}
+	return 0;
+failed_irq:
+	input_unregister_device(idev);
+	return ret;
+failed_reg:
+	if (idev)
+		input_free_device(idev);
+failed_alloc:
+	return ret;
+}
+
+/**
+ *	mpu3050_probe	-	device detection callback
+ *	@client: i2c client of found device
+ *	@id: id match information
+ *
+ *	The I2C layer calls us when it believes a sensor is present at this
+ *	address. Probe to see if this is correct and to validate the device.
+ *
+ *	If present install the relevant sysfs interfaces and input device.
+ */
+static int __devinit mpu3050_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct mpu3050_sensor *sensor;
+	int ret;
+	sensor = kzalloc(sizeof(struct mpu3050_sensor), GFP_KERNEL);
+	if (!sensor) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+	sensor->dev = &client->dev;
+	sensor->client = client;
+	i2c_set_clientdata(client, sensor);
+
+	mpu3050_set_power_mode(client, 1);
+	msleep(10);
+	ret = i2c_smbus_read_byte_data(client, MPU3050_CHIP_ID_REG);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to detect device\n");
+		goto failed_free;
+	}
+	if (ret != MPU3050_CHIP_ID) {
+		dev_err(&client->dev, "unsupported chip id\n");
+		goto failed_free;
+	}
+
+	mutex_init(&sensor->lock);
+
+	pm_runtime_set_active(&client->dev);
+
+	ret = mpu3050_register_input_device(sensor);
+	if (ret)
+		dev_err(&client->dev, "only provide sysfs\n");
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
+
+	dev_info(&client->dev, "%s registered\n", id->name);
+	return 0;
+
+failed_free:
+	kfree(sensor);
+	return ret;
+}
+
+/**
+ *	mpu3050_remove	-	remove a sensor
+ *	@client: i2c client of sensor being removed
+ *
+ *	Our sensor is going away, clean up the resources.
+ */
+static int __devexit mpu3050_remove(struct i2c_client *client)
+{
+	struct mpu3050_sensor *sensor = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
+	if (sensor->idev)
+		mpu3050_unregister_input_device(sensor);
+	kfree(sensor);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/**
+ *	mpu3050_suspend		-	called on device suspend
+ *	@client: i2c client of sensor
+ *	@mesg: actual suspend type
+ *
+ *	Put the device into sleep mode before we suspend the machine.
+ */
+static int mpu3050_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	mpu3050_set_power_mode(client, 0);
+	return 0;
+}
+
+/**
+ *	mpu3050_resume		-	called on device resume
+ *	@client: i2c client of sensor
+ *
+ *	Put the device into powered mode on resume.
+ */
+static int mpu3050_resume(struct i2c_client *client)
+{
+	mpu3050_set_power_mode(client, 1);
+	msleep(100);  /* wait for gyro chip resume */
+	return 0;
+}
+#else
+#define mpu3050_suspend NULL
+#define mpu3050_resume NULL
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static int mpu3050_runtime_suspend(struct device *dev)
+{
+	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
+	mpu3050_set_power_mode(sensor->client, 0);
+	return 0;
+}
+
+static int mpu3050_runtime_resume(struct device *dev)
+{
+	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
+	mpu3050_set_power_mode(sensor->client, 1);
+	msleep(100);  /* wait for gyro chip resume */
+	return 0;
+}
+
+static const struct dev_pm_ops mpu3050_pm = {
+	.runtime_suspend = mpu3050_runtime_suspend,
+	.runtime_resume  = mpu3050_runtime_resume,
+};
+#endif
+
+static const struct i2c_device_id mpu3050_ids[] = {
+	{ "mpu3050", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mpu3050_ids);
+
+static struct i2c_driver mpu3050_i2c_driver = {
+	.driver	= {
+		.name	= "mpu3050",
+#ifdef CONFIG_PM_RUNTIME
+		.pm		= &mpu3050_pm,
+#endif
+	},
+	.probe		= mpu3050_probe,
+	.remove		= __devexit_p(mpu3050_remove),
+	.suspend	= mpu3050_suspend,
+	.resume		= mpu3050_resume,
+	.id_table	= mpu3050_ids,
+};
+
+static int __init mpu3050_init(void)
+{
+	return i2c_add_driver(&mpu3050_i2c_driver);
+}
+module_init(mpu3050_init);
+
+static void __exit mpu3050_exit(void)
+{
+	i2c_del_driver(&mpu3050_i2c_driver);
+}
+module_exit(mpu3050_exit);
+
+MODULE_AUTHOR("Wistron Corp.");
+MODULE_DESCRIPTION("MPU3050 Tri-axis gyroscope driver");
+MODULE_LICENSE("GPL");

