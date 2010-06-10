From: Xiaolong CHEN <a21785@motorola.com>
Subject: [RFC] Input: ADP5588 - Support GPI event for ADP5588 devices
Date: Thu, 10 Jun 2010 10:36:14 +0800
Message-ID: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:54265 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab0FJCgR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 22:36:17 -0400
Received: from il06vts03.mot.com (il06vts03.mot.com [129.188.137.143])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id o5A2aTeX014233
	for <linux-input@vger.kernel.org>; Wed, 9 Jun 2010 20:36:29 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id o5A2aTkC014225
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Wed, 9 Jun 2010 20:36:29 -0600 (MDT)
Received: by iwn7 with SMTP id 7so3683918iwn.27
        for <linux-input@vger.kernel.org>; Wed, 09 Jun 2010 19:36:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Michael Hennerich <hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi,

This patch supports GPI event for ADP5588 devices.

Kernel Version: 2.6.34

A column or row configured as a GPI can be programmed to be part of
the key event table and therefore also capable of generating a key
event interrupt. A key event interrupt caused by a GPI follows the
same process flow as a key event interrupt caused by a key press. GPIs
configured as part of the key event table allow single key switches
and other GPI interrupts to bemonitored. As part of the event table,
GPIs are represented by the decimal value 97 (0x61or 1100001) through
the decimal value 114 (0x72 or 1110010). See Table as below for GPI
event number assignments for rows and columns.

GPI Event Number Assignments for Rows
Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
97       98       99       100     101     102     103    104

GPI Event Number Assignments for Cols
Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
105  106   107   108   109   110   111   112  113  114

Usage:
1. Enable CONFIG_KEYBOARD_ADP5588_GPI_EVENT
2. Add gpimap and gpimapsize setting in adp5588_kpad_platform_data
(The settings should not conflict with rows/cols for keymap)

Patch:
>From 75412f66cc16c19c8b6046ed499ccf6e34db01c3 Mon Sep 17 00:00:00 2001
From: xiaolong <a21785@motorola.com>
Date: Thu, 10 Jun 2010 05:13:13 -0400
Subject: [PATCH] Input: ADP5588 - Support GPI event for ADP5588 devices

A column or row configured as a GPI can be programmed to be part
of the key event table and therefore also capable of generating a
key event interrupt. A key event interrupt caused by a GPI follows
the same process flow as a key event interrupt caused by a key
press. GPIs configured as part of the key event table allow single
key switches and other GPI interrupts to bemonitored. As part of
the event table, GPIs are represented by the decimal value 97 (0x61
or 1100001) through the decimal value 114 (0x72 or 1110010). See
Table as below for GPI event number assignments for rows and columns.

GPI Event Number Assignments for Rows
Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
97   98   99   100  101  102  103  104

GPI Event Number Assignments for Cols
Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
105  106  107  108  109  110  111  112  113  114

Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
---
 drivers/input/keyboard/Kconfig        |    8 ++
 drivers/input/keyboard/adp5588-keys.c |  126 +++++++++++++++++++++++++++++++++
 include/linux/i2c/adp5588.h           |   40 ++++++++++
 3 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 64c1023..aebf8de 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -44,6 +44,14 @@ config KEYBOARD_ADP5588
 	  To compile this driver as a module, choose M here: the
 	  module will be called adp5588-keys.

+config KEYBOARD_ADP5588_GPI_EVENT
+	tristate "ADP5588 GPI event on key event interrupt"
+	depends on KEYBOARD_ADP5588
+	help
+	  Enable GPI events on key event interrupt, GPIs configured
+	  as part of the key event table allow single key switches
+	  and other GPI interrupts to be monitored.
+
 config KEYBOARD_AMIGA
 	tristate "Amiga keyboard"
 	depends on AMIGA
diff --git a/drivers/input/keyboard/adp5588-keys.c
b/drivers/input/keyboard/adp5588-keys.c
index b5142d2..4cd5cee 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -66,6 +66,10 @@ struct adp5588_kpad {
 	struct delayed_work work;
 	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	const struct adp5588_gpi_map *gpimap;
+	unsigned short gpimapsize;
+#endif
 };

 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -99,10 +103,33 @@ static void adp5588_work(struct work_struct *work)
 		ev_cnt = adp5588_read(client, KEY_LCK_EC_STAT) & KEC;
 		if (ev_cnt) {
 			for (i = 0; i < ev_cnt; i++) {
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+				int j, key_val, pin;
+#endif
 				key = adp5588_read(client, Key_EVENTA + i);
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+				key_val = key & (~KEY_EV_PRESSED);
+
+				if ((key_val >= GPI_PIN_BASE) &&
+					(key_val <= GPI_PIN_END)) {
+					for (j = 0; j < kpad->gpimapsize; j++) {
+						pin = kpad->gpimap[j].pin;
+						if (key_val != pin)
+							continue;
+
+						input_report_switch(kpad->input,
+							kpad->gpimap[j].sw_evt,
+							key & KEY_EV_PRESSED);
+						break;
+					}
+				} else {
+#endif
 				input_report_key(kpad->input,
 					kpad->keycode[(key & KEY_EV_MASK) - 1],
 					key & KEY_EV_PRESSED);
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+				}
+#endif
 			}
 			input_sync(kpad->input);
 		}
@@ -129,6 +156,9 @@ static int __devinit adp5588_setup(struct
i2c_client *client)
 {
 	struct adp5588_kpad_platform_data *pdata = client->dev.platform_data;
 	int i, ret;
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
+#endif

 	ret = adp5588_write(client, KP_GPIO1, KP_SEL(pdata->rows));
 	ret |= adp5588_write(client, KP_GPIO2, KP_SEL(pdata->cols) & 0xFF);
@@ -143,6 +173,23 @@ static int __devinit adp5588_setup(struct
i2c_client *client)
 	for (i = 0; i < KEYP_MAX_EVENT; i++)
 		ret |= adp5588_read(client, Key_EVENTA);

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	for (i = 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin = pdata->gpimap[i].pin;
+
+		if (pin <= GPI_PIN_ROW_END) {
+			evt_mode1 |= (1 << (pin - GPI_PIN_ROW_BASE));
+		} else {
+			evt_mode2 |= ((1 << (pin - GPI_PIN_COL_BASE)) & 0xFF);
+			evt_mode3 |= ((1 << (pin - GPI_PIN_COL_BASE)) >> 8);
+		}
+	}
+
+	ret |= adp5588_write(client, GPI_EM1, evt_mode1);
+	ret |= adp5588_write(client, GPI_EM2, evt_mode2);
+	ret |= adp5588_write(client, GPI_EM3, evt_mode3);
+#endif
+
 	ret |= adp5588_write(client, INT_STAT, CMP2_INT | CMP1_INT |
 					OVR_FLOW_INT | K_LCK_INT |
 					GPI_INT | KE_INT); /* Status is W1C */
@@ -166,6 +213,9 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	unsigned int revid;
 	int ret, i;
 	int error;
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	int gpi_stat1 = 0, gpi_stat2 = 0, gpi_stat3 = 0;
+#endif

 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -188,6 +238,39 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 		return -EINVAL;
 	}

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	if (!pdata->gpimap) {
+		dev_err(&client->dev, "no gpimap from pdata\n");
+		return -EINVAL;
+	}
+
+	if (pdata->gpimapsize > ADP5588_GPIMAPSIZE_MAX) {
+		dev_err(&client->dev, "invalid gpimapsize\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin = pdata->gpimap[i].pin;
+
+		if ((pin < GPI_PIN_BASE) || (pin > GPI_PIN_END)) {
+			dev_err(&client->dev, "invalid gpi pin data\n");
+			return -EINVAL;
+		}
+
+		if (pin <= GPI_PIN_ROW_END) {
+			if ((pin - GPI_PIN_ROW_BASE + 1) <= pdata->rows) {
+				dev_err(&client->dev, "invalid gpi row data\n");
+				return -EINVAL;
+			}
+		} else {
+			if ((pin - GPI_PIN_COL_BASE + 1) <= pdata->cols) {
+				dev_err(&client->dev, "invalid gpi col data\n");
+				return -EINVAL;
+			}
+		}
+	}
+#endif
+
 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
 		return -EINVAL;
@@ -232,6 +315,11 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	memcpy(kpad->keycode, pdata->keymap,
 		pdata->keymapsize * input->keycodesize);

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	kpad->gpimap = pdata->gpimap;
+	kpad->gpimapsize = pdata->gpimapsize;
+#endif
+
 	/* setup input device */
 	__set_bit(EV_KEY, input->evbit);

@@ -242,6 +330,12 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 		__set_bit(kpad->keycode[i] & KEY_MAX, input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	__set_bit(EV_SW, input->evbit);
+	for (i = 0; i < kpad->gpimapsize; i++)
+		__set_bit(kpad->gpimap[i].sw_evt, input->swbit);
+#endif
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device\n");
@@ -263,6 +357,38 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	gpi_stat1 = adp5588_read(client, GPIO_DAT_STAT1);
+	gpi_stat2 = adp5588_read(client, GPIO_DAT_STAT2);
+	gpi_stat3 = adp5588_read(client, GPIO_DAT_STAT3);
+
+	for (i = 0; i < kpad->gpimapsize; i++) {
+		int gpi_stat_tmp, pin_loc;
+		unsigned short pin = kpad->gpimap[i].pin;
+
+		if (pin <= GPI_PIN_ROW_END) {
+			gpi_stat_tmp = gpi_stat1;
+			pin_loc = pin - GPI_PIN_ROW_BASE;
+		} else if ((pin - GPI_PIN_COL_BASE) < 8) {
+			gpi_stat_tmp = gpi_stat2;
+			pin_loc = pin - GPI_PIN_COL_BASE;
+		} else {
+			gpi_stat_tmp = gpi_stat3;
+			pin_loc = pin - GPI_PIN_COL_BASE - 8;
+		}
+
+		if (gpi_stat_tmp < 0) {
+			dev_err(&client->dev, "Can't read GPIO_DAT_STAT "
+				"switch %d default to OFF\n", pin);
+			gpi_stat_tmp = 0;
+		}
+
+		input_report_switch(input, kpad->gpimap[i].sw_evt,
+			!(gpi_stat_tmp & (1 << pin_loc)));
+		input_sync(input);
+	}
+#endif
+
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index 02c9af3..bb6365d 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -78,6 +78,42 @@

 #define ADP5588_KEYMAPSIZE	80

+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+#define GPI_PIN_ROW0 97
+#define GPI_PIN_ROW1 98
+#define GPI_PIN_ROW2 99
+#define GPI_PIN_ROW3 100
+#define GPI_PIN_ROW4 101
+#define GPI_PIN_ROW5 102
+#define GPI_PIN_ROW6 103
+#define GPI_PIN_ROW7 104
+#define GPI_PIN_COL0 105
+#define GPI_PIN_COL1 106
+#define GPI_PIN_COL2 107
+#define GPI_PIN_COL3 108
+#define GPI_PIN_COL4 109
+#define GPI_PIN_COL5 110
+#define GPI_PIN_COL6 111
+#define GPI_PIN_COL7 112
+#define GPI_PIN_COL8 113
+#define GPI_PIN_COL9 114
+
+#define GPI_PIN_ROW_BASE GPI_PIN_ROW0
+#define GPI_PIN_ROW_END GPI_PIN_ROW7
+#define GPI_PIN_COL_BASE GPI_PIN_COL0
+#define GPI_PIN_COL_END GPI_PIN_COL9
+
+#define GPI_PIN_BASE GPI_PIN_ROW_BASE
+#define GPI_PIN_END GPI_PIN_COL_END
+
+#define ADP5588_GPIMAPSIZE_MAX (GPI_PIN_END - GPI_PIN_BASE + 1)
+
+struct adp5588_gpi_map {
+	unsigned short pin;
+	unsigned short sw_evt;
+};
+#endif
+
 struct adp5588_kpad_platform_data {
 	int rows;			/* Number of rows */
 	int cols;			/* Number of columns */
@@ -87,6 +123,10 @@ struct adp5588_kpad_platform_data {
 	unsigned en_keylock:1;		/* Enable Key Lock feature */
 	unsigned short unlock_key1;	/* Unlock Key 1 */
 	unsigned short unlock_key2;	/* Unlock Key 2 */
+#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
+	const struct adp5588_gpi_map *gpimap;
+	unsigned short gpimapsize;
+#endif
 };

 struct adp5588_gpio_platform_data {
-- 
1.5.4.3

If there is any comments and suggestion, please let me know.

Thanks,
Xiaolong
