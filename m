From: <michael.hennerich@analog.com>
Subject: [PATCH] input: keyboard: adp5588-keys: unify common header defines
Date: Tue, 2 Nov 2010 13:31:12 +0100
Message-ID: <1288701072-336-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:54144 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0KBMiJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Nov 2010 08:38:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes.
Unify adp5588-gpio and adp5588-keys common header defines.
(as per Andrew Morton request)
For consistency move remaining defines and prefix accordingly.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/keyboard/adp5588-keys.c |   74 +++++++++++----------------------
 include/linux/i2c/adp5588.h           |   15 ++++++-
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index b92d1cd..af45d27 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -4,7 +4,7 @@
  *		 I2C QWERTY Keypad and IO Expander
  * Bugs: Enter bugs at http://blackfin.uclinux.org/
  *
- * Copyright (C) 2008-2009 Analog Devices Inc.
+ * Copyright (C) 2008-2010 Analog Devices Inc.
  * Licensed under the GPL-2 or later.
  */
 
@@ -24,29 +24,6 @@
 
 #include <linux/i2c/adp5588.h>
 
- /* Configuration Register1 */
-#define AUTO_INC	(1 << 7)
-#define GPIEM_CFG	(1 << 6)
-#define OVR_FLOW_M	(1 << 5)
-#define INT_CFG		(1 << 4)
-#define OVR_FLOW_IEN	(1 << 3)
-#define K_LCK_IM	(1 << 2)
-#define GPI_IEN		(1 << 1)
-#define KE_IEN		(1 << 0)
-
-/* Interrupt Status Register */
-#define CMP2_INT	(1 << 5)
-#define CMP1_INT	(1 << 4)
-#define OVR_FLOW_INT	(1 << 3)
-#define K_LCK_INT	(1 << 2)
-#define GPI_INT		(1 << 1)
-#define KE_INT		(1 << 0)
-
-/* Key Lock and Event Counter Register */
-#define K_LCK_EN	(1 << 6)
-#define LCK21		0x30
-#define KEC		0xF
-
 /* Key Event Register xy */
 #define KEY_EV_PRESSED		(1 << 7)
 #define KEY_EV_MASK		(0x7F)
@@ -55,10 +32,6 @@
 
 #define KEYP_MAX_EVENT		10
 
-#define MAXGPIO			18
-#define ADP_BANK(offs)		((offs) >> 3)
-#define ADP_BIT(offs)		(1u << ((offs) & 0x7))
-
 /*
  * Early pre 4.0 Silicon required to delay readout by at least 25ms,
  * since the Event Counter Register updated 25ms after the interrupt
@@ -75,7 +48,7 @@ struct adp5588_kpad {
 	const struct adp5588_gpi_map *gpimap;
 	unsigned short gpimapsize;
 #ifdef CONFIG_GPIOLIB
-	unsigned char gpiomap[MAXGPIO];
+	unsigned char gpiomap[ADP5588_MAXGPIO];
 	bool export_gpio;
 	struct gpio_chip gc;
 	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
@@ -103,8 +76,8 @@ static int adp5588_write(struct i2c_client *client, u8 reg, u8 val)
 static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5588_kpad *kpad = container_of(chip, struct adp5588_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]);
 
 	return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
 }
@@ -113,8 +86,8 @@ static void adp5588_gpio_set_value(struct gpio_chip *chip,
 				   unsigned off, int val)
 {
 	struct adp5588_kpad *kpad = container_of(chip, struct adp5588_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]);
 
 	mutex_lock(&kpad->gpio_lock);
 
@@ -132,8 +105,8 @@ static void adp5588_gpio_set_value(struct gpio_chip *chip,
 static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5588_kpad *kpad = container_of(chip, struct adp5588_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]);
 	int ret;
 
 	mutex_lock(&kpad->gpio_lock);
@@ -150,8 +123,8 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 					 unsigned off, int val)
 {
 	struct adp5588_kpad *kpad = container_of(chip, struct adp5588_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]);
 	int ret;
 
 	mutex_lock(&kpad->gpio_lock);
@@ -176,7 +149,7 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 static int __devinit adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 				const struct adp5588_kpad_platform_data *pdata)
 {
-	bool pin_used[MAXGPIO];
+	bool pin_used[ADP5588_MAXGPIO];
 	int n_unused = 0;
 	int i;
 
@@ -191,7 +164,7 @@ static int __devinit adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	for (i = 0; i < kpad->gpimapsize; i++)
 		pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = true;
 
-	for (i = 0; i < MAXGPIO; i++)
+	for (i = 0; i < ADP5588_MAXGPIO; i++)
 		if (!pin_used[i])
 			kpad->gpiomap[n_unused++] = i;
 
@@ -234,7 +207,7 @@ static int __devinit adp5588_gpio_add(struct adp5588_kpad *kpad)
 		return error;
 	}
 
-	for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 		kpad->dat_out[i] = adp5588_read(kpad->client,
 						GPIO_DAT_OUT1 + i);
 		kpad->dir[i] = adp5588_read(kpad->client, GPIO_DIR1 + i);
@@ -318,11 +291,11 @@ static void adp5588_work(struct work_struct *work)
 
 	status = adp5588_read(client, INT_STAT);
 
-	if (status & OVR_FLOW_INT)	/* Unlikely and should never happen */
+	if (status & ADP5588_OVR_FLOW_INT)	/* Unlikely and should never happen */
 		dev_err(&client->dev, "Event Overflow Error\n");
 
-	if (status & KE_INT) {
-		ev_cnt = adp5588_read(client, KEY_LCK_EC_STAT) & KEC;
+	if (status & ADP5588_KE_INT) {
+		ev_cnt = adp5588_read(client, KEY_LCK_EC_STAT) & ADP5588_KEC;
 		if (ev_cnt) {
 			adp5588_report_events(kpad, ev_cnt);
 			input_sync(kpad->input);
@@ -360,7 +333,7 @@ static int __devinit adp5588_setup(struct i2c_client *client)
 	if (pdata->en_keylock) {
 		ret |= adp5588_write(client, UNLOCK1, pdata->unlock_key1);
 		ret |= adp5588_write(client, UNLOCK2, pdata->unlock_key2);
-		ret |= adp5588_write(client, KEY_LCK_EC_STAT, K_LCK_EN);
+		ret |= adp5588_write(client, KEY_LCK_EC_STAT, ADP5588_K_LCK_EN);
 	}
 
 	for (i = 0; i < KEYP_MAX_EVENT; i++)
@@ -384,7 +357,7 @@ static int __devinit adp5588_setup(struct i2c_client *client)
 	}
 
 	if (gpio_data) {
-		for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+		for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 			int pull_mask = gpio_data->pullup_dis_mask;
 
 			ret |= adp5588_write(client, GPIO_PULL1 + i,
@@ -392,11 +365,14 @@ static int __devinit adp5588_setup(struct i2c_client *client)
 		}
 	}
 
-	ret |= adp5588_write(client, INT_STAT, CMP2_INT | CMP1_INT |
-					OVR_FLOW_INT | K_LCK_INT |
-					GPI_INT | KE_INT); /* Status is W1C */
+	ret |= adp5588_write(client, INT_STAT,
+				ADP5588_CMP2_INT | ADP5588_CMP1_INT |
+				ADP5588_OVR_FLOW_INT | ADP5588_K_LCK_INT |
+				ADP5588_GPI_INT | ADP5588_KE_INT); /* Status is W1C */
 
-	ret |= adp5588_write(client, CFG, INT_CFG | OVR_FLOW_IEN | KE_IEN);
+	ret |= adp5588_write(client, CFG, ADP5588_INT_CFG |
+					  ADP5588_OVR_FLOW_IEN |
+					  ADP5588_KE_IEN);
 
 	if (ret < 0) {
 		dev_err(&client->dev, "Write Error\n");
diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index 3c5d6b6..cec17cf 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -1,7 +1,7 @@
 /*
  * Analog Devices ADP5588 I/O Expander and QWERTY Keypad Controller
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2010 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -77,13 +77,26 @@
  /* Configuration Register1 */
 #define ADP5588_AUTO_INC	(1 << 7)
 #define ADP5588_GPIEM_CFG	(1 << 6)
+#define ADP5588_OVR_FLOW_M	(1 << 5)
 #define ADP5588_INT_CFG		(1 << 4)
+#define ADP5588_OVR_FLOW_IEN	(1 << 3)
+#define ADP5588_K_LCK_IM	(1 << 2)
 #define ADP5588_GPI_IEN		(1 << 1)
+#define ADP5588_KE_IEN		(1 << 0)
 
 /* Interrupt Status Register */
+#define ADP5588_CMP2_INT	(1 << 5)
+#define ADP5588_CMP1_INT	(1 << 4)
+#define ADP5588_OVR_FLOW_INT	(1 << 3)
+#define ADP5588_K_LCK_INT	(1 << 2)
 #define ADP5588_GPI_INT		(1 << 1)
 #define ADP5588_KE_INT		(1 << 0)
 
+/* Key Lock and Event Counter Register */
+#define ADP5588_K_LCK_EN	(1 << 6)
+#define ADP5588_LCK21		0x30
+#define ADP5588_KEC		0xF
+
 #define ADP5588_MAXGPIO		18
 #define ADP5588_BANK(offs)	((offs) >> 3)
 #define ADP5588_BIT(offs)	(1u << ((offs) & 0x7))
-- 
1.6.0.2

