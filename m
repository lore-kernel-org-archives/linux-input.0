From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 4/7] Input: synaptics-rmi4: Add support for controlling dribble packets in F12
Date: Fri, 3 Jun 2016 11:40:40 -0700
Message-ID: <1464979240-2549-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Implements reading and setting the dribble bit in F12's control registers.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f12.c | 74 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8dd3fb5..041a91d 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -30,6 +30,7 @@ struct f12_data {
 	struct rmi_function *fn;
 	struct rmi_2d_sensor sensor;
 	struct rmi_2d_sensor_platform_data sensor_pdata;
+	bool has_dribble;
 
 	u16 data_addr;
 
@@ -228,12 +229,79 @@ static int rmi_f12_attention(struct rmi_function *fn,
 	return 0;
 }
 
+static int rmi_f12_write_control_regs(struct rmi_function *fn)
+{
+	int ret;
+	const struct rmi_register_desc_item *item;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
+	int control_size;
+	char buf[3];
+	u16 control_offset = 0;
+	u8 subpacket_offset = 0;
+
+	if (f12->has_dribble
+	    && (f12->sensor.dribble != RMI_REG_STATE_DEFAULT)) {
+		item = rmi_get_register_desc_item(&f12->control_reg_desc, 20);
+		if (item) {
+			control_offset = rmi_register_desc_calc_reg_offset(
+						&f12->control_reg_desc, 20);
+
+			/*
+			 * The byte containing the EnableDribble bit will be
+			 * in either byte 0 or byte 2 of control 20. Depending
+			 * on the existence of subpacket 0. If control 20 is
+			 * larger then 3 bytes, just read the first 3.
+			 */
+			if (item->reg_size >= 3)
+				control_size = 3;
+			else
+				control_size = item->reg_size;
+
+			ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr
+					+ control_offset, buf, control_size);
+			if (ret)
+				return ret;
+
+			if (rmi_register_desc_has_subpacket(item, 0))
+				subpacket_offset += 1;
+
+			switch (f12->sensor.dribble) {
+			case RMI_REG_STATE_OFF:
+				buf[subpacket_offset] &= ~BIT(2);
+				break;
+			case RMI_REG_STATE_ON:
+				buf[subpacket_offset] |= BIT(2);
+				break;
+			case RMI_REG_STATE_DEFAULT:
+			default:
+				break;
+			}
+
+			ret = rmi_write_block(rmi_dev,
+				fn->fd.control_base_addr + control_offset,
+				buf, control_size);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+
+}
+
 static int rmi_f12_config(struct rmi_function *fn)
 {
 	struct rmi_driver *drv = fn->rmi_dev->driver;
+	int ret;
 
 	drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
 
+	ret = rmi_f12_write_control_regs(fn);
+	if (ret)
+		dev_warn(&fn->dev,
+			"Failed to write F12 control registers: %d\n", ret);
+
 	return 0;
 }
 
@@ -260,16 +328,19 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	}
 	++query_addr;
 
-	if (!(buf & 0x1)) {
+	if (!(buf & BIT(0))) {
 		dev_err(&fn->dev,
 			"Behavior of F12 without register descriptors is undefined.\n");
 		return -ENODEV;
 	}
 
+
 	f12 = devm_kzalloc(&fn->dev, sizeof(struct f12_data), GFP_KERNEL);
 	if (!f12)
 		return -ENOMEM;
 
+	f12->has_dribble = !!(buf & BIT(3));
+
 	if (fn->dev.of_node) {
 		ret = rmi_2d_sensor_of_probe(&fn->dev, &f12->sensor_pdata);
 		if (ret)
@@ -318,6 +389,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
 
 	sensor->x_mm = f12->sensor_pdata.x_mm;
 	sensor->y_mm = f12->sensor_pdata.y_mm;
+	sensor->dribble = f12->sensor_pdata.dribble;
 
 	if (sensor->sensor_type == rmi_sensor_default)
 		sensor->sensor_type =
-- 
2.5.0
