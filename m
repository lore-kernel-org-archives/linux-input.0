From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Fri, 28 Aug 2015 17:45:56 -0700
Message-ID: <20150829004556.GD8298@dtor-ws>
References: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
 <20150115013558.GA37437@dtor-ws>
 <CACBHAeywdgzS=SbyXmR--VZop9fANeS4JRTRbDg0hKj6xV6SZw@mail.gmail.com>
 <20150807180614.279d6d9104c5a5110d8071dd@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34454 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbbH2Ap7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 20:45:59 -0400
Received: by pabzx8 with SMTP id zx8so78161032pab.1
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2015 17:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150807180614.279d6d9104c5a5110d8071dd@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-input@vger.kernel.org

Hi Yoichi,

On Fri, Aug 07, 2015 at 06:06:14PM +0900, Yoichi Yuasa wrote:
> v5 Changes:
> - contact count variables move to array
> - remove unneeded u16 casts in #define
> - remove module parameters
> - handle "no fingers" as same as others
> - move devm_request_thread_irq() from open() to probe()
> - move "power off" from remove() to close()

You must have sent me some interim version because it could not have
worked for you. For example, you pass 'ts' pointer to
devm_request_theraded_irq() before allocating memory for ts, you also
treat sysfs attributes as if they were attached to input device
structure while you are creating them (as you should) at i2c dveice
level.

Also, handling of sysfs attributes is racy with regard to open/close. I
tried correcting these issues (and also made some stylistic changes,
please see an incremental patch below). If you could integrate it with
your work and test to make sure it actually works with the hardware that
would be great.

Thanks.

-- 
Dmitry


Input: rohm_bu21023 - misc fixes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/rohm_bu21023.c |  827 ++++++++++++++----------------
 1 file changed, 390 insertions(+), 437 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index 8aeaaf3..ffc1684 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -13,7 +13,6 @@
  */
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/hrtimer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -29,7 +28,7 @@
 #define AXIS_ADJUST			4
 #define AXIS_OFFSET			8
 
-#define FIRMWARE_BLOCK_SIZE		32
+#define FIRMWARE_BLOCK_SIZE		32U
 #define FIRMWARE_RETRY_MAX		4
 
 #define SAMPLING_DELAY			12	/* msec */
@@ -265,7 +264,7 @@
 
 struct rohm_ts_data {
 	struct i2c_client *client;
-	struct input_dev *input_dev;
+	struct input_dev *input;
 
 	bool initialized;
 
@@ -338,7 +337,7 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 	int reg_x, reg_y;
 	int err_x, err_y;
 
-	int err = 0, ret;
+	int error, error2;
 	int i;
 
 	reg1_orig = i2c_smbus_read_byte_data(client, CALIBRATION_REG1);
@@ -353,19 +352,16 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 	if (reg3_orig < 0)
 		return reg3_orig;
 
-	ret = i2c_smbus_write_byte_data(client, INT_MASK,
-					COORD_UPDATE | SLEEP_IN | SLEEP_OUT |
-					PROGRAM_LOAD_DONE);
-	if (ret) {
-		err = ret;
-		goto err_exit;
-	}
+	error = i2c_smbus_write_byte_data(client, INT_MASK,
+					  COORD_UPDATE | SLEEP_IN | SLEEP_OUT |
+						PROGRAM_LOAD_DONE);
+	if (error)
+		goto out;
 
-	ret = i2c_smbus_write_byte_data(client, TEST1, DUALTOUCH_STABILIZE_ON);
-	if (ret) {
-		err = ret;
-		goto err_exit;
-	}
+	error = i2c_smbus_write_byte_data(client, TEST1,
+					  DUALTOUCH_STABILIZE_ON);
+	if (error)
+		goto out;
 
 	for (retry = 0; retry < CALIBRATION_RETRY_MAX; retry++) {
 		/* wait 2 sampling for update */
@@ -373,11 +369,9 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 
 #define READ_CALIB_BUF(reg)	buf[((reg) - PRM1_X_H)]
 
-		ret = rohm_i2c_burst_read(client, PRM1_X_H, buf, sizeof(buf));
-		if (ret < 0) {
-			err = ret;
-			goto err_exit;
-		}
+		error = rohm_i2c_burst_read(client, PRM1_X_H, buf, sizeof(buf));
+		if (error)
+			goto out;
 
 		if (READ_CALIB_BUF(TOUCH) & TOUCH_DETECT)
 			continue;
@@ -391,13 +385,11 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 			    ((int)READ_CALIB_BUF(PRM1_Y_H) << 2 |
 			     READ_CALIB_BUF(PRM1_Y_L)) - AXIS_OFFSET;
 
-			ret = i2c_smbus_write_byte_data(client, TEST1,
-							DUALTOUCH_STABILIZE_ON |
-							DUALTOUCH_REG_ON);
-			if (ret) {
-				err = ret;
-				goto err_exit;
-			}
+			error = i2c_smbus_write_byte_data(client, TEST1,
+					 DUALTOUCH_STABILIZE_ON |
+						DUALTOUCH_REG_ON);
+			if (error)
+				goto out;
 
 			first_time = false;
 		} else {
@@ -429,47 +421,36 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 		reg2 = (reg_y & 0x7) << 4 | (reg_x & 0x7);
 		reg3 = reg_y >> 3;
 
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1, reg1);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client,
+						  CALIBRATION_REG1, reg1);
+		if (error)
+			goto out;
 
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2, reg2);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, CALIBRATION_REG2, reg2);
+		if (error)
+			goto out;
 
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3, reg3);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, CALIBRATION_REG3, reg3);
+		if (error)
+			goto out;
 
 		/*
 		 * force calibration sequcence
 		 */
-		ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+		error = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
 						FORCE_CALIBRATION_OFF);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		if (error)
+			goto out;
 
-		ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+		error = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
 						FORCE_CALIBRATION_ON);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		if (error)
+			goto out;
 
 		/* clear all interrupts */
-		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+		if (error)
+			goto out;
 
 		/*
 		 * Wait for the status change of calibration, max 10 sampling
@@ -484,8 +465,8 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 				calibration_done = true;
 				break;
 			} else if (val < 0) {
-				err = val;
-				goto err_exit;
+				error = val;
+				goto out;
 			}
 		}
 
@@ -495,8 +476,8 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 				success = true;
 				break;
 			} else if (val < 0) {
-				err = val;
-				goto err_exit;
+				error = val;
+				goto out;
 			}
 		} else {
 			dev_warn(dev, "Calibration timeout\n");
@@ -504,63 +485,52 @@ static int rohm_ts_manual_calibration(struct rohm_ts_data *ts)
 	}
 
 	if (!success) {
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
-						reg1_orig);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
+						  reg1_orig);
+		if (error)
+			goto out;
 
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
-						reg2_orig);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
+						  reg2_orig);
+		if (error)
+			goto out;
 
-		ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
-						reg3_orig);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
+						  reg3_orig);
+		if (error)
+			goto out;
 
 		/* calibration data enable */
-		ret = i2c_smbus_write_byte_data(client, TEST1,
-						DUALTOUCH_STABILIZE_ON |
-						DUALTOUCH_REG_ON);
-		if (ret) {
-			err = ret;
-			goto err_exit;
-		}
+		error = i2c_smbus_write_byte_data(client, TEST1,
+						  DUALTOUCH_STABILIZE_ON |
+							DUALTOUCH_REG_ON);
+		if (error)
+			goto out;
 
 		/* wait 10 sampling */
 		mdelay(10 * SAMPLING_DELAY);
 
-		err = -EBUSY;
+		error = -EBUSY;
 	}
 
-err_exit:
-	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
-	if (!ret)
+out:
+	error2 = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
+	if (!error2)
 		/* Clear all interrupts */
-		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-
-	if (!err && ret)
-		err = ret;
+		error2 = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
 
-	return err;
+	return error ? error : error2;
 }
 
-static unsigned int untouch_threshold[3] = { 0, 1, 5 };
-static unsigned int single_touch_threshold[3] = { 0, 0, 4 };
-static unsigned int dual_touch_threshold[3] = { 10, 8, 0 };
+static const unsigned int untouch_threshold[3] = { 0, 1, 5 };
+static const unsigned int single_touch_threshold[3] = { 0, 0, 4 };
+static const unsigned int dual_touch_threshold[3] = { 10, 8, 0 };
 
 static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 {
 	struct rohm_ts_data *ts = dev_id;
 	struct i2c_client *client = ts->client;
-	struct input_dev *input_dev = ts->input_dev;
+	struct input_dev *input_dev = ts->input;
 	struct device *dev = &client->dev;
 
 	u8 buf[10];		/* for 0x20-0x29 */
@@ -571,9 +541,9 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 	unsigned int threshold;
 	int finger_count = -1;
 	int prev_finger_count = ts->finger_count;
-
-	s32 status;
-	int i, ret;
+	int status;
+	int error;
+	int i;
 
 	status = i2c_smbus_read_byte_data(client, INT_STATUS);
 	if (!status)
@@ -582,19 +552,19 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 	if (status < 0)
 		return IRQ_HANDLED;
 
-	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
-	if (ret)
+	error = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
+	if (error)
 		return IRQ_HANDLED;
 
 	/* Clear all interrupts */
-	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-	if (ret)
+	error = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (error)
 		return IRQ_HANDLED;
 
 #define READ_POS_BUF(reg)	buf[((reg) - POS_X1_H)]
 
-	ret = rohm_i2c_burst_read(client, POS_X1_H, buf, sizeof(buf));
-	if (ret < 0)
+	error = rohm_i2c_burst_read(client, POS_X1_H, buf, sizeof(buf));
+	if (error)
 		return IRQ_HANDLED;
 
 	touch_flags = READ_POS_BUF(TOUCH_GESTURE) & TOUCH_MASK;
@@ -616,6 +586,7 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 		if (ts->contact_count[0] >= threshold)
 			finger_count = 0;
 		break;
+
 	case SINGLE_TOUCH:
 		threshold = single_touch_threshold[prev_finger_count];
 		if (ts->contact_count[1] >= threshold)
@@ -630,11 +601,13 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 			}
 		}
 		break;
+
 	case DUAL_TOUCH:
 		threshold = dual_touch_threshold[prev_finger_count];
 		if (ts->contact_count[2] >= threshold)
 			finger_count = 2;
 		break;
+
 	default:
 		dev_dbg(dev,
 			"Three or more touches are not supported\n");
@@ -668,13 +641,15 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void *dev_id)
 	}
 
 	if (READ_POS_BUF(TOUCH_GESTURE) & CALIBRATION_REQUEST) {
-		if (rohm_ts_manual_calibration(ts) < 0)
-			dev_warn(dev, "Failed to manual calibration\n");
+		error = rohm_ts_manual_calibration(ts);
+		if (error)
+			dev_warn(dev, "manual calibration failed: %d\n",
+				 error);
 	}
 
 	i2c_smbus_write_byte_data(client, INT_MASK,
 				  CALIBRATION_DONE | SLEEP_OUT | SLEEP_IN |
-				  PROGRAM_LOAD_DONE);
+					PROGRAM_LOAD_DONE);
 
 	return IRQ_HANDLED;
 }
@@ -683,120 +658,96 @@ static int rohm_ts_load_firmware(struct i2c_client *client,
 				 const char *firmware_name)
 {
 	struct device *dev = &client->dev;
-	const struct firmware *firmware = NULL;
+	const struct firmware *fw;
 	s32 status;
-	int blocks, remainder, retry = 0, offset;
-	int err = 0, ret;
-	int i;
-
-	ret = request_firmware(&firmware, firmware_name, dev);
-	if (ret) {
-		dev_err(dev, "Unable to open firmware %s\n", firmware_name);
-		return ret;
+	unsigned int offset, len, xfer_len;
+	unsigned int retry = 0;
+	int error, error2;
+
+	error = request_firmware(&fw, firmware_name, dev);
+	if (error) {
+		dev_err(dev, "unable to retrieve firmware %s: %d\n",
+			firmware_name, error);
+		return error;
 	}
 
-	blocks = firmware->size / FIRMWARE_BLOCK_SIZE;
-	remainder = firmware->size % FIRMWARE_BLOCK_SIZE;
-
-	ret = i2c_smbus_write_byte_data(client, INT_MASK,
-					COORD_UPDATE | CALIBRATION_DONE |
-					SLEEP_IN | SLEEP_OUT);
-	if (ret) {
-		err = ret;
+	error = i2c_smbus_write_byte_data(client, INT_MASK,
+					  COORD_UPDATE | CALIBRATION_DONE |
+						SLEEP_IN | SLEEP_OUT);
+	if (error)
 		goto err_int_mask_exit;
-	}
 
-	while (retry < FIRMWARE_RETRY_MAX) {
-		ret = i2c_smbus_write_byte_data(client, COMMON_SETUP1,
-						COMMON_SETUP1_DEFAULT);
-		if (ret) {
-			err = ret;
+	while (1) {
+		error = i2c_smbus_write_byte_data(client, COMMON_SETUP1,
+						  COMMON_SETUP1_DEFAULT);
+		if (error)
 			goto err_int_mask_exit;
-		}
 
-		ret = i2c_smbus_write_byte_data(client, EX_ADDR_H, 0);
-		if (ret) {
-			err = ret;
+		error = i2c_smbus_write_byte_data(client, EX_ADDR_H, 0);
+		if (error)
 			goto err_int_mask_exit;
-		}
 
-		ret = i2c_smbus_write_byte_data(client, EX_ADDR_L, 0);
-		if (ret) {
-			err = ret;
+		error = i2c_smbus_write_byte_data(client, EX_ADDR_L, 0);
+		if (error)
 			goto err_int_mask_exit;
-		}
-
-		offset = 0;
 
 		/* firmware load to the device */
-		for (i = 0; i < blocks; i++) {
-			ret = i2c_smbus_write_i2c_block_data(client, EX_WDAT,
-				FIRMWARE_BLOCK_SIZE, &firmware->data[offset]);
-			if (ret) {
-				err = ret;
-				goto err_int_mask_exit;
-			}
+		offset = 0;
+		len = fw->size;
 
-			offset += FIRMWARE_BLOCK_SIZE;
-		}
+		while (len) {
+			xfer_len = min(FIRMWARE_BLOCK_SIZE, len);
 
-		if (remainder) {
-			ret = i2c_smbus_write_i2c_block_data(client, EX_WDAT,
-				remainder, &firmware->data[offset]);
-			if (ret) {
-				err = ret;
+			error = i2c_smbus_write_i2c_block_data(client, EX_WDAT,
+						xfer_len, &fw->data[offset]);
+			if (error)
 				goto err_int_mask_exit;
-			}
+
+			len -= xfer_len;
+			offset += xfer_len;
 		}
 
-		/* check formware load result */
+		/* check firmware load result */
 		status = i2c_smbus_read_byte_data(client, INT_STATUS);
 		if (status < 0) {
-			err = status;
+			error = status;
 			goto err_int_mask_exit;
 		}
 
 		/* clear all interrupts */
-		ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-		if (ret) {
-			err = ret;
+		error = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+		if (error)
 			goto err_int_mask_exit;
-		}
 
 		if (status == PROGRAM_LOAD_DONE)
 			break;
 
-		/* settings for retry */
-		ret = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
-		if (ret) {
-			err = ret;
-			goto err_int_mask_exit;
+		if (++retry >= FIRMWARE_RETRY_MAX) {
+			error = -EIO;
+			break;
 		}
 
-		retry++;
-		dev_warn(dev, "Retry firmware load\n");
+		dev_warn(dev, "retrying firmware load\n");
+
+		/* settings for retry */
+		error = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
+		if (error)
+			goto err_int_mask_exit;
 	}
 
 err_int_mask_exit:
-	ret = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
-	if (ret)
-		err = ret;
-
-	release_firmware(firmware);
+	error2 = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
 
-	if (retry >= FIRMWARE_RETRY_MAX)
-		return -EBUSY;
+	release_firmware(fw);
 
-	return err;
+	return error ? error : error2;
 }
 
 static ssize_t swap_xy_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
-
-	ts = input_get_drvdata(input_dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 
 	return sprintf(buf, "%d\n", !!(ts->setup2 & SWAP_XY));
 }
@@ -804,16 +755,18 @@ static ssize_t swap_xy_show(struct device *dev, struct device_attribute *attr,
 static ssize_t swap_xy_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 	unsigned int val;
-	int err = 0;
+	int error;
 
-	ts = input_get_drvdata(input_dev);
+	error = kstrtouint(buf, 0, &val);
+	if (error)
+		return error;
 
-	err = kstrtouint(buf, 0, &val);
-	if (err)
-		return err;
+	error = mutex_lock_interruptible(&ts->input->mutex);
+	if (error)
+		return error;
 
 	if (val)
 		ts->setup2 |= SWAP_XY;
@@ -821,19 +774,18 @@ static ssize_t swap_xy_store(struct device *dev, struct device_attribute *attr,
 		ts->setup2 &= ~SWAP_XY;
 
 	if (ts->initialized)
-		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
-						ts->setup2);
+		error = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
+						  ts->setup2);
 
-	return err;
+	mutex_unlock(&ts->input->mutex);
+	return error;
 }
 
 static ssize_t inv_x_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
-
-	ts = input_get_drvdata(input_dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 
 	return sprintf(buf, "%d\n", !!(ts->setup2 & INV_X));
 }
@@ -841,16 +793,18 @@ static ssize_t inv_x_show(struct device *dev, struct device_attribute *attr,
 static ssize_t inv_x_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 	unsigned int val;
-	int err = 0;
+	int error;
 
-	ts = input_get_drvdata(input_dev);
+	error = kstrtouint(buf, 0, &val);
+	if (error)
+		return error;
 
-	err = kstrtouint(buf, 0, &val);
-	if (err)
-		return err;
+	error = mutex_lock_interruptible(&ts->input->mutex);
+	if (error)
+		return error;
 
 	if (val)
 		ts->setup2 |= INV_X;
@@ -858,19 +812,18 @@ static ssize_t inv_x_store(struct device *dev, struct device_attribute *attr,
 		ts->setup2 &= ~INV_X;
 
 	if (ts->initialized)
-		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
-						ts->setup2);
+		error = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
+						  ts->setup2);
 
-	return err;
+	mutex_unlock(&ts->input->mutex);
+	return error;
 }
 
 static ssize_t inv_y_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
-
-	ts = input_get_drvdata(input_dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 
 	return sprintf(buf, "%d\n", !!(ts->setup2 & INV_Y));
 }
@@ -878,16 +831,18 @@ static ssize_t inv_y_show(struct device *dev, struct device_attribute *attr,
 static ssize_t inv_y_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-	struct rohm_ts_data *ts;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rohm_ts_data *ts = i2c_get_clientdata(client);
 	unsigned int val;
-	int err = 0;
+	int error;
 
-	ts = input_get_drvdata(input_dev);
+	error = kstrtouint(buf, 0, &val);
+	if (error)
+		return error;
 
-	err = kstrtouint(buf, 0, &val);
-	if (err)
-		return err;
+	error = mutex_lock_interruptible(&ts->input->mutex);
+	if (error)
+		return error;
 
 	if (val)
 		ts->setup2 |= INV_X;
@@ -895,10 +850,11 @@ static ssize_t inv_y_store(struct device *dev, struct device_attribute *attr,
 		ts->setup2 &= ~INV_X;
 
 	if (ts->initialized)
-		err = i2c_smbus_write_byte_data(ts->client, COMMON_SETUP2,
-						ts->setup2);
+		error = i2c_smbus_write_byte_data(client, COMMON_SETUP2,
+						  ts->setup2);
 
-	return err;
+	mutex_unlock(&ts->input->mutex);
+	return error;
 }
 
 static DEVICE_ATTR_RW(swap_xy);
@@ -916,11 +872,10 @@ static const struct attribute_group rohm_ts_attr_group = {
 	.attrs = rohm_ts_attrs,
 };
 
-static int rohm_ts_device_init(struct rohm_ts_data *ts)
+static int rohm_ts_device_init(struct i2c_client *client, u8 setup2)
 {
-	struct i2c_client *client = ts->client;
 	struct device *dev = &client->dev;
-	int ret;
+	int error;
 
 	/*
 	 * Wait 200usec for reset
@@ -928,118 +883,118 @@ static int rohm_ts_device_init(struct rohm_ts_data *ts)
 	udelay(200);
 
 	/* Release analog reset */
-	ret = i2c_smbus_write_byte_data(client, SYSTEM, ANALOG_POWER_ON);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, SYSTEM, ANALOG_POWER_ON);
+	if (error)
+		return error;
 
 	/* Waiting for the analog warm-up, max. 200usec */
 	udelay(200);
 
 	/* clear all interrupts */
-	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP1, 0);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP2, ts->setup2);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, COMMON_SETUP3,
-					SEL_TBL_DEFAULT | EN_MULTI);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, THRESHOLD_GESTURE,
-					THRESHOLD_GESTURE_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, INTERVAL_TIME,
-					INTERVAL_TIME_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, CPU_FREQ, CPU_FREQ_10MHZ);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, PRM_SWOFF_TIME,
-					PRM_SWOFF_TIME_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, ADC_CTRL, ADC_DIV_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, ADC_WAIT, ADC_WAIT_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, COMMON_SETUP1, 0);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, COMMON_SETUP2, setup2);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, COMMON_SETUP3,
+					  SEL_TBL_DEFAULT | EN_MULTI);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, THRESHOLD_GESTURE,
+					  THRESHOLD_GESTURE_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, INTERVAL_TIME,
+					  INTERVAL_TIME_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, CPU_FREQ, CPU_FREQ_10MHZ);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, PRM_SWOFF_TIME,
+					  PRM_SWOFF_TIME_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, ADC_CTRL, ADC_DIV_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, ADC_WAIT, ADC_WAIT_DEFAULT);
+	if (error)
+		return error;
 
 	/*
 	 * Panel setup, these values change with the panel.
 	 */
-	ret = i2c_smbus_write_byte_data(client, STEP_X, STEP_X_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, STEP_X, STEP_X_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, STEP_Y, STEP_Y_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, STEP_Y, STEP_Y_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, OFFSET_X, OFFSET_X_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, OFFSET_X, OFFSET_X_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, OFFSET_Y, OFFSET_Y_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, OFFSET_Y, OFFSET_Y_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, THRESHOLD_TOUCH,
-					THRESHOLD_TOUCH_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, THRESHOLD_TOUCH,
+					  THRESHOLD_TOUCH_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, EVR_XY, EVR_XY_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, EVR_XY, EVR_XY_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, EVR_X, EVR_X_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, EVR_X, EVR_X_DEFAULT);
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, EVR_Y, EVR_Y_DEFAULT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, EVR_Y, EVR_Y_DEFAULT);
+	if (error)
+		return error;
 
 	/* Fixed value settings */
-	ret = i2c_smbus_write_byte_data(client, CALIBRATION_ADJUST,
-					CALIBRATION_ADJUST_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, SWCONT, SWCONT_DEFAULT);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, TEST1,
-					DUALTOUCH_STABILIZE_ON |
-					DUALTOUCH_REG_ON);
-	if (ret)
-		return ret;
-
-	ret = rohm_ts_load_firmware(client, BU21023_FIRMWARE_NAME);
-	if (ret) {
-		dev_err(dev, "Failed to firmware load\n");
-		return ret;
+	error = i2c_smbus_write_byte_data(client, CALIBRATION_ADJUST,
+					  CALIBRATION_ADJUST_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, SWCONT, SWCONT_DEFAULT);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, TEST1,
+					  DUALTOUCH_STABILIZE_ON |
+						DUALTOUCH_REG_ON);
+	if (error)
+		return error;
+
+	error = rohm_ts_load_firmware(client, BU21023_FIRMWARE_NAME);
+	if (error) {
+		dev_err(dev, "failed to load firmware: %d\n", error);
+		return error;
 	}
 
 	/*
@@ -1048,69 +1003,94 @@ static int rohm_ts_device_init(struct rohm_ts_data *ts)
 	 * the controller will not require calibration request interrupt
 	 * when the typical values are set to the calibration registers.
 	 */
-	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
+	error = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
 					CALIBRATION_REG1_DEFAULT);
-	if (ret)
-		return ret;
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
+	error = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
 					CALIBRATION_REG2_DEFAULT);
-	if (ret)
-		return ret;
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
+	error = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
 					CALIBRATION_REG3_DEFAULT);
-	if (ret)
-		return ret;
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+	error = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
 					FORCE_CALIBRATION_OFF);
-	if (ret)
-		return ret;
+	if (error)
+		return error;
 
-	ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
-					FORCE_CALIBRATION_ON);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
+					  FORCE_CALIBRATION_ON);
+	if (error)
+		return error;
 
 	/* Clear all interrupts */
-	ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
+	if (error)
+		return error;
 
 	/* Enable coordinates update interrupt */
-	ret = i2c_smbus_write_byte_data(client, INT_MASK,
-					CALIBRATION_DONE |
-					SLEEP_OUT | SLEEP_IN |
-					PROGRAM_LOAD_DONE);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, ERR_MASK,
-					PROGRAM_LOAD_ERR | CPU_TIMEOUT |
-					ADC_TIMEOUT);
-	if (ret)
-		return ret;
+	error = i2c_smbus_write_byte_data(client, INT_MASK,
+					  CALIBRATION_DONE |
+						SLEEP_OUT | SLEEP_IN |
+						PROGRAM_LOAD_DONE);
+	if (error)
+		return error;
+
+	error = i2c_smbus_write_byte_data(client, ERR_MASK,
+					  PROGRAM_LOAD_ERR | CPU_TIMEOUT |
+						ADC_TIMEOUT);
+	if (error)
+		return error;
 
 	/* controller CPU power on */
-	ret = i2c_smbus_write_byte_data(client, SYSTEM,
-					CPU_POWER_ON | ANALOG_POWER_ON);
+	error = i2c_smbus_write_byte_data(client, SYSTEM,
+					  CPU_POWER_ON | ANALOG_POWER_ON);
+	if (error)
+		return error;
 
-	return ret;
+	return 0;
+}
+
+static int rohm_ts_power_off(struct i2c_client *client)
+{
+	int error;
+
+	error = i2c_smbus_write_byte_data(client, SYSTEM,
+					  ANALOG_POWER_ON | CPU_POWER_OFF);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to power off device CPU: %d\n", error);
+		return error;
+	}
+
+	error = i2c_smbus_write_byte_data(client, SYSTEM,
+					  ANALOG_POWER_OFF | CPU_POWER_OFF);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to power off the device: %d\n", error);
+		return error;
+	}
+
+	return 0;
 }
 
 static int rohm_ts_open(struct input_dev *input_dev)
 {
 	struct rohm_ts_data *ts = input_get_drvdata(input_dev);
 	struct i2c_client *client = ts->client;
-	int ret;
+	int error;
 
 	if (!ts->initialized) {
-		ret = rohm_ts_device_init(ts);
-		if (ret) {
+		error = rohm_ts_device_init(client, ts->setup2);
+		if (error) {
 			dev_err(&client->dev,
-				"Failed to device initialization\n");
-			return ret;
+				"device initialization failed: %d\n", error);
+			return error;
 		}
 
 		ts->initialized = true;
@@ -1122,61 +1102,32 @@ static int rohm_ts_open(struct input_dev *input_dev)
 static void rohm_ts_close(struct input_dev *input_dev)
 {
 	struct rohm_ts_data *ts = input_get_drvdata(input_dev);
-	struct i2c_client *client = ts->client;
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(client, SYSTEM,
-					ANALOG_POWER_ON | CPU_POWER_OFF);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to device CPU power off\n");
-		return;
-	}
 
-	ret = i2c_smbus_write_byte_data(client, SYSTEM,
-					ANALOG_POWER_OFF | CPU_POWER_OFF);
-	if (ret)
-		dev_err(&client->dev,
-			"Failed to device power off\n");
+	rohm_ts_power_off(ts->client);
 }
 
 static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	struct rohm_ts_data *ts;
-	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
-	struct input_dev *input_dev;
-	int ret;
+	struct rohm_ts_data *ts;
+	struct input_dev *input;
+	int error;
 
 	if (!client->irq) {
 		dev_err(dev, "IRQ is not assigned\n");
 		return -EINVAL;
 	}
 
-	if (!adap->algo->master_xfer) {
-		dev_err(&adap->dev, "I2C level transfers not supported\n");
+	if (!client->adapter->algo->master_xfer) {
+		dev_err(dev, "I2C level transfers not supported\n");
 		return -EOPNOTSUPP;
 	}
 
 	/* Trun off CPU just in case */
-	ret = i2c_smbus_write_byte_data(client, SYSTEM,
-					ANALOG_POWER_ON | CPU_POWER_OFF);
-	if (ret)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(client, SYSTEM,
-					ANALOG_POWER_OFF | CPU_POWER_OFF);
-	if (ret)
-		return ret;
-
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-					rohm_ts_soft_irq, IRQF_TRIGGER_FALLING,
-					client->name, ts);
-	if (ret) {
-		dev_err(dev, "Unable to request IRQ\n");
-		return ret;
-	}
+	error = rohm_ts_power_off(client);
+	if (error)
+		return error;
 
 	ts = devm_kzalloc(dev, sizeof(struct rohm_ts_data), GFP_KERNEL);
 	if (!ts)
@@ -1186,65 +1137,69 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 	ts->setup2 = MAF_1SAMPLE;
 	i2c_set_clientdata(client, ts);
 
-	input_dev = devm_input_allocate_device(dev);
-	if (!input_dev)
+	input = devm_input_allocate_device(dev);
+	if (!input)
 		return -ENOMEM;
 
-	input_dev->name = BU21023_NAME;
-	input_dev->id.bustype = BUS_I2C;
-	input_dev->open = rohm_ts_open;
-	input_dev->close = rohm_ts_close;
+	input->name = BU21023_NAME;
+	input->id.bustype = BUS_I2C;
+	input->open = rohm_ts_open;
+	input->close = rohm_ts_close;
 
-	ts->input_dev = input_dev;
-	input_set_drvdata(input_dev, ts);
+	ts->input = input;
+	input_set_drvdata(input, ts);
 
-	__set_bit(EV_SYN, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
 
-	__set_bit(BTN_TOUCH, input_dev->keybit);
+	__set_bit(BTN_TOUCH, input->keybit);
 
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+	input_set_abs_params(input, ABS_MT_POSITION_X,
 			     ROHM_TS_ABS_X_MIN, ROHM_TS_ABS_X_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     ROHM_TS_ABS_Y_MIN, ROHM_TS_ABS_Y_MAX, 0, 0);
 
-	input_set_abs_params(input_dev, ABS_X,
+	input_set_abs_params(input, ABS_X,
 			     ROHM_TS_ABS_X_MIN, ROHM_TS_ABS_X_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y,
+	input_set_abs_params(input, ABS_Y,
 			     ROHM_TS_ABS_Y_MIN, ROHM_TS_ABS_Y_MAX, 0, 0);
 
-	ret = input_mt_init_slots(input_dev, MAX_CONTACTS,
-				  INPUT_MT_DIRECT | INPUT_MT_TRACK |
-				  INPUT_MT_DROP_UNUSED);
-	if (ret) {
+	error = input_mt_init_slots(input, MAX_CONTACTS,
+				    INPUT_MT_DIRECT | INPUT_MT_TRACK |
+					INPUT_MT_DROP_UNUSED);
+	if (error) {
 		dev_err(dev, "Failed to multi touch slots initialization\n");
-		return ret;
+		return error;
 	}
 
-	ret = input_register_device(input_dev);
-	if (ret) {
-		dev_err(dev, "Unable to register input device\n");
-		return ret;
+	error = devm_request_threaded_irq(dev, client->irq,
+					  NULL, rohm_ts_soft_irq,
+					  0, client->name, ts);
+	if (error) {
+		dev_err(dev, "failed to request IRQ: %d\n", error);
+		return error;
 	}
 
-	ret = sysfs_create_group(&dev->kobj, &rohm_ts_attr_group);
-	if (ret)
-		dev_err(dev, "Failed to create sysfs group\n");
-
-	return ret;
-}
+	error = input_register_device(input);
+	if (error) {
+		dev_err(dev, "failed to register input device: %d\n", error);
+		return error;
+	}
 
-static int rohm_bu21023_i2c_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &rohm_ts_attr_group);
+	// error = devm_sysfs_create_group(dev, &rohm_ts_attr_group);
+	error = sysfs_create_group(&dev->kobj, &rohm_ts_attr_group);
+	if (error) {
+		dev_err(dev, "Failed to create sysfs group: %d\n", error);
+		return error;
+	}
 
 	return 0;
 }
 
 static const struct i2c_device_id rohm_bu21023_i2c_id[] = {
-	{BU21023_NAME, 0},
-	{},
+	{ BU21023_NAME, 0 },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(i2c, rohm_bu21023_i2c_id);
@@ -1254,12 +1209,10 @@ static struct i2c_driver rohm_bu21023_i2c_driver = {
 		.name = BU21023_NAME,
 	},
 	.probe = rohm_bu21023_i2c_probe,
-	.remove = rohm_bu21023_i2c_remove,
 	.id_table = rohm_bu21023_i2c_id,
 };
-
 module_i2c_driver(rohm_bu21023_i2c_driver);
 
 MODULE_DESCRIPTION("ROHM BU21023/24 Touchscreen driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("ROHM Co., Ltd.");
