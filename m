From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Add a driver to support InvenSense mpu3050
 gyroscope chip.
Date: Thu, 23 Jun 2011 15:16:01 -0700
Message-ID: <20110623221559.GA27064@core.coreip.homeip.net>
References: <20110524114227.25805.65841.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33836 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759791Ab1FWWQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 18:16:11 -0400
Received: by pvg12 with SMTP id 12so1387136pvg.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 15:16:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110524114227.25805.65841.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.jf.intel.com>
Cc: linux-input@vger.kernel.org

Hi Alan,

On Tue, May 24, 2011 at 12:42:52PM +0100, Alan Cox wrote:
> From: Joseph Lai <joseph_lai@wistron.com>
> 
> This driver is registered as an input device. An IRQ is required in this
> basic driver configuration.
> 
> Signed-off-by: Joseph Lai <joseph_lai@wistron.com>
> [Cleaned up PM_RUNTIME defines]
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I rearranged the code a bit and consolidated PM methods. If the version
below still makes sense to you I will queue it for 3.1.

Thanks.

-- 
Dmitry

Input: add a driver to support InvenSense mpu3050 gyroscope chip

From: Joseph Lai <joseph_lai@wistron.com>

This driver is registered as an input device. An IRQ is required in this
basic driver configuration.

Signed-off-by: Joseph Lai <joseph_lai@wistron.com>
[Cleaned up PM_RUNTIME defines]
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig   |   10 +
 drivers/input/misc/Makefile  |    1 
 drivers/input/misc/mpu3050.c |  376 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/mpu3050.c


diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 0f22918..6fdce4b 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -111,6 +111,16 @@ config INPUT_MMA8450
 	  To compile this driver as a module, choose M here: the
 	  module will be called mma8450.
 
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
 config INPUT_APANEL
 	tristate "Fujitsu Lifebook Application Panel buttons"
 	depends on X86 && I2C && LEDS_CLASS
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 99953c3..b7e227a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_MMA8450)		+= mma8450.o
+obj-$(CONFIG_INPUT_MPU3050)		+= mpu3050.o
 obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
 obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
new file mode 100644
index 0000000..b95fac1
--- /dev/null
+++ b/drivers/input/misc/mpu3050.c
@@ -0,0 +1,376 @@
+/*
+ * MPU3050 Tri-axis gyroscope driver
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
+};
+
+/**
+ *	mpu3050_xyz_read_reg	-	read the axes values
+ *	@buffer: provide register addr and get register
+ *	@length: length of register
+ *
+ *	Reads the register values in one transaction or returns a negative
+ *	error code on failure.
+ */
+static int mpu3050_xyz_read_reg(struct i2c_client *client,
+			       u8 *buffer, int length)
+{
+	/*
+	 * Annoying we can't make this const because the i2c layer doesn't
+	 * declare input buffers const.
+	 */
+	char cmd = MPU3050_XOUT_H;
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &cmd,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = length,
+			.buf = buffer,
+		},
+	};
+
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
+			     struct axis_data *coords)
+{
+	u16 buffer[3];
+
+	mpu3050_xyz_read_reg(client, (u8 *)buffer, 6);
+	coords->x = be16_to_cpu(buffer[0]);
+	coords->y = be16_to_cpu(buffer[1]);
+	coords->z = be16_to_cpu(buffer[2]);
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
+
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
+
+	pm_runtime_get(sensor->dev);
+
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
+
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
+	mpu3050_read_xyz(sensor->client, &axis);
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
+				   const struct i2c_device_id *id)
+{
+	struct mpu3050_sensor *sensor;
+	struct input_dev *idev;
+	int ret;
+	int error;
+
+	sensor = kzalloc(sizeof(struct mpu3050_sensor), GFP_KERNEL);
+	idev = input_allocate_device();
+	if (!sensor || !idev) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	sensor->client = client;
+	sensor->dev = &client->dev;
+	sensor->idev = idev;
+
+	mpu3050_set_power_mode(client, 1);
+	msleep(10);
+
+	ret = i2c_smbus_read_byte_data(client, MPU3050_CHIP_ID_REG);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to detect device\n");
+		error = -ENXIO;
+		goto err_free_mem;
+	}
+
+	if (ret != MPU3050_CHIP_ID) {
+		dev_err(&client->dev, "unsupported chip id\n");
+		error = -ENXIO;
+		goto err_free_mem;
+	}
+
+	idev->name = "MPU3050";
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &client->dev;
+
+	idev->open = mpu3050_input_open;
+	idev->close = mpu3050_input_close;
+
+	__set_bit(EV_ABS, idev->evbit);
+	input_set_abs_params(idev, ABS_X,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Y,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+	input_set_abs_params(idev, ABS_Z,
+			     MPU3050_MIN_VALUE, MPU3050_MAX_VALUE, 0, 0);
+
+	input_set_drvdata(idev, sensor);
+
+	pm_runtime_set_active(&client->dev);
+
+	error = request_threaded_irq(client->irq,
+				     NULL, mpu3050_interrupt_thread,
+				     IRQF_TRIGGER_RISING,
+				     "mpu_int", sensor);
+	if (error) {
+		dev_err(&client->dev,
+			"can't get IRQ %d, error %d\n", client->irq, error);
+		goto err_pm_set_suspended;
+	}
+
+	error = input_register_device(idev);
+	if (error) {
+		dev_err(&client->dev, "failed to register input device\n");
+		goto err_free_irq;
+	}
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, sensor);
+err_pm_set_suspended:
+	pm_runtime_set_suspended(&client->dev);
+err_free_mem:
+	input_unregister_device(idev);
+	kfree(sensor);
+	return error;
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
+	free_irq(client->irq, sensor);
+	input_unregister_device(sensor->idev);
+	kfree(sensor);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/**
+ *	mpu3050_suspend		-	called on device suspend
+ *	@dev: device being suspended
+ *
+ *	Put the device into sleep mode before we suspend the machine.
+ */
+static int mpu3050_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	mpu3050_set_power_mode(client, 0);
+
+	return 0;
+}
+
+/**
+ *	mpu3050_resume		-	called on device resume
+ *	@dev: device being resumed
+ *
+ *	Put the device into powered mode on resume.
+ */
+static int mpu3050_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	mpu3050_set_power_mode(client, 1);
+	msleep(100);  /* wait for gyro chip resume */
+
+	return 0;
+}
+#endif
+
+static UNIVERSAL_DEV_PM_OPS(mpu3050_pm, mpu3050_suspend, mpu3050_resume, NULL);
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
+		.owner	= THIS_MODULE,
+		.pm	= &mpu3050_pm,
+	},
+	.probe		= mpu3050_probe,
+	.remove		= __devexit_p(mpu3050_remove),
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
