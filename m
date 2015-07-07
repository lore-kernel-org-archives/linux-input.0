From: Yuger <yuger_yu@sis.com>
Subject: [PATCH] Add support for SiS i2c touch driver
Date: Tue, 7 Jul 2015 11:51:29 +0800
Message-ID: <20150707035128.GA28112@sis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 42-72-213-13.EMOME-IP.hinet.net ([42.72.213.13]:19192 "EHLO
	yuger-ThinkCentre-M70e" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751513AbbGGE4f (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 00:56:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: yuger_yu@sis.com, tammy_tseng@sis.com

Hi, This patch is to add support for SiS i2c touch panel.
Thanks a lot.

Signed-off-by: Yuger <yuger_yu@sis.com>
---
 drivers/input/touchscreen/Kconfig   |  11 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sis_i2c.c | 627 ++++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/sis_i2c.h | 164 ++++++++++
 4 files changed, 803 insertions(+)
 create mode 100644 drivers/input/touchscreen/sis_i2c.c
 create mode 100644 drivers/input/touchscreen/sis_i2c.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index d20fe1d..3d7a30d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1027,4 +1027,15 @@ config TOUCHSCREEN_ZFORCE
 	  To compile this driver as a module, choose M here: the
 	  module will be called zforce_ts.
 
+config TOUCHSCREEN_SIS_I2C
+	tristate "SiS 9200 family I2C touchscreen driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for I2C connected SiS touch panels.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sis_i2c.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 44deea7..02b466e 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
+obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)   += sis_i2c.o
diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
new file mode 100644
index 0000000..22dfc1f
--- /dev/null
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -0,0 +1,627 @@
+/*
+ * Touch Screen driver for SiS 9200 family I2C Touch panels
+ *
+ * Copyright (C) 2015 SiS, Inc.
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
+ * Date: 2015/07/07
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include "sis_i2c.h"
+#include <linux/linkage.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/uaccess.h>
+#include <linux/irq.h>
+#include <asm/unaligned.h>
+#include <linux/input/mt.h>	/*For Type-B Slot function*/
+#include <linux/crc-itu-t.h>	/*For CRC Check*/
+
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = { SIS_SLAVE_ADDR, I2C_CLIENT_END };
+static struct workqueue_struct *sis_wq;
+struct sis_ts_data *ts_bak;
+static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int max);
+
+static int sis_command_for_read(struct i2c_client *client, int rlength,
+							unsigned char *rdata)
+{
+	int ret;
+	struct i2c_msg msg;
+
+	msg.addr = client->addr;
+	msg.flags = I2C_M_RD; /*Read*/
+	msg.len = rlength;
+	msg.buf = rdata;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret;
+}
+
+static int sis_cul_unit(uint8_t report_id)
+{
+	int ret = NORMAL_LEN_PER_POINT;
+
+	if (report_id != ALL_IN_ONE_PACKAGE) {
+		if (IS_AREA(report_id))
+			ret += AREA_LEN_PER_POINT;
+		if (IS_PRESSURE(report_id))
+			ret += PRESSURE_LEN_PER_POINT;
+	}
+
+	return ret;
+}
+
+static int sis_ReadPacket(struct i2c_client *client, uint8_t cmd, uint8_t *buf)
+{
+	uint8_t tmpbuf[MAX_BYTE] = {0};	/*MAX_BYTE = 64;*/
+	int ret;
+	int touchnum = 0;
+	int p_count = 0;
+	int touc_formate_id = 0;
+	int locate = 0;
+	bool read_first = true;
+	/*
+	* New i2c format
+	* buf[0] = Low 8 bits of byte count value
+	* buf[1] = High 8 bits of byte counte value
+	* buf[2] = Report ID
+	* buf[touch num * 6 + 2 ] = Touch information;
+	* 1 touch point has 6 bytes, it could be none if no touch
+	* buf[touch num * 6 + 3] = Touch numbers
+	*
+	* One touch point information include 6 bytes, the order is
+	*
+	* 1. status = touch down or touch up
+	* 2. id = finger id
+	* 3. x axis low 8 bits
+	* 4. x axis high 8 bits
+	* 5. y axis low 8 bits
+	* 6. y axis high 8 bits
+	* */
+	do {
+		if (locate >= PACKET_BUFFER_SIZE) {
+			pr_err("sis_ReadPacket: Buf Overflow\n");
+			return -EPERM;
+		}
+		ret = sis_command_for_read(client, MAX_BYTE, tmpbuf);
+
+		if (ret < 0) {
+			pr_err("sis_ReadPacket: i2c transfer error\n");
+			return ret;
+		}
+		/*error package length of receiving data*/
+		else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
+			pr_err("sis_ReadPacket: Error Bytecount\n");
+			return -EPERM;
+		}
+		if (read_first) {
+			/*access NO TOUCH event unless BUTTON NO TOUCH event*/
+			if (tmpbuf[P_BYTECOUNT] == 0/*NO_TOUCH_BYTECOUNT*/)
+				return 0;	/*touchnum is 0*/
+		}
+		/*skip parsing data when two devices are registered
+		 * at the same slave address*/
+		/*parsing data when P_REPORT_ID && 0xf is TOUCH_FORMAT
+		 * or P_REPORT_ID is ALL_IN_ONE_PACKAGE*/
+		touc_formate_id = tmpbuf[P_REPORT_ID] & 0xf;
+		if ((touc_formate_id != TOUCH_FORMAT)
+		&& (touc_formate_id != HIDI2C_FORMAT)
+		&& (tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE)) {
+			pr_err("sis_ReadPacket: Error Report_ID\n");
+			return -EPERM;
+		}
+		p_count = (int) tmpbuf[P_BYTECOUNT] - 1;	/*start from 0*/
+		if (tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE) {
+			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
+				p_count -= BYTE_CRC_I2C;/*delete 2 byte crc*/
+			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
+				p_count -= BYTE_CRC_HIDI2C;
+			} else {	/*should not be happen*/
+				pr_err("sis_ReadPacket: delete crc error\n");
+				return -EPERM;
+			}
+			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
+				p_count -= BYTE_SCANTIME;
+		}
+		/*For ALL_IN_ONE_PACKAGE*/
+		if (read_first) {
+			touchnum = tmpbuf[p_count];
+		} else {
+			if (tmpbuf[p_count] != 0) {
+				pr_err("sis_ReadPacket: get error package\n");
+				return -EPERM;
+			}
+		}
+
+#ifdef _CHECK_CRC
+		/* HID over I2C data foramt and no touch packet without CRC */
+		if ((touc_formate_id != HIDI2C_FORMAT) &&
+			(tmpbuf[P_BYTECOUNT] > 3)) {
+			int crc_end = p_count + (IS_SCANTIME(
+				tmpbuf[P_REPORT_ID]) * 2);
+			uint16_t buf_crc = crc_itu_t(
+				0, tmpbuf + 2, crc_end - 1);
+			int l_package_crc = (IS_SCANTIME(
+				tmpbuf[P_REPORT_ID]) * 2) + p_count + 1;
+			uint16_t package_crc = get_unaligned_le16(
+				&tmpbuf[l_package_crc]);
+
+			if (buf_crc != package_crc) {
+				pr_err("sis_ReadPacket: CRC Error\n");
+				return -EPERM;
+			}
+		}
+#endif
+		memcpy(&buf[locate], &tmpbuf[0], 64);
+		/*Buf_Data [0~63] [64~128]*/
+		locate += 64;
+		read_first = false;
+	} while (tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE &&
+			tmpbuf[p_count] > 5);
+	return touchnum;
+}
+
+static void sis_ts_work_func(struct work_struct *work)
+{
+	struct sis_ts_data *ts = container_of(work, struct sis_ts_data, work);
+	struct sisTP_driver_data *TPInfo = ts->TPInfo;
+	int ret;
+	int point_unit;
+	uint8_t buf[PACKET_BUFFER_SIZE] = {0};
+	uint8_t i = 0, fingers = 0;
+	uint8_t px = 0, py = 0, pstatus = 0;
+	uint8_t p_area = 0;
+	uint8_t p_preasure = 0;
+	int CheckID[MAX_FINGERS];
+	static int Pre_CheckID[MAX_FINGERS];
+	struct TypeB_Slot MM_Slot[MAX_FINGERS];
+
+	memset(CheckID, 0, sizeof(int)*MAX_FINGERS);
+
+	mutex_lock(&ts->mutex_wq);
+	/*I2C or SMBUS block data read*/
+	ret = sis_ReadPacket(ts->client, SIS_CMD_NORMAL, buf);
+	/*Error Number*/
+	if (ret < 0)
+		goto err_free_allocate;
+	/*access NO TOUCH event unless BUTTON NO TOUCH event*/
+	else if (ret == 0) {
+		fingers = 0;
+		sis_tpinfo_clear(TPInfo, MAX_FINGERS);
+
+		goto Tye_B_report;
+	}
+	sis_tpinfo_clear(TPInfo, MAX_FINGERS);
+
+	/*Parser and Get the sis9200 data*/
+	point_unit = sis_cul_unit(buf[P_REPORT_ID]);
+	fingers = ret;
+
+	TPInfo->fingers = fingers = (fingers > MAX_FINGERS ? 0 : fingers);
+
+	/*fingers 10 =  0 ~ 9*/
+	for (i = 0; i < fingers; i++) {
+		if ((buf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE) && (i >= 5)) {
+			/*Calc point status*/
+			pstatus = BYTE_BYTECOUNT + BYTE_ReportID
+					+ ((i - 5) * point_unit);
+			pstatus += 64;
+		} else {
+			pstatus = BYTE_BYTECOUNT + BYTE_ReportID
+					+ (i * point_unit);
+					/*Calc point status*/
+		}
+	    px = pstatus + 2;	/*Calc point x_coord*/
+	    py = px + 2;	/*Calc point y_coord*/
+		if ((buf[pstatus]) == TOUCHUP) {
+			TPInfo->pt[i].Width = 0;
+			TPInfo->pt[i].Height = 0;
+			TPInfo->pt[i].Pressure = 0;
+		} else if (buf[P_REPORT_ID] == ALL_IN_ONE_PACKAGE
+					&& (buf[pstatus]) == TOUCHDOWN) {
+			TPInfo->pt[i].Width = 1;
+			TPInfo->pt[i].Height = 1;
+			TPInfo->pt[i].Pressure = 1;
+		} else if ((buf[pstatus]) == TOUCHDOWN) {
+			p_area = py + 2;
+			p_preasure = py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
+			/*area*/
+			if (IS_AREA(buf[P_REPORT_ID])) {
+				TPInfo->pt[i].Width = buf[p_area];
+				TPInfo->pt[i].Height = buf[p_area + 1];
+			} else {
+				TPInfo->pt[i].Width = 1;
+				TPInfo->pt[i].Height = 1;
+			}
+			/*pressure*/
+			if (IS_PRESSURE(buf[P_REPORT_ID]))
+				TPInfo->pt[i].Pressure = (buf[p_preasure]);
+			else
+				TPInfo->pt[i].Pressure = 1;
+		} else {
+			pr_err("sis_ts_work_func: Error Touch Status\n");
+			goto err_free_allocate;
+		}
+		TPInfo->pt[i].id = (buf[pstatus + 1]);
+		TPInfo->pt[i].x = get_unaligned_le16(&buf[px]);
+		TPInfo->pt[i].y = get_unaligned_le16(&buf[py]);
+
+		CheckID[TPInfo->pt[i].id] = 1;
+		MM_Slot[TPInfo->pt[i].id].id = TPInfo->pt[i].id;
+		MM_Slot[TPInfo->pt[i].id].Pressure = TPInfo->pt[i].Pressure;
+		MM_Slot[TPInfo->pt[i].id].x = TPInfo->pt[i].x;
+		MM_Slot[TPInfo->pt[i].id].y = TPInfo->pt[i].y;
+		MM_Slot[TPInfo->pt[i].id].Width = TPInfo->pt[i].Width
+						* AREA_UNIT;
+		MM_Slot[TPInfo->pt[i].id].Height = TPInfo->pt[i].Height
+						* AREA_UNIT;
+
+	}
+
+Tye_B_report:
+
+	for (i = 0; i < MAX_FINGERS; i++) {
+		if ((CheckID[i] != Pre_CheckID[i]) && (CheckID[i] != 1))
+			CheckID[i] = -1;
+	}
+
+	for (i = 0; i < MAX_FINGERS; i++) {
+		if (CheckID[i] == 1) {
+			input_mt_slot(ts->input_dev, i+1);
+			if (MM_Slot[i].Pressure > 0) {
+				input_mt_report_slot_state(ts->input_dev,
+						MT_TOOL_FINGER, true);
+				input_report_abs(ts->input_dev,
+					ABS_MT_PRESSURE, MM_Slot[i].Pressure);
+				input_report_abs(ts->input_dev,
+					ABS_MT_TOUCH_MAJOR, MM_Slot[i].Width);
+				input_report_abs(ts->input_dev,
+					ABS_MT_TOUCH_MINOR, MM_Slot[i].Height);
+				input_report_abs(ts->input_dev,
+					ABS_MT_POSITION_X, MM_Slot[i].x);
+				input_report_abs(ts->input_dev,
+					ABS_MT_POSITION_Y, MM_Slot[i].y);
+			} else {
+				input_mt_report_slot_state(ts->input_dev,
+						MT_TOOL_FINGER, false);
+				CheckID[i] = 0;
+			}
+		} else if (CheckID[i] == -1) {
+			input_mt_slot(ts->input_dev, i+1);
+			input_mt_report_slot_state(ts->input_dev,
+					MT_TOOL_FINGER, false);
+			CheckID[i] = 0;
+		}
+		Pre_CheckID[i] = CheckID[i];
+	}
+
+	input_sync(ts->input_dev);
+
+err_free_allocate:
+
+	if (ts->use_irq) {
+#ifdef _INT_MODE_1	/*case 1 mode*/
+		/*TODO: After interrupt status low,
+		 * read i2c bus data by polling,
+		 * until interrupt status is high*/
+		ret =  gpio_get_value(GPIO_IRQ);
+		/*interrupt pin is still LOW,
+		 * read data until interrupt pin is released.*/
+		if (!ret)
+			hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS),
+						HRTIMER_MODE_REL);
+		else {
+			/*clear for interrupt*/
+			if (irqd_irq_disabled(&ts->desc->irq_data))
+				enable_irq(ts->client->irq);
+		}
+#else /*case 2 mode*/
+		if (irqd_irq_disabled(&ts->desc->irq_data))
+			enable_irq(ts->client->irq);
+#endif
+	}
+
+	mutex_unlock(&ts->mutex_wq);
+}
+
+static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int max)
+{
+	int i = 0;
+
+	for (i = 0; i < max; i++) {
+		TPInfo->pt[i].id = -1;
+		TPInfo->pt[i].x = 0;
+		TPInfo->pt[i].y = 0;
+		TPInfo->pt[i].Pressure = 0;
+		TPInfo->pt[i].Width = 0;
+	}
+	TPInfo->id = 0x0;
+	TPInfo->fingers = 0;
+}
+
+static enum hrtimer_restart sis_ts_timer_func(struct hrtimer *timer)
+{
+	struct sis_ts_data *ts = container_of(timer, struct sis_ts_data, timer);
+
+	queue_work(sis_wq, &ts->work);
+	if (!ts->use_irq)	/*For Polling mode*/
+	    hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS), HRTIMER_MODE_REL);
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
+{
+	struct sis_ts_data *ts = dev_id;
+
+	if (!irqd_irq_disabled(&ts->desc->irq_data))
+		disable_irq_nosync(ts->client->irq);
+	queue_work(sis_wq, &ts->work);
+	return IRQ_HANDLED;
+}
+
+static int initial_irq(void)
+{
+	int ret = 0;
+
+	/* initialize gpio and interrupt pins */
+	/*ex. GPIO_133 for interrupt mode*/
+	ret = gpio_request(GPIO_IRQ, "GPIO_54");
+	if (ret < 0) {
+		/*Set Active Low.
+		 * Please reference the file include/linux/interrupt.h*/
+		pr_err("sis_ts_probe: Failed to gpio_request\n");
+		pr_err("sis_ts_probe: Fail : gpio_request was called before this driver call\n");
+	}
+	/* setting gpio direction here OR boardinfo file*/
+	return ret;
+}
+
+static int sis_ts_probe(
+	struct i2c_client *client, const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct sis_ts_data *ts = NULL;
+	struct sis_i2c_rmi_platform_data *pdata = NULL;
+
+	pr_info("sis_ts_probe\n");
+	ts = kzalloc(sizeof(struct sis_ts_data), GFP_KERNEL);
+	if (ts == NULL) {
+		ret = -ENOMEM;
+		goto err_alloc_data_failed;
+	}
+	ts->TPInfo = kzalloc(sizeof(struct sisTP_driver_data), GFP_KERNEL);
+	if (ts->TPInfo == NULL) {
+		ret = -ENOMEM;
+		goto err_alloc_data_failed;
+	}
+	ts_bak = ts;
+
+	mutex_init(&ts->mutex_wq);
+	/*1. Init Work queue and necessary buffers*/
+	INIT_WORK(&ts->work, sis_ts_work_func);
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+	pdata = client->dev.platform_data;
+	if (pdata)
+		ts->power = pdata->power;
+	if (ts->power) {
+		ret = ts->power(1);
+		if (ret < 0) {
+			pr_err("sis_ts_probe power on failed\n");
+			goto err_power_failed;
+		}
+	}
+	/*2. Allocate input device*/
+	ts->input_dev = input_allocate_device();
+	if (ts->input_dev == NULL) {
+		ret = -ENOMEM;
+		pr_err("sis_ts_probe: Failed to allocate input device\n");
+		goto err_input_dev_alloc_failed;
+	}
+	/*This input device name should be the same to IDC file name.*/
+	ts->input_dev->name = "sis_touch";
+
+	set_bit(EV_ABS, ts->input_dev->evbit);
+	set_bit(EV_KEY, ts->input_dev->evbit);
+	set_bit(ABS_MT_POSITION_X, ts->input_dev->absbit);
+	set_bit(ABS_MT_POSITION_Y, ts->input_dev->absbit);
+	set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
+	set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
+	set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);
+
+	input_mt_init_slots(ts->input_dev, MAX_SLOTS, INPUT_MT_DIRECT);
+
+	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE,
+						0, PRESSURE_MAX, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+						0, AREA_LENGTH_LONGER, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR,
+						0, AREA_LENGTH_SHORT, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
+						0, SIS_MAX_X, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
+						0, SIS_MAX_Y, 0, 0);
+
+	/* add for touch keys */
+	set_bit(KEY_COMPOSE, ts->input_dev->keybit);
+	set_bit(KEY_BACK, ts->input_dev->keybit);
+	set_bit(KEY_MENU, ts->input_dev->keybit);
+	set_bit(KEY_HOME, ts->input_dev->keybit);
+	/*3. Register input device to core*/
+	ret = input_register_device(ts->input_dev);
+	if (ret) {
+		pr_err("sis_ts_probe: Unable to register %s input device\n",
+				ts->input_dev->name);
+		goto err_input_register_device_failed;
+	}
+	/*4. irq or timer setup*/
+	ret = initial_irq();
+	if (ret >= 0) {
+		client->irq = gpio_to_irq(GPIO_IRQ);
+		ret = request_irq(client->irq, sis_ts_irq_handler,
+					IRQF_TRIGGER_FALLING, client->name, ts);
+		if (ret == 0)
+			ts->use_irq = 1;
+		else
+			dev_err(&client->dev, "request_irq failed\n");
+	}
+	ts->desc = irq_to_desc(ts_bak->client->irq);
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ts->timer.function = sis_ts_timer_func;
+	if (!ts->use_irq)
+		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+	pr_info("sis_ts_probe: Start touchscreen %s in %s mode\n",
+			ts->input_dev->name,
+			ts->use_irq ? "interrupt" : "polling");
+	if (ts->use_irq) {
+#ifdef _INT_MODE_1
+		pr_info("sis_ts_probe: interrupt case 1 mode\n");
+#else
+		pr_info("sis_ts_probe: interrupt case 2 mode\n");
+#endif
+	}
+	pr_info("sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);
+	return 0;
+err_input_register_device_failed:
+	input_free_device(ts->input_dev);
+err_input_dev_alloc_failed:
+err_power_failed:
+	kfree(ts->TPInfo);
+	kfree(ts);
+err_alloc_data_failed:
+	return ret;
+}
+
+static int sis_ts_remove(struct i2c_client *client)
+{
+	struct sis_ts_data *ts = i2c_get_clientdata(client);
+
+	if (ts->use_irq)
+		free_irq(client->irq, ts);
+	else
+		hrtimer_cancel(&ts->timer);
+	input_unregister_device(ts->input_dev);
+	kfree(ts);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sis_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	int ret = 0;
+	struct sis_ts_data *ts = i2c_get_clientdata(client);
+
+	if (ts->use_irq) {
+		if (!irqd_irq_disabled(&ts->desc->irq_data))
+			disable_irq(client->irq);
+	} else
+		hrtimer_cancel(&ts->timer);
+	flush_workqueue(sis_wq);		/*only flush sis_wq*/
+
+
+	if (ts->power) {
+		ret = ts->power(0);
+		if (ret < 0)
+			pr_err("sis_ts_suspend power off failed\n");
+	}
+
+	return 0;
+}
+
+static int sis_ts_resume(struct i2c_client *client)
+{
+	int ret = 0;
+	struct sis_ts_data *ts = i2c_get_clientdata(client);
+
+	if (ts->power) {
+		ret = ts->power(1);
+		if (ret < 0)
+			pr_err("sis_ts_resume power on failed\n");
+	}
+
+	if (ts->use_irq) {
+		if (irqd_irq_disabled(&ts->desc->irq_data))
+			enable_irq(client->irq);
+	} else
+		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sis_ts_pm, sis_ts_suspend, sis_ts_resume);
+
+#ifdef CONFIG_X86
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int sis_ts_detect(struct i2c_client *client,
+		       struct i2c_board_info *info)
+{
+	const char *type_name;
+
+	pr_info("sis_ts_detect\n");
+	type_name = "sis_i2c_ts";
+	strlcpy(info->type, type_name, I2C_NAME_SIZE);
+	return 0;
+}
+#endif
+
+static const struct i2c_device_id sis_ts_id[] = {
+	{ SIS_I2C_NAME, 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sis_ts_id);
+
+static struct i2c_driver sis_ts_driver = {
+	.driver = {
+		.name = SIS_I2C_NAME,
+		.pm = &sis_ts_pm,
+	},
+	.probe		= sis_ts_probe,
+	.remove		= sis_ts_remove,
+#ifdef CONFIG_X86
+	.class		= I2C_CLASS_HWMON,
+	.detect		= sis_ts_detect,
+	.address_list	= normal_i2c,
+#endif
+	.id_table	= sis_ts_id,
+};
+
+static int __init sis_ts_init(void)
+{
+	pr_info("sis_ts_init\n");
+	sis_wq = create_singlethread_workqueue("sis_wq");
+
+	if (!sis_wq)
+		return -ENOMEM;
+	return i2c_add_driver(&sis_ts_driver);
+}
+
+static void __exit sis_ts_exit(void)
+{
+	pr_info("sis_ts_exit\n");
+	i2c_del_driver(&sis_ts_driver);
+	if (sis_wq)
+		destroy_workqueue(sis_wq);
+}
+
+module_init(sis_ts_init);
+module_exit(sis_ts_exit);
+MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/sis_i2c.h b/drivers/input/touchscreen/sis_i2c.h
new file mode 100644
index 0000000..a075158
--- /dev/null
+++ b/drivers/input/touchscreen/sis_i2c.h
@@ -0,0 +1,164 @@
+/*
+ * Touch Screen driver for SiS 9200 family I2C Touch panels
+ *
+ * Copyright (C) 2015 SiS, Inc.
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
+ * Date: 2015/07/07
+ */
+#include <linux/version.h>
+
+#ifndef _LINUX_SIS_I2C_H
+#define _LINUX_SIS_I2C_H
+
+
+#define SIS_I2C_NAME "sis_i2c_ts"
+#define SIS_SLAVE_ADDR					0x5c
+/*10ms*/
+#define TIMER_NS						10000000
+#define MAX_FINGERS						10
+
+/* Check data CRC */
+/*#define _CHECK_CRC*/					/*ON/OFF*/
+
+/* Interrupt modes */
+#define GPIO_IRQ						54
+
+/*	Enable if use interrupt case 1 mode.	*/
+/*	Disable if use interrupt case 2 mode.	*/
+/*#define _INT_MODE_1*/					/*ON/OFF*/
+
+/* Resolution mode */
+/*Constant value*/
+#define SIS_MAX_X						4095
+#define SIS_MAX_Y						4095
+
+#define ONE_BYTE						1
+#define FIVE_BYTE						5
+#define EIGHT_BYTE						8
+#define SIXTEEN_BYTE					16
+#define PACKET_BUFFER_SIZE				128
+
+#define SIS_CMD_NORMAL					0x0
+#define SIS_CMD_SOFTRESET				0x82
+#define SIS_CMD_RECALIBRATE				0x87
+#define SIS_CMD_POWERMODE				0x90
+#define MSK_TOUCHNUM					0x0f
+#define MSK_HAS_CRC						0x10
+#define MSK_DATAFMT						0xe0
+#define MSK_PSTATE						0x0f
+#define MSK_PID							0xf0
+#define RES_FMT							0x00
+#define FIX_FMT							0x40
+
+/* for new i2c format */
+#define TOUCHDOWN						0x3
+#define TOUCHUP							0x0
+#define MAX_BYTE						64
+#define	PRESSURE_MAX					255
+
+/*Resolution diagonal */
+#define AREA_LENGTH_LONGER				5792
+/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
+#define AREA_LENGTH_SHORT				5792
+#define AREA_UNIT						(5792/32)
+
+
+#define FORMAT_MODE						1
+
+#define MSK_NOBTN						0
+#define MSK_COMP						1
+#define MSK_BACK						2
+#define MSK_MENU						4
+#define MSK_HOME						8
+
+#define P_BYTECOUNT						0
+#define ALL_IN_ONE_PACKAGE				0x10
+#define IS_TOUCH(x)						(x & 0x1)
+#define IS_HIDI2C(x)					((x & 0xF) == 0x06)
+#define IS_AREA(x)						((x >> 4) & 0x1)
+#define IS_PRESSURE(x)				    ((x >> 5) & 0x1)
+#define IS_SCANTIME(x)			        ((x >> 6) & 0x1)
+#define NORMAL_LEN_PER_POINT			6
+#define AREA_LEN_PER_POINT				2
+#define PRESSURE_LEN_PER_POINT			1
+
+#define TOUCH_FORMAT					0x1
+#define BUTTON_FORMAT					0x4
+#define HIDI2C_FORMAT					0x6
+#define P_REPORT_ID						2
+#define BUTTON_STATE					3
+#define BUTTON_KEY_COUNT				16
+#define BYTE_BYTECOUNT					2
+#define BYTE_COUNT						1
+#define BYTE_ReportID					1
+#define BYTE_CRC_HIDI2C					0
+#define BYTE_CRC_I2C					2
+#define BYTE_SCANTIME					2
+#define NO_TOUCH_BYTECOUNT				0x3
+
+/* TODO */
+#define TOUCH_POWER_PIN					0
+#define TOUCH_RESET_PIN					1
+
+/* CMD Define */
+#define BUF_ACK_PLACE_L					4
+#define BUF_ACK_PLACE_H					5
+#define BUF_ACK_L						0xEF
+#define BUF_ACK_H						0xBE
+#define BUF_NACK_L						0xAD
+#define BUF_NACK_H						0xDE
+#define BUF_CRC_PLACE					7
+#define MAX_SLOTS						15
+
+struct sis_i2c_rmi_platform_data {
+	int (*power)(int on);	/* Only valid in first array entry */
+};
+
+struct TypeB_Slot {
+	int CheckID;
+	int id;
+	unsigned short x, y;
+	uint16_t Pressure;
+	uint16_t Width;
+	uint16_t Height;
+};
+
+struct Point {
+	int id;
+	unsigned short x, y;		/*uint16_t ?*/
+	uint16_t Pressure;
+	uint16_t Width;
+	uint16_t Height;
+};
+
+struct sisTP_driver_data {
+	int id;
+	int fingers;
+	struct Point pt[MAX_FINGERS];
+};
+
+struct sis_ts_data {
+	int (*power)(int on);
+	int use_irq;
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct hrtimer timer;
+	struct irq_desc *desc;
+	struct work_struct work;
+	struct mutex mutex_wq;
+	struct sisTP_driver_data *TPInfo;
+};
+
+static int sis_ts_suspend(struct i2c_client *client, pm_message_t mesg);
+static int sis_ts_resume(struct i2c_client *client);
+
+#endif /* _LINUX_SIS_I2C_H */
-- 
1.9.1

