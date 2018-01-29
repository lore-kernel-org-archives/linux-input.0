From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 1/8] Input: mms114 - use smbus functions whenever possible
Date: Mon, 29 Jan 2018 20:33:16 +0900
Message-ID: <20180129113323.18961-2-andi.shyti@samsung.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113330epcas2p436609515afc0c89504791908ae49059a@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180129113323.18961-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

The exchange of data to and from the mms114 touchscreen never
exceeds 256 bytes. In the worst case it goes up to 80 bytes in
the interrupt handler while reading the events.

Thus it's not needed to make use of custom read/write functions
for accessing the i2c. Replace, whenever possible, the use of
custom functions with the more standard smbus ones.

It's not possible only in one case, in the mms114_set_active()
function where the 'cache_mode_control' variable is updated
according to the value in the register 'MMS114_MODE_CONTROL'
register.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index c54f4afe1103..0b8b1f0e8ba6 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -207,14 +207,15 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	}
 	mutex_unlock(&input_dev->mutex);
 
-	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
+	packet_size = i2c_smbus_read_byte_data(data->client,
+					       MMS114_PACKET_SIZE);
 	if (packet_size <= 0)
 		goto out;
 
 	touch_size = packet_size / MMS114_PACKET_NUM;
 
-	error = __mms114_read_reg(data, MMS114_INFOMATION, packet_size,
-			(u8 *)touch);
+	error = i2c_smbus_read_i2c_block_data(data->client, MMS114_INFOMATION,
+					      packet_size, (u8 *)touch);
 	if (error < 0)
 		goto out;
 
@@ -254,7 +255,8 @@ static int mms114_get_version(struct mms114_data *data)
 
 	switch (data->type) {
 	case TYPE_MMS152:
-		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+		error = i2c_smbus_read_i2c_block_data(data->client,
+						      MMS152_FW_REV, 3, buf);
 		if (error)
 			return error;
 
@@ -268,7 +270,8 @@ static int mms114_get_version(struct mms114_data *data)
 		break;
 
 	case TYPE_MMS114:
-		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
+		error = i2c_smbus_read_i2c_block_data(data->client,
+						      MMS114_TSP_REV, 6, buf);
 		if (error)
 			return error;
 
@@ -300,30 +303,35 @@ static int mms114_setup_regs(struct mms114_data *data)
 
 	val = (props->max_x >> 8) & 0xf;
 	val |= ((props->max_y >> 8) & 0xf) << 4;
-	error = mms114_write_reg(data, MMS114_XY_RESOLUTION_H, val);
+	error = i2c_smbus_write_byte_data(data->client,
+					  MMS114_XY_RESOLUTION_H, val);
 	if (error < 0)
 		return error;
 
 	val = props->max_x & 0xff;
-	error = mms114_write_reg(data, MMS114_X_RESOLUTION, val);
+	error = i2c_smbus_write_byte_data(data->client,
+					  MMS114_X_RESOLUTION, val);
 	if (error < 0)
 		return error;
 
 	val = props->max_x & 0xff;
-	error = mms114_write_reg(data, MMS114_Y_RESOLUTION, val);
+	error = i2c_smbus_write_byte_data(data->client,
+					  MMS114_Y_RESOLUTION, val);
 	if (error < 0)
 		return error;
 
 	if (data->contact_threshold) {
-		error = mms114_write_reg(data, MMS114_CONTACT_THRESHOLD,
-				data->contact_threshold);
+		error = i2c_smbus_write_byte_data(data->client,
+						  MMS114_CONTACT_THRESHOLD,
+						  data->contact_threshold);
 		if (error < 0)
 			return error;
 	}
 
 	if (data->moving_threshold) {
-		error = mms114_write_reg(data, MMS114_MOVING_THRESHOLD,
-				data->moving_threshold);
+		error = i2c_smbus_write_byte_data(data->client,
+						  MMS114_MOVING_THRESHOLD,
+						  data->moving_threshold);
 		if (error < 0)
 			return error;
 	}
-- 
2.15.1
