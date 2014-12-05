From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH v4] input: Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Fri, 5 Dec 2014 18:17:39 +0900
Message-ID: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg-fb1501.iij4u.or.jp ([210.130.239.8]:55857 "EHLO
	mo-sg-fb.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbaLEJr7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Dec 2014 04:47:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yuasa@linux-mips.org, linux-input@vger.kernel.org

v4 Changes:
- remove inline
- master_xfer checks in probe()
- rewrite rohm_i2c_burst_read()
- rohm_i2c_burst_read() transfer error returns -EIO
- remove unused module parameters
- fix prev_touch_report update
- pass NULL to hard_irq
- per-device parameters use sysfs
- fix errno
- header file is taken in .c

v3 Changes:
- fix multi touch slots initialization
- fix set_bit BTN_TOUCH
- remove input_unregister_device()
- switch to __set_bit()

v2 Changes:
- remove polling mode
- switch to threaded interrupt
- switch to managed resources
- use MT-B protocol with input_mt_assign_slots
- provide ST emulation
- firmware load and device initialization are shifted at opening the
  device
- add error handling for IO operations

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/input/touchscreen/Kconfig        |   11 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/rohm_bu21023.c | 1257 ++++++++++++++++++++++++++++++
 3 files changed, 1269 insertions(+)
 create mode 100644 drivers/input/touchscreen/rohm_bu21023.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 568a020..80811a7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -975,4 +975,15 @@ config TOUCHSCREEN_ZFORCE
 	  To compile this driver as a module, choose M here: the
 	  module will be called zforce_ts.
 
+config TOUCHSCREEN_ROHM_BU21023
+	tristate "ROHM BU21023/24 Dual touch support resistive touchscreens"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using ROHM BU21023/24.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bu21023_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index dab4a56..5c2917b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
+obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
new file mode 100644
index 0000000..4c460c6
--- /dev/null
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -0,0 +1,1257 @@
+/*
+ * ROHM BU21023/24 Dual touch support resistive touch screen driver
+ * Copyright (C) 2012 ROHM CO.,LTD.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/hrtimer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define BU21023_NAME		"bu21023_ts"
+#define BU21023_FIRMWARE_NAME	"bu21023.bin"
+
+#define BU21023_MAX_SLOTS	2
+
+#define AXIS_ADJUST		4
+#define AXIS_OFFSET		8
+
+#define FIRMWARE_BLOCK_SIZE	32
+#define FIRMWARE_RETRY_MAX	4
+
+#define SAMPLING_DELAY		12	/* msec */
+
+#define CALIBRATION_RETRY_MAX	6
+
+#define ROHM_TS_ABS_X_MIN	40
+#define ROHM_TS_ABS_X_MAX	990
+#define ROHM_TS_ABS_Y_MIN	160
+#define ROHM_TS_ABS_Y_MAX	920
+
+/*
+ * BU21023GUL/BU21023MUV/BU21024FV-M registers map
+ */
+#define VADOUT_YP_H		0x00
+#define VADOUT_YP_L		0x01
+#define VADOUT_XP_H		0x02
+#define VADOUT_XP_L		0x03
+#define VADOUT_YN_H		0x04
+#define VADOUT_YN_L		0x05
+#define VADOUT_XN_H		0x06
+#define VADOUT_XN_L		0x07
+
+#define PRM1_X_H		0x08
+#define PRM1_X_L		0x09
+#define PRM1_Y_H		0x0a
+#define PRM1_Y_L		0x0b
+#define PRM2_X_H		0x0c
+#define PRM2_X_L		0x0d
+#define PRM2_Y_H		0x0e
+#define PRM2_Y_L		0x0f
+
+#define MLT_PRM_MONI_X		0x10
+#define MLT_PRM_MONI_Y		0x11
+
+#define DEBUG_MONI_1		0x12
+#define DEBUG_MONI_2		0x13
+
+#define VADOUT_ZX_H		0x14
+#define VADOUT_ZX_L		0x15
+#define VADOUT_ZY_H		0x16
+#define VADOUT_ZY_L		0x17
+
+#define Z_PARAM_H		0x18
+#define Z_PARAM_L		0x19
+
+/*
+ * Value for VADOUT_*_L
+ */
+#define VADOUT_L_MASK		0x01
+
+/*
+ * Value for PRM*_*_L
+ */
+#define PRM_L_MASK		0x01
+
+#define POS_X1_H		0x20
+#define POS_X1_L		0x21
+#define POS_Y1_H		0x22
+#define POS_Y1_L		0x23
+#define POS_X2_H		0x24
+#define POS_X2_L		0x25
+#define POS_Y2_H		0x26
+#define POS_Y2_L		0x27
+
+/*
+ * Value for POS_*_L
+ */
+#define POS_L_MASK		0x01
+
+#define TOUCH			0x28
+#define TOUCH_DETECT		0x01
+
+#define TOUCH_GESTURE		0x29
+#define SINGLE_TOUCH		0x01
+#define DUAL_TOUCH		0x03
+#define TOUCH_MASK		0x03
+#define CALIBRATION_REQUEST	0x04
+#define CALIBRATION_STATUS	0x08
+#define CALIBRATION_MASK	0x0c
+#define GESTURE_SPREAD		0x10
+#define GESTURE_PINCH		0x20
+#define GESTURE_ROTATE_R	0x40
+#define GESTURE_ROTATE_L	0x80
+
+#define INT_STATUS		0x2a
+#define INT_MASK		0x3d
+#define INT_CLEAR		0x3e
+
+/*
+ * Values for INT_*
+ */
+#define COORD_UPDATE		0x01
+#define CALIBRATION_DONE	0x02
+#define SLEEP_IN		0x04
+#define SLEEP_OUT		0x08
+#define PROGRAM_LOAD_DONE	0x10
+#define ERROR			0x80
+#define INT_ALL			0x9f
+
+#define ERR_STATUS		0x2b
+#define ERR_MASK		0x3f
+
+/*
+ * Values for ERR_*
+ */
+#define ADC_TIMEOUT		0x01
+#define CPU_TIMEOUT		0x02
+#define CALIBRATION_ERR		0x04
+#define PROGRAM_LOAD_ERR	0x10
+
+#define COMMON_SETUP1			0x30
+#define PROGRAM_LOAD_HOST		0x02
+#define PROGRAM_LOAD_EEPROM		0x03
+#define CENSOR_4PORT			0x04
+#define CENSOR_8PORT			0x00	/* Not supported by BU21023 */
+#define CALIBRATION_TYPE_DEFAULT	0x08
+#define CALIBRATION_TYPE_SPECIAL	0x00
+#define INT_ACTIVE_HIGH			0x10
+#define INT_ACTIVE_LOW			0x00
+#define AUTO_CALIBRATION		0x40
+#define MANUAL_CALIBRATION		0x00
+#define COMMON_SETUP1_DEFAULT		0x4e
+
+#define COMMON_SETUP2		0x31
+#define MAF_NONE		0x00
+#define MAF_1SAMPLE		0x01
+#define MAF_3SAMPLES		0x02
+#define MAF_5SAMPLES		0x03
+#define INV_Y			0x04
+#define INV_X			0x08
+#define SWAP_XY			0x10
+
+#define COMMON_SETUP3		0x32
+#define EN_SLEEP		0x01
+#define EN_MULTI		0x02
+#define EN_GESTURE		0x04
+#define EN_INTVL		0x08
+#define SEL_STEP		0x10
+#define SEL_MULTI		0x20
+#define SEL_TBL_DEFAULT		0x40
+
+#define INTERVAL_TIME		0x33
+#define INTERVAL_TIME_DEFAULT	0x10
+
+#define STEP_X			0x34
+#define STEP_X_DEFAULT		0x41
+
+#define STEP_Y			0x35
+#define STEP_Y_DEFAULT		0x8d
+
+#define OFFSET_X		0x38
+#define OFFSET_X_DEFAULT	0x0c
+
+#define OFFSET_Y		0x39
+#define OFFSET_Y_DEFAULT	0x0c
+
+#define THRESHOLD_TOUCH		0x3a
+#define THRESHOLD_TOUCH_DEFAULT	0xa0
+
+#define THRESHOLD_GESTURE		0x3b
+#define THRESHOLD_GESTURE_DEFAULT	0x17
+
+#define SYSTEM			0x40
+#define ANALOG_POWER_ON		0x01
+#define ANALOG_POWER_OFF	0x00
+#define CPU_POWER_ON		0x02
+#define CPU_POWER_OFF		0x00
+
+#define FORCE_CALIBRATION	0x42
+#define FORCE_CALIBRATION_ON	0x01
+#define FORCE_CALIBRATION_OFF	0x00
+
+#define CPU_FREQ		0x50	/* 10 / (reg + 1) MHz */
+#define CPU_FREQ_10MHZ		0x00
+#define CPU_FREQ_5MHZ		0x01
+#define CPU_FREQ_1MHZ		0x09
+
+#define EEPROM_ADDR		0x51
+
+#define CALIBRATION_ADJUST		0x52
+#define CALIBRATION_ADJUST_DEFAULT	0x00
+
+#define THRESHOLD_SLEEP_IN	0x53
+
+#define EVR_XY			0x56
+#define EVR_XY_DEFAULT		0x10
+
+#define PRM_SWOFF_TIME		0x57
+#define PRM_SWOFF_TIME_DEFAULT	0x04
+
+#define PROGRAM_VERSION		0x5f
+
+#define ADC_CTRL		0x60
+#define ADC_DIV_MASK		0x1f	/* The minimum value is 4 */
+#define ADC_DIV_DEFAULT		0x08
+
+#define ADC_WAIT		0x61
+#define ADC_WAIT_DEFAULT	0x0a
+
+#define SWCONT			0x62
+#define SWCONT_DEFAULT		0x0f
+
+#define EVR_X			0x63
+#define EVR_X_DEFAULT		0x86
+
+#define EVR_Y			0x64
+#define EVR_Y_DEFAULT		0x64
+
+#define TEST1			0x65
+#define DUALTOUCH_STABILIZE_ON	0x01
+#define DUALTOUCH_STABILIZE_OFF	0x00
+#define DUALTOUCH_REG_ON	0x20
+#define DUALTOUCH_REG_OFF	0x00
+
+#define CALIBRATION_REG1		0x68
+#define CALIBRATION_REG1_DEFAULT	0xd9
+
+#define CALIBRATION_REG2		0x69
+#define CALIBRATION_REG2_DEFAULT	0x36
+
+#define CALIBRATION_REG3		0x6a
+#define CALIBRATION_REG3_DEFAULT	0x32
+
+#define EX_ADDR_H		0x70
+#define EX_ADDR_L		0x71
+#define EX_WDAT			0x72
+#define EX_RDAT			0x73
+#define EX_CHK_SUM1		0x74
+#define EX_CHK_SUM2		0x75
+#define EX_CHK_SUM3		0x76
+
+struct rohm_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+
+	bool initialized;
+
+	unsigned int untouch_count;
+	unsigned int single_touch_count;
+	unsigned int dual_touch_count;
+	unsigned int prev_touch_report;
+
+	u8 setup2;
+};
+
+/*
+ * rohm_i2c_burst_read - execute combined I2C message for ROHM BU21023/24
+ * @client: Handle to ROHM BU21023/24
+ * @start: Where to start read address from ROHM BU21023/24
+ * @buf: Where to store read data from ROHM BU21023/24
+ * @len: How many bytes to read
+ *
+ * Returns negative errno, else zero on success.
+ *
+ * Note
+ * In BU21023/24 burst read, stop condition is needed after "address write".
+ * Therefore, transmission is performed in 2 steps.
+ */
+static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
+			       size_t len)
+{
+	struct i2c_adapter *adap = client->adapter;
+	struct i2c_msg msg[2];
+	int i, ret = 0;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &start;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = len;
+	msg[1].buf = buf;
+
+	i2c_lock_adapter(adap);
+
+	for (i = 0; i < 2; i++) {
+		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
+			ret = -EIO;
+			break;
+		}
+	}
+
+	i2c_unlock_adapter(adap);
+
+	return ret;
+}
+
+static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	struct device *dev = &client->dev;
+	u8 buf[33];
+
+	int retry;
+	bool success = false;
+	bool first_time = true;
+	bool calibration_done;
+
+	u8 reg1, reg2, reg3;
+	s32 reg1_orig, reg2_orig, reg3_orig;
+	s32 val;
+
+	int calib_x = 0, calib_y = 0;
+	int reg_x, reg_y;
+	int err_x, err_y;
+
+	int err = 0, ret;
+	int i;
+
+	reg1_orig = i2c_smbus_read_byte_data(client, CALIBRATION_REG1);
+	if (reg1_orig < 0)
+		return reg1_orig;
+
+	reg2_orig = i2c_smbus_read_byte_data(client, CALIBRATION_REG2);
+	if (reg2_orig < 0)
+		return reg2_orig;
+
+	reg3_orig = i2c_smbus_read_byte_data(client, CALIBRATION_REG3);
+	if (reg3_orig < 0)
+		return reg3_orig;
+
+	ret = i2c_smbus_write_byte_data(client, INT_MASK,
+					COORD_UPDATE | SLEEP_IN | SLEEP_OUT |
+					PROGRAM_LOAD_DONE);
+	if (ret) {
+		err = ret;
+		goto err_exit;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, TEST1, DUALTOUCH_STABILIZE_ON);
+	if (ret) {
+		err = ret;
+		goto err_exit;
+	}
+
+	for (retry = 0; retry < CALIBRATION_RETRY_MAX; retry++) {
+		/* wait 2 sampling for update */
+		mdelay(2 * SAMPLING_DELAY);
+
+#define READ_CALIB_BUF(reg)	((u16)buf[((reg) - PRM1_X_H)])
+
+		ret = rohm_i2c_burst_read(client, PRM1_X_H, buf, sizeof(buf));
+		if (ret < 0) {
+			err = ret;
+			goto err_exit;
+		}
+
+		if (READ_CALIB_BUF(TOUCH) & TOUCH_DETECT)
+			continue;
+
+		if (first_time) {
+			/* generate calibration parameter */
+			calib_x =
+			    (READ_CALIB_BUF(PRM1_X_H) << 2 |
+			     READ_CALIB_BUF(PRM1_X_L)) - AXIS_OFFSET;
+			calib_y =
+			    (READ_CALIB_BUF(PRM1_Y_H) << 2 |
+			     READ_CALIB_BUF(PRM1_Y_L)) - AXIS_OFFSET;
+
+			ret = i2c_smbus_write_byte_data(client, TEST1,
+							DUALTOUCH_STABILIZE_ON |
+							DUALTOUCH_REG_ON);
+			if (ret) {
+				err = ret;
+				goto err_exit;
+			}
+
+			first_time = false;
+		} else {
+			/* generate adjustment parameter */
+			err_x = READ_CALIB_BUF(PRM1_X_H) << 2 |
+			    READ_CALIB_BUF(PRM1_X_L);
+			err_y = READ_CALIB_BUF(PRM1_Y_H) << 2 |
+			    READ_CALIB_BUF(PRM1_Y_L);
+
+			/* X axis ajust */
+			if (err_x <= 4)
+				calib_x -= AXIS_ADJUST;
+			else if (err_x >= 60)
+				calib_x += AXIS_ADJUST;
+
+			/* Y axis ajust */
+			if (err_y <= 4)
+				calib_y -= AXIS_ADJUST;
+			else if (err_y >= 60)
+				calib_y += AXIS_ADJUST;
+		}
+
+		/* generate calibration setting value */
+		reg_x = calib_x + ((calib_x & 0x200) << 1);
+		reg_y = calib_y + ((calib_y & 0x200) << 1);
+
+		/* convert for register format */
+		reg1 = reg_x >> 3;
+		reg2 = (reg_y & 0x7) << 4 | (reg_x & 0x7);
+		reg3 = reg_y >> 3;
+
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1, reg1);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2, reg2);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3, reg3);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		/*
+		 * force calibration sequcence
+		 */
+		ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+						FORCE_CALIBRATION_OFF);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+						FORCE_CALIBRATION_ON);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		/* clear all interrupts */
+		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		/*
+		 * Wait for the status change of calibration, max 10 sampling
+		 */
+		calibration_done = false;
+
+		for (i = 0; i < 10; i++) {
+			mdelay(SAMPLING_DELAY);
+
+			val = i2c_smbus_read_byte_data(client, TOUCH_GESTURE);
+			if (!(val & CALIBRATION_MASK)) {
+				calibration_done = true;
+				break;
+			} else if (val < 0) {
+				err = val;
+				goto err_exit;
+			}
+		}
+
+		if (calibration_done) {
+			val = i2c_smbus_read_byte_data(client, INT_STATUS);
+			if (val == CALIBRATION_DONE) {
+				success = true;
+				break;
+			} else if (val < 0) {
+				err = val;
+				goto err_exit;
+			}
+		} else {
+			dev_warn(dev, "Calibration timeout\n");
+		}
+	}
+
+	if (!success) {
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
+						reg1_orig);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
+						reg2_orig);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
+						reg3_orig);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		/* calibration data enable */
+		ret = i2c_smbus_write_byte_data(client, TEST1,
+						DUALTOUCH_STABILIZE_ON |
+						DUALTOUCH_REG_ON);
+		if (ret) {
+			err = ret;
+			goto err_exit;
+		}
+
+		/* wait 10 sampling */
+		mdelay(10 * SAMPLING_DELAY);
+
+		err = -EBUSY;
+	}
+
+err_exit:
+	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
+	if (!ret)
+		/* Clear all interrupts */
+		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+
+	if (!err && ret)
+		err = ret;
+
+	return err;
+}
+
+static unsigned int untouch_threshold[3] = { 0, 1, 5 };
+static unsigned int single_touch_threshold[3] = { 0, 0, 4 };
+static unsigned int dual_touch_threshold[3] = { 10, 8, 0 };
+
+module_param_array(untouch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
+module_param_array(single_touch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
+module_param_array(dual_touch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
+
+MODULE_PARM_DESC(untouch_threshold, "Thresholds for un-touch detection");
+MODULE_PARM_DESC(single_touch_threshold,
+		 "Thresholds for single touch detection");
+MODULE_PARM_DESC(dual_touch_threshold, "Thresholds for dual touch detection");
+
+static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
+{
+	struct rohm_ts_data *ts = dev_id;
+	struct i2c_client *client = ts->client;
+	struct input_dev *input_dev = ts->input_dev;
+	struct device *dev = &client->dev;
+
+	u8 buf[10];		/* for 0x20-0x29 */
+
+	struct input_mt_pos pos[BU21023_MAX_SLOTS];
+	int slots[BU21023_MAX_SLOTS];
+	u8 touch_flags;
+	unsigned int threshold;
+	int touch_report = -1;
+	unsigned int prev_touch_report = ts->prev_touch_report;
+
+	s32 status;
+	int i, ret;
+
+	status = i2c_smbus_read_byte_data(client, INT_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status < 0)
+		return IRQ_HANDLED;
+
+	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
+	if (ret)
+		return IRQ_HANDLED;
+
+	/* Clear all interrupts */
+	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (ret)
+		return IRQ_HANDLED;
+
+#define READ_POS_BUF(reg)	((u16)buf[((reg) - POS_X1_H)])
+
+	ret = rohm_i2c_burst_read(client, POS_X1_H, buf, sizeof(buf));
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	touch_flags = READ_POS_BUF(TOUCH_GESTURE) & TOUCH_MASK;
+	if (touch_flags) {
+		/* generate coordinates */
+		pos[0].x = (READ_POS_BUF(POS_X1_H) << 2) |
+			   READ_POS_BUF(POS_X1_L);
+		pos[0].y = (READ_POS_BUF(POS_Y1_H) << 2) |
+			   READ_POS_BUF(POS_Y1_L);
+		pos[1].x = (READ_POS_BUF(POS_X2_H) << 2) |
+			   READ_POS_BUF(POS_X2_L);
+		pos[1].y = (READ_POS_BUF(POS_Y2_H) << 2) |
+			   READ_POS_BUF(POS_Y2_L);
+
+		switch (touch_flags) {
+		case SINGLE_TOUCH:
+			ts->untouch_count = 0;
+			ts->single_touch_count++;
+			ts->dual_touch_count = 0;
+
+			threshold = single_touch_threshold[prev_touch_report];
+			if (ts->single_touch_count > threshold)
+				touch_report = 1;
+
+			if (touch_report == 1) {
+				if (pos[1].x != 0 && pos[1].y != 0) {
+					pos[0].x = pos[1].x;
+					pos[0].y = pos[1].y;
+					pos[1].x = 0;
+					pos[1].y = 0;
+				}
+			}
+			break;
+		case DUAL_TOUCH:
+			ts->untouch_count = 0;
+			ts->single_touch_count = 0;
+			ts->dual_touch_count++;
+
+			threshold = dual_touch_threshold[prev_touch_report];
+			if (ts->dual_touch_count > threshold)
+				touch_report = 2;
+			break;
+		default:
+			dev_dbg(dev,
+				"Three or more touches are not supported\n");
+			return IRQ_HANDLED;
+		}
+	} else {
+		ts->untouch_count++;
+
+		threshold = untouch_threshold[prev_touch_report];
+		if (ts->untouch_count > threshold) {
+			ts->untouch_count = 0;
+			ts->single_touch_count = 0;
+			ts->dual_touch_count = 0;
+
+			touch_report = 0;
+		}
+	}
+
+	if (touch_report >= 0) {
+		input_mt_assign_slots(input_dev, slots, pos, touch_report);
+
+		for (i = 0; i < touch_report; i++) {
+			input_mt_slot(input_dev, slots[i]);
+			input_mt_report_slot_state(input_dev,
+						   MT_TOOL_FINGER, true);
+			input_report_abs(input_dev,
+					 ABS_MT_POSITION_X, pos[i].x);
+			input_report_abs(input_dev,
+					 ABS_MT_POSITION_Y, pos[i].y);
+		}
+
+		input_mt_sync_frame(input_dev);
+		input_mt_report_pointer_emulation(input_dev, true);
+		input_sync(input_dev);
+
+		ts->prev_touch_report = touch_report;
+	}
+
+	if (READ_POS_BUF(TOUCH_GESTURE) & CALIBRATION_REQUEST) {
+		if (rohm_ts_manual_calibration(ts) < 0)
+			dev_warn(dev, "Failed to manual calibration\n");
+	}
+
+	i2c_smbus_write_byte_data(client, INT_MASK,
+				  CALIBRATION_DONE | SLEEP_OUT | SLEEP_IN |
+				  PROGRAM_LOAD_DONE);
+
+	return IRQ_HANDLED;
+}
+
+static int rohm_ts_load_firmware(struct i2c_client *client,
+				 const char *firmware_name)
+{
+	struct device *dev = &client->dev;
+	const struct firmware *firmware = NULL;
+	s32 status;
+	int blocks, remainder, retry = 0, offset;
+	int err = 0, ret;
+	int i;
+
+	ret = request_firmware(&firmware, firmware_name, dev);
+	if (ret) {
+		dev_err(dev, "Unable to open firmware %s\n", firmware_name);
+		return ret;
+	}
+
+	blocks = firmware->size / FIRMWARE_BLOCK_SIZE;
+	remainder = firmware->size % FIRMWARE_BLOCK_SIZE;
+
+	ret = i2c_smbus_write_byte_data(client, INT_MASK,
+					COORD_UPDATE | CALIBRATION_DONE |
+					SLEEP_IN | SLEEP_OUT);
+	if (ret) {
+		err = ret;
+		goto err_int_mask_exit;
+	}
+
+	while (retry < FIRMWARE_RETRY_MAX) {
+		ret = i2c_smbus_write_byte_data(client, COMMON_SETUP1,
+						COMMON_SETUP1_DEFAULT);
+		if (ret) {
+			err = ret;
+			goto err_int_mask_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, EX_ADDR_H, 0);
+		if (ret) {
+			err = ret;
+			goto err_int_mask_exit;
+		}
+
+		ret = i2c_smbus_write_byte_data(client, EX_ADDR_L, 0);
+		if (ret) {
+			err = ret;
+			goto err_int_mask_exit;
+		}
+
+		offset = 0;
+
+		/* firmware load to the device */
+		for (i = 0; i < blocks; i++) {
+			ret = i2c_smbus_write_i2c_block_data(client, EX_WDAT,
+				FIRMWARE_BLOCK_SIZE, &firmware->data[offset]);
+			if (ret) {
+				err = ret;
+				goto err_int_mask_exit;
+			}
+
+			offset += FIRMWARE_BLOCK_SIZE;
+		}
+
+		if (remainder) {
+			ret = i2c_smbus_write_i2c_block_data(client, EX_WDAT,
+				remainder, &firmware->data[offset]);
+			if (ret) {
+				err = ret;
+				goto err_int_mask_exit;
+			}
+		}
+
+		/* check formware load result */
+		status = i2c_smbus_read_byte_data(client, INT_STATUS);
+		if (status < 0) {
+			err = status;
+			goto err_int_mask_exit;
+		}
+
+		/* clear all interrupts */
+		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+		if (ret) {
+			err = ret;
+			goto err_int_mask_exit;
+		}
+
+		if (status == PROGRAM_LOAD_DONE)
+			break;
+
+		/* settings for retry */
+		ret = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
+		if (ret) {
+			err = ret;
+			goto err_int_mask_exit;
+		}
+
+		retry++;
+		dev_warn(dev, "Retry firmware load\n");
+	}
+
+err_int_mask_exit:
+	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
+	if (ret)
+		err = ret;
+
+	release_firmware(firmware);
+
+	if (retry >= FIRMWARE_RETRY_MAX)
+		return -EBUSY;
+
+	return err;
+}
+
+static ssize_t swap_xy_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+
+	ts = input_get_drvdata(input_dev);
+
+	return sprintf(buf, "%d\n", !!(ts->setup2 & SWAP_XY));
+}
+
+static ssize_t swap_xy_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+	unsigned int val;
+	int err = 0;
+
+	ts = input_get_drvdata(input_dev);
+
+	err = kstrtouint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val)
+		ts->setup2 |= SWAP_XY;
+	else
+		ts->setup2 &= ~SWAP_XY;
+
+	if (ts->initialized)
+		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
+						ts->setup2);
+
+	return err;
+}
+
+static ssize_t inv_x_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+
+	ts = input_get_drvdata(input_dev);
+
+	return sprintf(buf, "%d\n", !!(ts->setup2 & INV_X));
+}
+
+static ssize_t inv_x_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+	unsigned int val;
+	int err = 0;
+
+	ts = input_get_drvdata(input_dev);
+
+	err = kstrtouint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val)
+		ts->setup2 |= INV_X;
+	else
+		ts->setup2 &= ~INV_X;
+
+	if (ts->initialized)
+		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
+						ts->setup2);
+
+	return err;
+}
+
+static ssize_t inv_y_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+
+	ts = input_get_drvdata(input_dev);
+
+	return sprintf(buf, "%d\n", !!(ts->setup2 & INV_Y));
+}
+
+static ssize_t inv_y_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	struct rohm_ts_data *ts;
+	unsigned int val;
+	int err = 0;
+
+	ts = input_get_drvdata(input_dev);
+
+	err = kstrtouint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val)
+		ts->setup2 |= INV_X;
+	else
+		ts->setup2 &= ~INV_X;
+
+	if (ts->initialized)
+		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
+						ts->setup2);
+
+	return err;
+}
+
+static DEVICE_ATTR_RW(swap_xy);
+static DEVICE_ATTR_RW(inv_x);
+static DEVICE_ATTR_RW(inv_y);
+
+static struct attribute *rohm_ts_attrs[] = {
+	&dev_attr_swap_xy.attr,
+	&dev_attr_inv_x.attr,
+	&dev_attr_inv_y.attr,
+	NULL,
+};
+
+static const struct attribute_group rohm_ts_attr_group = {
+	.attrs = rohm_ts_attrs,
+};
+
+static int rohm_ts_device_init(struct rohm_ts_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	struct device *dev = &client->dev;
+	int ret;
+
+	/*
+	 * Wait 200usec for reset
+	 */
+	udelay(200);
+
+	/* Release analog reset */
+	ret = i2c_smbus_write_byte_data(client, SYSTEM, ANALOG_POWER_ON);
+	if (ret)
+		return ret;
+
+	/* Waiting for the analog warm-up, max. 200usec */
+	udelay(200);
+
+	/* clear all interrupts */
+	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP1, 0);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP2, ts->setup2);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP3,
+					SEL_TBL_DEFAULT | EN_MULTI);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, THRESHOLD_GESTURE,
+					THRESHOLD_GESTURE_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, INTERVAL_TIME,
+					INTERVAL_TIME_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, CPU_FREQ, CPU_FREQ_10MHZ);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, PRM_SWOFF_TIME,
+					PRM_SWOFF_TIME_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, ADC_CTRL, ADC_DIV_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, ADC_WAIT, ADC_WAIT_DEFAULT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Panel setup, these values change with the panel.
+	 */
+	ret = i2c_smbus_write_byte_data(client, STEP_X, STEP_X_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, STEP_Y, STEP_Y_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, OFFSET_X, OFFSET_X_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, OFFSET_Y, OFFSET_Y_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, THRESHOLD_TOUCH,
+					THRESHOLD_TOUCH_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EVR_XY, EVR_XY_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EVR_X, EVR_X_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, EVR_Y, EVR_Y_DEFAULT);
+	if (ret)
+		return ret;
+
+	/* Fixed value settings */
+	ret = i2c_smbus_write_byte_data(client, CALIBRATION_ADJUST,
+					CALIBRATION_ADJUST_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, SWCONT, SWCONT_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, TEST1,
+					DUALTOUCH_STABILIZE_ON |
+					DUALTOUCH_REG_ON);
+	if (ret)
+		return ret;
+
+	ret = rohm_ts_load_firmware(client, BU21023_FIRMWARE_NAME);
+	if (ret) {
+		dev_err(dev, "Failed to firmware load\n");
+		return ret;
+	}
+
+	/*
+	 * Manual calibration results are not changed in same environment.
+	 * If the force calibration is performed,
+	 * the controller will not require calibration request interrupt
+	 * when the typical values are set to the calibration registers.
+	 */
+	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
+					CALIBRATION_REG1_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
+					CALIBRATION_REG2_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
+					CALIBRATION_REG3_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+					FORCE_CALIBRATION_OFF);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+					FORCE_CALIBRATION_ON);
+	if (ret)
+		return ret;
+
+	/* Clear all interrupts */
+	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					rohm_ts_soft_irq, IRQF_TRIGGER_FALLING,
+					client->name, ts);
+	if (ret) {
+		dev_err(dev, "Unable to request IRQ\n");
+		return ret;
+	}
+
+	/* Enable coordinates update interrupt */
+	ret = i2c_smbus_write_byte_data(client, INT_MASK,
+					CALIBRATION_DONE |
+					SLEEP_OUT | SLEEP_IN |
+					PROGRAM_LOAD_DONE);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, ERR_MASK,
+					PROGRAM_LOAD_ERR | CPU_TIMEOUT |
+					ADC_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* controller CPU power on */
+	ret = i2c_smbus_write_byte_data(client, SYSTEM,
+					CPU_POWER_ON | ANALOG_POWER_ON);
+
+	return ret;
+}
+
+static int rohm_ts_open(struct input_dev *input_dev)
+{
+	struct rohm_ts_data *ts = input_get_drvdata(input_dev);
+	struct i2c_client *client = ts->client;
+	int ret;
+
+	if (!ts->initialized) {
+		ret = rohm_ts_device_init(ts);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to device initialization\n");
+			return ret;
+		}
+
+		ts->initialized = true;
+	}
+
+	return 0;
+}
+
+static int rohm_bu21023_i2c_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
+{
+	struct rohm_ts_data *ts;
+	struct i2c_adapter *adap = client->adapter;
+	struct device *dev = &client->dev;
+	struct input_dev *input_dev;
+	int ret;
+
+	if (!client->irq) {
+		dev_err(dev, "IRQ is not assigned\n");
+		return -EINVAL;
+	}
+
+	if (!adap->algo->master_xfer) {
+		dev_err(&adap->dev, "I2C level transfers not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	ts = devm_kzalloc(dev, sizeof(struct rohm_ts_data), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client = client;
+	ts->setup2 = MAF_1SAMPLE;
+	i2c_set_clientdata(client, ts);
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = BU21023_NAME;
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->open = rohm_ts_open;
+
+	ts->input_dev = input_dev;
+	input_set_drvdata(input_dev, ts);
+
+	__set_bit(EV_SYN, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(EV_ABS, input_dev->evbit);
+
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+			     ROHM_TS_ABS_X_MIN, ROHM_TS_ABS_X_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+			     ROHM_TS_ABS_Y_MIN, ROHM_TS_ABS_Y_MAX, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_X,
+			     ROHM_TS_ABS_X_MIN, ROHM_TS_ABS_X_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			     ROHM_TS_ABS_Y_MIN, ROHM_TS_ABS_Y_MAX, 0, 0);
+
+	ret = input_mt_init_slots(input_dev, BU21023_MAX_SLOTS,
+				  INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (ret) {
+		dev_err(dev, "Failed to multi touch slots initialization\n");
+		return ret;
+	}
+
+	ret = input_register_device(input_dev);
+	if (ret) {
+		dev_err(dev, "Unable to register input device\n");
+		return ret;
+	}
+
+	ret = sysfs_create_group(&dev->kobj, &rohm_ts_attr_group);
+	if (ret)
+		dev_err(dev, "Failed to create sysfs group\n");
+
+	return ret;
+}
+
+static int rohm_bu21023_i2c_remove(struct i2c_client *client)
+{
+	int ret;
+
+	sysfs_remove_group(&client->dev.kobj, &rohm_ts_attr_group);
+
+	ret = i2c_smbus_write_byte_data(client, SYSTEM,
+					ANALOG_POWER_ON | CPU_POWER_OFF);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(client, SYSTEM,
+					 ANALOG_POWER_OFF | CPU_POWER_OFF);
+}
+
+static const struct i2c_device_id rohm_bu21023_i2c_id[] = {
+	{BU21023_NAME, 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, rohm_bu21023_i2c_id);
+
+static struct i2c_driver rohm_bu21023_i2c_driver = {
+	.driver = {
+		.name = BU21023_NAME,
+	},
+	.probe = rohm_bu21023_i2c_probe,
+	.remove = rohm_bu21023_i2c_remove,
+	.id_table = rohm_bu21023_i2c_id,
+};
+
+module_i2c_driver(rohm_bu21023_i2c_driver);
+
+MODULE_DESCRIPTION("ROHM BU21023/24 Touchscreen driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("ROHM Co., Ltd.");
-- 
1.7.9.5

