From: simon.budig@kernelconcepts.de
Subject: [PATCH v8] Touchscreen driver for FT5x06 based EDT displays
Date: Sun,  8 Jul 2012 18:05:22 +0200
Message-ID: <1341763522-14374-2-git-send-email-simon.budig@kernelconcepts.de>
References: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:56135 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2GHQFb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jul 2012 12:05:31 -0400
In-Reply-To: <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com, Simon Budig <simon.budig@kernelconcepts.de>

From: Simon Budig <simon.budig@kernelconcepts.de>

This is a driver for the EDT "Polytouch" family of touch controllers
based on the FocalTech FT5x06 line of chips.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 Documentation/input/edt-ft5x06.txt     |   56 ++
 drivers/input/touchscreen/Kconfig      |   13 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/edt-ft5x06.c |  895 ++++++++++++++++++++++++++++++++
 include/linux/input/edt-ft5x06.h       |   24 +
 5 files changed, 989 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/input/edt-ft5x06.txt
 create mode 100644 drivers/input/touchscreen/edt-ft5x06.c
 create mode 100644 include/linux/input/edt-ft5x06.h

diff --git a/Documentation/input/edt-ft5x06.txt b/Documentation/input/edt-ft5x06.txt
new file mode 100644
index 0000000..d2f1444
--- /dev/null
+++ b/Documentation/input/edt-ft5x06.txt
@@ -0,0 +1,56 @@
+EDT ft5x06 based Polytouch devices
+----------------------------------
+
+The edt-ft5x06 driver is useful for the EDT "Polytouch" family of capacitive
+touch screens. Note that it is *not* suitable for other devices based on the
+focaltec ft5x06 devices, since they contain vendor-specific firmware. In
+particular this driver is not suitable for the Nook tablet.
+
+It has been tested with the following devices:
+  * EP0350M06
+  * EP0430M06
+  * EP0570M06
+  * EP0700M06
+
+The driver allows configuration of the touch screen via a set of sysfs files:
+
+/sys/class/input/eventX/device/device/threshold:
+    allows setting the "click"-threshold in the range from 20 to 80.
+
+/sys/class/input/eventX/device/device/gain:
+    allows setting the sensitivity in the range from 0 to 31. Note that
+    lower values indicate higher sensitivity.
+
+/sys/class/input/eventX/device/device/offset:
+    allows setting the edge compensation in the range from 0 to 31.
+
+/sys/class/input/eventX/device/device/report_rate:
+    allows setting the report rate in the range from 3 to 14.
+
+
+For debugging purposes the driver provides a few files in the debug
+filesystem (if available in the kernel). In /sys/kernel/debug/edt_ft5x06
+you'll find the following files:
+
+num_x, num_y:
+    (readonly) contains the number of sensor fields in X- and
+    Y-direction.
+
+mode:
+    allows switching the sensor between "factory mode" and "operation
+    mode" by writing "1" or "0" to it. In factory mode (1) it is
+    possible to get the raw data from the sensor. Note that in factory
+    mode regular events don't get delivered and the options described
+    above are unavailable.
+
+raw_data:
+    contains num_x * num_y big endian 16 bit values describing the raw
+    values for each sensor field. Note that each read() call on this
+    files triggers a new readout. It is recommended to provide a buffer
+    big enough to contain num_x * num_y * 2 bytes.
+
+Note that reading raw_data gives a I/O error when the device is not in factory
+mode. The same happens when reading/writing to the parameter files when the
+device is not in regular operation mode.
+
+
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 98d2635..2008d72 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -460,6 +460,19 @@ config TOUCHSCREEN_PENMOUNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called penmount.
 
+config TOUCHSCREEN_EDT_FT5X06
+	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
+	depends on I2C
+	help
+	  Say Y here if you have an EDT "Polytouch" touchscreen based
+	  on the FocalTech FT5x06 family of controllers connected to
+	  your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called edt-ft5x06.
+
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
 	depends on SH_MIGOR && I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index eb8bfe1..bed430d7 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)	+= cyttsp_spi.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
+obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
new file mode 100644
index 0000000..32d8840
--- /dev/null
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -0,0 +1,895 @@
+/*
+ * Copyright (C) 2012 Simon Budig, <simon.budig@kernelconcepts.de>
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
+ * You should have received a copy of the GNU General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This is a driver for the EDT "Polytouch" family of touch controllers
+ * based on the FocalTech FT5x06 line of chips.
+ *
+ * Development of this driver has been sponsored by Glyn:
+ *    http://www.glyn.com/Products/Displays
+ */
+
+#include <linux/module.h>
+#include <linux/ratelimit.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/input/mt.h>
+#include <linux/input/edt-ft5x06.h>
+
+#define DRIVER_VERSION "v0.7"
+
+#define MAX_SUPPORT_POINTS		5
+
+#define WORK_REGISTER_THRESHOLD		0x00
+#define WORK_REGISTER_REPORT_RATE	0x08
+#define WORK_REGISTER_GAIN		0x30
+#define WORK_REGISTER_OFFSET		0x31
+#define WORK_REGISTER_NUM_X		0x33
+#define WORK_REGISTER_NUM_Y		0x34
+
+#define WORK_REGISTER_OPMODE		0x3c
+#define FACTORY_REGISTER_OPMODE		0x01
+
+#define TOUCH_EVENT_DOWN		0x00
+#define TOUCH_EVENT_UP			0x01
+#define TOUCH_EVENT_ON			0x02
+#define TOUCH_EVENT_RESERVED		0x03
+
+#define EDT_NAME_LEN			23
+#define EDT_SWITCH_MODE_RETRIES		10
+#define EDT_SWITCH_MODE_DELAY		5 /* msec */
+#define EDT_RAW_DATA_RETRIES		100
+#define EDT_RAW_DATA_DELAY		1 /* msec */
+
+struct edt_ft5x06_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	u16 num_x;
+	u16 num_y;
+
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry *debug_dir;
+	u8 *raw_buffer;
+#endif
+
+	struct mutex mutex;
+	bool factory_mode;
+	int threshold;
+	int gain;
+	int offset;
+	int report_rate;
+
+	char name[EDT_NAME_LEN];
+};
+
+static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
+				   u16 wr_len, u8 *wr_buf,
+				   u16 rd_len, u8 *rd_buf)
+{
+	struct i2c_msg wrmsg[2];
+	int i = 0;
+	int ret;
+
+	i = 0;
+	if (wr_len) {
+		wrmsg[i].addr  = client->addr;
+		wrmsg[i].flags = 0;
+		wrmsg[i].len = wr_len;
+		wrmsg[i].buf = wr_buf;
+		i++;
+	}
+	if (rd_len) {
+		wrmsg[i].addr  = client->addr;
+		wrmsg[i].flags = I2C_M_RD;
+		wrmsg[i].len = rd_len;
+		wrmsg[i].buf = rd_buf;
+		i++;
+	}
+
+	ret = i2c_transfer(client->adapter, wrmsg, i);
+	if (ret < 0)
+		return ret;
+	if (ret != i)
+		return -EIO;
+
+	return 0;
+}
+
+static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
+				    u8 *buf, int buflen)
+{
+	int i;
+	u8 crc = 0;
+
+	for (i = 0; i < buflen - 1; i++)
+		crc ^= buf[i];
+
+	if (crc != buf[buflen-1]) {
+		dev_err_ratelimited(&tsdata->client->dev,
+				    "crc error: 0x%02x expected, got 0x%02x\n",
+				    crc, buf[buflen-1]);
+		return false;
+	}
+
+	return true;
+}
+
+static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
+{
+	struct edt_ft5x06_ts_data *tsdata = dev_id;
+	struct device *dev = &tsdata->client->dev;
+	u8 cmd = 0xf9;
+	u8 rdbuf[26];
+	int i, type, x, y, id;
+	int error;
+
+	memset(rdbuf, 0, sizeof(rdbuf));
+
+	error = edt_ft5x06_ts_readwrite(tsdata->client,
+					sizeof(cmd), &cmd,
+					sizeof(rdbuf), rdbuf);
+	if (error) {
+		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
+				    error);
+		goto out;
+	}
+
+	if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa || rdbuf[2] != 26) {
+		dev_err_ratelimited(dev, "Unexpected header: %02x%02x%02x!\n",
+				    rdbuf[0], rdbuf[1], rdbuf[2]);
+		goto out;
+	}
+
+	if (!edt_ft5x06_ts_check_crc(tsdata, rdbuf, 26))
+		goto out;
+
+	for (i = 0; i < MAX_SUPPORT_POINTS; i++) {
+		u8 *buf = &rdbuf[i * 4];
+		bool down;
+
+		type = buf[5] >> 6;
+		/* ignore Reserved events */
+		if (type == TOUCH_EVENT_RESERVED)
+			continue;
+
+		x = ((buf[5] << 8) | buf[6]) & 0x0fff;
+		y = ((buf[7] << 8) | buf[8]) & 0x0fff;
+		id = (buf[7] >> 4) & 0x0f;
+		down = (type != TOUCH_EVENT_UP);
+
+		input_mt_slot(tsdata->input, id);
+		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
+
+		if (!down)
+			continue;
+
+		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
+	}
+
+	input_mt_report_pointer_emulation(tsdata->input, true);
+	input_sync(tsdata->input);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
+				     u8 addr, u8 value)
+{
+	u8 wrbuf[4];
+
+	wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
+	wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+	wrbuf[2] = value;
+	wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
+
+	return edt_ft5x06_ts_readwrite(tsdata->client, 4, wrbuf, 0, NULL);
+}
+
+static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
+				    u8 addr)
+{
+	u8 wrbuf[2], rdbuf[2];
+	int error;
+
+	wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
+	wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+	wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
+
+	error = edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2, rdbuf);
+	if (error)
+		return error;
+
+	if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1]) {
+		dev_err(&tsdata->client->dev,
+			"crc error: 0x%02x expected, got 0x%02x\n",
+			wrbuf[0] ^ wrbuf[1] ^ rdbuf[0], rdbuf[1]);
+		return -EIO;
+	}
+
+	return rdbuf[0];
+}
+
+struct edt_ft5x06_attribute {
+	struct device_attribute dattr;
+	size_t field_offset;
+	u8 limit_low;
+	u8 limit_high;
+	u8 addr;
+};
+
+#define EDT_ATTR(_field, _mode, _addr, _limit_low, _limit_high)		\
+	struct edt_ft5x06_attribute edt_ft5x06_attr_##_field = {	\
+		.dattr = __ATTR(_field, _mode,				\
+				edt_ft5x06_setting_show,		\
+				edt_ft5x06_setting_store),		\
+		.field_offset =						\
+			offsetof(struct edt_ft5x06_ts_data, _field),	\
+		.limit_low = _limit_low,				\
+		.limit_high = _limit_high,				\
+		.addr = _addr,						\
+	}
+
+static ssize_t edt_ft5x06_setting_show(struct device *dev,
+				       struct device_attribute *dattr,
+				       char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_attribute *attr =
+			container_of(dattr, struct edt_ft5x06_attribute, dattr);
+	u8 *field = (u8 *)((char *)tsdata + attr->field_offset);
+	int val;
+	size_t count = 0;
+	int error = 0;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (tsdata->factory_mode) {
+		error = -EIO;
+		goto out;
+	}
+
+	val = edt_ft5x06_register_read(tsdata, attr->addr);
+	if (val < 0) {
+		error = val;
+		dev_err(&tsdata->client->dev,
+			"Failed to fetch attribute %s, error %d\n",
+			dattr->attr.name, error);
+		goto out;
+	}
+
+	if (val != *field) {
+		dev_warn(&tsdata->client->dev,
+			 "%s: read (%d) and stored value (%d) differ\n",
+			 dattr->attr.name, val, *field);
+		*field = val;
+	}
+
+	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: count;
+}
+
+static ssize_t edt_ft5x06_setting_store(struct device *dev,
+					struct device_attribute *dattr,
+					const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_attribute *attr =
+			container_of(dattr, struct edt_ft5x06_attribute, dattr);
+	u8 *field = (u8 *)((char *)tsdata + attr->field_offset);
+	unsigned int val;
+	int error;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (tsdata->factory_mode) {
+		error = -EIO;
+		goto out;
+	}
+
+	error = kstrtouint(buf, 0, &val);
+	if (error)
+		goto out;
+
+	if (val < attr->limit_low || val > attr->limit_high) {
+		error = -ERANGE;
+		goto out;
+	}
+
+	error = edt_ft5x06_register_write(tsdata, attr->addr, val);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"Failed to update attribute %s, error: %d\n",
+			dattr->attr.name, error);
+		goto out;
+	}
+
+	*field = val;
+
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: count;
+}
+
+static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN, 0, 31);
+static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET, 0, 31);
+static EDT_ATTR(threshold, S_IWUSR | S_IRUGO,
+		WORK_REGISTER_THRESHOLD, 20, 80);
+static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO,
+		WORK_REGISTER_REPORT_RATE, 3, 14);
+
+static struct attribute *edt_ft5x06_attrs[] = {
+	&edt_ft5x06_attr_gain.dattr.attr,
+	&edt_ft5x06_attr_offset.dattr.attr,
+	&edt_ft5x06_attr_threshold.dattr.attr,
+	&edt_ft5x06_attr_report_rate.dattr.attr,
+	NULL
+};
+
+static const struct attribute_group edt_ft5x06_attr_group = {
+	.attrs = edt_ft5x06_attrs,
+};
+
+#if defined(CONFIG_DEBUG_FS)
+static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
+{
+	int retries = EDT_SWITCH_MODE_RETRIES;
+	int ret;
+	int error;
+
+	disable_irq(tsdata->client->irq);
+
+	if (!tsdata->raw_buffer) {
+		tsdata->raw_buffer = kzalloc(tsdata->num_x * tsdata->num_x * 2,
+					     GFP_KERNEL);
+		if (!tsdata->raw_buffer) {
+			error = -ENOMEM;
+			goto err_out;
+		}
+	}
+
+	/* mode register is 0x3c when in the work mode */
+	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"failed to switch to factory mode, error %d\n",
+			error);
+		goto err_out;
+	}
+
+	tsdata->factory_mode = true;
+	do {
+		mdelay(EDT_SWITCH_MODE_DELAY);
+		/* mode register is 0x01 when in factory mode */
+		ret = edt_ft5x06_register_read(tsdata, FACTORY_REGISTER_OPMODE);
+		if (ret == 0x03)
+			break;
+	} while (--retries > 0);
+
+	if (retries == 0) {
+		dev_err(&tsdata->client->dev,
+			"not in factory mode after %dms.\n",
+			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
+		error = -EIO;
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	kfree(tsdata->raw_buffer);
+	tsdata->factory_mode = false;
+	enable_irq(tsdata->client->irq);
+	return error;
+}
+
+static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
+{
+	int retries = EDT_SWITCH_MODE_RETRIES;
+	int ret;
+	int error;
+
+	/* mode register is 0x01 when in the factory mode */
+	error = edt_ft5x06_register_write(tsdata, FACTORY_REGISTER_OPMODE, 0x1);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"failed to switch to work mode, error: %d\n",
+			error);
+		return error;
+	}
+
+	tsdata->factory_mode = false;
+
+	do {
+		mdelay(EDT_SWITCH_MODE_DELAY);
+		/* mode register is 0x01 when in factory mode */
+		ret = edt_ft5x06_register_read(tsdata, WORK_REGISTER_OPMODE);
+		if (ret == 0x01)
+			break;
+	} while (--retries > 0);
+
+	if (retries == 0) {
+		dev_err(&tsdata->client->dev,
+			"not in work mode after %dms.\n",
+			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
+		tsdata->factory_mode = true;
+		return -EIO;
+	}
+
+	kfree(tsdata->raw_buffer);
+	tsdata->raw_buffer = NULL;
+
+	/* restore parameters */
+	edt_ft5x06_register_write(tsdata, WORK_REGISTER_THRESHOLD,
+				  tsdata->threshold);
+	edt_ft5x06_register_write(tsdata, WORK_REGISTER_GAIN,
+				  tsdata->gain);
+	edt_ft5x06_register_write(tsdata, WORK_REGISTER_OFFSET,
+				  tsdata->offset);
+	edt_ft5x06_register_write(tsdata, WORK_REGISTER_REPORT_RATE,
+				  tsdata->report_rate);
+
+	enable_irq(tsdata->client->irq);
+
+	return 0;
+}
+
+ssize_t edt_ft5x06_debugfs_mode_get(void *data, u64 *mode)
+{
+	struct edt_ft5x06_ts_data *tsdata = data;
+	*mode = tsdata->factory_mode;
+	return 0;
+};
+
+ssize_t edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
+{
+	struct edt_ft5x06_ts_data *tsdata = data;
+	int error = 0;
+
+	if (mode > 1)
+		return -ERANGE;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (mode != tsdata->factory_mode) {
+		error = mode ? edt_ft5x06_factory_mode(tsdata) :
+			       edt_ft5x06_work_mode(tsdata);
+	}
+
+	mutex_unlock(&tsdata->mutex);
+
+	return error;
+};
+
+DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
+			edt_ft5x06_debugfs_mode_set, "%llu\n");
+
+static int edt_ft5x06_debugfs_raw_data_open(struct inode *inode,
+					    struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
+					 char *buf,
+					 size_t count,
+					 loff_t *off)
+{
+	struct edt_ft5x06_ts_data *tsdata = file->private_data;
+	int retries  = EDT_RAW_DATA_RETRIES;
+	int ret = 0, i, error;
+	int colbytes;
+	char wrbuf[3];
+	u8 *rdbuf;
+
+	colbytes = tsdata->num_y * 2;
+
+	if (*off < 0 || *off >= tsdata->num_x * colbytes)
+		return 0;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (!tsdata->factory_mode || !tsdata->raw_buffer) {
+		error = -EIO;
+		goto out;
+	}
+
+	error = edt_ft5x06_register_write(tsdata, 0x08, 0x01);
+	if (error) {
+		dev_dbg(&tsdata->client->dev,
+			"failed to write 0x08 register, error %d\n",
+			error);
+		goto out;
+	}
+
+	do {
+		msleep(EDT_RAW_DATA_DELAY);
+		ret = edt_ft5x06_register_read(tsdata, 0x08);
+		if (ret < 1)
+			break;
+	} while (--retries > 0);
+
+	if (ret < 0) {
+		error = ret;
+		dev_dbg(&tsdata->client->dev,
+			"failed to read 0x08 register, error %d\n",
+			error);
+		goto out;
+	}
+
+	if (retries == 0) {
+		dev_dbg(&tsdata->client->dev,
+			"timed out waiting for register to settle\n");
+		error = -ETIMEDOUT;
+		goto out;
+	}
+
+	rdbuf = tsdata->raw_buffer;
+
+	wrbuf[0] = 0xf5;
+	wrbuf[1] = 0x0e;
+	for (i = 0; i < tsdata->num_x; i++) {
+		wrbuf[2] = i;  /* column index */
+		error = edt_ft5x06_ts_readwrite(tsdata->client,
+						sizeof(wrbuf), wrbuf,
+						colbytes, rdbuf);
+		if (error)
+			goto out;
+
+		rdbuf += colbytes;
+	}
+
+	/* rdbuf now points to the end of the raw_buffer */
+
+	ret = min(count, (size_t) ((rdbuf - tsdata->raw_buffer) - *off));
+
+	error = copy_to_user(buf, tsdata->raw_buffer + *off, ret);
+	if (!error)
+		*off += ret;
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: ret;
+};
+
+
+static const struct file_operations debugfs_raw_data_fops = {
+	.open = edt_ft5x06_debugfs_raw_data_open,
+	.read = edt_ft5x06_debugfs_raw_data_read,
+};
+#endif
+
+static int __devinit edt_ft5x06_ts_reset(struct i2c_client *client,
+					 int reset_pin)
+{
+	int error;
+
+	if (gpio_is_valid(reset_pin)) {
+		/* this pulls reset down, enabling the low active reset */
+		error = gpio_request_one(reset_pin, GPIOF_OUT_INIT_LOW,
+					 "edt-ft5x06 reset");
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to request GPIO %d as reset pin, error %d\n",
+				reset_pin, error);
+			return error;
+		}
+
+		mdelay(50);
+		gpio_set_value(reset_pin, 1);
+		mdelay(100);
+	}
+
+	return 0;
+}
+
+static int __devinit edt_ft5x06_ts_identify(struct i2c_client *client,
+					    char *model_name,
+					    char *fw_version)
+{
+	u8 rdbuf[EDT_NAME_LEN];
+	char *p;
+	int error;
+
+	error = edt_ft5x06_ts_readwrite(client, 1, "\xbb",
+					EDT_NAME_LEN - 1, rdbuf);
+	if (error)
+		return error;
+
+	/* remove last '$' end marker */
+	rdbuf[EDT_NAME_LEN - 1] = '\0';
+	if (rdbuf[EDT_NAME_LEN - 2] == '$')
+		rdbuf[EDT_NAME_LEN - 2] = '\0';
+
+	/* look for Model/Version separator */
+	p = strchr(rdbuf, '*');
+	if (p)
+		*p++ = '\0';
+
+	strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
+	strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
+
+	return 0;
+}
+
+static void edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
+				const struct edt_ft5x06_platform_data *pdata)
+{
+	if (!pdata->use_parameters)
+		return;
+
+	/* pick up defaults from the platform data */
+	if (pdata->threshold >= edt_ft5x06_attr_threshold.limit_low &&
+	    pdata->threshold <= edt_ft5x06_attr_threshold.limit_high)
+		edt_ft5x06_register_write(tsdata, WORK_REGISTER_THRESHOLD,
+					  pdata->threshold);
+
+	if (pdata->gain >= edt_ft5x06_attr_gain.limit_low &&
+	    pdata->gain <= edt_ft5x06_attr_gain.limit_high)
+		edt_ft5x06_register_write(tsdata, WORK_REGISTER_GAIN,
+					  pdata->gain);
+
+	if (pdata->offset >= edt_ft5x06_attr_offset.limit_low &&
+	    pdata->offset <= edt_ft5x06_attr_offset.limit_high)
+		edt_ft5x06_register_write(tsdata, WORK_REGISTER_OFFSET,
+					  pdata->offset);
+
+	if (pdata->report_rate >= edt_ft5x06_attr_report_rate.limit_low &&
+	    pdata->report_rate <= edt_ft5x06_attr_report_rate.limit_high)
+		edt_ft5x06_register_write(tsdata, WORK_REGISTER_REPORT_RATE,
+					  pdata->report_rate);
+}
+
+static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
+{
+	tsdata->threshold = edt_ft5x06_register_read(tsdata,
+						     WORK_REGISTER_THRESHOLD);
+	tsdata->gain = edt_ft5x06_register_read(tsdata, WORK_REGISTER_GAIN);
+	tsdata->offset = edt_ft5x06_register_read(tsdata, WORK_REGISTER_OFFSET);
+	tsdata->report_rate = edt_ft5x06_register_read(tsdata,
+						WORK_REGISTER_REPORT_RATE);
+	tsdata->num_x = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_X);
+	tsdata->num_y = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_Y);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+static void edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
+					  const char *debugfs_name)
+{
+	tsdata->debug_dir = debugfs_create_dir(debugfs_name, NULL);
+
+	if (!tsdata->debug_dir)
+		return;
+
+	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);
+	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);
+
+	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
+			    tsdata->debug_dir, tsdata,
+			    &debugfs_mode_fops);
+
+	debugfs_create_file("raw_data", S_IRUSR,
+			    tsdata->debug_dir, tsdata,
+			    &debugfs_raw_data_fops);
+}
+#endif
+
+static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
+					 const struct i2c_device_id *id)
+{
+	const struct edt_ft5x06_platform_data *pdata =
+						client->dev.platform_data;
+	struct edt_ft5x06_ts_data *tsdata;
+	struct input_dev *input;
+	int error;
+	char fw_version[EDT_NAME_LEN];
+
+	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
+
+	if (!pdata) {
+		dev_err(&client->dev, "no platform data?\n");
+		return -EINVAL;
+	}
+
+	error = edt_ft5x06_ts_reset(client, pdata->reset_pin);
+	if (error)
+		return error;
+
+	if (gpio_is_valid(pdata->irq_pin)) {
+		error = gpio_request_one(pdata->irq_pin,
+					 GPIOF_IN, "edt-ft5x06 irq");
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to request GPIO %d, error %d\n",
+				pdata->irq_pin, error);
+			return error;
+		}
+	}
+
+	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!tsdata || !input) {
+		dev_err(&client->dev, "failed to allocate driver data.\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	mutex_init(&tsdata->mutex);
+	tsdata->client = client;
+	tsdata->input = input;
+	tsdata->factory_mode = false;
+
+	error = edt_ft5x06_ts_identify(client, tsdata->name, fw_version);
+	if (error) {
+		dev_err(&client->dev, "touchscreen probe failed\n");
+		goto err_free_mem;
+	}
+
+	edt_ft5x06_ts_get_defaults(tsdata, pdata);
+	edt_ft5x06_ts_get_parameters(tsdata);
+
+	dev_dbg(&client->dev,
+		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
+		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
+
+	input->name = tsdata->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	input_set_abs_params(input, ABS_X, 0, tsdata->num_x * 64 - 1, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X,
+			     0, tsdata->num_x * 64 - 1, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
+			     0, tsdata->num_y * 64 - 1, 0, 0);
+	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS);
+	if (error) {
+		dev_err(&client->dev, "Unable to init MT slots.\n");
+		goto err_free_mem;
+	}
+
+	input_set_drvdata(input, tsdata);
+	i2c_set_clientdata(client, tsdata);
+
+	error = request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     client->name, tsdata);
+	if (error) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		goto err_free_mem;
+	}
+
+	error = sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_group);
+	if (error)
+		goto err_free_irq;
+
+	error = input_register_device(input);
+	if (error)
+		goto err_remove_attrs;
+
+#if defined(CONFIG_DEBUG_FS)
+	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
+#endif
+
+	device_init_wakeup(&client->dev, 1);
+
+	dev_dbg(&tsdata->client->dev,
+		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
+		pdata->irq_pin, pdata->reset_pin);
+
+	return 0;
+
+err_remove_attrs:
+	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
+err_free_irq:
+	free_irq(client->irq, tsdata);
+err_free_mem:
+	input_free_device(input);
+	kfree(tsdata);
+
+	if (gpio_is_valid(pdata->irq_pin))
+		gpio_free(pdata->irq_pin);
+
+	return error;
+}
+
+static int __devexit edt_ft5x06_ts_remove(struct i2c_client *client)
+{
+	const struct edt_ft5x06_platform_data *pdata =
+						client->dev.platform_data;
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+
+#if defined(CONFIG_DEBUG_FS)
+	if (tsdata->debug_dir)
+		debugfs_remove_recursive(tsdata->debug_dir);
+#endif
+
+	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
+
+	free_irq(client->irq, tsdata);
+	input_unregister_device(tsdata->input);
+	if (gpio_is_valid(pdata->irq_pin))
+		gpio_free(pdata->irq_pin);
+	if (gpio_is_valid(pdata->reset_pin))
+		gpio_free(pdata->reset_pin);
+	kfree(tsdata);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int edt_ft5x06_ts_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int edt_ft5x06_ts_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
+			 edt_ft5x06_ts_suspend, edt_ft5x06_ts_resume);
+
+static const struct i2c_device_id edt_ft5x06_ts_id[] = {
+	{ "edt-ft5x06", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
+
+static struct i2c_driver edt_ft5x06_ts_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "edt_ft5x06",
+		.pm = &edt_ft5x06_ts_pm_ops,
+	},
+	.id_table = edt_ft5x06_ts_id,
+	.probe    = edt_ft5x06_ts_probe,
+	.remove   = __devexit_p(edt_ft5x06_ts_remove),
+};
+
+module_i2c_driver(edt_ft5x06_ts_driver);
+
+MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
+MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
new file mode 100644
index 0000000..8a1e0d1
--- /dev/null
+++ b/include/linux/input/edt-ft5x06.h
@@ -0,0 +1,24 @@
+#ifndef _EDT_FT5X06_H
+#define _EDT_FT5X06_H
+
+/*
+ * Copyright (c) 2012 Simon Budig, <simon.budig@kernelconcepts.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+struct edt_ft5x06_platform_data {
+	int irq_pin;
+	int reset_pin;
+
+	/* startup defaults for operational parameters */
+	bool use_parameters;
+	u8 gain;
+	u8 threshold;
+	u8 offset;
+	u8 report_rate;
+};
+
+#endif /* _EDT_FT5X06_H */
-- 
1.7.2.5

