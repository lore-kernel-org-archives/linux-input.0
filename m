From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1] HID: cp2112: support i2c write-read transfers in hid-cp2112
Date: Thu, 18 Jun 2015 02:55:40 -0700
Message-ID: <1434621340-10422-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

cp2112_i2c_xfer() only supports a single i2c_msg.  More than
one message at a time just returns EIO.  This breaks certain
important cases.  For example, the at24 eeprom driver generates
paired write and read messages (for eeprom address and data).

Since the device doesn't support i2c repeated starts in general,
but does support a single write-repeated-start-read pair
(since hardware rev 1), we recognize the latter case and
implement only that.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
 drivers/hid/hid-cp2112.c |   74 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 5a72819..00d062a 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -153,6 +153,7 @@ MODULE_DEVICE_TABLE(hid, cp2112_devices);
 struct cp2112_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+	int hwversion;
 	wait_queue_head_t wait;
 	u8 read_data[61];
 	u8 read_length;
@@ -444,6 +445,24 @@ static int cp2112_i2c_write_req(void *buf, u8 slave_address, u8 *data,
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
@@ -451,26 +470,46 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[64];
 	ssize_t count;
+	ssize_t read_length = 0;
+	u8 *read_buf = NULL;
 	unsigned int retries;
 	int ret;
 
 	hid_dbg(hdev, "I2C %d messages\n", num);
 
-	if (num != 1) {
+	if (num == 1) {
+		if (msgs->flags & I2C_M_RD) {
+			hid_dbg(hdev, "I2C read %#04x len %d\n",
+				msgs->addr, msgs->len);
+			read_length = msgs->len;
+			read_buf = msgs->buf;
+			count = cp2112_read_req(buf, msgs->addr, msgs->len);
+		} else {
+			hid_dbg(hdev, "I2C write %#04x len %d\n",
+				msgs->addr, msgs->len);
+			count = cp2112_i2c_write_req(buf, msgs->addr,
+						     msgs->buf, msgs->len);
+		}
+		if (count < 0)
+			return count;
+	} else if (dev->hwversion > 1 &&  /* no repeated start in rev 1 */
+		   num == 2 &&
+		   msgs[0].addr == msgs[1].addr &&
+		   !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD)) {
+		hid_dbg(hdev, "I2C write-read %#04x wlen %d rlen %d\n",
+			msgs[0].addr, msgs[0].len, msgs[1].len);
+		read_length = msgs[1].len;
+		read_buf = msgs[1].buf;
+		count = cp2112_i2c_write_read_req(buf, msgs[0].addr,
+				msgs[0].buf, msgs[0].len, msgs[1].len);
+		if (count < 0)
+			return count;
+	} else {
 		hid_err(hdev,
 			"Multi-message I2C transactions not supported\n");
 		return -EOPNOTSUPP;
 	}
 
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
@@ -506,15 +545,12 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		goto power_normal;
 	}
 
-	if (!(msgs->flags & I2C_M_RD))
-		goto finish;
-
-	for (count = 0; count < msgs->len;) {
-		ret = cp2112_read(dev, msgs->buf + count, msgs->len - count);
+	for (count = 0; count < read_length;) {
+		ret = cp2112_read(dev, read_buf + count, read_length - count);
 		if (ret < 0)
 			goto power_normal;
 		count += ret;
-		if (count > msgs->len) {
+		if (count > read_length) {
 			/*
 			 * The hardware returned too much data.
 			 * This is mostly harmless because cp2112_read()
@@ -524,15 +560,14 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			 * it shouldn't go unnoticed.
 			 */
 			hid_err(hdev, "long read: %d > %zd\n",
-				ret, msgs->len - count + ret);
+				ret, read_length - count + ret);
 			ret = -EIO;
 			goto power_normal;
 		}
 	}
 
-finish:
 	/* return the number of transferred messages */
-	ret = 1;
+	ret = num;
 
 power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
@@ -1040,6 +1075,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.dev.parent	= &hdev->dev;
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
 		 "CP2112 SMBus Bridge on hiddev%d", hdev->minor);
+	dev->hwversion = buf[2];
 	init_waitqueue_head(&dev->wait);
 
 	hid_device_io_start(hdev);
-- 
1.7.10.4
