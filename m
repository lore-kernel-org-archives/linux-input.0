From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 7/8] Input: synaptics-rmi4: Handle incomplete input data
Date: Fri, 24 Jun 2016 17:19:34 -0700
Message-ID: <1466813974-16036-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Commit 5b65c2a02966 ("HID: rmi: check sanity of the incoming report") added
support for handling incomplete HID reports do to the input data being
corrupted in transit. This patch reimplements this functionality in the
function drivers so they can handle getting less valid data then they
expect.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 54 ++++++++++++++++++++++++++++++++------------
 drivers/input/rmi4/rmi_f12.c | 23 ++++++++++++++-----
 drivers/input/rmi4/rmi_f30.c |  4 ++++
 3 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 688e604..3fda75b 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -572,31 +572,48 @@ static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
 
 static void rmi_f11_finger_handler(struct f11_data *f11,
 				   struct rmi_2d_sensor *sensor,
-				   unsigned long *irq_bits, int num_irq_regs)
+				   unsigned long *irq_bits, int num_irq_regs,
+				   int size)
 {
 	const u8 *f_state = f11->data.f_state;
 	u8 finger_state;
 	u8 i;
+	int abs_fingers;
+	int rel_fingers;
+	int abs_size = sensor->nbr_fingers * RMI_F11_ABS_BYTES;
 
 	int abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
 				  num_irq_regs * 8);
 	int rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
 				  num_irq_regs * 8);
 
-	for (i = 0; i < sensor->nbr_fingers; i++) {
-		/* Possible of having 4 fingers per f_statet register */
-		finger_state = rmi_f11_parse_finger_state(f_state, i);
-		if (finger_state == F11_RESERVED) {
-			pr_err("Invalid finger state[%d]: 0x%02x", i,
-				finger_state);
-			continue;
-		}
+	if (abs_bits) {
+		if (abs_size > size)
+			abs_fingers = size / RMI_F11_ABS_BYTES;
+		else
+			abs_fingers = sensor->nbr_fingers;
+
+		for (i = 0; i < abs_fingers; i++) {
+			/* Possible of having 4 fingers per f_state register */
+			finger_state = rmi_f11_parse_finger_state(f_state, i);
+			if (finger_state == F11_RESERVED) {
+				pr_err("Invalid finger state[%d]: 0x%02x", i,
+					finger_state);
+				continue;
+			}
 
-		if (abs_bits)
 			rmi_f11_abs_pos_process(f11, sensor, &sensor->objs[i],
 							finger_state, i);
+		}
+	}
+
+	if (rel_bits) {
+		if ((abs_size + sensor->nbr_fingers * RMI_F11_REL_BYTES) > size)
+			rel_fingers = (size - abs_size) / RMI_F11_REL_BYTES;
+		else
+			rel_fingers = sensor->nbr_fingers;
 
-		if (rel_bits)
+		for (i = 0; i < rel_fingers; i++)
 			rmi_f11_rel_pos_report(f11, i);
 	}
 
@@ -612,7 +629,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 					      sensor->nbr_fingers,
 					      sensor->dmax);
 
-		for (i = 0; i < sensor->nbr_fingers; i++) {
+		for (i = 0; i < abs_fingers; i++) {
 			finger_state = rmi_f11_parse_finger_state(f_state, i);
 			if (finger_state == F11_RESERVED)
 				/* no need to send twice the error */
@@ -1266,10 +1283,19 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	u16 data_base_addr = fn->fd.data_base_addr;
 	int error;
+	int valid_bytes = f11->sensor.pkt_size;
 
 	if (rmi_dev->xport->attn_data) {
+		/*
+		 * The valid data in the attention report is less then
+		 * expected. Only process the complete fingers.
+		 */
+		if (f11->sensor.attn_size > rmi_dev->xport->attn_size)
+			valid_bytes = rmi_dev->xport->attn_size;
+		else
+			valid_bytes = f11->sensor.attn_size;
 		memcpy(f11->sensor.data_pkt, rmi_dev->xport->attn_data,
-			f11->sensor.attn_size);
+			valid_bytes);
 		rmi_dev->xport->attn_data += f11->sensor.attn_size;
 		rmi_dev->xport->attn_size -= f11->sensor.attn_size;
 	} else {
@@ -1281,7 +1307,7 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	}
 
 	rmi_f11_finger_handler(f11, &f11->sensor, irq_bits,
-				drvdata->num_of_irq_regs);
+				drvdata->num_of_irq_regs, valid_bytes);
 
 	return 0;
 }
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 7d66766..c30fd86 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -26,6 +26,8 @@ enum rmi_f12_object_type {
 	RMI_F12_OBJECT_SMALL_OBJECT		= 0x0D,
 };
 
+#define F12_DATA1_BYTES_PER_OBJ			8
+
 struct f12_data {
 	struct rmi_2d_sensor sensor;
 	struct rmi_2d_sensor_platform_data sensor_pdata;
@@ -146,12 +148,16 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	return 0;
 }
 
-static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1)
+static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, int size)
 {
 	int i;
 	struct rmi_2d_sensor *sensor = &f12->sensor;
+	int objects = f12->data1->num_subpackets;
+
+	if ((f12->data1->num_subpackets * F12_DATA1_BYTES_PER_OBJ) > size)
+		objects = size / F12_DATA1_BYTES_PER_OBJ;
 
-	for (i = 0; i < f12->data1->num_subpackets; i++) {
+	for (i = 0; i < objects; i++) {
 		struct rmi_2d_sensor_abs_object *obj = &sensor->objs[i];
 
 		obj->type = RMI_2D_OBJECT_NONE;
@@ -182,7 +188,7 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1)
 
 		rmi_2d_sensor_abs_process(sensor, obj, i);
 
-		data1 += 8;
+		data1 += F12_DATA1_BYTES_PER_OBJ;
 	}
 
 	if (sensor->kernel_tracking)
@@ -192,7 +198,7 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1)
 				      sensor->nbr_fingers,
 				      sensor->dmax);
 
-	for (i = 0; i < sensor->nbr_fingers; i++)
+	for (i = 0; i < objects; i++)
 		rmi_2d_sensor_abs_report(sensor, &sensor->objs[i], i);
 }
 
@@ -203,10 +209,15 @@ static int rmi_f12_attention(struct rmi_function *fn,
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
 	struct rmi_2d_sensor *sensor = &f12->sensor;
+	int valid_bytes = sensor->pkt_size;
 
 	if (rmi_dev->xport->attn_data) {
+		if (sensor->attn_size > rmi_dev->xport->attn_size)
+			valid_bytes = rmi_dev->xport->attn_size;
+		else
+			valid_bytes = sensor->attn_size;
 		memcpy(sensor->data_pkt, rmi_dev->xport->attn_data,
-			sensor->attn_size);
+			valid_bytes);
 		rmi_dev->xport->attn_data += sensor->attn_size;
 		rmi_dev->xport->attn_size -= sensor->attn_size;
 	} else {
@@ -221,7 +232,7 @@ static int rmi_f12_attention(struct rmi_function *fn,
 
 	if (f12->data1)
 		rmi_f12_process_objects(f12,
-			&sensor->data_pkt[f12->data1_offset]);
+			&sensor->data_pkt[f12->data1_offset], valid_bytes);
 
 	input_mt_sync_frame(sensor->input);
 
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 760aff1..485907f 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -110,6 +110,10 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 
 	/* Read the gpi led data. */
 	if (rmi_dev->xport->attn_data) {
+		if (rmi_dev->xport->attn_size < f30->register_count) {
+			dev_warn(&fn->dev, "F30 interrupted, but data is missing\n");
+			return 0;
+		}
 		memcpy(f30->data_regs, rmi_dev->xport->attn_data,
 			f30->register_count);
 		rmi_dev->xport->attn_data += f30->register_count;
-- 
2.5.0
