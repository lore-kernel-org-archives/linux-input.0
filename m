From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 2/8] Input: mms114 - get read of custm i2c read/write
 functions
Date: Mon, 29 Jan 2018 20:33:17 +0900
Message-ID: <20180129113323.18961-3-andi.shyti@samsung.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p1851ecb668e26bee1a09d162b4fe42225@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180129113323.18961-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

The 'mms114_read_reg' and 'mms114_write_reg' are used when
reading or writing to the 'MMS114_MODE_CONTROL' register for
updating the 'cache_mode_control' variable.

Update the 'cache_mode_control' variable in the calling
mms114_set_active() function and get rid of all the custom i2c
read/write functions.

With this remove also the redundant sleep of MMS114_I2C_DELAY
(50us) between i2c operations. The waiting should to be handled
by the i2c driver.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 87 +++++---------------------------------
 1 file changed, 10 insertions(+), 77 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 0b8b1f0e8ba6..94a97049d711 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -37,9 +37,6 @@
 #define MMS152_FW_REV			0xE1
 #define MMS152_COMPAT_GROUP		0xF2
 
-/* Minimum delay time is 50us between stop and start signal of i2c */
-#define MMS114_I2C_DELAY		50
-
 /* 200ms needs after power on */
 #define MMS114_POWERON_DELAY		200
 
@@ -83,76 +80,6 @@ struct mms114_touch {
 	u8 reserved[2];
 } __packed;
 
-static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
-			     unsigned int len, u8 *val)
-{
-	struct i2c_client *client = data->client;
-	struct i2c_msg xfer[2];
-	u8 buf = reg & 0xff;
-	int error;
-
-	if (reg <= MMS114_MODE_CONTROL && reg + len > MMS114_MODE_CONTROL)
-		BUG();
-
-	/* Write register: use repeated start */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = I2C_M_TEN | I2C_M_NOSTART;
-	xfer[0].len = 1;
-	xfer[0].buf = &buf;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = len;
-	xfer[1].buf = val;
-
-	error = i2c_transfer(client->adapter, xfer, 2);
-	if (error != 2) {
-		dev_err(&client->dev,
-			"%s: i2c transfer failed (%d)\n", __func__, error);
-		return error < 0 ? error : -EIO;
-	}
-	udelay(MMS114_I2C_DELAY);
-
-	return 0;
-}
-
-static int mms114_read_reg(struct mms114_data *data, unsigned int reg)
-{
-	u8 val;
-	int error;
-
-	if (reg == MMS114_MODE_CONTROL)
-		return data->cache_mode_control;
-
-	error = __mms114_read_reg(data, reg, 1, &val);
-	return error < 0 ? error : val;
-}
-
-static int mms114_write_reg(struct mms114_data *data, unsigned int reg,
-			    unsigned int val)
-{
-	struct i2c_client *client = data->client;
-	u8 buf[2];
-	int error;
-
-	buf[0] = reg & 0xff;
-	buf[1] = val & 0xff;
-
-	error = i2c_master_send(client, buf, 2);
-	if (error != 2) {
-		dev_err(&client->dev,
-			"%s: i2c send failed (%d)\n", __func__, error);
-		return error < 0 ? error : -EIO;
-	}
-	udelay(MMS114_I2C_DELAY);
-
-	if (reg == MMS114_MODE_CONTROL)
-		data->cache_mode_control = val;
-
-	return 0;
-}
-
 static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
 {
 	struct i2c_client *client = data->client;
@@ -231,19 +158,25 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 static int mms114_set_active(struct mms114_data *data, bool active)
 {
-	int val;
+	int val, err;
 
-	val = mms114_read_reg(data, MMS114_MODE_CONTROL);
+	val = i2c_smbus_read_byte_data(data->client, MMS114_MODE_CONTROL);
 	if (val < 0)
 		return val;
 
-	val &= ~MMS114_OPERATION_MODE_MASK;
+	val = data->cache_mode_control &= ~MMS114_OPERATION_MODE_MASK;
 
 	/* If active is false, sleep mode */
 	if (active)
 		val |= MMS114_ACTIVE;
 
-	return mms114_write_reg(data, MMS114_MODE_CONTROL, val);
+	err = i2c_smbus_write_byte_data(data->client, MMS114_MODE_CONTROL, val);
+	if (err < 0)
+		return err;
+
+	data->cache_mode_control = val;
+
+	return 0;
 }
 
 static int mms114_get_version(struct mms114_data *data)
-- 
2.15.1
