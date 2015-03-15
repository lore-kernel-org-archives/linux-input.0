From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH] hid: cp2112: support i2c_transfer() when num > 1
Date: Sun, 15 Mar 2015 19:43:18 +0800
Message-ID: <1426419798-25360-1-git-send-email-borneo.antonio@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34496 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbCOLoS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Mar 2015 07:44:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Antonio Borneo <borneo.antonio@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

The device cp2112 does not support i2c combined transactions,
since unable to suppress the stop bit between adjacent i2c
transactions.
For this reason, in commit b9029345ed6483fcadadc4834b44a5656dd56d70
("HID: cp2112: add I2C mode") I have omitted the support for
num > 1 in i2c_transfer().

But:

1) in few kernel drivers i2c_transfer() has been used to
simplify the code by replacing a sequence of i2c_master_send()
and i2c_master_recv(), e.g. in i2c-hid.c and iio subsystem.
Those drivers will fail if used with current cp2112 driver.

2) in drivers/i2c/busses/ there are already drivers that
implement i2c_transfer() as a sequence of elementary (not
combined) i2c transactions, e.g. i2c-bcm2835.c, i2c-puv3.c,
i2c-qup.c, i2c-robotfuzz-osif.c, i2c-viperboard.c, i2c-xlr.c.

To fix 1) and considering 2), rewrite i2c_transfer() in case
of num > 1 as a loop of non-combined i2c transactions.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---

Hi Benjamin,

In [1] we had a talk about implementing i2c_transfer() as a
sequence of elementary (not combined) i2c transactions.
After Jonathan's reply in [2], I went to check better the
existing I2C drivers and I changed opinion.

Added linux-i2c list in copy to get feedback, if any, from
the I2C experts.

Regards,
Antonio Borneo

[1] https://lkml.org/lkml/2014/6/29/6
[2] https://lkml.org/lkml/2014/7/15/104


 drivers/hid/hid-cp2112.c | 76 ++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..76cad81 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -444,8 +444,7 @@ static int cp2112_i2c_write_req(void *buf, u8 slave_address, u8 *data,
 	return data_length + 3;
 }
 
-static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			   int num)
+static int cp2112_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg)
 {
 	struct cp2112_device *dev = (struct cp2112_device *)adap->algo_data;
 	struct hid_device *hdev = dev->hdev;
@@ -454,33 +453,18 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	unsigned int retries;
 	int ret;
 
-	hid_dbg(hdev, "I2C %d messages\n", num);
-
-	if (num != 1) {
-		hid_err(hdev,
-			"Multi-message I2C transactions not supported\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (msgs->flags & I2C_M_RD)
-		count = cp2112_read_req(buf, msgs->addr, msgs->len);
+	if (msg->flags & I2C_M_RD)
+		count = cp2112_read_req(buf, msg->addr, msg->len);
 	else
-		count = cp2112_i2c_write_req(buf, msgs->addr, msgs->buf,
-					     msgs->len);
-
+		count = cp2112_i2c_write_req(buf, msg->addr, msg->buf,
+					     msg->len);
 	if (count < 0)
 		return count;
 
-	ret = hid_hw_power(hdev, PM_HINT_FULLON);
-	if (ret < 0) {
-		hid_err(hdev, "power management error: %d\n", ret);
-		return ret;
-	}
-
 	ret = cp2112_hid_output(hdev, buf, count, HID_OUTPUT_REPORT);
 	if (ret < 0) {
 		hid_warn(hdev, "Error starting transaction: %d\n", ret);
-		goto power_normal;
+		return ret;
 	}
 
 	for (retries = 0; retries < XFER_STATUS_RETRIES; ++retries) {
@@ -488,7 +472,7 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		if (-EBUSY == ret)
 			continue;
 		if (ret < 0)
-			goto power_normal;
+			return ret;
 		break;
 	}
 
@@ -502,30 +486,46 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			hid_warn(hdev, "Error cancelling transaction: %d\n",
 				 ret);
 
-		ret = -ETIMEDOUT;
-		goto power_normal;
+		return -ETIMEDOUT;
 	}
 
-	if (!(msgs->flags & I2C_M_RD))
-		goto finish;
+	if (!(msg->flags & I2C_M_RD))
+		return 0;
 
-	ret = cp2112_read(dev, msgs->buf, msgs->len);
+	ret = cp2112_read(dev, msg->buf, msg->len);
 	if (ret < 0)
-		goto power_normal;
-	if (ret != msgs->len) {
-		hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
-		ret = -EIO;
-		goto power_normal;
+		return ret;
+	if (ret != msg->len) {
+		hid_warn(hdev, "short read: %d < %d\n", ret, msg->len);
+		return -EIO;
 	}
+	return 0;
+}
 
-finish:
-	/* return the number of transferred messages */
-	ret = 1;
+static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num)
+{
+	struct cp2112_device *dev = (struct cp2112_device *)adap->algo_data;
+	struct hid_device *hdev = dev->hdev;
+	int i, ret;
+
+	hid_dbg(hdev, "I2C %d messages\n", num);
+
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret < 0) {
+		hid_err(hdev, "power management error: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		ret = cp2112_i2c_xfer_msg(adap, &msgs[i]);
+		if (ret < 0)
+			break;
+	}
 
-power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 	hid_dbg(hdev, "I2C transfer finished: %d\n", ret);
-	return ret;
+	return (ret < 0) ? ret : num;
 }
 
 static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
-- 
2.3.1

