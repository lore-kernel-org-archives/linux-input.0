From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 25/40] Input: atmel_mxt_ts - implement I2C retries
Date: Fri, 22 Feb 2013 17:58:12 +0000
Message-ID: <1361555907-19840-26-git-send-email-nick.dyer@itdev.co.uk>
References: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Some maXTouch chips will not respond on the first I2C request when they are in
a sleep state. It must be retried after a delay for the chip to wake up.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   39 +++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6ab7ef6..b0dcae4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -193,6 +193,7 @@ struct t9_range {
 #define MXT_RESET_TIME		200	/* msec */
 #define MXT_RESET_NOCHGREAD	400	/* msec */
 #define MXT_FWRESET_TIME	1000	/* msec */
+#define MXT_WAKEUP_TIME		25	/* msec */
 
 /* Command to unlock bootloader */
 #define MXT_UNLOCK_CMD_MSB	0xaa
@@ -503,6 +504,7 @@ static int __mxt_read_reg(struct i2c_client *client,
 	struct i2c_msg xfer[2];
 	u8 buf[2];
 	int ret;
+	bool retry = false;
 
 	buf[0] = reg & 0xff;
 	buf[1] = (reg >> 8) & 0xff;
@@ -519,17 +521,22 @@ static int __mxt_read_reg(struct i2c_client *client,
 	xfer[1].len = len;
 	xfer[1].buf = val;
 
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret == 2) {
-		ret = 0;
-	} else {
-		if (ret >= 0)
-			ret = -EIO;
-		dev_err(&client->dev, "%s: i2c transfer failed (%d)\n",
-			__func__, ret);
+retry_read:
+	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+	if (ret != ARRAY_SIZE(xfer)) {
+		if (!retry) {
+			dev_dbg(&client->dev, "%s: i2c retry\n", __func__);
+			msleep(MXT_WAKEUP_TIME);
+			retry = true;
+			goto retry_read;
+		} else {
+			dev_err(&client->dev, "%s: i2c transfer failed (%d)\n",
+				__func__, ret);
+			return -EIO;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
@@ -538,6 +545,7 @@ static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 	u8 *buf;
 	size_t count;
 	int ret;
+	bool retry = false;
 
 	count = len + 2;
 	buf = kmalloc(count, GFP_KERNEL);
@@ -548,14 +556,21 @@ static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 	buf[1] = (reg >> 8) & 0xff;
 	memcpy(&buf[2], val, len);
 
+retry_write:
 	ret = i2c_master_send(client, buf, count);
 	if (ret == count) {
 		ret = 0;
 	} else {
-		if (ret >= 0)
+		if (!retry) {
+			dev_dbg(&client->dev, "%s: i2c retry\n", __func__);
+			msleep(MXT_WAKEUP_TIME);
+			retry = true;
+			goto retry_write;
+		} else {
+			dev_err(&client->dev, "%s: i2c send failed (%d)\n",
+				__func__, ret);
 			ret = -EIO;
-		dev_err(&client->dev, "%s: i2c send failed (%d)\n",
-			__func__, ret);
+		}
 	}
 
 	kfree(buf);
-- 
1.7.10.4
