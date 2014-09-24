From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH v3 2/2] input: bu21023_ts: Add calibration function
Date: Thu, 25 Sep 2014 00:19:16 +0900
Message-ID: <20140925001916.c78535ec293e354c27e5f9fa@linux-mips.org>
References: <20140925001647.dd48571a3c0ceda5c25ab669@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg1500.iij4u.or.jp ([210.130.239.5]:40626 "EHLO
	mo-sg.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbaIXPUp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 11:20:45 -0400
In-Reply-To: <20140925001647.dd48571a3c0ceda5c25ab669@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yuasa@linux-mips.org, linux-input@vger.kernel.org

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/input/touchscreen/rohm_bu21023.c |  250 ++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index a35a914..de6717f 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -72,6 +72,251 @@ static inline int rohm_i2c_burst_read(struct i2c_adapter *adap,
 	return ret;
 }
 
+static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	struct device *dev = &client->dev;
+	struct i2c_msg msg[2];
+	u8 buf[33];
+	u8 addr_buf;		/* burst read start address */
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
+	addr_buf = PRM1_X_H;
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &addr_buf;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(buf);
+	msg[1].buf = buf;
+
+#define READ_CALIB_BUF(reg)	((u16)buf[((reg) - PRM1_X_H)])
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
+		ret = rohm_i2c_burst_read(client->adapter, msg, 2);
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
+		} else
+			dev_warn(dev, "Calibration timeout\n");
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
 static unsigned long inactive_polling_interval[2] = { 1, 0 };
 static unsigned long active_polling_interval[2] = { 0, 10000000 };
 
@@ -228,6 +473,11 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 	input_mt_report_pointer_emulation(input_dev, true);
 	input_sync(input_dev);
 
+	if (READ_POS_BUF(TOUCH_GESTURE) & CALIBRATION_REQUEST) {
+		if (rohm_ts_manual_calibration(ts) < 0)
+			dev_warn(dev, "Failed to manual calibration\n");
+	}
+
 	i2c_smbus_write_byte_data(client, INT_MASK,
 				  CALIBRATION_DONE | SLEEP_OUT | SLEEP_IN |
 				  PROGRAM_LOAD_DONE);
-- 
1.7.9.5

