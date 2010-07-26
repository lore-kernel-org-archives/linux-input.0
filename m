From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 12/36]  [Driver][Qualcomm 1070][EC_C_SENSOR] EC compass sensor driver porting
Date: Mon, 26 Jul 2010 16:30:21 +0800
Message-ID: <1280133045-25945-12-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f66.google.com ([209.85.160.66]:42017 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab0GZInK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:43:10 -0400
Received: by pwj4 with SMTP id 4so4875009pwj.1
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:43:10 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 drivers/hwmon/Kconfig   |    7 +
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/hmc5843.c |  501 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/hmc5843.h |   37 ++++
 4 files changed, 546 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/hmc5843.c
 create mode 100755 drivers/hwmon/hmc5843.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 30ac82d..123749d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1069,6 +1069,13 @@ config SENSORS_WPCE775X
 	  This driver provides support for the Winbond WPCE775XX Embedded
 	  Controller, which provides lcd backlight, LEDs, and Battery control.
 
+config SENSORS_HMC5843
+        tristate "HMC5843 Compass Sensor Driver"
+        depends on I2C && ARCH_MSM_SCORPION
+        default n
+        help
+          HMC5843 Compass Sensor Driver implemented by Quanta.
+
 config SENSORS_BOSCH_BMA150
         tristate "SMB380/BMA150 acceleration sensor support"
         depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 87f75e1..5ba2984 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_ISL29011)  += isl29011.o
 obj-$(CONFIG_SENSORS_WPCE775X)  += wpce775x.o
 obj-$(CONFIG_SENSORS_BOSCH_BMA150)      += bma150.o
+obj-$(CONFIG_SENSORS_HMC5843)   += hmc5843.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/hmc5843.c b/drivers/hwmon/hmc5843.c
new file mode 100755
index 0000000..7a0a22c
--- /dev/null
+++ b/drivers/hwmon/hmc5843.c
@@ -0,0 +1,501 @@
+/* Quanta I2C Compass sensor Driver
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ * Author: Ivan Chang <Ivan.Chang@quantatw.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include "hmc5843.h"
+
+#define MSENSOR_DRV_NAME 		"hmc5843"
+#define MSENSOR_DEV_NAME 		"hmc5843"
+#define MSENSOR_DEV_MINOR      		MISC_DYNAMIC_MINOR
+#define MSENSOR_DATA_BUF_LEN		3
+
+#define	MSENSOR_A_REG			0
+#define	MSENSOR_A_MEASURE_MASK		0x03
+#define	MSENSOR_A_RATE_MASK		0x1c
+#define	MSENSOR_A_RATE_SHIFT		2
+#define	MSENSOR_B_REG			1
+#define	MSENSOR_B_GAIN_MASK		0xe0
+#define	MSENSOR_B_GAIN_SHIFT		5
+#define	MSENSOR_MODE_REG		2
+#define	MSENSOR_MODE_MASK		0x03
+#define	MSENSOR_MODE_CONTINU		0
+#define	MSENSOR_MODE_SINGLE		1
+#define	MSENSOR_MODE_IDLE		2
+#define	MSENSOR_MODE_SLEEP		3
+#define	MSENSOR_X_DATA_REG		3
+#define	MSENSOR_Y_DATA_REG		5
+#define	MSENSOR_Z_DATA_REG		7
+#define	MSENSOR_STATUS_REG		9
+#define	MSENSOR_STATUS_REN		0x04
+#define	MSENSOR_STATUS_LOCK		0x02
+#define	MSENSOR_STATUS_RDY		0x01
+#define	MSENSOR_ID_REG_A		10
+#define	MSENSOR_ID_REG_B		11
+#define	MSENSOR_ID_REG_C		12
+
+/*-----------------------------------------------------------------------------
+ * Global variables
+ *---------------------------------------------------------------------------*/
+/* General structure to hold the driver data */
+struct msensor_drv_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	struct miscdevice msensor_dev;
+	s16 msensor_data[3];
+	u8  rate;
+	u8  measure;
+	u8  gain;
+	u8  mode;
+	u8  reg_idx;
+};
+
+static struct msensor_drv_data *g_mdrv_data;
+
+static int __devinit msensor_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id);
+static int __devexit msensor_remove(struct i2c_client *client);
+
+/*-----------------------------------------------------------------------------
+ * Low level functions
+ *---------------------------------------------------------------------------*/
+static int msensor_set_register(struct i2c_client *client,
+				u8 reg, u8 reg_value)
+{
+	struct msensor_drv_data *pdata = i2c_get_clientdata(client);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, reg_value);
+	if (ret == 0) {
+		switch (reg) {
+		case MSENSOR_A_REG:
+			pdata->rate = (reg_value & MSENSOR_A_RATE_MASK) >>
+				       MSENSOR_A_RATE_SHIFT;
+			pdata->measure = reg_value & MSENSOR_A_MEASURE_MASK;
+			break;
+		case MSENSOR_B_REG:
+			pdata->gain = (reg_value & MSENSOR_B_GAIN_MASK) >>
+				       MSENSOR_B_GAIN_SHIFT;
+			break;
+		case MSENSOR_MODE_REG:
+			pdata->mode = reg_value & MSENSOR_MODE_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+		pdata->reg_idx = reg + 1;
+	}
+	return ret;
+}
+
+static int msensor_get_adc_value(struct i2c_client *client)
+{
+	struct msensor_drv_data *pdata = i2c_get_clientdata(client);
+	u8 raw_data[6];
+	u8 raw_status;
+	int ret, i;
+
+	if (pdata->reg_idx != MSENSOR_X_DATA_REG) {
+		raw_data[0] = MSENSOR_X_DATA_REG;
+		ret = i2c_master_send(client, raw_data, 1);
+		if (ret != 1) {
+			dev_err(&client->dev,"[M-sensor] Set reg_idx failed\n");
+			return ret;
+		}
+		pdata->reg_idx = MSENSOR_X_DATA_REG;
+	}
+
+	ret = i2c_master_recv(client, raw_data, 6);
+	if (ret != 6) {
+		dev_err(&client->dev,
+			"[M-sensor] Get value failed with ret = %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = i2c_master_recv(client, &raw_status, 1);
+	if (ret != 1) {
+		dev_err(&client->dev,
+			"[M-sensor] Get status failed with ret = %d\n",
+			ret);
+		return ret;
+	}
+
+	for (i = 0; i < MSENSOR_DATA_BUF_LEN ; i++) {
+		pdata->msensor_data[i] = raw_data[2*i+1] |
+					 (s8)raw_data[2*i] << 8;
+	}
+
+	dev_dbg(&client->dev,"qci-msensor: X = %d \n", pdata->msensor_data[0]);
+	dev_dbg(&client->dev,"qci-msensor: Y = %d \n", pdata->msensor_data[1]);
+	dev_dbg(&client->dev,"qci-msensor: Z = %d \n", pdata->msensor_data[2]);
+	return 0;
+}
+
+/*-----------------------------------------------------------------------------
+ * File Operation functions
+ *---------------------------------------------------------------------------*/
+static ssize_t msensor_read(struct file *file, char __user *userbuf,
+				size_t count, loff_t *offset)
+{
+	struct msensor_drv_data *pdata = file->private_data;
+	int ret1 = 0;
+	int ret2 = 0;
+
+	mutex_lock(&pdata->lock);
+	ret1 = msensor_get_adc_value(pdata->client);
+	ret2 = copy_to_user(userbuf, pdata->msensor_data, count);
+	mutex_unlock(&pdata->lock);
+	if (ret1 != 0 || ret2 != 0) {
+		dev_err(&pdata->client->dev,"[M-sensor] read data failed!\n");
+		return -EFAULT;
+	}
+	return count;
+}
+
+static int msensor_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long param)
+{
+	struct msensor_drv_data *pdata = file->private_data;
+	void __user *argp = (void __user *)param;
+	int ret = 0;
+	int ret1 = 0;
+	int ret2 = 0;
+	int ret3 = 0;
+	u8 rate, measure, gain, mode;
+	u8 reg_value;
+
+	switch (cmd) {
+	case GET_RATE:
+		mutex_lock(&pdata->lock);
+		ret = copy_to_user(argp, &pdata->rate, sizeof(u8));
+		mutex_unlock(&pdata->lock);
+		if (ret != 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Get rate copy to user failed!\n");
+			return -EFAULT;
+		}
+		dev_dbg(&pdata->client->dev,
+			"[M-sensor] Get rate with value %d\n",
+			pdata->rate);
+		break;
+	case SET_RATE:
+		if (copy_from_user(&rate, argp, sizeof(rate))) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Fetch rate from user error\n");
+			return -EINVAL;
+		}
+		mutex_lock(&pdata->lock);
+		reg_value = pdata->measure | ((rate & MSENSOR_A_RATE_MASK) <<
+					       MSENSOR_A_RATE_SHIFT);
+		ret = msensor_set_register(pdata->client,
+					   MSENSOR_A_REG,
+					   reg_value);
+		mutex_unlock(&pdata->lock);
+		if (ret < 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set rate error\n");
+			return -EFAULT;
+		}
+		break;
+	case GET_MEASURE:
+		mutex_lock(&pdata->lock);
+		ret = copy_to_user(argp, &pdata->measure, sizeof(u8));
+		mutex_unlock(&pdata->lock);
+		if (ret != 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Get measure"
+				"copy to user failed!\n");
+			return -EFAULT;
+		}
+		dev_dbg(&pdata->client->dev,"[M-sensor] Get measure with value %d\n",
+			pdata->measure);
+		break;
+	case SET_MEASURE:
+		if (copy_from_user(&measure, argp, sizeof(measure))) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Fetch measure from user error\n");
+			return -EINVAL;
+		}
+		mutex_lock(&pdata->lock);
+		reg_value = (pdata->rate << MSENSOR_A_RATE_MASK) |
+			    (measure & MSENSOR_A_MEASURE_MASK);
+		ret = msensor_set_register(pdata->client,
+					   MSENSOR_A_REG,
+					   reg_value);
+		mutex_unlock(&pdata->lock);
+		if (ret < 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set measure error\n");
+			return -EFAULT;
+		}
+		break;
+	case GET_GAIN:
+		mutex_lock(&pdata->lock);
+		ret = copy_to_user(argp, &pdata->gain, sizeof(u8));
+		mutex_unlock(&pdata->lock);
+		if (ret != 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Get gain copy to user failed!\n");
+			return -EFAULT;
+		}
+		dev_dbg(&pdata->client->dev,
+			"[M-sensor] Get gain with value %d\n", pdata->gain);
+		break;
+	case SET_GAIN:
+		if (copy_from_user(&gain, argp, sizeof(gain))) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Fetch mode from user error\n");
+			return -EINVAL;
+		}
+		mutex_lock(&pdata->lock);
+		ret = msensor_set_register(pdata->client,
+					   MSENSOR_B_REG,
+					   ((gain & MSENSOR_B_GAIN_MASK) <<
+						MSENSOR_B_GAIN_SHIFT));
+		mutex_unlock(&pdata->lock);
+		if (ret < 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set gain error\n");
+			return -EFAULT;
+		}
+		break;
+	case GET_MODE:
+		mutex_lock(&pdata->lock);
+		ret = copy_to_user(argp, &pdata->mode, sizeof(u8));
+		mutex_unlock(&pdata->lock);
+		if (ret != 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Get mode copy to user failed!\n");
+			return -EFAULT;
+		}
+		dev_dbg(&pdata->client->dev,
+			"[M-sensor] Get mode with value %d\n", pdata->mode);
+		break;
+	case SET_MODE:
+		if (copy_from_user(&mode, argp, sizeof(mode))) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Fetch mode from user error\n");
+			return -EINVAL;
+		}
+		mutex_lock(&pdata->lock);
+		ret = msensor_set_register(pdata->client,
+					   MSENSOR_MODE_REG,
+					   mode & MSENSOR_MODE_MASK);
+		mutex_unlock(&pdata->lock);
+		if (ret < 0) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set mode error\n");
+			return -EFAULT;
+		}
+		break;
+	case SELF_TEST:
+		mutex_lock(&pdata->lock);
+		ret1 = msensor_set_register(pdata->client,
+					    MSENSOR_A_REG,
+					    0x11);
+		msleep(30);
+		ret2 = msensor_set_register(pdata->client,
+					    MSENSOR_B_REG,
+					    0x20);
+		msleep(30);
+		ret3 = msensor_set_register(pdata->client,
+					    MSENSOR_MODE_REG,
+					    0x01);
+		msleep(30);
+		if ((ret1 < 0) || (ret2 < 0) || (ret3 < 0)) {
+			mutex_unlock(&pdata->lock);
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set mode register error\n");
+			return -EFAULT;
+		}
+		msleep(100);
+
+		ret1 = msensor_get_adc_value(pdata->client);
+		ret2 = copy_to_user(argp,
+				    pdata->msensor_data,
+				    sizeof(signed short)*3);
+		if (ret1 != 0 || ret2 != 0) {
+			mutex_unlock(&pdata->lock);
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Copy to user failed!\n");
+			 return -EFAULT;
+		}
+
+		msleep(200);
+		ret1 = msensor_set_register(pdata->client,
+					    MSENSOR_A_REG,
+					    0x10);
+		msleep(35);
+		ret2 = msensor_set_register(pdata->client,
+					    MSENSOR_B_REG,
+					    0x20);
+		msleep(35);
+		ret3 = msensor_set_register(pdata->client,
+					    MSENSOR_MODE_REG,
+					    0x00);
+		msleep(35);
+		mutex_unlock(&pdata->lock);
+		if ((ret1 < 0) || (ret2 < 0) || (ret3 < 0)) {
+			dev_err(&pdata->client->dev,
+				"[M-sensor] Set mode register error\n");
+			return -EFAULT;
+		}
+		break;
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+static int msensor_open(struct inode *inode, struct file  *file)
+{
+	file->private_data = g_mdrv_data;
+	return 0;
+}
+
+static int msensor_close(struct inode *inode, struct file  *file)
+{
+	file->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations msensor_ops = {
+	.owner = THIS_MODULE,
+	.read = msensor_read,
+	.open = msensor_open,
+	.release = msensor_close,
+	.ioctl = msensor_ioctl,
+};
+
+/*-----------------------------------------------------------------------------
+ * I2C Driver functions
+ *---------------------------------------------------------------------------*/
+static const struct i2c_device_id msensor_idtable[] = {
+	{ MSENSOR_DRV_NAME, 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, msensor_idtable);
+#ifdef CONFIG_PM
+static int msensor_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int msensor_resume(struct device *dev)
+{
+	return 0;
+}
+
+static struct dev_pm_ops msensor_pm_ops = {
+	.suspend  = msensor_suspend,
+	.resume   = msensor_resume,
+};
+
+#endif
+static struct i2c_driver msensor_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name  = MSENSOR_DRV_NAME,
+#ifdef CONFIG_PM
+		.pm = &msensor_pm_ops,
+#endif
+	},
+	.probe  = msensor_probe,
+	.remove = msensor_remove,
+	.id_table   = msensor_idtable,
+};
+
+static int __devinit msensor_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	int ret;
+	struct msensor_drv_data *pdata = 0;
+	pdata = kzalloc(sizeof(struct msensor_drv_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	g_mdrv_data = pdata;
+	i2c_set_clientdata(client, pdata);
+	pdata->client = client;
+	strlcpy(pdata->client->name, MSENSOR_DRV_NAME, I2C_NAME_SIZE);
+	client->driver = &msensor_driver;
+
+	pdata->msensor_dev.minor = MSENSOR_DEV_MINOR;
+	pdata->msensor_dev.name  = MSENSOR_DEV_NAME;
+	pdata->msensor_dev.fops  = &msensor_ops;
+
+	mutex_init(&pdata->lock);
+
+	msensor_set_register(client, MSENSOR_A_REG, 0x10);
+	msensor_set_register(client, MSENSOR_B_REG, 0x20);
+	msensor_set_register(client, MSENSOR_MODE_REG, 0x00);
+	msleep(100);
+
+	ret = misc_register(&pdata->msensor_dev);
+	if (ret) {
+		dev_err(&client->dev,
+			"[M-sensor] Misc device register failed\n");
+		goto misc_register_fail;
+	}
+
+	dev_dbg(&client->dev,"[M-sensor] Probe successful \n");
+	return 0;
+
+misc_register_fail:
+	i2c_set_clientdata(client, NULL);
+	kfree(pdata);
+	return ret;
+}
+
+static int __devexit msensor_remove(struct i2c_client *client)
+{
+	struct msensor_drv_data *pdata;
+
+	pdata = i2c_get_clientdata(client);
+	misc_deregister(&pdata->msensor_dev);
+	kfree(pdata);
+	return 0;
+}
+
+static int __init msensor_init(void)
+{
+	return i2c_add_driver(&msensor_driver);
+}
+
+static void __exit msensor_exit(void)
+{
+	i2c_del_driver(&msensor_driver);
+}
+
+module_init(msensor_init);
+module_exit(msensor_exit);
+
+MODULE_AUTHOR("Quanta Computer Inc.");
+MODULE_DESCRIPTION("Quanta I2C M-Sensor Driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/hwmon/hmc5843.h b/drivers/hwmon/hmc5843.h
new file mode 100755
index 0000000..09587a8
--- /dev/null
+++ b/drivers/hwmon/hmc5843.h
@@ -0,0 +1,37 @@
+/* Quanta I2C Compass sensor Driver Header File
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ * Author: Ivan Chang <Ivan.Chang@quantatw.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef HMC5843_DRV_H
+#define HMC5843_DRV_H
+
+#include <linux/ioctl.h>
+
+/*===========================================================================
+				IOCTLS
+===========================================================================*/
+#define HMC5843_IOC_MAGIC     0xe5
+
+#define GET_RATE	_IOWR(HMC5843_IOC_MAGIC, 0, unsigned long)
+#define SET_RATE	_IOWR(HMC5843_IOC_MAGIC, 1, unsigned long)
+#define GET_MEASURE	_IOWR(HMC5843_IOC_MAGIC, 2, unsigned long)
+#define SET_MEASURE	_IOWR(HMC5843_IOC_MAGIC, 3, unsigned long)
+#define GET_GAIN	_IOWR(HMC5843_IOC_MAGIC, 4, unsigned long)
+#define SET_GAIN	_IOWR(HMC5843_IOC_MAGIC, 5, unsigned long)
+#define GET_MODE	_IOWR(HMC5843_IOC_MAGIC, 6, unsigned long)
+#define SET_MODE	_IOWR(HMC5843_IOC_MAGIC, 7, unsigned long)
+#define SELF_TEST	_IOWR(HMC5843_IOC_MAGIC, 8, unsigned long)
+
+#endif
+
-- 
1.7.0.4

