From: Eudean Sun <eudean@arista.com>
Subject: [PATCH v2] HID: cp2112: Fix I2C_BLOCK_DATA transactions
Date: Tue, 21 Nov 2017 10:43:24 -0800
Message-ID: <20171121184324.GA7204@mail.arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The existing driver erroneously treats I2C_BLOCK_DATA and BLOCK_DATA
commands the same.

For I2C_BLOCK_DATA reads, the length of the read is provided in
data->block[0], but the length itself should not be sent to the slave. In
contrast, for BLOCK_DATA reads no length is specified since the length
will be the first byte returned from the slave. When copying data back
to the data buffer, for an I2C_BLOCK_DATA read we have to take care not to
overwrite data->block[0] to avoid overwriting the length. A BLOCK_DATA
read doesn't have this concern since the first byte returned by the device
is the length and belongs in data->block[0].

For I2C_BLOCK_DATA writes, the length is also provided in data->block[0],
but the length itself is not sent to the slave (in contrast to BLOCK_DATA
writes where the length prefixes the data sent to the slave).

This was tested on physical hardware using i2cdump with the i and s flags
to test the behavior of I2C_BLOCK_DATA reads and BLOCK_DATA reads,
respectively. Writes were not tested but the I2C_BLOCK_DATA write change
is pretty simple to verify by inspection.

Signed-off-by: Eudean Sun <eudean@arista.com>
---
Changes in v2:
  - Explain the fix and testing in more detail in the commit message.
---
 drivers/hid/hid-cp2112.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 078026f..0adece2 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -692,8 +692,16 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 					      (u8 *)&word, 2);
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-		size = I2C_SMBUS_BLOCK_DATA;
-		/* fallthrough */
+		if (read_write == I2C_SMBUS_READ) {
+			read_length = data->block[0];
+			count = cp2112_write_read_req(buf, addr, read_length,
+						      command, NULL, 0);
+		} else {
+			count = cp2112_write_req(buf, addr, command,
+						 data->block + 1,
+						 data->block[0]);
+		}
+		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (I2C_SMBUS_READ == read_write) {
 			count = cp2112_write_read_req(buf, addr,
@@ -781,6 +789,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 	case I2C_SMBUS_WORD_DATA:
 		data->word = le16_to_cpup((__le16 *)buf);
 		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		memcpy(data->block + 1, buf, read_length);
+		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_length > I2C_SMBUS_BLOCK_MAX) {
 			ret = -EPROTO;
-- 
2.7.4
