From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] Input: ADP5589 - new driver for I2C Keypad Decoder and I/O Expander
Date: Thu, 24 Mar 2011 11:01:37 -0400
Message-ID: <1300978897-25833-1-git-send-email-vapier@gentoo.org>
References: <1300896316-15391-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38030 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab1CXPBI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2011 11:01:08 -0400
In-Reply-To: <1300896316-15391-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

>From http://www.analog.com/ADP5589:
The ADP5589 is an I/O port expander and keypad matrix decoder designed
for QWERTY type phones that require a large keypad matrix and expanded
I/O lines.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v2
	- address feedback from Dmitry et al

 drivers/input/keyboard/Kconfig        |   10 +
 drivers/input/keyboard/Makefile       |    1 +
 drivers/input/keyboard/adp5589-keys.c |  764 +++++++++++++++++++++++++++++++++
 include/linux/input/adp5589.h         |  213 +++++++++
 4 files changed, 988 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/adp5589-keys.c
 create mode 100644 include/linux/input/adp5589.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b16bed0..688a55c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -32,6 +32,16 @@ config KEYBOARD_ADP5588
 	  To compile this driver as a module, choose M here: the
 	  module will be called adp5588-keys.
 
+config KEYBOARD_ADP5589
+	tristate "ADP5589 I2C QWERTY Keypad and IO Expander"
+	depends on I2C
+	help
+	  Say Y here if you want to use a ADP5589 attached to your
+	  system I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adp5589-keys.
+
 config KEYBOARD_AMIGA
 	tristate "Amiga keyboard"
 	depends on AMIGA
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 878e6c2..f57425c 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
+obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
new file mode 100644
index 0000000..b1118ca
--- /dev/null
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -0,0 +1,764 @@
+/*
+ * Description:  keypad driver for ADP5589
+ *		 I2C QWERTY Keypad and IO Expander
+ * Bugs: Enter bugs at http://blackfin.uclinux.org/
+ *
+ * Copyright (C) 2010-2011 Analog Devices Inc.
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/workqueue.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+
+#include <linux/input/adp5589.h>
+
+/* GENERAL_CFG Register */
+#define OSC_EN		(1 << 7)
+#define CORE_CLK(x)	(((x) & 0x3) << 5)
+#define LCK_TRK_LOGIC	(1 << 4)
+#define LCK_TRK_GPI	(1 << 3)
+#define INT_CFG		(1 << 1)
+#define RST_CFG		(1 << 0)
+
+/* INT_EN Register */
+#define LOGIC2_IEN	(1 << 5)
+#define LOGIC1_IEN	(1 << 4)
+#define LOCK_IEN	(1 << 3)
+#define OVRFLOW_IEN	(1 << 2)
+#define GPI_IEN		(1 << 1)
+#define EVENT_IEN	(1 << 0)
+
+/* Interrupt Status Register */
+#define LOGIC2_INT	(1 << 5)
+#define LOGIC1_INT	(1 << 4)
+#define LOCK_INT	(1 << 3)
+#define OVRFLOW_INT	(1 << 2)
+#define GPI_INT		(1 << 1)
+#define EVENT_INT	(1 << 0)
+
+/* STATUS Register */
+
+#define LOGIC2_STAT	(1 << 7)
+#define LOGIC1_STAT	(1 << 6)
+#define LOCK_STAT	(1 << 5)
+#define KEC		0xF
+
+/* PIN_CONFIG_D Register */
+#define C4_EXTEND_CFG	(1 << 6)	/* RESET2 */
+#define R4_EXTEND_CFG	(1 << 5)	/* RESET1 */
+
+/* LOCK_CFG */
+#define LOCK_EN		(1 << 0)
+
+#define PTIME_MASK	0x3
+#define LTIME_MASK	0x3
+
+/* Key Event Register xy */
+#define KEY_EV_PRESSED		(1 << 7)
+#define KEY_EV_MASK		(0x7F)
+
+#define KEYP_MAX_EVENT		16
+
+#define MAXGPIO			19
+#define ADP_BANK(offs)		((offs) >> 3)
+#define ADP_BIT(offs)		(1u << ((offs) & 0x7))
+
+struct adp5589_kpad {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned short keycode[ADP5589_KEYMAPSIZE];
+	const struct adp5589_gpi_map *gpimap;
+	unsigned short gpimapsize;
+	unsigned extend_cfg;
+#ifdef CONFIG_GPIOLIB
+	unsigned char gpiomap[MAXGPIO];
+	bool export_gpio;
+	struct gpio_chip gc;
+	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
+	u8 dat_out[3];
+	u8 dir[3];
+#endif
+};
+
+static int adp5589_read(struct i2c_client *client, u8 reg)
+{
+	int ret = i2c_smbus_read_byte_data(client, reg);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Read Error\n");
+
+	return ret;
+}
+
+static int adp5589_write(struct i2c_client *client, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(client, reg, val);
+}
+
+#ifdef CONFIG_GPIOLIB
+static int adp5589_gpio_get_value(struct gpio_chip *chip, unsigned off)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+
+	return !!(adp5589_read(kpad->client, ADP5589_GPI_STATUS_A + bank) &
+		  bit);
+}
+
+static void adp5589_gpio_set_value(struct gpio_chip *chip,
+				   unsigned off, int val)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+
+	mutex_lock(&kpad->gpio_lock);
+
+	if (val)
+		kpad->dat_out[bank] |= bit;
+	else
+		kpad->dat_out[bank] &= ~bit;
+
+	adp5589_write(kpad->client, ADP5589_GPO_DATA_OUT_A + bank,
+		      kpad->dat_out[bank]);
+
+	mutex_unlock(&kpad->gpio_lock);
+}
+
+static int adp5589_gpio_direction_input(struct gpio_chip *chip, unsigned off)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	int ret;
+
+	mutex_lock(&kpad->gpio_lock);
+
+	kpad->dir[bank] &= ~bit;
+	ret =
+	    adp5589_write(kpad->client, ADP5589_GPIO_DIRECTION_A + bank,
+			  kpad->dir[bank]);
+
+	mutex_unlock(&kpad->gpio_lock);
+
+	return ret;
+}
+
+static int adp5589_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned off, int val)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	int ret;
+
+	mutex_lock(&kpad->gpio_lock);
+
+	kpad->dir[bank] |= bit;
+
+	if (val)
+		kpad->dat_out[bank] |= bit;
+	else
+		kpad->dat_out[bank] &= ~bit;
+
+	ret = adp5589_write(kpad->client, ADP5589_GPO_DATA_OUT_A + bank,
+			    kpad->dat_out[bank]);
+	ret |= adp5589_write(kpad->client, ADP5589_GPIO_DIRECTION_A + bank,
+			     kpad->dir[bank]);
+
+	mutex_unlock(&kpad->gpio_lock);
+
+	return ret;
+}
+
+static int __devinit adp5589_build_gpiomap(struct adp5589_kpad *kpad,
+				const struct adp5589_kpad_platform_data *pdata)
+{
+	bool pin_used[MAXGPIO];
+	int n_unused = 0;
+	int i;
+
+	memset(pin_used, false, sizeof(pin_used));
+
+	for (i = 0; i < MAXGPIO; i++)
+		if (pdata->keypad_en_mask & (1 << i))
+			pin_used[i] = true;
+
+	for (i = 0; i < kpad->gpimapsize; i++)
+		pin_used[kpad->gpimap[i].pin - ADP5589_GPI_PIN_BASE] = true;
+
+	if (kpad->extend_cfg & R4_EXTEND_CFG)
+		pin_used[4] = true;
+
+	if (kpad->extend_cfg & C4_EXTEND_CFG)
+		pin_used[12] = true;
+
+	for (i = 0; i < MAXGPIO; i++)
+		if (!pin_used[i])
+			kpad->gpiomap[n_unused++] = i;
+
+	return n_unused;
+}
+
+static int __devinit adp5589_gpio_add(struct adp5589_kpad *kpad)
+{
+	struct device *dev = &kpad->client->dev;
+	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
+	int i, error;
+
+	if (!gpio_data)
+		return 0;
+
+	kpad->gc.ngpio = adp5589_build_gpiomap(kpad, pdata);
+	if (kpad->gc.ngpio == 0) {
+		dev_info(dev, "No unused gpios left to export\n");
+		return 0;
+	}
+
+	kpad->export_gpio = true;
+
+	kpad->gc.direction_input = adp5589_gpio_direction_input;
+	kpad->gc.direction_output = adp5589_gpio_direction_output;
+	kpad->gc.get = adp5589_gpio_get_value;
+	kpad->gc.set = adp5589_gpio_set_value;
+	kpad->gc.can_sleep = 1;
+
+	kpad->gc.base = gpio_data->gpio_start;
+	kpad->gc.label = kpad->client->name;
+	kpad->gc.owner = THIS_MODULE;
+
+	mutex_init(&kpad->gpio_lock);
+
+	error = gpiochip_add(&kpad->gc);
+	if (error) {
+		dev_err(dev, "gpiochip_add failed, err: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+		kpad->dat_out[i] = adp5589_read(kpad->client,
+						ADP5589_GPO_DATA_OUT_A + i);
+		kpad->dir[i] =
+		    adp5589_read(kpad->client, ADP5589_GPIO_DIRECTION_A + i);
+	}
+
+	if (gpio_data->setup) {
+		error = gpio_data->setup(kpad->client,
+					 kpad->gc.base, kpad->gc.ngpio,
+					 gpio_data->context);
+		if (error)
+			dev_warn(dev, "setup failed, %d\n", error);
+	}
+
+	return 0;
+}
+
+static void __devexit adp5589_gpio_remove(struct adp5589_kpad *kpad)
+{
+	struct device *dev = &kpad->client->dev;
+	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
+	int error;
+
+	if (!kpad->export_gpio)
+		return;
+
+	if (gpio_data->teardown) {
+		error = gpio_data->teardown(kpad->client,
+					    kpad->gc.base, kpad->gc.ngpio,
+					    gpio_data->context);
+		if (error)
+			dev_warn(dev, "teardown failed %d\n", error);
+	}
+
+	error = gpiochip_remove(&kpad->gc);
+	if (error)
+		dev_warn(dev, "gpiochip_remove failed %d\n", error);
+}
+#else
+static inline int adp5589_gpio_add(struct adp5589_kpad *kpad)
+{
+	return 0;
+}
+
+static inline void adp5589_gpio_remove(struct adp5589_kpad *kpad)
+{
+}
+#endif
+
+static void adp5589_report_events(struct adp5589_kpad *kpad, int ev_cnt)
+{
+	int i, j;
+
+	for (i = 0; i < ev_cnt; i++) {
+		int key = adp5589_read(kpad->client, ADP5589_FIFO_1 + i);
+		int key_val = key & KEY_EV_MASK;
+
+		if (key_val >= ADP5589_GPI_PIN_BASE
+		    && key_val <= ADP5589_GPI_PIN_END) {
+			for (j = 0; j < kpad->gpimapsize; j++) {
+				if (key_val == kpad->gpimap[j].pin) {
+					input_report_switch(kpad->input,
+							    kpad->gpimap[j].
+							    sw_evt,
+							    key &
+							    KEY_EV_PRESSED);
+					break;
+				}
+			}
+		} else {
+			input_report_key(kpad->input,
+					 kpad->keycode[key_val - 1],
+					 key & KEY_EV_PRESSED);
+		}
+	}
+}
+
+static irqreturn_t adp5589_irq(int irq, void *handle)
+{
+	struct adp5589_kpad *kpad = handle;
+	struct i2c_client *client = kpad->client;
+	int status, ev_cnt;
+
+	status = adp5589_read(client, ADP5589_INT_STATUS);
+
+	if (status & OVRFLOW_INT)	/* Unlikely and should never happen */
+		dev_err(&client->dev, "Event Overflow Error\n");
+
+	if (status & EVENT_INT) {
+		ev_cnt = adp5589_read(client, ADP5589_STATUS) & KEC;
+		if (ev_cnt) {
+			adp5589_report_events(kpad, ev_cnt);
+			input_sync(kpad->input);
+		}
+	}
+	adp5589_write(client, ADP5589_INT_STATUS, status);	/* Status is W1C */
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit adp5589_get_evcode(struct adp5589_kpad *kpad, unsigned short key)
+{
+	int i;
+	for (i = 0; i < ADP5589_KEYMAPSIZE; i++)
+		if (key == kpad->keycode[i])
+			return (i + 1) | KEY_EV_PRESSED;
+
+	dev_err(&kpad->client->dev, "RESET/UNLOCK key not in keycode map\n");
+	return -EINVAL;
+}
+static int __devinit adp5589_setup(struct adp5589_kpad *kpad)
+{
+	struct i2c_client *client = kpad->client;
+	const struct adp5589_kpad_platform_data *pdata =
+	    client->dev.platform_data;
+	int i, ret;
+	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
+	unsigned char pull_mask = 0;
+
+	ret = adp5589_write(client, ADP5589_PIN_CONFIG_A,
+			    pdata->keypad_en_mask & 0xFF);
+	ret |= adp5589_write(client, ADP5589_PIN_CONFIG_B,
+			     (pdata->keypad_en_mask >> 8) & 0xFF);
+	ret |= adp5589_write(client, ADP5589_PIN_CONFIG_C,
+			     (pdata->keypad_en_mask >> 16) & 0xFF);
+
+	if (pdata->en_keylock) {
+		ret |= adp5589_write(client, ADP5589_UNLOCK1,
+				     pdata->unlock_key1);
+		ret |= adp5589_write(client, ADP5589_UNLOCK2,
+				     pdata->unlock_key2);
+		ret |= adp5589_write(client, ADP5589_UNLOCK_TIMERS,
+				     pdata->unlock_timer & LTIME_MASK);
+		ret |= adp5589_write(client, ADP5589_LOCK_CFG, LOCK_EN);
+	}
+
+	for (i = 0; i < KEYP_MAX_EVENT; i++)
+		ret |= adp5589_read(client, ADP5589_FIFO_1 + i);
+
+	for (i = 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin = pdata->gpimap[i].pin;
+
+		if (pin <= ADP5589_GPI_PIN_ROW_END) {
+			evt_mode1 |= (1 << (pin - ADP5589_GPI_PIN_ROW_BASE));
+		} else {
+			evt_mode2 |=
+			    ((1 << (pin - ADP5589_GPI_PIN_COL_BASE)) & 0xFF);
+			evt_mode3 |=
+			    ((1 << (pin - ADP5589_GPI_PIN_COL_BASE)) >> 8);
+		}
+	}
+
+	if (pdata->gpimapsize) {
+		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_A, evt_mode1);
+		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_B, evt_mode2);
+		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_C, evt_mode3);
+	}
+
+	if (pdata->pull_dis_mask & pdata->pullup_en_100k &
+	    pdata->pullup_en_300k & pdata->pulldown_en_300k)
+		dev_warn(&client->dev, "Conflicting pull resistor config\n");
+
+	for (i = 0; i < MAXGPIO; i++) {
+		unsigned val = 0;
+		if (pdata->pullup_en_300k & (1 << i))
+			val = 0;
+		else if (pdata->pulldown_en_300k & (1 << i))
+			val = 1;
+		else if (pdata->pullup_en_100k & (1 << i))
+			val = 2;
+		else if (pdata->pull_dis_mask & (1 << i))
+			val = 3;
+
+		pull_mask |= val << (2 * (i & 0x3));
+
+		if (((i & 0x3) == 0x3) || (i == (MAXGPIO - 1))) {
+			ret |= adp5589_write(client,
+					     ADP5589_RPULL_CONFIG_A + (i >> 2),
+					     pull_mask);
+			pull_mask = 0;
+		}
+	}
+
+	if (pdata->reset1_key_1 && pdata->reset1_key_2 &&
+		pdata->reset1_key_3) {
+		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_A,
+				     adp5589_get_evcode(kpad,
+				     pdata->reset1_key_1));
+		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_B,
+				     adp5589_get_evcode(kpad,
+				     pdata->reset1_key_2));
+		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_C,
+				     adp5589_get_evcode(kpad,
+				     pdata->reset1_key_3));
+		kpad->extend_cfg |= R4_EXTEND_CFG;
+	}
+
+	if (pdata->reset2_key_1 && pdata->reset2_key_2) {
+		ret |= adp5589_write(client, ADP5589_RESET2_EVENT_A,
+				     adp5589_get_evcode(kpad,
+				     pdata->reset2_key_1));
+		ret |= adp5589_write(client, ADP5589_RESET2_EVENT_B,
+				     adp5589_get_evcode(kpad,
+				     pdata->reset2_key_2));
+		kpad->extend_cfg |= C4_EXTEND_CFG;
+	}
+
+	if (kpad->extend_cfg) {
+		ret |= adp5589_write(client, ADP5589_RESET_CFG,
+				     pdata->reset_cfg);
+		ret |= adp5589_write(client, ADP5589_PIN_CONFIG_D,
+				     kpad->extend_cfg);
+	}
+
+	for (i = 0; i <= ADP_BANK(MAXGPIO); i++)
+		ret |= adp5589_write(client, ADP5589_DEBOUNCE_DIS_A + i,
+				     pdata->debounce_dis_mask >> (i * 8));
+
+	ret |= adp5589_write(client, ADP5589_POLL_PTIME_CFG,
+			     pdata->scan_cycle_time & PTIME_MASK);
+	ret |= adp5589_write(client, ADP5589_INT_STATUS, LOGIC2_INT |
+			     LOGIC1_INT | OVRFLOW_INT | LOCK_INT |
+			     GPI_INT | EVENT_INT);	/* Status is W1C */
+
+	ret |= adp5589_write(client, ADP5589_GENERAL_CFG,
+			     INT_CFG | OSC_EN | CORE_CLK(3));
+	ret |= adp5589_write(client, ADP5589_INT_EN,
+			     OVRFLOW_IEN | GPI_IEN | EVENT_IEN);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Write Error\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __devinit adp5589_report_switch_state(struct adp5589_kpad *kpad)
+{
+	int gpi_stat1 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_A);
+	int gpi_stat2 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_B);
+	int gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);
+	int gpi_stat_tmp, pin_loc;
+	int i;
+
+	for (i = 0; i < kpad->gpimapsize; i++) {
+		unsigned short pin = kpad->gpimap[i].pin;
+
+		if (pin <= ADP5589_GPI_PIN_ROW_END) {
+			gpi_stat_tmp = gpi_stat1;
+			pin_loc = pin - ADP5589_GPI_PIN_ROW_BASE;
+		} else if ((pin - ADP5589_GPI_PIN_COL_BASE) < 8) {
+			gpi_stat_tmp = gpi_stat2;
+			pin_loc = pin - ADP5589_GPI_PIN_COL_BASE;
+		} else {
+			gpi_stat_tmp = gpi_stat3;
+			pin_loc = pin - ADP5589_GPI_PIN_COL_BASE - 8;
+		}
+
+		if (gpi_stat_tmp < 0) {
+			dev_err(&kpad->client->dev,
+				"Can't read GPIO_DAT_STAT switch"
+				" %d default to OFF\n", pin);
+			gpi_stat_tmp = 0;
+		}
+
+		input_report_switch(kpad->input,
+				    kpad->gpimap[i].sw_evt,
+				    !(gpi_stat_tmp & (1 << pin_loc)));
+	}
+
+	input_sync(kpad->input);
+}
+
+static int __devinit adp5589_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct adp5589_kpad *kpad;
+	const struct adp5589_kpad_platform_data *pdata =
+	    client->dev.platform_data;
+	struct input_dev *input;
+	unsigned int revid;
+	int ret, i;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
+		return -EIO;
+	}
+
+	if (!pdata) {
+		dev_err(&client->dev, "no platform data?\n");
+		return -EINVAL;
+	}
+
+	if (!((pdata->keypad_en_mask & 0xFF) &&
+		(pdata->keypad_en_mask >> 8)) || !pdata->keymap) {
+		dev_err(&client->dev, "no rows, cols or keymap from pdata\n");
+		return -EINVAL;
+	}
+
+	if (pdata->keymapsize != ADP5589_KEYMAPSIZE) {
+		dev_err(&client->dev, "invalid keymapsize\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->gpimap && pdata->gpimapsize) {
+		dev_err(&client->dev, "invalid gpimap from pdata\n");
+		return -EINVAL;
+	}
+
+	if (pdata->gpimapsize > ADP5589_GPIMAPSIZE_MAX) {
+		dev_err(&client->dev, "invalid gpimapsize\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin = pdata->gpimap[i].pin;
+
+		if (pin < ADP5589_GPI_PIN_BASE || pin > ADP5589_GPI_PIN_END) {
+			dev_err(&client->dev, "invalid gpi pin data\n");
+			return -EINVAL;
+		}
+
+		if ((1 << (pin - ADP5589_GPI_PIN_ROW_BASE)) &
+			pdata->keypad_en_mask) {
+			dev_err(&client->dev, "invalid gpi row/col data\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!client->irq) {
+		dev_err(&client->dev, "no IRQ?\n");
+		return -EINVAL;
+	}
+
+	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!kpad || !input) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	kpad->client = client;
+	kpad->input = input;
+
+	ret = adp5589_read(client, ADP5589_ID);
+	if (ret < 0) {
+		error = ret;
+		goto err_free_mem;
+	}
+
+	revid = (u8) ret & ADP5589_DEVICE_ID_MASK;
+
+	input->name = client->name;
+	input->phys = "adp5589-keys/input0";
+	input->dev.parent = &client->dev;
+
+	input_set_drvdata(input, kpad);
+
+	input->id.bustype = BUS_I2C;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = revid;
+
+	input->keycodesize = sizeof(kpad->keycode[0]);
+	input->keycodemax = pdata->keymapsize;
+	input->keycode = kpad->keycode;
+
+	memcpy(kpad->keycode, pdata->keymap,
+	       pdata->keymapsize * input->keycodesize);
+
+	kpad->gpimap = pdata->gpimap;
+	kpad->gpimapsize = pdata->gpimapsize;
+
+	/* setup input device */
+	__set_bit(EV_KEY, input->evbit);
+
+	if (pdata->repeat)
+		__set_bit(EV_REP, input->evbit);
+
+	for (i = 0; i < input->keycodemax; i++)
+		__set_bit(kpad->keycode[i] & KEY_MAX, input->keybit);
+	__clear_bit(KEY_RESERVED, input->keybit);
+
+	if (kpad->gpimapsize)
+		__set_bit(EV_SW, input->evbit);
+	for (i = 0; i < kpad->gpimapsize; i++)
+		__set_bit(kpad->gpimap[i].sw_evt, input->swbit);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&client->dev, "unable to register input device\n");
+		goto err_free_mem;
+	}
+
+	error = request_threaded_irq(client->irq, NULL, adp5589_irq,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     client->dev.driver->name, kpad);
+	if (error) {
+		dev_err(&client->dev, "irq %d busy?\n", client->irq);
+		goto err_unreg_dev;
+	}
+
+	error = adp5589_setup(kpad);
+	if (error)
+		goto err_free_irq;
+
+	if (kpad->gpimapsize)
+		adp5589_report_switch_state(kpad);
+
+	error = adp5589_gpio_add(kpad);
+	if (error)
+		goto err_free_irq;
+
+	device_init_wakeup(&client->dev, 1);
+	i2c_set_clientdata(client, kpad);
+
+	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, kpad);
+err_unreg_dev:
+	input_unregister_device(input);
+	input = NULL;
+err_free_mem:
+	input_free_device(input);
+	kfree(kpad);
+
+	return error;
+}
+
+static int __devexit adp5589_remove(struct i2c_client *client)
+{
+	struct adp5589_kpad *kpad = i2c_get_clientdata(client);
+
+	adp5589_write(client, ADP5589_GENERAL_CFG, 0);
+	free_irq(client->irq, kpad);
+	input_unregister_device(kpad->input);
+	adp5589_gpio_remove(kpad);
+	kfree(kpad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int adp5589_suspend(struct device *dev)
+{
+	struct adp5589_kpad *kpad = dev_get_drvdata(dev);
+	struct i2c_client *client = kpad->client;
+
+	disable_irq(client->irq);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int adp5589_resume(struct device *dev)
+{
+	struct adp5589_kpad *kpad = dev_get_drvdata(dev);
+	struct i2c_client *client = kpad->client;
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(adp5589_dev_pm_ops, adp5589_suspend, adp5589_resume);
+
+static const struct i2c_device_id adp5589_id[] = {
+	{"adp5589-keys", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, adp5589_id);
+
+static struct i2c_driver adp5589_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.owner = THIS_MODULE,
+		.pm = &adp5589_dev_pm_ops,
+	},
+	.probe = adp5589_probe,
+	.remove = __devexit_p(adp5589_remove),
+	.id_table = adp5589_id,
+};
+
+static int __init adp5589_init(void)
+{
+	return i2c_add_driver(&adp5589_driver);
+}
+
+module_init(adp5589_init);
+
+static void __exit adp5589_exit(void)
+{
+	i2c_del_driver(&adp5589_driver);
+}
+
+module_exit(adp5589_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("ADP5589 Keypad driver");
diff --git a/include/linux/input/adp5589.h b/include/linux/input/adp5589.h
new file mode 100644
index 0000000..ef792ec
--- /dev/null
+++ b/include/linux/input/adp5589.h
@@ -0,0 +1,213 @@
+/*
+ * Analog Devices ADP5589 I/O Expander and QWERTY Keypad Controller
+ *
+ * Copyright 2010-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef _ADP5589_H
+#define _ADP5589_H
+
+#define ADP5589_ID			0x00
+#define ADP5589_INT_STATUS		0x01
+#define ADP5589_STATUS			0x02
+#define ADP5589_FIFO_1			0x03
+#define ADP5589_FIFO_2			0x04
+#define ADP5589_FIFO_3			0x05
+#define ADP5589_FIFO_4			0x06
+#define ADP5589_FIFO_5			0x07
+#define ADP5589_FIFO_6			0x08
+#define ADP5589_FIFO_7			0x09
+#define ADP5589_FIFO_8			0x0A
+#define ADP5589_FIFO_9			0x0B
+#define ADP5589_FIFO_10			0x0C
+#define ADP5589_FIFO_11			0x0D
+#define ADP5589_FIFO_12			0x0E
+#define ADP5589_FIFO_13			0x0F
+#define ADP5589_FIFO_14			0x10
+#define ADP5589_FIFO_15			0x11
+#define ADP5589_FIFO_16			0x12
+#define ADP5589_GPI_INT_STAT_A		0x13
+#define ADP5589_GPI_INT_STAT_B		0x14
+#define ADP5589_GPI_INT_STAT_C		0x15
+#define ADP5589_GPI_STATUS_A		0x16
+#define ADP5589_GPI_STATUS_B		0x17
+#define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_RPULL_CONFIG_B		0x1A
+#define ADP5589_RPULL_CONFIG_C		0x1B
+#define ADP5589_RPULL_CONFIG_D		0x1C
+#define ADP5589_RPULL_CONFIG_E		0x1D
+#define ADP5589_GPI_INT_LEVEL_A		0x1E
+#define ADP5589_GPI_INT_LEVEL_B		0x1F
+#define ADP5589_GPI_INT_LEVEL_C		0x20
+#define ADP5589_GPI_EVENT_EN_A		0x21
+#define ADP5589_GPI_EVENT_EN_B		0x22
+#define ADP5589_GPI_EVENT_EN_C		0x23
+#define ADP5589_GPI_INTERRUPT_EN_A	0x24
+#define ADP5589_GPI_INTERRUPT_EN_B	0x25
+#define ADP5589_GPI_INTERRUPT_EN_C	0x26
+#define ADP5589_DEBOUNCE_DIS_A		0x27
+#define ADP5589_DEBOUNCE_DIS_B		0x28
+#define ADP5589_DEBOUNCE_DIS_C		0x29
+#define ADP5589_GPO_DATA_OUT_A		0x2A
+#define ADP5589_GPO_DATA_OUT_B		0x2B
+#define ADP5589_GPO_DATA_OUT_C		0x2C
+#define ADP5589_GPO_OUT_MODE_A		0x2D
+#define ADP5589_GPO_OUT_MODE_B		0x2E
+#define ADP5589_GPO_OUT_MODE_C		0x2F
+#define ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_GPIO_DIRECTION_B	0x31
+#define ADP5589_GPIO_DIRECTION_C	0x32
+#define ADP5589_UNLOCK1			0x33
+#define ADP5589_UNLOCK2			0x34
+#define ADP5589_EXT_LOCK_EVENT		0x35
+#define ADP5589_UNLOCK_TIMERS		0x36
+#define ADP5589_LOCK_CFG		0x37
+#define ADP5589_RESET1_EVENT_A		0x38
+#define ADP5589_RESET1_EVENT_B		0x39
+#define ADP5589_RESET1_EVENT_C		0x3A
+#define ADP5589_RESET2_EVENT_A		0x3B
+#define ADP5589_RESET2_EVENT_B		0x3C
+#define ADP5589_RESET_CFG		0x3D
+#define ADP5589_PWM_OFFT_LOW		0x3E
+#define ADP5589_PWM_OFFT_HIGH		0x3F
+#define ADP5589_PWM_ONT_LOW		0x40
+#define ADP5589_PWM_ONT_HIGH		0x41
+#define ADP5589_PWM_CFG			0x42
+#define ADP5589_CLOCK_DIV_CFG		0x43
+#define ADP5589_LOGIC_1_CFG		0x44
+#define ADP5589_LOGIC_2_CFG		0x45
+#define ADP5589_LOGIC_FF_CFG		0x46
+#define ADP5589_LOGIC_INT_EVENT_EN	0x47
+#define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
+#define ADP5589_PIN_CONFIG_B		0x4A
+#define ADP5589_PIN_CONFIG_C		0x4B
+#define ADP5589_PIN_CONFIG_D		0x4C
+#define ADP5589_GENERAL_CFG		0x4D
+#define ADP5589_INT_EN			0x4E
+
+#define ADP5589_DEVICE_ID_MASK	0xF
+
+/* Put one of these structures in i2c_board_info platform_data */
+
+#define ADP5589_KEYMAPSIZE	88
+
+#define ADP5589_GPI_PIN_ROW0 97
+#define ADP5589_GPI_PIN_ROW1 98
+#define ADP5589_GPI_PIN_ROW2 99
+#define ADP5589_GPI_PIN_ROW3 100
+#define ADP5589_GPI_PIN_ROW4 101
+#define ADP5589_GPI_PIN_ROW5 102
+#define ADP5589_GPI_PIN_ROW6 103
+#define ADP5589_GPI_PIN_ROW7 104
+#define ADP5589_GPI_PIN_COL0 105
+#define ADP5589_GPI_PIN_COL1 106
+#define ADP5589_GPI_PIN_COL2 107
+#define ADP5589_GPI_PIN_COL3 108
+#define ADP5589_GPI_PIN_COL4 109
+#define ADP5589_GPI_PIN_COL5 110
+#define ADP5589_GPI_PIN_COL6 111
+#define ADP5589_GPI_PIN_COL7 112
+#define ADP5589_GPI_PIN_COL8 113
+#define ADP5589_GPI_PIN_COL9 114
+#define ADP5589_GPI_PIN_COL10 115
+#define GPI_LOGIC1 116
+#define GPI_LOGIC2 117
+
+#define ADP5589_GPI_PIN_ROW_BASE ADP5589_GPI_PIN_ROW0
+#define ADP5589_GPI_PIN_ROW_END ADP5589_GPI_PIN_ROW7
+#define ADP5589_GPI_PIN_COL_BASE ADP5589_GPI_PIN_COL0
+#define ADP5589_GPI_PIN_COL_END ADP5589_GPI_PIN_COL10
+
+#define ADP5589_GPI_PIN_BASE ADP5589_GPI_PIN_ROW_BASE
+#define ADP5589_GPI_PIN_END ADP5589_GPI_PIN_COL_END
+
+#define ADP5589_GPIMAPSIZE_MAX (ADP5589_GPI_PIN_END - ADP5589_GPI_PIN_BASE + 1)
+
+struct adp5589_gpi_map {
+	unsigned short pin;
+	unsigned short sw_evt;
+};
+
+/* scan_cycle_time */
+#define ADP5589_SCAN_CYCLE_10ms		0
+#define ADP5589_SCAN_CYCLE_20ms		1
+#define ADP5589_SCAN_CYCLE_30ms		2
+#define ADP5589_SCAN_CYCLE_40ms		3
+
+/* RESET_CFG */
+#define RESET_PULSE_WIDTH_500us		0
+#define RESET_PULSE_WIDTH_1ms		1
+#define RESET_PULSE_WIDTH_2ms		2
+#define RESET_PULSE_WIDTH_10ms		3
+
+#define RESET_TRIG_TIME_0ms		(0 << 2)
+#define RESET_TRIG_TIME_1000ms		(1 << 2)
+#define RESET_TRIG_TIME_1500ms		(2 << 2)
+#define RESET_TRIG_TIME_2000ms		(3 << 2)
+#define RESET_TRIG_TIME_2500ms		(4 << 2)
+#define RESET_TRIG_TIME_3000ms		(5 << 2)
+#define RESET_TRIG_TIME_3500ms		(6 << 2)
+#define RESET_TRIG_TIME_4000ms		(7 << 2)
+
+#define RESET_PASSTHRU_EN		(1 << 5)
+#define RESET1_POL_HIGH			(1 << 6)
+#define RESET1_POL_LOW			(0 << 6)
+#define RESET2_POL_HIGH			(1 << 7)
+#define RESET2_POL_LOW			(0 << 7)
+
+/* Mask Bits:
+ * C C C C C C C C C C C | R R R R R R R R
+ * 1 9 8 7 6 5 4 3 2 1 0 | 7 6 5 4 3 2 1 0
+ * 0
+ * ---------------- BIT ------------------
+ * 1 1 1 1 1 1 1 1 1 0 0 | 0 0 0 0 0 0 0 0
+ * 8 7 6 5 4 3 2 1 0 9 8 | 7 6 5 4 3 2 1 0
+ */
+
+#define ADP_ROW(x)			(1 << (x))
+#define ADP_COL(x)			(1 << (x + 8))
+
+struct adp5589_kpad_platform_data {
+	unsigned keypad_en_mask;	/* Keypad (Rows/Columns) enable mask */
+	const unsigned short *keymap;	/* Pointer to keymap */
+	unsigned short keymapsize;	/* Keymap size */
+	bool repeat;			/* Enable key repeat */
+	bool en_keylock;		/* Enable key lock feature */
+	unsigned char unlock_key1;	/* Unlock Key 1 */
+	unsigned char unlock_key2;	/* Unlock Key 2 */
+	unsigned char unlock_timer;	/* Time in seconds [0..7] between the two unlock keys 0=disable */
+	unsigned char scan_cycle_time;	/* Time between consecutive scan cycles */
+	unsigned char reset_cfg;	/* Reset config */
+	unsigned short reset1_key_1;	/* Reset Key 1 */
+	unsigned short reset1_key_2;	/* Reset Key 2 */
+	unsigned short reset1_key_3;	/* Reset Key 3 */
+	unsigned short reset2_key_1;	/* Reset Key 1 */
+	unsigned short reset2_key_2;	/* Reset Key 2 */
+	unsigned debounce_dis_mask;	/* Disable debounce mask */
+	unsigned pull_dis_mask;		/* Disable all pull resistors mask */
+	unsigned pullup_en_100k;	/* Pull-Up 100k Enable Mask */
+	unsigned pullup_en_300k;	/* Pull-Up 300k Enable Mask */
+	unsigned pulldown_en_300k;	/* Pull-Down 300k Enable Mask */
+	const struct adp5589_gpi_map *gpimap;
+	unsigned short gpimapsize;
+	const struct adp5589_gpio_platform_data *gpio_data;
+};
+
+struct i2c_client; /* forward declaration */
+
+struct adp5589_gpio_platform_data {
+	int	gpio_start;	/* GPIO Chip base # */
+	int	(*setup)(struct i2c_client *client,
+				int gpio, unsigned ngpio,
+				void *context);
+	int	(*teardown)(struct i2c_client *client,
+				int gpio, unsigned ngpio,
+				void *context);
+	void	*context;
+};
+
+#endif
-- 
1.7.4.1

