From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 28/63] Input: atmel_mxt_ts - implement I2C retries
Date: Fri, 16 Aug 2019 17:33:40 +0900
Message-ID: <20190816083415.18819-4-jiada_wang@mentor.com>
References: <20190816083415.18819-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083415.18819-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Some maXTouch chips (eg mXT1386) will not respond on the first I2C request
when they are in a sleep state. It must be retried after a delay for the
chip to wake up.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Yufeng Shen <miletus@chromium.org>
(cherry picked from ndyer/linux/for-upstream commit 63fd7a2cd03c3a572a5db39c52f4856819e1835d)
[gdavis: Forward port and fix conflicts.]
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 45 ++++++++++++++++--------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d3e1cd677aa7..86c016dbec0d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -216,6 +216,7 @@ enum t100_type {
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
+#define MXT_WAKEUP_TIME		25	/* msec */
 #define MXT_REGULATOR_DELAY	150	/* msec */
 #define MXT_CHG_DELAY	        100	/* msec */
 #define MXT_POWERON_DELAY	150	/* msec */
@@ -723,6 +724,7 @@ static int __mxt_read_reg(struct i2c_client *client,
 	struct i2c_msg xfer[2];
 	u8 buf[2];
 	int ret;
+	bool retry = false;
 
 	buf[0] = reg & 0xff;
 	buf[1] = (reg >> 8) & 0xff;
@@ -739,17 +741,22 @@ static int __mxt_read_reg(struct i2c_client *client,
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
 
 static int mxt_read_blks(struct mxt_data *data, u16 start, u16 count, u8 *buf)
@@ -779,6 +786,7 @@ static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 	u8 *buf;
 	size_t count;
 	int ret;
+	bool retry = false;
 
 	count = len + 2;
 	buf = kmalloc(count, GFP_KERNEL);
@@ -789,14 +797,21 @@ static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 	buf[1] = (reg >> 8) & 0xff;
 	memcpy(&buf[2], val, len);
 
+retry_write:
 	ret = i2c_master_send(client, buf, count);
-	if (ret == count) {
-		ret = 0;
-	} else {
-		if (ret >= 0)
+	if (ret != count) {
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
+	} else {
+		ret = 0;
 	}
 
 	kfree(buf);
-- 
2.19.2
