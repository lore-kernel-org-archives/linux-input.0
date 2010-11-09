From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 1/8] qt2160: add slider support
Date: Tue,  9 Nov 2010 13:15:04 +1100
Message-ID: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40001 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0KICPq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:15:46 -0500
Received: by gxk23 with SMTP id 23so3933812gxk.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:15:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Supports keys only, slider only, slider & keys configurations.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |  180 +++++++++++++++++++++++++++++++++------
 include/linux/input/qt2160.h    |   26 ++++++
 2 files changed, 181 insertions(+), 25 deletions(-)
 mode change 100644 => 100755 drivers/input/keyboard/qt2160.c
 create mode 100755 include/linux/input/qt2160.h

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
old mode 100644
new mode 100755
index fac6951..7ec256c
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -27,6 +27,9 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/delay.h>
+
+#include <linux/input/qt2160.h>
 
 #define QT2160_VALID_CHIPID  0x11
 
@@ -39,14 +42,32 @@
 #define QT2160_CMD_GPIOS      6
 #define QT2160_CMD_SUBVER     7
 #define QT2160_CMD_CALIBRATE  10
+#define QT2160_CMD_RESET      11
+#define QT2160_CMD_SLIDE_CTRL 20
+#define QT2160_CMD_SLIDE_OPT  21
+#define QT2160_CMD_KEY0_AKS   22
 
 #define QT2160_CYCLE_INTERVAL	(2*HZ)
 
-static unsigned char qt2160_key2code[] = {
-	KEY_0, KEY_1, KEY_2, KEY_3,
-	KEY_4, KEY_5, KEY_6, KEY_7,
-	KEY_8, KEY_9, KEY_A, KEY_B,
-	KEY_C, KEY_D, KEY_E, KEY_F,
+#define QT2160_SLIDE_RESOLUTION	(8)
+#define QT2160_SLIDE_HYSTERESIS	(10)
+#define QT2160_SLIDE_MAX_VALUE	(0xFF)
+
+static struct qt2160_info default_hw_info = {
+	.slider_length = 0,
+	.slider_axis = 0,
+	.keycodes = {
+		KEY_0, KEY_1, KEY_2, KEY_3,
+		KEY_4, KEY_5, KEY_6, KEY_7,
+		KEY_8, KEY_9, KEY_A, KEY_B,
+		KEY_C, KEY_D, KEY_E, KEY_F,
+		},
+	.key_aks = {
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		},
 };
 
 struct qt2160_data {
@@ -54,8 +75,10 @@ struct qt2160_data {
 	struct input_dev *input;
 	struct delayed_work dwork;
 	spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
-	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
+	struct qt2160_info *hw_info;
 	u16 key_matrix;
+	u8 slide_val;
+	unsigned char num_keys;
 };
 
 static int qt2160_read_block(struct i2c_client *client,
@@ -113,8 +136,10 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 {
 	struct i2c_client *client = qt2160->client;
 	struct input_dev *input = qt2160->input;
+	struct qt2160_info *hw_info = qt2160->hw_info;
 	u8 regs[6];
 	u16 old_matrix, new_matrix;
+	u8 old_slide;
 	int ret, i, mask;
 
 	dev_dbg(&client->dev, "requesting keys...\n");
@@ -130,17 +155,30 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 		return ret;
 	}
 
-	old_matrix = qt2160->key_matrix;
-	qt2160->key_matrix = new_matrix = (regs[2] << 8) | regs[1];
-
-	mask = 0x01;
-	for (i = 0; i < 16; ++i, mask <<= 1) {
-		int keyval = new_matrix & mask;
+	if (hw_info->slider_length) {
+		old_slide = qt2160->slide_val;
+		if (old_slide != regs[3]) {
+			qt2160->slide_val = regs[3];
+			input_report_abs(input, hw_info->slider_axis, regs[3]);
+		}
+	}
 
-		if ((old_matrix & mask) != keyval) {
-			input_report_key(input, qt2160->keycodes[i], keyval);
-			dev_dbg(&client->dev, "key %d %s\n",
-				i, keyval ? "pressed" : "released");
+	if (qt2160->num_keys) {
+		old_matrix = qt2160->key_matrix;
+		qt2160->key_matrix = new_matrix = (regs[2] << 8) | regs[1];
+
+		mask = 0x01 << hw_info->slider_length;
+		for (i = hw_info->slider_length; i < QT2160_MAXKEYS;
+		     ++i, mask <<= 1) {
+			int keyval = new_matrix & mask;
+
+			if (((old_matrix & mask) != keyval) &&
+			    (hw_info->keycodes[i])) {
+				input_report_key(input, hw_info->keycodes[i],
+						 keyval);
+				dev_dbg(&client->dev, "key %d %s\n",
+					i, keyval ? "pressed" : "released");
+			}
 		}
 	}
 
@@ -226,6 +264,52 @@ static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 	return error;
 }
 
+static int __devinit qt2160_configure_device(struct i2c_client *client,
+					     struct qt2160_data *qt2160)
+{
+	struct qt2160_info *pdata = qt2160->hw_info;
+	int i;
+	int error = 0;
+
+	/* perform software reset and wait for at least 32ms */
+	i2c_smbus_write_byte_data(client, QT2160_CMD_RESET, 0xFF);
+	msleep(200);
+
+	/* perform dummy write to reset I2C state */
+	i2c_smbus_write_byte(client, QT2160_CMD_CHIPID);
+
+	/* setup slider control and slider options */
+	if (pdata->slider_length) {
+		error |= i2c_smbus_write_byte_data(
+						client,
+						QT2160_CMD_SLIDE_CTRL,
+						(QT2160_SLIDE_HYSTERESIS << 4) |
+						(pdata->slider_length & 0x0F));
+		error |= i2c_smbus_write_byte_data(client, QT2160_CMD_SLIDE_OPT,
+						   8 - QT2160_SLIDE_RESOLUTION);
+	} else {
+		error = i2c_smbus_write_byte_data(client,
+						  QT2160_CMD_SLIDE_CTRL, 0);
+	}
+	if (error) {
+		dev_err(&client->dev, "could not write slider config\n");
+		goto config_fault;
+	}
+
+	for (i = 0; i < QT2160_MAXKEYS; i++) {
+		/* set AKS */
+		error |= i2c_smbus_write_byte_data(client,
+						   QT2160_CMD_KEY0_AKS + i,
+						   pdata->key_aks[i]);
+	}
+	if (error) {
+		dev_err(&client->dev, "could not write key config\n");
+		goto config_fault;
+	}
+
+config_fault:
+	return error;
+}
 
 static bool __devinit qt2160_identify(struct i2c_client *client)
 {
@@ -263,6 +347,8 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 {
 	struct qt2160_data *qt2160;
 	struct input_dev *input;
+	struct qt2160_info *pdata;
+	struct qt2160_info *hw_info;
 	int i;
 	int error;
 
@@ -275,6 +361,8 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	pdata = client->dev.platform_data;
+
 	if (!qt2160_identify(client))
 		return -ENODEV;
 
@@ -287,6 +375,33 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
+	if (pdata)
+		qt2160->hw_info = pdata;
+	else
+		qt2160->hw_info = &default_hw_info;
+	hw_info = qt2160->hw_info;
+
+	qt2160->num_keys = 0;
+	for (i = hw_info->slider_length; i < QT2160_MAXKEYS; ++i) {
+		if (hw_info->keycodes[i])
+			qt2160->num_keys++;
+	}
+	if ((!qt2160->num_keys) &&
+	    (hw_info->slider_length < QT2160_MIN_SLIDER_LENGTH)) {
+		dev_err(&client->dev, "No valid input device specified\n");
+		error = -EINVAL;
+		goto err_free_mem;
+	}
+	if (hw_info->slider_length != 0) {
+		if ((hw_info->slider_length > QT2160_MAX_SLIDER_LENGTH) ||
+		    (hw_info->slider_length < QT2160_MIN_SLIDER_LENGTH)) {
+			dev_err(&client->dev, "%d keys slider not supported\n",
+				hw_info->slider_length);
+			error = -EINVAL;
+			goto err_free_mem;
+		}
+	}
+
 	qt2160->client = client;
 	qt2160->input = input;
 	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
@@ -295,17 +410,32 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 	input->name = "AT42QT2160 Touch Sense Keyboard";
 	input->id.bustype = BUS_I2C;
 
-	input->keycode = qt2160->keycodes;
-	input->keycodesize = sizeof(qt2160->keycodes[0]);
-	input->keycodemax = ARRAY_SIZE(qt2160_key2code);
+	if (qt2160->num_keys) {
+		input->keycode = hw_info->keycodes;
+		input->keycodesize = sizeof(hw_info->keycodes[0]);
+		input->keycodemax = QT2160_MAXKEYS - hw_info->slider_length;
+
+		__set_bit(EV_KEY, input->evbit);
+		__clear_bit(EV_REP, input->evbit);
+		for (i = hw_info->slider_length; i < QT2160_MAXKEYS; i++) {
+			if (hw_info->keycodes[i])
+				__set_bit(hw_info->keycodes[i], input->keybit);
+		}
+		__clear_bit(KEY_RESERVED, input->keybit);
+	}
+	if (hw_info->slider_length) {
+		__set_bit(EV_ABS, input->evbit);
+		__set_bit(hw_info->slider_axis, input->absbit);
+		input_set_abs_params(input, hw_info->slider_axis, 0,
+				     QT2160_SLIDE_MAX_VALUE, 0, 0);
+	}
 
-	__set_bit(EV_KEY, input->evbit);
-	__clear_bit(EV_REP, input->evbit);
-	for (i = 0; i < ARRAY_SIZE(qt2160_key2code); i++) {
-		qt2160->keycodes[i] = qt2160_key2code[i];
-		__set_bit(qt2160_key2code[i], input->keybit);
+	/* Configure device */
+	error = qt2160_configure_device(client, qt2160);
+	if (error) {
+		dev_err(&client->dev, "failed to configure device\n");
+		goto err_free_mem;
 	}
-	__clear_bit(KEY_RESERVED, input->keybit);
 
 	/* Calibrate device */
 	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
new file mode 100755
index 0000000..9d1252e
--- /dev/null
+++ b/include/linux/input/qt2160.h
@@ -0,0 +1,26 @@
+#ifndef __QT2160_H__
+#define __QT2160_H__
+
+#define QT2160_MAXKEYS 16
+#define QT2160_MAX_SLIDER_LENGTH 8
+#define QT2160_MIN_SLIDER_LENGTH 2
+
+/**
+ * struct qt2160_info - defines the chip configuration
+ * @slider_length: number of keys to use as slider, max 8 keys, min 2 keys
+ * @slider_axis: absolute axis type, value 0 is ABS_X
+ * @keycodes: key codes for keys that are part of the slider are ignored; slider
+ *  keys always start from key index 0 and end at key index (slider_length - 1);
+ *  set to value 0 if key is not used;
+ * @key_aks: adjacent key suppression; keys that form a slider must be in the
+ *  same aks group; keys in the same aks group will only report 1 active key at
+ *  any time; value 0 disables aks group; valid aks groups are 1, 2, 3
+ */
+struct qt2160_info {
+	unsigned char slider_length;
+	unsigned int slider_axis;
+	unsigned short keycodes[QT2160_MAXKEYS];
+	unsigned char key_aks[QT2160_MAXKEYS];
+};
+
+#endif /* __QT2160_H__ */
-- 
1.7.0.4

