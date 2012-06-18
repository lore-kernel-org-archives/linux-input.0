From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 11/22 v4] Input: atmel_mxt_ts - add variable length __mxt_write_reg
Date: Mon, 18 Jun 2012 12:08:31 +0800
Message-ID: <1339992522-22073-12-git-send-email-djkurtz@chromium.org>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

The i2c bus requires 4 bytes to do a 1-byte write
(1 byte i2c address + 2 byte offset + 1 byte data).

By taking a length with writes, the driver can amortize transaction
overhead by performing larger transactions where appropriate.

This patch just sets up the new API.  Later patches refactor writes
to take advantage of the larger transactions.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1ef3aef..2e49488 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -430,17 +430,24 @@ static int mxt_read_reg(struct i2c_client *client, u16 reg, u8 *val)
 	return __mxt_read_reg(client, reg, 1, val);
 }
 
-static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
+static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
+			   const void *val)
 {
-	u8 buf[3];
+	u8 *buf;
+	size_t count;
 	int ret;
 
+	count = len + 2;
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	buf[0] = reg & 0xff;
 	buf[1] = (reg >> 8) & 0xff;
-	buf[2] = val;
+	memcpy(&buf[2], val, len);
 
-	ret = i2c_master_send(client, buf, 3);
-	if (ret == 3) {
+	ret = i2c_master_send(client, buf, count);
+	if (ret == count) {
 		ret = 0;
 	} else {
 		if (ret >= 0)
@@ -452,6 +459,11 @@ static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
 	return ret;
 }
 
+static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
+{
+	return __mxt_write_reg(client, reg, 1, &val);
+}
+
 static int mxt_read_object_table(struct i2c_client *client,
 				      u16 reg, u8 *object_buf)
 {
-- 
1.7.7.3
