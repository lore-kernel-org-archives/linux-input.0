From: Eudean Sun <eudean@arista.com>
Subject: [PATCH] HID: cp2112: Fix I2C_BLOCK_DATA transactions
Date: Mon, 13 Nov 2017 16:03:59 -0800
Message-ID: <20171114000358.GA14433@mail.arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46374 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdKNAED (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 19:04:03 -0500
Received: by mail-qt0-f195.google.com with SMTP id 1so21824080qtn.3
        for <linux-input@vger.kernel.org>; Mon, 13 Nov 2017 16:04:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The existing driver erroneously treats I2C_BLOCK_DATA and BLOCK_DATA
commands the same. Fix the logic for I2C_BLOCK_DATA reads and writes.

Signed-off-by: Eudean Sun <eudean@arista.com>
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

