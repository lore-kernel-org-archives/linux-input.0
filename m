From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: silead: Add support for capactive home button found on some x86 tablets
Date: Thu, 15 Jun 2017 08:54:54 +0200
Message-ID: <20170615065454.15835-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbdFOGy4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 02:54:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On some x86 tablets with a silead touchscreen the windows logo on the
front is a capacitive home button. Touching this button results in a touch
with bits 12-15 of the Y coordinates set, while normally only the lower 12
are used.

Detect this and report a KEY_LEFTMETA press when this happens. Note for
now we only respond to the Y coordinate bits 12-15 containing 0x01, on some
tablets *without* a capacative button I've noticed these bits containing
0x04 when crossing the edges of the screen.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 45 ++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 52c878a20a92..30fba3cbe277 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -57,7 +57,7 @@
 #define SILEAD_POINT_Y_MSB_OFF	0x01
 #define SILEAD_POINT_X_OFF	0x02
 #define SILEAD_POINT_X_MSB_OFF	0x03
-#define SILEAD_TOUCH_ID_MASK	0xF0
+#define SILEAD_EXTRA_DATA_MASK	0xF0
 
 #define SILEAD_CMD_SLEEP_MIN	10000
 #define SILEAD_CMD_SLEEP_MAX	20000
@@ -110,6 +110,8 @@ static int silead_ts_request_input_dev(struct silead_ts_data *data)
 			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED |
 			    INPUT_MT_TRACK);
 
+	input_set_capability(data->input, EV_KEY, KEY_LEFTMETA);
+
 	data->input->name = SILEAD_TS_NAME;
 	data->input->phys = "input/ts";
 	data->input->id.bustype = BUS_I2C;
@@ -140,7 +142,8 @@ static void silead_ts_read_data(struct i2c_client *client)
 	struct input_dev *input = data->input;
 	struct device *dev = &client->dev;
 	u8 *bufp, buf[SILEAD_TS_DATA_LEN];
-	int touch_nr, error, i;
+	int touch_nr, softbutton, error, i;
+	bool softbutton_pressed = false;
 
 	error = i2c_smbus_read_i2c_block_data(client, SILEAD_REG_DATA,
 					      SILEAD_TS_DATA_LEN, buf);
@@ -149,21 +152,40 @@ static void silead_ts_read_data(struct i2c_client *client)
 		return;
 	}
 
-	touch_nr = buf[0];
-	if (touch_nr > data->max_fingers) {
+	if (buf[0] > data->max_fingers) {
 		dev_warn(dev, "More touches reported then supported %d > %d\n",
-			 touch_nr, data->max_fingers);
-		touch_nr = data->max_fingers;
+			 buf[0], data->max_fingers);
+		buf[0] = data->max_fingers;
 	}
 
+	touch_nr = 0;
 	bufp = buf + SILEAD_POINT_DATA_LEN;
-	for (i = 0; i < touch_nr; i++, bufp += SILEAD_POINT_DATA_LEN) {
-		/* Bits 4-7 are the touch id */
-		data->id[i] = (bufp[SILEAD_POINT_X_MSB_OFF] &
-			       SILEAD_TOUCH_ID_MASK) >> 4;
-		touchscreen_set_mt_pos(&data->pos[i], &data->prop,
+	for (i = 0; i < buf[0]; i++, bufp += SILEAD_POINT_DATA_LEN) {
+		softbutton = (bufp[SILEAD_POINT_Y_MSB_OFF] &
+			      SILEAD_EXTRA_DATA_MASK) >> 4;
+
+		if (softbutton) {
+			/*
+			 * For now only respond to softbutton == 0x01, some
+			 * tablets *without* a capacative button send 0x04
+			 * when crossing the edges of the screen.
+			 */
+			if (softbutton == 0x01)
+				softbutton_pressed = true;
+
+			continue;
+		}
+
+		/*
+		 * Bits 4-7 are the touch id, note not all models have
+		 * hardware touch ids so atm we don't use these.
+		 */
+		data->id[touch_nr] = (bufp[SILEAD_POINT_X_MSB_OFF] &
+				      SILEAD_EXTRA_DATA_MASK) >> 4;
+		touchscreen_set_mt_pos(&data->pos[touch_nr], &data->prop,
 			get_unaligned_le16(&bufp[SILEAD_POINT_X_OFF]) & 0xfff,
 			get_unaligned_le16(&bufp[SILEAD_POINT_Y_OFF]) & 0xfff);
+		touch_nr++;
 	}
 
 	input_mt_assign_slots(input, data->slots, data->pos, touch_nr, 0);
@@ -179,6 +201,7 @@ static void silead_ts_read_data(struct i2c_client *client)
 	}
 
 	input_mt_sync_frame(input);
+	input_report_key(input, KEY_LEFTMETA, softbutton_pressed);
 	input_sync(input);
 }
 
-- 
2.13.0

