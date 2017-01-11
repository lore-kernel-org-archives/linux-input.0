From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 4/5] Input: mpr121 - use matrix keypad helper API
Date: Thu, 12 Jan 2017 02:42:28 +0900
Message-ID: <1484156549-26585-5-git-send-email-akinobu.mita@gmail.com>
References: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33418 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938782AbdAKRm4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 12:42:56 -0500
In-Reply-To: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Convert to use matrix_kaypad_build_keymap() helper.

This is preparation for adding device tree support.  This change enables
to share code between legacy platform data probe and device tree probe.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/input/keyboard/Kconfig           |  1 +
 drivers/input/keyboard/mpr121_touchkey.c | 64 +++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index cbd75cf..b436e71 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -407,6 +407,7 @@ config KEYBOARD_MCS
 config KEYBOARD_MPR121
 	tristate "Freescale MPR121 Touchkey"
 	depends on I2C
+	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you have Freescale MPR121 touchkey controller
 	  chip in your system.
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index c809f70..7e85512 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/i2c/mpr121_touchkey.h>
+#include <linux/input/matrix_keypad.h>
 
 /* Register definitions */
 #define ELE_TOUCH_STATUS_0_ADDR	0x0
@@ -61,7 +62,6 @@ struct mpr121_touchkey {
 	struct input_dev	*input_dev;
 	unsigned int		statusbits;
 	unsigned int		keycount;
-	u16			keycodes[MPR121_MAX_KEY_COUNT];
 };
 
 struct mpr121_init_register {
@@ -88,6 +88,7 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	struct input_dev *input = mpr121->input_dev;
 	unsigned int bit_changed;
 	unsigned int key_num;
+	const unsigned short *keycode = input->keycode;
 	int reg;
 
 	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
@@ -114,7 +115,7 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 			continue;
 
 		pressed = reg & (1 << key_num);
-		key_val = mpr121->keycodes[key_num];
+		key_val = keycode[key_num];
 
 		input_event(input, EV_MSC, MSC_SCAN, key_num);
 		input_report_key(input, key_val, pressed);
@@ -196,23 +197,46 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 {
 	const struct mpr121_platform_data *pdata =
 			dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
+	unsigned int keymap_size;
+	struct matrix_keymap_data *keymap_data;
 	struct mpr121_touchkey *mpr121;
 	struct input_dev *input_dev;
 	int error;
 	int i;
 
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
+	if (pdata) {
+		uint32_t *keymap;
 
-	if (!pdata->keymap || !pdata->keymap_size) {
-		dev_err(&client->dev, "missing keymap data\n");
-		return -EINVAL;
-	}
+		if (!pdata->keymap || !pdata->keymap_size) {
+			dev_err(dev, "missing keymap data\n");
+			return -EINVAL;
+		}
+
+		if (pdata->keymap_size > MPR121_MAX_KEY_COUNT) {
+			dev_err(dev, "too many keys defined\n");
+			return -EINVAL;
+		}
+
+		keymap_size = pdata->keymap_size;
+
+		keymap = devm_kcalloc(dev, keymap_size,
+				sizeof(keymap_data->keymap[0]), GFP_KERNEL);
+		if (!keymap)
+			return -ENOMEM;
 
-	if (pdata->keymap_size > MPR121_MAX_KEY_COUNT) {
-		dev_err(&client->dev, "too many keys defined\n");
+		for (i = 0; i < keymap_size; i++)
+			keymap[i] = KEY(0, i, pdata->keymap[i]);
+
+		keymap_data = devm_kzalloc(dev, sizeof(*keymap_data),
+					GFP_KERNEL);
+		if (!keymap_data)
+			return -ENOMEM;
+
+		keymap_data->keymap_size = keymap_size;
+		keymap_data->keymap = keymap;
+	} else {
+		dev_err(&client->dev, "no platform data defined\n");
 		return -EINVAL;
 	}
 
@@ -232,22 +256,18 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	mpr121->client = client;
 	mpr121->input_dev = input_dev;
-	mpr121->keycount = pdata->keymap_size;
+	mpr121->keycount = keymap_size;
 
 	input_dev->name = "Freescale MPR121 Touchkey";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	input_dev->evbit[0] = BIT_MASK(EV_REP);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
-	input_dev->keycode = mpr121->keycodes;
-	input_dev->keycodesize = sizeof(mpr121->keycodes[0]);
-	input_dev->keycodemax = mpr121->keycount;
-
-	for (i = 0; i < pdata->keymap_size; i++) {
-		input_set_capability(input_dev, EV_KEY, pdata->keymap[i]);
-		mpr121->keycodes[i] = pdata->keymap[i];
-	}
+	error = matrix_keypad_build_keymap(keymap_data, NULL, 1, keymap_size,
+						NULL, input_dev);
+	if (error)
+		return error;
 
 	error = mpr121_phys_init(pdata, mpr121, client);
 	if (error) {
-- 
2.7.4

