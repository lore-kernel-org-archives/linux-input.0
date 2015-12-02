From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 1/8] Input: atmel_mxt_ts - improve touchscreen size/orientation handling
Date: Wed,  2 Dec 2015 20:42:24 +0000
Message-ID: <1449088951-7069-2-git-send-email-nick.dyer@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Both T100 and T9 handle range and orientation in a similar fashion.
Reduce duplication between the two implementations.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 68 ++++++++++++--------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c562205..4a1d218 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -113,8 +113,8 @@ struct t7_config {
 #define MXT_T9_DETECT		(1 << 7)
 
 struct t9_range {
-	u16 x;
-	u16 y;
+	__le16 x;
+	__le16 y;
 } __packed;
 
 /* MXT_TOUCH_MULTI_T9 orient */
@@ -216,6 +216,7 @@ struct mxt_data {
 	unsigned int irq;
 	unsigned int max_x;
 	unsigned int max_y;
+	bool xy_switch;
 	bool in_bootloader;
 	u16 mem_size;
 	u8 t100_aux_ampl;
@@ -1665,8 +1666,8 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 	if (error)
 		return error;
 
-	le16_to_cpus(&range.x);
-	le16_to_cpus(&range.y);
+	data->max_x = get_unaligned_le16(&range.x);
+	data->max_y = get_unaligned_le16(&range.y);
 
 	error =  __mxt_read_reg(client,
 				object->start_address + MXT_T9_ORIENT,
@@ -1674,23 +1675,7 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 	if (error)
 		return error;
 
-	/* Handle default values */
-	if (range.x == 0)
-		range.x = 1023;
-
-	if (range.y == 0)
-		range.y = 1023;
-
-	if (orient & MXT_T9_ORIENT_SWITCH) {
-		data->max_x = range.y;
-		data->max_y = range.x;
-	} else {
-		data->max_x = range.x;
-		data->max_y = range.y;
-	}
-
-	dev_dbg(&client->dev,
-		"Touchscreen size X%uY%u\n", data->max_x, data->max_y);
+	data->xy_switch = orient & MXT_T9_ORIENT_SWITCH;
 
 	return 0;
 }
@@ -1708,13 +1693,14 @@ static int mxt_read_t100_config(struct mxt_data *data)
 	if (!object)
 		return -EINVAL;
 
+	/* read touchscreen dimensions */
 	error = __mxt_read_reg(client,
 			       object->start_address + MXT_T100_XRANGE,
 			       sizeof(range_x), &range_x);
 	if (error)
 		return error;
 
-	le16_to_cpus(&range_x);
+	data->max_x = get_unaligned_le16(&range_x);
 
 	error = __mxt_read_reg(client,
 			       object->start_address + MXT_T100_YRANGE,
@@ -1722,36 +1708,24 @@ static int mxt_read_t100_config(struct mxt_data *data)
 	if (error)
 		return error;
 
-	le16_to_cpus(&range_y);
+	data->max_y = get_unaligned_le16(&range_y);
 
+	/* read orientation config */
 	error =  __mxt_read_reg(client,
 				object->start_address + MXT_T100_CFG1,
 				1, &cfg);
 	if (error)
 		return error;
 
+	data->xy_switch = cfg & MXT_T100_CFG_SWITCHXY;
+
+	/* allocate aux bytes */
 	error =  __mxt_read_reg(client,
 				object->start_address + MXT_T100_TCHAUX,
 				1, &tchaux);
 	if (error)
 		return error;
 
-	/* Handle default values */
-	if (range_x == 0)
-		range_x = 1023;
-
-	if (range_y == 0)
-		range_y = 1023;
-
-	if (cfg & MXT_T100_CFG_SWITCHXY) {
-		data->max_x = range_y;
-		data->max_y = range_x;
-	} else {
-		data->max_x = range_x;
-		data->max_y = range_y;
-	}
-
-	/* allocate aux bytes */
 	aux = 6;
 
 	if (tchaux & MXT_T100_TCHAUX_VECT)
@@ -1767,9 +1741,6 @@ static int mxt_read_t100_config(struct mxt_data *data)
 		"T100 aux mappings vect:%u ampl:%u area:%u\n",
 		data->t100_aux_vect, data->t100_aux_ampl, data->t100_aux_area);
 
-	dev_info(&client->dev,
-		 "T100 Touchscreen size X%uY%u\n", data->max_x, data->max_y);
-
 	return 0;
 }
 
@@ -1828,6 +1799,19 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 		return -EINVAL;
 	}
 
+	/* Handle default values and orientation switch */
+	if (data->max_x == 0)
+		data->max_x = 1023;
+
+	if (data->max_y == 0)
+		data->max_y = 1023;
+
+	if (data->xy_switch)
+		swap(data->max_x, data->max_y);
+
+	dev_info(dev, "Touchscreen size X%uY%u\n", data->max_x, data->max_y);
+
+	/* Register input device */
 	input_dev = input_allocate_device();
 	if (!input_dev) {
 		dev_err(dev, "Failed to allocate memory\n");
-- 
2.5.0
