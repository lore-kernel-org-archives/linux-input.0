From: Bogdan George Stefan <bogdan.g.stefan@intel.com>
Subject: [PATCH v2] Input: Add generic driver for Zeitec touchscreens
Date: Thu, 28 May 2015 15:22:02 +0300
Message-ID: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27552 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbbE1MPp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 08:15:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Purdila Octavian <octavian.purdila@intel.com>

This driver adds support for Zeitec touchscreens. It has
been tested with ZET6273 and ZET9172.

It supports ACPI and device tree enumeration. For ACPI you need ACPI
5.1+ in order to be able to use named GPIOs.

Screen resolution, the maximum number of fingers supported,
if the touchscreen has hardware keys are configurable
using ACPI/DT properties.

Signed-off-by: Bogdan George Stefan <bogdan.g.stefan@intel.com>
---
Changes since v1:

Implemented most changes following Dmitry Torokhov's recommendations
from https://lkml.org/lkml/2015/5/15/319
The only things I kept are described below in the Notes section.
- fixed style issues
- reset is activated when gpio is set to high
- switched from i2c_transfer to i2c_master_recv/i2c_master_send
- removed redundant evbit initialization. However EV_ABS still needs
to be reported and it is set through input_set_capability
- replaced usleep_range with msleep where neede. Checking the patch
with -strict will report an issue on this. Hope this is not a problem
- fixed casts in zet_process_events
- removed  client->irq = gpiod_to_irq(ts->irq); from probe
- moved firmware loading from probe to open
- used proper casts in zet_suspend
- dropped zet_ts_remove as it was doing unnecesary things
Notes:
- I've kept the flags IRQF_TRIGGER_FALLING | IRQF_ONESHOT when calling
devm_request_threaded_irq. No the irq handler is not called whn only IRQF_ONESHOT
is used. Looking at other drivers, I saw that they use the same aproach. I am not
sure how to setup things in ACPI/DT so that the driver could work only with IRQF_ONESHOT
- The number of thingers that can simultaneously touch the device and if it has
HW keys or not, cannot be read from the device. I've asked Zeitec on this.

 drivers/input/touchscreen/Kconfig  |  12 +
 drivers/input/touchscreen/Makefile |   1 +
 drivers/input/touchscreen/zeitec.c | 550 +++++++++++++++++++++++++++++++++++++
 3 files changed, 563 insertions(+)
 create mode 100644 drivers/input/touchscreen/zeitec.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 80f6386..2046633 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -27,6 +27,18 @@ config TOUCHSCREEN_88PM860X
 	  To compile this driver as a module, choose M here: the
 	  module will be called 88pm860x-ts.
 
+config TOUCHSCREEN_ZEITEC
+	tristate "Generic ZEITEC touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have the Zeitec touchscreen connected to
+	  your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zeitec.
+
 config TOUCHSCREEN_ADS7846
 	tristate "ADS7846/TSC2046/AD7873 and AD(S)7843 based touchscreens"
 	depends on SPI_MASTER
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 44deea7..7593fea 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
+obj-$(CONFIG_TOUCHSCREEN_ZEITEC)	+= zeitec.o
diff --git a/drivers/input/touchscreen/zeitec.c b/drivers/input/touchscreen/zeitec.c
new file mode 100644
index 0000000..bffa6f9
--- /dev/null
+++ b/drivers/input/touchscreen/zeitec.c
@@ -0,0 +1,550 @@
+/*
+ * Driver for Zeitec touchscreens.
+ *
+ * Copyright (c) 2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+#include <linux/acpi.h>
+#include <linux/gpio.h>
+#include <linux/firmware.h>
+#include <linux/types.h>
+#include "../../gpio/gpiolib.h"
+
+#define FLASH_SIZE_ZET6273			0xA000
+#define ZET_TOTAL_PKT_SIZE			70
+#define ZET_MODEL_PKT_SIZE			17
+
+#define ZET_ROM_TYPE_UNKNOWN			0x00
+#define ZET_ROM_TYPE_SRAM			0x02
+#define ZET_ROM_TYPE_OTP			0x06
+#define ZET_ROM_TYPE_FLASH			0x0F
+
+#define ZET_FLASH_PAGE_LEN			128
+
+#define ZET_CMD_GET_CODEOPTION			0x27
+#define ZET_CMD_GET_INFORMATION			0xB2
+#define ZET_CMD_WRITE_PASSWORD			0x20
+#define ZET_CMD_WRITE_PROGRAM			0x22
+#define ZET_CMD_READ_CODE_OPTION		0x27
+#define ZET_CMD_RESET_MCU			0x29
+#define ZET_CMD_WRITE_SFR			0x2B
+#define ZET_CMD_READ_SFR			0x2C
+#define ZET_CMD_ENTER_SLEEP			0xB1
+
+#define ZET_PASSWORD				0x9DC5
+
+#define ZET_TS_WAKEUP_LOW_PERIOD		10
+#define ZET_TS_WAKEUP_HIGH_PERIOD		20
+
+#define ZET_FINGER_REPROT_DATA_HEADER		0x3C
+#define ZET_PAGE_HEADER_COMMAND_LEN		3
+#define FINGER_PACK_SIZE			4
+#define FINGER_HEADER_SHIFT			3
+#define ZET_FINGER_OFFSET		(FINGER_PACK_SIZE + \
+					 FINGER_HEADER_SHIFT)
+
+#define ZET_MODEL_6273	0x6270
+#define ZET_MODEL_9172	0x9172
+
+#define ZET_RESOLUTION_X		"touchscreen-size-x"
+#define ZET_RESOLUTION_Y		"touchscreen-size-y"
+#define ZET_MAX_FINGERS			"max-fingers"
+#define ZET_HAS_KEYS			"has-keys"
+
+struct zet_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	u16 resolution_x;
+	u16 resolution_y;
+	u8 finger_num;
+	u16 finger_packet_size;
+	struct gpio_desc *reset;
+	struct gpio_desc *irq;
+	u8 device_model;
+	u8 rom_type;
+	u16 model_type;
+	u8 has_keys;
+	char fw_name[32];
+};
+
+struct zet_finger_coordinate {
+	u32 report_x;
+	u32 report_y;
+	u32 report_z;
+	u8 valid;
+};
+
+static void zet_ts_reset(struct zet_ts_data *ts)
+{
+	gpiod_set_value_cansleep(ts->reset, 1);
+	msleep(ZET_TS_WAKEUP_LOW_PERIOD);
+	gpiod_set_value_cansleep(ts->reset, 0);
+	msleep(ZET_TS_WAKEUP_HIGH_PERIOD);
+}
+
+static int zet_get_model_type(struct zet_ts_data *ts)
+{
+	u8 ts_in_data[ZET_MODEL_PKT_SIZE];
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(ts->client,
+					    ZET_CMD_GET_CODEOPTION,
+					    ZET_MODEL_PKT_SIZE, ts_in_data);
+	if (ret < 0) {
+		dev_err(&ts->client->dev, "I2C read error= %d\n", ret);
+		return ret;
+	}
+
+	ts->model_type = le16_to_cpup((__le16 *)&ts_in_data[6]);
+
+	switch (ts->model_type) {
+	case ZET_MODEL_6273:
+	case ZET_MODEL_9172:
+		ts->rom_type = ZET_ROM_TYPE_SRAM;
+		snprintf(ts->fw_name, sizeof(ts->fw_name),
+			 "zet%x.bin", ts->model_type);
+		break;
+	default:
+		ts->rom_type = ZET_ROM_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int zet_ts_get_information(struct zet_ts_data *ts)
+{
+	int error;
+
+	error = device_property_read_u16(&ts->client->dev,
+					 ZET_RESOLUTION_X,
+					 &ts->resolution_x);
+	if (error < 0) {
+		dev_err(&ts->client->dev, "Failed to read %s property\n",
+			ZET_RESOLUTION_X);
+		return error;
+	}
+
+	error = device_property_read_u16(&ts->client->dev,
+					 ZET_RESOLUTION_Y,
+					 &ts->resolution_y);
+	if (error < 0) {
+		dev_err(&ts->client->dev, "Failed to read %s property\n",
+			ZET_RESOLUTION_Y);
+		return error;
+	}
+
+	error = device_property_read_u8(&ts->client->dev,
+					ZET_MAX_FINGERS,
+					&ts->finger_num);
+	if (error < 0) {
+		dev_err(&ts->client->dev, "Failed to read %s property\n",
+			ZET_MAX_FINGERS);
+		return error;
+	}
+
+	error = device_property_read_u8(&ts->client->dev,
+					ZET_HAS_KEYS,
+					&ts->has_keys);
+	if (error < 0) {
+		dev_err(&ts->client->dev, "Failed to read %s property\n",
+			ZET_HAS_KEYS);
+		return error;
+	}
+
+	ts->finger_packet_size  = 3 + 4 * ts->finger_num;
+	if (ts->has_keys)
+		ts->finger_packet_size += 1;
+
+	return 0;
+}
+
+static int zet_gpio_probe(struct zet_ts_data *ts)
+{
+	struct device *dev;
+	struct gpio_desc *gpiod;
+	int err;
+
+	dev = &ts->client->dev;
+
+	gpiod = devm_gpiod_get(dev, "int", GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		dev_err(dev, "get int failed: %d\n", err);
+		return err;
+	}
+
+	ts->irq = gpiod;
+
+	gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		dev_err(dev, "get reset failed: %d\n", err);
+		return err;
+	}
+
+	ts->reset = gpiod;
+
+	return 0;
+}
+
+static bool zet_ts_check_skip_page(const u8 *data)
+{
+	int j;
+
+	for (j = 0 ; j < ZET_FLASH_PAGE_LEN ; j++) {
+		if (data[j] != 0xFF)
+			return false;
+	}
+
+	return true;
+}
+
+static int zet_cmd_writepage(struct zet_ts_data *ts,
+			     int page_id,
+			     const u8 *buf)
+{
+	u8 tx_buf[ZET_PAGE_HEADER_COMMAND_LEN + ZET_FLASH_PAGE_LEN];
+	int error;
+
+	switch (ts->model_type) {
+	case ZET_MODEL_6273:
+	case ZET_MODEL_9172:
+		tx_buf[0] = ZET_CMD_WRITE_PROGRAM;
+		tx_buf[1] = (page_id & 0xff);
+		tx_buf[2] = (u8)(page_id >> 8);
+		break;
+	default:
+		kfree(tx_buf);
+		return -EINVAL;
+	}
+
+	memmove(tx_buf + ZET_PAGE_HEADER_COMMAND_LEN, buf, ZET_FLASH_PAGE_LEN);
+
+	/*
+	 * i2c_smbus functions only allow us to write 32 bytes at a time
+	 * We need to write 131 at a time for each page. i2c_master_send
+	 * is needed here
+	 */
+	error = i2c_master_send(ts->client, tx_buf,
+				ZET_PAGE_HEADER_COMMAND_LEN +
+				ZET_FLASH_PAGE_LEN);
+	if (error < 0) {
+		dev_err(&ts->client->dev,
+			"Failed to write firmware page: %d\n", page_id);
+	}
+
+	return 0;
+}
+
+static int zet_download_firmware(struct zet_ts_data *ts)
+{
+	const struct firmware *fw;
+	int flash_rest_len = 0;
+	int flash_page_id = 0;
+	int error = 0;
+	int offset;
+
+	error = request_firmware(&fw, ts->fw_name, &ts->client->dev);
+	if (error != 0) {
+		dev_err(&ts->client->dev,
+			"Unable to open firmware %s\n",
+			ts->fw_name);
+		return error;
+	}
+
+	flash_rest_len = fw->size;
+
+	while (flash_rest_len > 0) {
+		offset = flash_page_id * ZET_FLASH_PAGE_LEN;
+		if (zet_ts_check_skip_page(fw->data + offset)) {
+			flash_rest_len -= ZET_FLASH_PAGE_LEN;
+			flash_page_id += 1;
+			continue;
+		}
+
+		error = zet_cmd_writepage(ts, flash_page_id,
+					  fw->data + offset);
+		if (error < 0) {
+			dev_err(&ts->client->dev,
+				"Could not write firmware page %d\n", error);
+			goto cleanup;
+		}
+
+
+		flash_rest_len -= ZET_FLASH_PAGE_LEN;
+		flash_page_id++;
+	}
+
+	error = i2c_smbus_write_byte(ts->client, ZET_CMD_RESET_MCU);
+	if (error < 0) {
+		dev_err(&ts->client->dev,
+			"Unable to reset device %d\n", error);
+		goto cleanup;
+	}
+
+	msleep(10);
+	zet_ts_reset(ts);
+
+cleanup:
+	release_firmware(fw);
+
+	return error > 0 ? 0 : error;
+}
+
+static int zet_ts_open(struct input_dev *dev)
+{
+	struct zet_ts_data *ts;
+	int error;
+
+	ts = input_get_drvdata(dev);
+	error = zet_download_firmware(ts);
+	if (error < 0)
+		return error;
+
+	error = zet_ts_get_information(ts);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int zet_request_input_dev(struct zet_ts_data *ts)
+{
+	int error;
+
+	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
+	if (!ts->input_dev) {
+		dev_err(&ts->client->dev, "Failed to allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	input_set_capability(ts->input_dev, EV_ABS, ABS_X);
+	input_set_capability(ts->input_dev, EV_ABS, ABS_Y);
+
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
+			     ts->resolution_x, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
+			     ts->resolution_y, 0, 0);
+
+	input_mt_init_slots(ts->input_dev, ts->finger_num,
+			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+
+	ts->input_dev->name = "Zeitec touchscreen";
+	ts->input_dev->phys = "input/ts";
+	ts->input_dev->id.bustype = BUS_HOST;
+	ts->input_dev->open = zet_ts_open;
+	input_set_drvdata(ts->input_dev, ts);
+
+	error = input_register_device(ts->input_dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	__set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
+
+	return 0;
+}
+
+static void zet_process_events(struct zet_ts_data *ts)
+{
+	char ts_data[ZET_TOTAL_PKT_SIZE];
+	int error;
+	int i;
+	u16 valid;
+	u8 offset;
+	struct zet_finger_coordinate finger_report;
+
+	/*
+	 * We do not read from a specific register as i2c_smbus function
+	 * require. We know exactly how many bytes are available on the
+	 * first read after an IRQ and use i2c_master_recv for it
+	 */
+	error = i2c_master_recv(ts->client, &ts_data[0],
+				ts->finger_packet_size);
+	if (error < 0) {
+		dev_err(&ts->client->dev,
+			"Unable to open read touch info %d\n",
+			error);
+		return;
+	}
+
+	if (ts_data[0] != ZET_FINGER_REPROT_DATA_HEADER)
+		return;
+
+	valid = get_unaligned_be16(&ts_data[1]);
+
+	for (i = 0; i < ts->finger_num; i++) {
+		/*if not pressed, go on */
+		if (!(valid & BIT(15 - i)))
+			continue;
+
+		/* get the finger data */
+		offset = FINGER_HEADER_SHIFT + FINGER_PACK_SIZE * i;
+		finger_report.report_x =
+			(u32)(ts_data[offset] >> 4) * 256 +
+			ts_data[offset + 1];
+
+		finger_report.report_y =
+			(u32)(ts_data[offset] & 0x0f) * 256 +
+			ts_data[offset + 2];
+
+		input_mt_slot(ts->input_dev, i);
+		input_mt_report_slot_state(ts->input_dev,
+					   MT_TOOL_FINGER,
+					   true);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+				 finger_report.report_x);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+				 finger_report.report_y);
+	}
+
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+}
+
+static irqreturn_t zet_ts_irq_handler(int irq, void *dev_id)
+{
+	zet_process_events((struct zet_ts_data *)dev_id);
+	return IRQ_HANDLED;
+}
+
+static int zet_ts_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct zet_ts_data *ts;
+	int error;
+	int flags;
+
+	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C check functionality failed.\n");
+		return -ENXIO;
+	}
+
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	ts->client = client;
+
+	error = zet_gpio_probe(ts);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, ts);
+
+	error = i2c_smbus_write_word_data(ts->client,
+					  ZET_CMD_WRITE_PASSWORD,
+					  cpu_to_le16(ZET_PASSWORD));
+	if (error < 0) {
+		dev_err(&client->dev,
+			"Could not unlock device. error: %d\n", error);
+		return error;
+	}
+
+	error = zet_get_model_type(ts);
+	if (error < 0)
+		return error;
+
+	error = zet_request_input_dev(ts);
+	if (error)
+		return error;
+
+	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	error = devm_request_threaded_irq(&ts->client->dev, client->irq,
+					  NULL, zet_ts_irq_handler,
+					  flags, client->name, ts);
+	if (error) {
+		dev_err(&client->dev, "request IRQ failed: %d\n", error);
+		return error;
+	}
+
+	return error;
+}
+
+static int zet_suspend(struct device *dev)
+{
+	int error;
+	struct i2c_client *client;
+
+	client = to_i2c_client(dev);
+	disable_irq(client->irq);
+
+	error = i2c_smbus_write_byte(client, ZET_CMD_ENTER_SLEEP);
+	if (error < 0) {
+		dev_err(dev, "could not enter sleep error= %d\n", error);
+		return error;
+	}
+
+	dev_dbg(dev, "sleeping\n");
+	return 0;
+}
+
+static int zet_wakeup(struct device *dev)
+{
+	struct i2c_client *client;
+	struct zet_ts_data *ts;
+
+	client = to_i2c_client(dev);
+	ts = (struct zet_ts_data *)i2c_get_clientdata(client);
+
+	enable_irq(ts->client->irq);
+
+	zet_ts_reset(ts);
+
+	return 0;
+}
+
+static const struct i2c_device_id zet_ts_idtable[] = {
+	{ "zet6273", 0 },
+	{ "zet9172", 0 },
+	{ }
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id zeitec_acpi_match[] = {
+	{ "ZET6273", 0 },
+	{ "ZET9172", 0 },
+	{ }
+};
+#endif
+
+static SIMPLE_DEV_PM_OPS(zet_pm_ops, zet_suspend, zet_wakeup);
+
+static struct i2c_driver zet_i2c_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "zeitec_ts",
+		.pm	= &zet_pm_ops,
+		.acpi_match_table = ACPI_PTR(zeitec_acpi_match),
+	},
+	.probe		= zet_ts_probe,
+	.id_table	= zet_ts_idtable,
+};
+
+module_i2c_driver(zet_i2c_driver);
+
+MODULE_AUTHOR("Bogdan George Stefan <bogdan.g.stefan@intel.com>");
+MODULE_DESCRIPTION("ZEITEC I2C Touch Screen driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

