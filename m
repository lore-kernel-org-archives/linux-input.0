From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1] HID: support multiple and large i2c transfers in hid-cp2112
Date: Thu, 23 Apr 2015 14:49:26 -0700
Message-ID: <1429825766-19594-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

cp2112_i2c_xfer() only supports a single i2c_msg and only
reads up to 61 bytes.  More than one message at a time
and longers reads just return errors.

This is a serious limitation.  For example, the at24 eeprom driver
generates paired write and read messages (for eeprom address and data).
And the reads can be quite large.  The fix consists of a loop
to go through all the messages, and a loop around cp2112_read()
to pick up all the returned data.  For extra credit, it now also
supports write-read pairs and implements them as
CP2112_DATA_WRITE_READ_REQUEST.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
 drivers/hid/hid-cp2112.c |  136 +++++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..e7e72a4 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -444,11 +444,30 @@ static int cp2112_i2c_write_req(void *buf, u8 slave_address, u8 *data,
 	return data_length + 3;
 }
 
+static int cp2112_i2c_write_read_req(void *buf, u8 slave_address,
+				     u8 *addr, int addr_length,
+				     int read_length)
+{
+	struct cp2112_write_read_req_report *report = buf;
+
+	if (read_length < 1 || read_length > 512 ||
+	    addr_length > sizeof(report->target_address))
+		return -EINVAL;
+
+	report->report = CP2112_DATA_WRITE_READ_REQUEST;
+	report->slave_address = slave_address << 1;
+	report->length = cpu_to_be16(read_length);
+	report->target_address_length = addr_length;
+	memcpy(report->target_address, addr, addr_length);
+	return addr_length + 5;
+}
+
 static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num)
 {
 	struct cp2112_device *dev = (struct cp2112_device *)adap->algo_data;
 	struct hid_device *hdev = dev->hdev;
+	struct i2c_msg *m;
 	u8 buf[64];
 	ssize_t count;
 	unsigned int retries;
@@ -456,71 +475,90 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 	hid_dbg(hdev, "I2C %d messages\n", num);
 
-	if (num != 1) {
-		hid_err(hdev,
-			"Multi-message I2C transactions not supported\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (msgs->flags & I2C_M_RD)
-		count = cp2112_read_req(buf, msgs->addr, msgs->len);
-	else
-		count = cp2112_i2c_write_req(buf, msgs->addr, msgs->buf,
-					     msgs->len);
-
-	if (count < 0)
-		return count;
-
 	ret = hid_hw_power(hdev, PM_HINT_FULLON);
 	if (ret < 0) {
 		hid_err(hdev, "power management error: %d\n", ret);
 		return ret;
 	}
 
-	ret = cp2112_hid_output(hdev, buf, count, HID_OUTPUT_REPORT);
-	if (ret < 0) {
-		hid_warn(hdev, "Error starting transaction: %d\n", ret);
-		goto power_normal;
-	}
+	for (m = msgs; m < msgs + num; m++) {
+		/*
+		 * If the top two messages are a write followed by a read,
+		 * then we do them together as CP2112_DATA_WRITE_READ_REQUEST.
+		 * Otherwise, process one message.
+		 */
+
+		if (m + 1 < msgs + num && m[0].addr == m[1].addr &&
+		    !(m[0].flags & I2C_M_RD) && (m[1].flags & I2C_M_RD)) {
+			hid_dbg(hdev, "I2C msg %zd write-read %#04x wlen %d rlen %d\n",
+				m - msgs, m[0].addr, m[0].len, m[1].len);
+			count = cp2112_i2c_write_read_req(buf, m[0].addr,
+					m[0].buf, m[0].len, m[1].len);
+			m++;
+		} else if (m->flags & I2C_M_RD) {
+			hid_dbg(hdev, "I2C msg %zd read %#04x len %d\n",
+				m - msgs, m->addr, m->len);
+			count = cp2112_read_req(buf, m->addr, m->len);
+		} else {
+			hid_dbg(hdev, "I2C msg %zd write %#04x len %d\n",
+				m - msgs, m->addr, m->len);
+			count = cp2112_i2c_write_req(buf, m->addr, m->buf,
+						     m->len);
+		}
 
-	for (retries = 0; retries < XFER_STATUS_RETRIES; ++retries) {
-		ret = cp2112_xfer_status(dev);
-		if (-EBUSY == ret)
-			continue;
-		if (ret < 0)
+		if (count < 0) {
+			ret = count;
 			goto power_normal;
-		break;
-	}
+		}
 
-	if (XFER_STATUS_RETRIES <= retries) {
-		hid_warn(hdev, "Transfer timed out, cancelling.\n");
-		buf[0] = CP2112_CANCEL_TRANSFER;
-		buf[1] = 0x01;
+		ret = cp2112_hid_output(hdev, buf, count, HID_OUTPUT_REPORT);
+		if (ret < 0) {
+			hid_warn(hdev, "Error starting transaction: %d\n", ret);
+			goto power_normal;
+		}
 
-		ret = cp2112_hid_output(hdev, buf, 2, HID_OUTPUT_REPORT);
-		if (ret < 0)
-			hid_warn(hdev, "Error cancelling transaction: %d\n",
-				 ret);
+		for (retries = 0; retries < XFER_STATUS_RETRIES; ++retries) {
+			ret = cp2112_xfer_status(dev);
+			if (-EBUSY == ret)
+				continue;
+			if (ret < 0)
+				goto power_normal;
+			break;
+		}
 
-		ret = -ETIMEDOUT;
-		goto power_normal;
-	}
+		if (XFER_STATUS_RETRIES <= retries) {
+			hid_warn(hdev, "Transfer timed out, cancelling.\n");
+			buf[0] = CP2112_CANCEL_TRANSFER;
+			buf[1] = 0x01;
 
-	if (!(msgs->flags & I2C_M_RD))
-		goto finish;
+			ret = cp2112_hid_output(hdev, buf, 2,
+						HID_OUTPUT_REPORT);
+			if (ret < 0)
+				hid_warn(hdev,
+					 "Error cancelling transaction: %d\n",
+					 ret);
 
-	ret = cp2112_read(dev, msgs->buf, msgs->len);
-	if (ret < 0)
-		goto power_normal;
-	if (ret != msgs->len) {
-		hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
-		ret = -EIO;
-		goto power_normal;
+			ret = -ETIMEDOUT;
+			goto power_normal;
+		}
+
+		if (!(m->flags & I2C_M_RD))
+			continue;
+
+		for (count = 0; count < m->len;) {
+			ret = cp2112_read(dev, m->buf + count, m->len - count);
+			if (ret < 0)
+				goto power_normal;
+			count += ret;
+			if (count > m->len) {
+				hid_warn(hdev, "long read: %d > %zd\n",
+					 ret, m->len - count + ret);
+			}
+		}
 	}
 
-finish:
 	/* return the number of transferred messages */
-	ret = 1;
+	ret = num;
 
 power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
-- 
1.7.10.4
