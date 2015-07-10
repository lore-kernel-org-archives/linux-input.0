From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1] HID: cp2112: fix byte order in SMBUS operations
Date: Thu,  9 Jul 2015 22:04:31 -0700
Message-ID: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

Change all occurrences of be16 to le16 in cp2112_xfer(),
because SMBUS words are little endian, not big endian.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
 drivers/hid/hid-cp2112.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 1d24a65..a3703b8 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -589,7 +589,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 	struct cp2112_device *dev = (struct cp2112_device *)adap->algo_data;
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[64];
-	__be16 word;
+	__le16 word;
 	ssize_t count;
 	size_t read_length = 0;
 	unsigned int retries;
@@ -621,7 +621,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		break;
 	case I2C_SMBUS_WORD_DATA:
 		read_length = 2;
-		word = cpu_to_be16(data->word);
+		word = cpu_to_le16(data->word);
 
 		if (I2C_SMBUS_READ == read_write)
 			count = cp2112_write_read_req(buf, addr, read_length,
@@ -634,7 +634,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		size = I2C_SMBUS_WORD_DATA;
 		read_write = I2C_SMBUS_READ;
 		read_length = 2;
-		word = cpu_to_be16(data->word);
+		word = cpu_to_le16(data->word);
 
 		count = cp2112_write_read_req(buf, addr, read_length, command,
 					      (u8 *)&word, 2);
@@ -727,7 +727,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		data->byte = buf[0];
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		data->word = be16_to_cpup((__be16 *)buf);
+		data->word = le16_to_cpup((__le16 *)buf);
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_length > I2C_SMBUS_BLOCK_MAX) {
-- 
1.9.1
