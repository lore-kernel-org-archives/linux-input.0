From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: synaptics-rmi4 - clean up F30 implementation
Date: Thu,  9 Feb 2017 11:49:10 -0800
Message-ID: <20170209194911.32442-2-dmitry.torokhov@gmail.com>
References: <20170209194911.32442-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170209194911.32442-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch does several cleanup changes to F30 code

- switch to using BIT() macro
- use DIV_ROUND_UP() where appropriate
- factor out code setting up and reporting buttons
- use single loop when reporting buttons: arithmetic is cheap compared to
  conditionals and associated branch misprediction.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f30.c | 326 +++++++++++++++++++------------------------
 1 file changed, 144 insertions(+), 182 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index f4b491e3e0fd..c5eb4d034e84 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -16,30 +16,24 @@
 
 /* Defs for Query 0 */
 #define RMI_F30_EXTENDED_PATTERNS		0x01
-#define RMI_F30_HAS_MAPPABLE_BUTTONS		(1 << 1)
-#define RMI_F30_HAS_LED			(1 << 2)
-#define RMI_F30_HAS_GPIO			(1 << 3)
-#define RMI_F30_HAS_HAPTIC			(1 << 4)
-#define RMI_F30_HAS_GPIO_DRV_CTL		(1 << 5)
-#define RMI_F30_HAS_MECH_MOUSE_BTNS		(1 << 6)
+#define RMI_F30_HAS_MAPPABLE_BUTTONS		BIT(1)
+#define RMI_F30_HAS_LED				BIT(2)
+#define RMI_F30_HAS_GPIO			BIT(3)
+#define RMI_F30_HAS_HAPTIC			BIT(4)
+#define RMI_F30_HAS_GPIO_DRV_CTL		BIT(5)
+#define RMI_F30_HAS_MECH_MOUSE_BTNS		BIT(6)
 
 /* Defs for Query 1 */
 #define RMI_F30_GPIO_LED_COUNT			0x1F
 
 /* Defs for Control Registers */
 #define RMI_F30_CTRL_1_GPIO_DEBOUNCE		0x01
-#define RMI_F30_CTRL_1_HALT			(1 << 4)
-#define RMI_F30_CTRL_1_HALTED			(1 << 5)
+#define RMI_F30_CTRL_1_HALT			BIT(4)
+#define RMI_F30_CTRL_1_HALTED			BIT(5)
 #define RMI_F30_CTRL_10_NUM_MECH_MOUSE_BTNS	0x03
 
-struct rmi_f30_ctrl_data {
-	int address;
-	int length;
-	u8 *regs;
-};
-
 #define RMI_F30_CTRL_MAX_REGS		32
-#define RMI_F30_CTRL_MAX_BYTES		((RMI_F30_CTRL_MAX_REGS + 7) >> 3)
+#define RMI_F30_CTRL_MAX_BYTES		DIV_ROUND_UP(RMI_F30_CTRL_MAX_REGS, 8)
 #define RMI_F30_CTRL_MAX_REG_BLOCKS	11
 
 #define RMI_F30_CTRL_REGS_MAX_SIZE (RMI_F30_CTRL_MAX_BYTES		\
@@ -54,6 +48,12 @@ struct rmi_f30_ctrl_data {
 					+ 1				\
 					+ 1)
 
+struct rmi_f30_ctrl_data {
+	int address;
+	int length;
+	u8 *regs;
+};
+
 struct f30_data {
 	/* Query Data */
 	bool has_extended_pattern;
@@ -81,13 +81,13 @@ struct f30_data {
 static int rmi_f30_read_control_parameters(struct rmi_function *fn,
 						struct f30_data *f30)
 {
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	int error = 0;
+	int error;
 
-	error = rmi_read_block(rmi_dev, fn->fd.control_base_addr,
-				f30->ctrl_regs, f30->ctrl_regs_size);
+	error = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
+			       f30->ctrl_regs, f30->ctrl_regs_size);
 	if (error) {
-		dev_err(&rmi_dev->dev, "%s : Could not read control registers at 0x%x error (%d)\n",
+		dev_err(&fn->dev,
+			"%s: Could not read control registers at 0x%x: %d\n",
 			__func__, fn->fd.control_base_addr, error);
 		return error;
 	}
@@ -95,24 +95,32 @@ static int rmi_f30_read_control_parameters(struct rmi_function *fn,
 	return 0;
 }
 
+static void rmi_f30_report_button(struct rmi_function *fn,
+				  struct f30_data *f30, unsigned int button)
+{
+	unsigned int reg_num = button >> 3;
+	unsigned int bit_num = button & 0x07;
+	bool key_down = !(f30->data_regs[reg_num] & BIT(bit_num));
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: call input report key (0x%04x) value (0x%02x)",
+		__func__, f30->gpioled_key_map[button], key_down);
+
+	input_report_key(f30->input, f30->gpioled_key_map[button], key_down);
+}
+
 static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 {
 	struct f30_data *f30 = dev_get_drvdata(&fn->dev);
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
-	int retval;
-	int gpiled = 0;
-	int value = 0;
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&fn->rmi_dev->dev);
+	int error;
 	int i;
-	int reg_num;
-
-	if (!f30->input)
-		return 0;
 
 	/* Read the gpi led data. */
 	if (drvdata->attn_data.data) {
 		if (drvdata->attn_data.size < f30->register_count) {
-			dev_warn(&fn->dev, "F30 interrupted, but data is missing\n");
+			dev_warn(&fn->dev,
+				 "F30 interrupted, but data is missing\n");
 			return 0;
 		}
 		memcpy(f30->data_regs, drvdata->attn_data.data,
@@ -120,72 +128,21 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 		drvdata->attn_data.data += f30->register_count;
 		drvdata->attn_data.size -= f30->register_count;
 	} else {
-		retval = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
-			f30->data_regs, f30->register_count);
-
-		if (retval) {
-			dev_err(&fn->dev, "%s: Failed to read F30 data registers.\n",
-				__func__);
-			return retval;
-		}
-	}
-
-	for (reg_num = 0; reg_num < f30->register_count; ++reg_num) {
-		for (i = 0; gpiled < f30->gpioled_count && i < 8; ++i,
-			++gpiled) {
-			if (f30->gpioled_key_map[gpiled] != 0) {
-				/* buttons have pull up resistors */
-				value = (((f30->data_regs[reg_num] >> i) & 0x01)
-									== 0);
-
-				rmi_dbg(RMI_DEBUG_FN, &fn->dev,
-					"%s: call input report key (0x%04x) value (0x%02x)",
-					__func__,
-					f30->gpioled_key_map[gpiled], value);
-				input_report_key(f30->input,
-						 f30->gpioled_key_map[gpiled],
-						 value);
-			}
-
+		error = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr,
+				       f30->data_regs, f30->register_count);
+		if (error) {
+			dev_err(&fn->dev,
+				"%s: Failed to read F30 data registers: %d\n",
+				__func__, error);
+			return error;
 		}
 	}
 
-	return 0;
-}
-
-static int rmi_f30_register_device(struct rmi_function *fn)
-{
-	int i;
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
-	struct f30_data *f30 = dev_get_drvdata(&fn->dev);
-	struct input_dev *input_dev;
-	int button_count = 0;
-
-	input_dev = drv_data->input;
-	if (!input_dev) {
-		dev_info(&fn->dev, "F30: no input device found, ignoring.\n");
-		return -EINVAL;
-	}
-
-	f30->input = input_dev;
-
-	set_bit(EV_KEY, input_dev->evbit);
-
-	input_dev->keycode = f30->gpioled_key_map;
-	input_dev->keycodesize = sizeof(u16);
-	input_dev->keycodemax = f30->gpioled_count;
-
-	for (i = 0; i < f30->gpioled_count; i++) {
-		if (f30->gpioled_key_map[i] != 0) {
-			input_set_capability(input_dev, EV_KEY,
-						f30->gpioled_key_map[i]);
-			button_count++;
-		}
-	}
+	if (f30->has_gpio)
+		for (i = 0; i < f30->gpioled_count; i++)
+			if (f30->gpioled_key_map[i] != KEY_RESERVED)
+				rmi_f30_report_button(fn, f30, i);
 
-	if (button_count == 1)
-		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
 	return 0;
 }
 
@@ -204,19 +161,20 @@ static int rmi_f30_config(struct rmi_function *fn)
 		error = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
 					f30->ctrl_regs, f30->ctrl_regs_size);
 		if (error) {
-			dev_err(&fn->rmi_dev->dev,
-				"%s : Could not write control registers at 0x%x error (%d)\n",
+			dev_err(&fn->dev,
+				"%s: Could not write control registers at 0x%x: %d\n",
 				__func__, fn->fd.control_base_addr, error);
 			return error;
 		}
 
 		drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
 	}
+
 	return 0;
 }
 
-static inline void rmi_f30_set_ctrl_data(struct rmi_f30_ctrl_data *ctrl,
-					int *ctrl_addr, int len, u8 **reg)
+static void rmi_f30_set_ctrl_data(struct rmi_f30_ctrl_data *ctrl,
+				  int *ctrl_addr, int len, u8 **reg)
 {
 	ctrl->address = *ctrl_addr;
 	ctrl->length = len;
@@ -225,8 +183,7 @@ static inline void rmi_f30_set_ctrl_data(struct rmi_f30_ctrl_data *ctrl,
 	*reg += len;
 }
 
-static inline bool rmi_f30_is_valid_button(int button,
-		struct rmi_f30_ctrl_data *ctrl)
+static bool rmi_f30_is_valid_button(int button, struct rmi_f30_ctrl_data *ctrl)
 {
 	int byte_position = button >> 3;
 	int bit_position = button & 0x07;
@@ -239,32 +196,60 @@ static inline bool rmi_f30_is_valid_button(int button,
 		(ctrl[3].regs[byte_position] & BIT(bit_position));
 }
 
-static inline int rmi_f30_initialize(struct rmi_function *fn)
+static int rmi_f30_map_gpios(struct rmi_function *fn,
+			     struct f30_data *f30)
 {
-	struct f30_data *f30;
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	const struct rmi_device_platform_data *pdata;
-	int retval = 0;
-	int control_address;
+	const struct rmi_device_platform_data *pdata =
+					rmi_get_platform_data(fn->rmi_dev);
+	struct input_dev *input = f30->input;
+	unsigned int button = BTN_LEFT;
 	int i;
-	int button;
-	u8 buf[RMI_F30_QUERY_SIZE];
-	u8 *ctrl_reg;
-	u8 *map_memory;
 
-	f30 = devm_kzalloc(&fn->dev, sizeof(struct f30_data),
-			   GFP_KERNEL);
-	if (!f30)
+	f30->gpioled_key_map = devm_kcalloc(&fn->dev,
+					    f30->gpioled_count,
+					    sizeof(f30->gpioled_key_map[0]),
+					    GFP_KERNEL);
+	if (!f30->gpioled_key_map) {
+		dev_err(&fn->dev, "Failed to allocate gpioled map memory.\n");
 		return -ENOMEM;
+	}
 
-	dev_set_drvdata(&fn->dev, f30);
+	for (i = 0; i < f30->gpioled_count; i++) {
+		if (rmi_f30_is_valid_button(i, f30->ctrl)) {
+			f30->gpioled_key_map[i] = button;
+			input_set_capability(input, EV_KEY, button++);
+
+			/*
+			 * buttonpad might be given by
+			 * f30->has_mech_mouse_btns, but I am
+			 * not sure, so use only the pdata info
+			 */
+			if (pdata->f30_data.buttonpad) {
+				__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+				break;
+			}
+		}
+	}
+
+	input->keycode = f30->gpioled_key_map;
+	input->keycodesize = sizeof(f30->gpioled_key_map[0]);
+	input->keycodemax = f30->gpioled_count;
+
+	return 0;
+}
 
-	retval = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr, buf,
-				RMI_F30_QUERY_SIZE);
+static int rmi_f30_initialize(struct rmi_function *fn, struct f30_data *f30)
+{
+	u8 *ctrl_reg = f30->ctrl_regs;
+	int control_address = fn->fd.control_base_addr;
+	u8 buf[RMI_F30_QUERY_SIZE];
+	int error;
 
-	if (retval) {
-		dev_err(&fn->dev, "Failed to read query register.\n");
-		return retval;
+	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
+			       buf, RMI_F30_QUERY_SIZE);
+	if (error) {
+		dev_err(&fn->dev, "Failed to read query register\n");
+		return error;
 	}
 
 	f30->has_extended_pattern = buf[0] & RMI_F30_EXTENDED_PATTERNS;
@@ -276,101 +261,71 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 	f30->has_mech_mouse_btns = buf[0] & RMI_F30_HAS_MECH_MOUSE_BTNS;
 	f30->gpioled_count = buf[1] & RMI_F30_GPIO_LED_COUNT;
 
-	f30->register_count = (f30->gpioled_count + 7) >> 3;
-
-	control_address = fn->fd.control_base_addr;
-	ctrl_reg = f30->ctrl_regs;
+	f30->register_count = DIV_ROUND_UP(f30->gpioled_count, 8);
 
 	if (f30->has_gpio && f30->has_led)
 		rmi_f30_set_ctrl_data(&f30->ctrl[0], &control_address,
-					f30->register_count, &ctrl_reg);
+				      f30->register_count, &ctrl_reg);
 
-	rmi_f30_set_ctrl_data(&f30->ctrl[1], &control_address, sizeof(u8),
-				&ctrl_reg);
+	rmi_f30_set_ctrl_data(&f30->ctrl[1], &control_address,
+			      sizeof(u8), &ctrl_reg);
 
 	if (f30->has_gpio) {
 		rmi_f30_set_ctrl_data(&f30->ctrl[2], &control_address,
-					f30->register_count, &ctrl_reg);
+				      f30->register_count, &ctrl_reg);
 
 		rmi_f30_set_ctrl_data(&f30->ctrl[3], &control_address,
-					f30->register_count, &ctrl_reg);
+				      f30->register_count, &ctrl_reg);
 	}
 
 	if (f30->has_led) {
-		int ctrl5_len;
-
 		rmi_f30_set_ctrl_data(&f30->ctrl[4], &control_address,
-					f30->register_count, &ctrl_reg);
-
-		if (f30->has_extended_pattern)
-			ctrl5_len = 6;
-		else
-			ctrl5_len = 2;
+				      f30->register_count, &ctrl_reg);
 
 		rmi_f30_set_ctrl_data(&f30->ctrl[5], &control_address,
-					ctrl5_len, &ctrl_reg);
+				      f30->has_extended_pattern ? 6 : 2,
+				      &ctrl_reg);
 	}
 
 	if (f30->has_led || f30->has_gpio_driver_control) {
 		/* control 6 uses a byte per gpio/led */
 		rmi_f30_set_ctrl_data(&f30->ctrl[6], &control_address,
-					f30->gpioled_count, &ctrl_reg);
+				      f30->gpioled_count, &ctrl_reg);
 	}
 
 	if (f30->has_mappable_buttons) {
 		/* control 7 uses a byte per gpio/led */
 		rmi_f30_set_ctrl_data(&f30->ctrl[7], &control_address,
-					f30->gpioled_count, &ctrl_reg);
+				      f30->gpioled_count, &ctrl_reg);
 	}
 
 	if (f30->has_haptic) {
 		rmi_f30_set_ctrl_data(&f30->ctrl[8], &control_address,
-					f30->register_count, &ctrl_reg);
+				      f30->register_count, &ctrl_reg);
 
 		rmi_f30_set_ctrl_data(&f30->ctrl[9], &control_address,
-					sizeof(u8), &ctrl_reg);
+				      sizeof(u8), &ctrl_reg);
 	}
 
 	if (f30->has_mech_mouse_btns)
 		rmi_f30_set_ctrl_data(&f30->ctrl[10], &control_address,
-					sizeof(u8), &ctrl_reg);
+				      sizeof(u8), &ctrl_reg);
 
-	f30->ctrl_regs_size = ctrl_reg - f30->ctrl_regs
-				?: RMI_F30_CTRL_REGS_MAX_SIZE;
+	f30->ctrl_regs_size = ctrl_reg -
+				f30->ctrl_regs ?: RMI_F30_CTRL_REGS_MAX_SIZE;
 
-	retval = rmi_f30_read_control_parameters(fn, f30);
-	if (retval < 0) {
+	error = rmi_f30_read_control_parameters(fn, f30);
+	if (error) {
 		dev_err(&fn->dev,
-			"Failed to initialize F19 control params.\n");
-		return retval;
-	}
-
-	map_memory = devm_kzalloc(&fn->dev,
-				  (f30->gpioled_count * (sizeof(u16))),
-				  GFP_KERNEL);
-	if (!map_memory) {
-		dev_err(&fn->dev, "Failed to allocate gpioled map memory.\n");
-		return -ENOMEM;
+			"Failed to initialize F30 control params: %d\n",
+			error);
+		return error;
 	}
 
-	f30->gpioled_key_map = (u16 *)map_memory;
-
-	pdata = rmi_get_platform_data(rmi_dev);
 	if (f30->has_gpio) {
-		button = BTN_LEFT;
-		for (i = 0; i < f30->gpioled_count; i++) {
-			if (rmi_f30_is_valid_button(i, f30->ctrl)) {
-				f30->gpioled_key_map[i] = button++;
-
-				/*
-				 * buttonpad might be given by
-				 * f30->has_mech_mouse_btns, but I am
-				 * not sure, so use only the pdata info
-				 */
-				if (pdata->f30_data.buttonpad)
-					break;
-			}
-		}
+		error = rmi_f30_map_gpios(fn, f30);
+		if (error)
+			return error;
 	}
 
 	return 0;
@@ -378,26 +333,33 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 
 static int rmi_f30_probe(struct rmi_function *fn)
 {
-	int rc;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
 	const struct rmi_device_platform_data *pdata =
-				rmi_get_platform_data(fn->rmi_dev);
+					rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct f30_data *f30;
+	int error;
 
 	if (pdata->f30_data.disable)
 		return 0;
 
-	rc = rmi_f30_initialize(fn);
-	if (rc < 0)
-		goto error_exit;
+	if (!drv_data->input) {
+		dev_info(&fn->dev, "F30: no input device found, ignoring\n");
+		return -ENXIO;
+	}
 
-	rc = rmi_f30_register_device(fn);
-	if (rc < 0)
-		goto error_exit;
+	f30 = devm_kzalloc(&fn->dev, sizeof(*f30), GFP_KERNEL);
+	if (!f30)
+		return -ENOMEM;
 
-	return 0;
+	f30->input = drv_data->input;
 
-error_exit:
-	return rc;
+	error = rmi_f30_initialize(fn, f30);
+	if (error)
+		return error;
 
+	dev_set_drvdata(&fn->dev, f30);
+	return 0;
 }
 
 struct rmi_function_handler rmi_f30_handler = {
-- 
2.11.0.483.g087da7b7c-goog
