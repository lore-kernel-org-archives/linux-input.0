From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2] HID: support i2c write-read and large transfers in hid-cp2112
Date: Sat, 13 Jun 2015 01:26:30 -0700
Message-ID: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

cp2112_i2c_xfer() only supports a single i2c_msg and only
reads up to 61 bytes.  More than one message at a time
and longers reads just return errors.  This breaks certain
important cases.  For example, the at24 eeprom driver generates
paired write and read messages (for eeprom address and data).
And the reads can be larger than 61 bytes.

Since the device doesn't support i2c repeated starts in general,
but does support a single write-repeated-start-read pair
(as CP2112_DATA_WRITE_READ_REQUEST), we recognize the latter
case and implement only that.

To support large reads, we wrap a loop around cp2112_read()
to pick up all the returned data.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
As Antonio Borneo and I discussed previously, this is the updated
patch that preserves the repeated start semantics (by not incorrectly
implementing cases that don't work).

Thank you for your time!
---
 drivers/hid/hid-cp2112.c |   79 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..2c10a45 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -444,6 +444,24 @@ static int cp2112_i2c_write_req(void *buf, u8 slave_address, u8 *data,
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
@@ -451,26 +469,45 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
+	} else if (num == 2 &&
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
@@ -506,21 +543,19 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		goto power_normal;
 	}
 
-	if (!(msgs->flags & I2C_M_RD))
-		goto finish;
-
-	ret = cp2112_read(dev, msgs->buf, msgs->len);
-	if (ret < 0)
-		goto power_normal;
-	if (ret != msgs->len) {
-		hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
-		ret = -EIO;
-		goto power_normal;
+	for (count = 0; count < read_length;) {
+		ret = cp2112_read(dev, read_buf + count, read_length - count);
+		if (ret < 0)
+			goto power_normal;
+		count += ret;
+		if (count > read_length) {
+			hid_warn(hdev, "long read: %d > %zd\n",
+				 ret, read_length - count + ret);
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
