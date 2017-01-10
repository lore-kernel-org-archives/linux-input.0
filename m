From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 03/10] Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on buttonpads to PS/2 guest
Date: Tue, 10 Jan 2017 17:11:21 +0100
Message-ID: <20170110161128.7441-4-benjamin.tissoires@redhat.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On the latest series of ThinkPads, the button events for the TrackPoint
are reported through the touchpad itself as opposed to the TrackPoint
device. In order to report these buttons properly, we need to forward
them to the TrackPoint device and send the button presses/releases
through there instead.

Signed-off-by: Lyude Paul <thatslyude@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_driver.h | 14 ++++++++
 drivers/input/rmi4/rmi_f03.c    | 30 +++++++++++++++++
 drivers/input/rmi4/rmi_f30.c    | 72 ++++++++++++++++++++++++++++++++---------
 3 files changed, 101 insertions(+), 15 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 0506371..66b935f 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -107,7 +107,21 @@ int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
 
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
 
+#ifdef CONFIG_RMI4_F03
+int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
+			     int value);
+void rmi_f03_commit_buttons(struct rmi_function *fn);
+#else
+static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
+					   unsigned int button, int value)
+{
+	return 0;
+}
+static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
+#endif
+
 #ifdef CONFIG_RMI4_F34
+
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
 void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
 #else
diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 8a7ca3e..26f6edd 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -31,10 +31,40 @@ struct f03_data {
 
 	struct serio *serio;
 
+	unsigned int overwrite_buttons;
+
 	u8 device_count;
 	u8 rx_queue_length;
 };
 
+int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
+			     int value)
+{
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+	unsigned int bit = BIT(button);
+
+	if (button > 2)
+		return -EINVAL;
+
+	if (value)
+		f03->overwrite_buttons |= bit;
+	else
+		f03->overwrite_buttons &= ~bit;
+
+	return 0;
+}
+
+void rmi_f03_commit_buttons(struct rmi_function *fn)
+{
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+	int i;
+
+	f03->serio->extra_byte = f03->overwrite_buttons;
+
+	for (i = 0; i < 3; i++)
+		serio_interrupt(f03->serio, 0x00, 0x00);
+}
+
 static int rmi_f03_pt_write(struct serio *id, unsigned char val)
 {
 	struct f03_data *f03 = id->port_data;
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index f4b491e..608c5ee 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -74,8 +74,11 @@ struct f30_data {
 
 	u8 data_regs[RMI_F30_CTRL_MAX_BYTES];
 	u16 *gpioled_key_map;
+	u16 *gpio_passthrough_key_map;
 
 	struct input_dev *input;
+	bool trackstick_buttons;
+	struct rmi_function *f03;
 };
 
 static int rmi_f30_read_control_parameters(struct rmi_function *fn,
@@ -109,6 +112,13 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	if (!f30->input)
 		return 0;
 
+	if (f30->trackstick_buttons && !f30->f03) {
+		f30->f03 = rmi_find_function(rmi_dev, 3);
+
+		if (!f30->f03)
+			return -EBUSY;
+	}
+
 	/* Read the gpi led data. */
 	if (drvdata->attn_data.data) {
 		if (drvdata->attn_data.size < f30->register_count) {
@@ -133,23 +143,29 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	for (reg_num = 0; reg_num < f30->register_count; ++reg_num) {
 		for (i = 0; gpiled < f30->gpioled_count && i < 8; ++i,
 			++gpiled) {
-			if (f30->gpioled_key_map[gpiled] != 0) {
-				/* buttons have pull up resistors */
-				value = (((f30->data_regs[reg_num] >> i) & 0x01)
-									== 0);
+			/* buttons have pull up resistors */
+			value = (((f30->data_regs[reg_num] >> i) & 0x01) == 0);
 
+			if (f30->gpioled_key_map[gpiled] != 0) {
 				rmi_dbg(RMI_DEBUG_FN, &fn->dev,
 					"%s: call input report key (0x%04x) value (0x%02x)",
 					__func__,
 					f30->gpioled_key_map[gpiled], value);
+
 				input_report_key(f30->input,
 						 f30->gpioled_key_map[gpiled],
 						 value);
+			} else if (f30->gpio_passthrough_key_map[gpiled]) {
+				rmi_f03_overwrite_button(f30->f03,
+						f30->gpio_passthrough_key_map[gpiled] - BTN_LEFT,
+						value);
 			}
-
 		}
 	}
 
+	if (f30->trackstick_buttons)
+		rmi_f03_commit_buttons(f30->f03);
+
 	return 0;
 }
 
@@ -247,10 +263,11 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 	int retval = 0;
 	int control_address;
 	int i;
-	int button;
+	int button, extra_button;
 	u8 buf[RMI_F30_QUERY_SIZE];
 	u8 *ctrl_reg;
-	u8 *map_memory;
+	u8 *map_memory, *pt_memory;
+	bool buttonpad;
 
 	f30 = devm_kzalloc(&fn->dev, sizeof(struct f30_data),
 			   GFP_KERNEL);
@@ -348,29 +365,54 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
 	map_memory = devm_kzalloc(&fn->dev,
 				  (f30->gpioled_count * (sizeof(u16))),
 				  GFP_KERNEL);
-	if (!map_memory) {
+	pt_memory = devm_kzalloc(&fn->dev,
+				 (f30->gpioled_count * (sizeof(u16))),
+				 GFP_KERNEL);
+	if (!map_memory || !pt_memory) {
 		dev_err(&fn->dev, "Failed to allocate gpioled map memory.\n");
 		return -ENOMEM;
 	}
 
 	f30->gpioled_key_map = (u16 *)map_memory;
+	f30->gpio_passthrough_key_map = (u16 *)pt_memory;
 
 	pdata = rmi_get_platform_data(rmi_dev);
 	if (f30->has_gpio) {
+		/*
+		 * buttonpad might be given by f30->has_mech_mouse_btns,
+		 * but I am not sure, so use only the pdata info
+		 */
+		buttonpad = pdata->f30_data.buttonpad;
+		f30->trackstick_buttons = pdata->f30_data.trackstick_buttons;
+
+		/*
+		 * For touchpads the buttons are mapped as:
+		 * - bit 0 = Left, bit 1 = right, bit 2 = middle / clickbutton
+		 * - 3, 4, 5 are extended buttons and
+		 * - 6 and 7 are other sorts of GPIOs
+		 */
 		button = BTN_LEFT;
-		for (i = 0; i < f30->gpioled_count; i++) {
+		extra_button = BTN_LEFT;
+		for (i = 0; i < f30->gpioled_count && i < 3; i++) {
 			if (rmi_f30_is_valid_button(i, f30->ctrl)) {
 				f30->gpioled_key_map[i] = button++;
 
-				/*
-				 * buttonpad might be given by
-				 * f30->has_mech_mouse_btns, but I am
-				 * not sure, so use only the pdata info
-				 */
-				if (pdata->f30_data.buttonpad)
+				if (buttonpad)
 					break;
 			}
 		}
+
+		if (f30->trackstick_buttons) {
+			for (i = 3; i < f30->gpioled_count && i < 6; i++) {
+				if (rmi_f30_is_valid_button(i, f30->ctrl))
+					f30->gpio_passthrough_key_map[i] = extra_button++;
+			}
+		} else if (!buttonpad) {
+			for (i = 3; i < f30->gpioled_count; i++) {
+				if (rmi_f30_is_valid_button(i, f30->ctrl))
+					f30->gpioled_key_map[i] = button++;
+			}
+		}
 	}
 
 	return 0;
-- 
2.9.3
