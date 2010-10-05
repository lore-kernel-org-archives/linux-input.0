From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Driver for TC35894XBG keypad controller
Date: Tue, 05 Oct 2010 17:19:18 +0100
Message-ID: <20101005161838.16209.16231.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59404 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0JERru (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 13:47:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-i2c@vger/kernel.org

From: Charlie Paul <charlie.paul@windriver.com>

The actual keypad translation is done via platform supplied data. This is
neccessary as there are multiple driver users with different keypad layouts
already, and will no doubt be more.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/keyboard/Kconfig           |    6 
 drivers/input/keyboard/Makefile          |    1 
 drivers/input/keyboard/tc35894xbg.c      |  722 ++++++++++++++
 drivers/input/keyboard/tc35894xbg_regs.h | 1528 ++++++++++++++++++++++++++++++
 include/linux/i2c/tc35894xbg.h           |   72 +
 5 files changed, 2329 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/tc35894xbg.c
 create mode 100644 drivers/input/keyboard/tc35894xbg_regs.h
 create mode 100644 include/linux/i2c/tc35894xbg.h


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 7dacba3..24d5e81 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -318,6 +318,12 @@ config KEYBOARD_IMX
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx_keypad.
 
+config KEYBOARD_TC35894XBG
+	tristate "TC35894XBG I2C keypad support"
+	depends on I2C
+	help
+	  Say Y if you have Toshiba TX35894XBG keypad controller
+
 config KEYBOARD_NEWTON
 	tristate "Newton keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a34452e..1057855 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
+obj-$(CONFIG_KEYBOARD_TC35894XBG)	+= tc35894xbg.o
 obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
diff --git a/drivers/input/keyboard/tc35894xbg.c b/drivers/input/keyboard/tc35894xbg.c
new file mode 100644
index 0000000..68e197d
--- /dev/null
+++ b/drivers/input/keyboard/tc35894xbg.c
@@ -0,0 +1,722 @@
+/*
+ * tc35894xbg.c: Keypad driver for Toshiba TC35894XBG
+ *
+ * (C) Copyright 2010 Intel Corporation
+ * Author: Charlie Paul (z8cpaul@windriver.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+
+#include <linux/i2c/tc35894xbg.h>
+#include "tc35894xbg_regs.h"
+
+struct tc35894xbg_keypad_chip {
+	/* device lock */
+	struct mutex lock;
+	struct i2c_client *client;
+	struct work_struct work;
+	struct input_dev *idev;
+	bool kp_enabled;
+	bool pm_suspend;
+	char phys[32];
+	struct tc35894xbg_platform_data pd;
+	unsigned char keymap_index;
+	unsigned int kp_reg_addr;
+};
+
+#define work_to_keypad(w)   container_of(w, struct tc35894xbg_keypad_chip, \
+								work)
+#define client_to_keypad(c) container_of(c, struct tc35894xbg_keypad_chip, \
+								client)
+#define dev_to_keypad(d)    container_of(c, struct tc35894xbg_keypad_chip, \
+								client->dev)
+
+#define KEYPAD_MAX_DATA    8
+
+/*
+ * To write, access the chip's address in write mode, and dump the
+ * command and data on the bus. The command and data are taken as
+ * sequential u8s out of varargs, to a maxinum of KEYPAD_MAX_DATA
+ */
+static int keypad_write(struct tc35894xbg_keypad_chip *tc, int len, ...)
+{
+	int ret, i;
+	va_list ap;
+	u8 data[KEYPAD_MAX_DATA];
+
+	va_start(ap, len);
+	if (len > KEYPAD_MAX_DATA) {
+		dev_err(&tc->client->dev, "tried to send %d bytes\n", len);
+		va_end(ap);
+		return 0;
+	}
+
+	for (i = 0; i < len; i++)
+		data[i] = va_arg(ap, int);
+	va_end(ap);
+
+#ifdef DEBUG
+	dev_dbg(&tc->client->dev, "Register write: register:0x%02x", data[0]);
+	for (i = 1; i < len; i++)
+		dev_dbg(&tc->client->dev, ", value:0x%02x", data[i]);
+	dev_dbg(&tc->client->dev, "\n");
+#endif
+	/*
+	 * In case of host's asleep, send again when get NACK
+	 */
+	ret = i2c_master_send(tc->client, data, len);
+	if (ret == -EREMOTEIO)
+		ret = i2c_master_send(tc->client, data, len);
+
+	if (ret != len)
+		dev_err(&tc->client->dev, "sent %d bytes of %d total\n",
+								len, ret);
+
+	return ret;
+}
+
+/*
+ * To read, first send the command byte and end the transaction.
+ * Then we can get the data in read mode.
+ */
+static int keypad_read(struct tc35894xbg_keypad_chip *tc, u8 cmd, u8 * buf,
+				int len)
+{
+#ifdef DEBUG
+	int i;
+#endif
+	int ret;
+
+	/*
+	 * In case of host's asleep, send again when get NACK
+	 */
+	ret = i2c_master_send(tc->client, &cmd, 1);
+	if (ret == -EREMOTEIO)
+		ret = i2c_master_send(tc->client, &cmd, 1);
+
+	if (ret != 1) {
+		dev_err(&tc->client->dev, "sending command 0x%2x failed.\n",
+				cmd);
+		return 0;
+	}
+
+	ret = i2c_master_recv(tc->client, buf, len);
+	if (ret != len)
+		dev_err(&tc->client->dev, "want %d bytes, got %d\n", len, ret);
+
+#ifdef DEBUG
+	dev_dbg(&tc->client->dev, "Register read: register:0x%02x", cmd);
+	for (i = 0; i < len; i++)
+		dev_dbg(&tc->client->dev, ", value:0x%02x", buf[i]);
+	dev_dbg(&tc->client->dev, "\n");
+#endif
+	return ret;
+}
+
+/*software reset */
+static void keypad_reset(struct tc35894xbg_keypad_chip *tc)
+{
+	/*
+	 * Three reset mode, one is software reset by
+	 * control the RSTCTRL register.
+	 */
+	keypad_write(tc, 2, TC_REG_RSTCTRL, (TC_VAL_IRQRST | TC_VAL_TIMRST
+				| TC_VAL_KBDRST | TC_VAL_GPIRST));
+	/*
+	 * Once reset bit is set, need write back to 0
+	 */
+	keypad_write(tc, 2, TC_REG_RSTCTRL, 0x0);
+}
+
+/*
+ * Read the manufacturer ID and SW revision registers.  Return them
+ * to the caller, if the caller has supplied pointers.
+ */
+static int keypad_checkid(struct tc35894xbg_keypad_chip *tc,
+				int *mfg_id_ret, int *sw_rev_ret)
+{
+	u8 mfg_id;
+	u8 sw_rev;
+
+	if (keypad_read(tc, TC_REG_MANUFACT_CODE, &mfg_id, 1) != 1)
+		return -EREMOTEIO;
+	if (keypad_read(tc, TC_REG_SW_VERSION, &sw_rev, 1) != 1)
+		return -EREMOTEIO;
+
+	if (mfg_id_ret != NULL)
+		*mfg_id_ret = (int)mfg_id;
+	if (sw_rev_ret != NULL)
+		*sw_rev_ret = (int)sw_rev;
+	return 0;
+}
+
+static int keypad_configure(struct tc35894xbg_keypad_chip *tc)
+{
+	/* enable the modified feature */
+	keypad_write(tc, 2, TC_REG_KBDMFS, TC_VAL_MFSEN);
+
+	/* enable the SYSCLK in KBD and timer */
+	keypad_write(tc, 2, TC_REG_CLKEN, 0x28 | TC_VAL_KBDEN);
+	/* when clock source is RC osci NOTE: Needs to be written twice */
+	keypad_write(tc, 2, TC_REG_CLKEN, 0x28 | TC_VAL_KBDEN);
+
+	dev_dbg(&tc->client->dev, "keypad internal clock setting\n");
+	/* CLKCFG : select the RC-osc:2MHZ, disable doubler, divider:2 */
+	/* CLK_IN = internal clock / 2 = 65KHZ / 2 = 32KHZ */
+	keypad_write(tc, 2, TC_REG_CLKCFG, TC_VAL_CLKSRCSEL | 0x01);
+
+	dev_dbg(&tc->client->dev, "keypad keyboard setting\n");
+	/* keyboard settings */
+	keypad_write(tc, 2, TC_REG_KBDSETTLE, tc->pd.settle_time);
+	keypad_write(tc, 2, TC_REG_KBD_BOUNCE, tc->pd.debounce_time);
+	keypad_write(tc, 2, TC_REG_KBDSIZE, ((tc->pd.size_x << 4)
+							| tc->pd.size_y));
+	keypad_write(tc, 3, TC_REG_DEDCFG_COL, tc->pd.col_setting,
+						tc->pd.rowcol_setting);
+
+	dev_dbg(&tc->client->dev, "keypad keyboard interrupt setting\n");
+	/*XXX: set again */
+	keypad_write(tc, 2, TC_REG_DKBDMSK, 0x03);
+
+	/* clear pending interrupts before irq enabled */
+	keypad_write(tc, 2, TC_REG_KBDIC, (TC_VAL_EVTIC | TC_VAL_KBDIC));
+
+	/* Enable keycode lost intr & keyboard status intr */
+	keypad_write(tc, 2, TC_REG_KBDMSK, 0x00);
+
+	return 0;
+}
+
+/*
+ * AT-style: low 7 bits are the keycode, and the top
+ * bit indicates the state( 1 for down, 0 for up)
+ */
+static inline u8 keypad_whichkey(u8 event)
+{
+	/* bit[7-4]:key row, bit[3-0]:key col */
+	u8 row, col;
+	u8 key;
+	row = (event & 0x70) >> 4;
+	col = (event & 0x0F);
+
+	key = row * 8 + col;
+
+	return key;
+}
+
+static inline int keypad_ispress(u8 event)
+{
+	/* 1: pressed, 0: released */
+	return (event & 0x80) ? 0 : 1;
+}
+
+/* reset the keybit of input */
+static void set_keymap_bit(struct tc35894xbg_keypad_chip *tc)
+{
+	int i;
+	unsigned temp;
+	for (i = 0; i < tc->pd.keymap_size; i++) {
+		temp = (tc->pd.keymap[tc->keymap_index][i] &  ~(SHIFT_NEEDED));
+		__set_bit(temp, tc->idev->keybit);
+	}
+
+	__clear_bit(KEY_RESERVED, tc->idev->keybit);
+}
+
+
+/* report the 'right shift' key */
+static void report_shift_key(struct tc35894xbg_keypad_chip *tc, int isdown)
+{
+	if (tc->kp_enabled) {
+		input_report_key(tc->idev,
+			tc->pd.keymap[TC_DEFAULT_KEYMAP][tc->pd.right_shift_key],
+			isdown);
+		input_sync(tc->idev);
+	}
+}
+
+/* report the key code */
+static void submit_key(struct tc35894xbg_keypad_chip *tc, u8 key,
+				unsigned short keycode, int isdown)
+{
+	unsigned short saved_keycode = keycode;
+
+	dev_vdbg(&tc->client->dev, "key 0x%02x %s\n",
+			key, isdown ? "down" : "up");
+	/*
+	 * Translate the non-exist keycode keys.
+	 * when key press down, report the 'shift' key pressed ahead.
+	 */
+	if ((keycode & SHIFT_NEEDED) && isdown)	{
+		keycode = keycode & ~(SHIFT_NEEDED);
+		report_shift_key(tc, isdown);
+	}
+
+	/* report the key */
+	if (tc->kp_enabled) {
+		input_report_key(tc->idev, (keycode & ~(SHIFT_NEEDED)), isdown);
+		input_sync(tc->idev);
+	}
+
+	/*
+	 * When key press up, report the 'shift' up followed.
+	 */
+	if ((saved_keycode & SHIFT_NEEDED) && !isdown)
+		report_shift_key(tc, isdown);
+}
+
+/* key event interrupt handler */
+static inline void process_keys(struct tc35894xbg_keypad_chip *tc)
+{
+	u8 event;
+	int ret, i = 0;
+	static u8 queue[TC35894XBG_MAX_FIFO];
+	static int tail;
+
+	ret = keypad_read(tc, TC_REG_EVTCODE, &event, 1);
+	if (ret < 0) {
+		dev_err(&tc->client->dev, "Failed reading fifo\n");
+		/* clear event buffer */
+		keypad_write(tc, 2, TC_REG_KBDIC, 0x83);
+		return;
+	}
+
+	/* clear event buffer */
+	keypad_write(tc, 2, TC_REG_KBDIC, 0x83);
+
+	i = 0;
+	/* modified feature enable on KBDMFS */
+	if (event != 0x7F && event != 0xFF) {
+
+		u8 key = keypad_whichkey(event);
+		int isdown = keypad_ispress(event);
+		unsigned short keycode = tc->pd.keymap[tc->keymap_index][key];
+
+		/* The function key pressed */
+		if ((key == tc->pd.function_key) && isdown) {
+			tc->keymap_index = TC_ALT_KEYMAP;
+			set_keymap_bit(tc);
+			return;
+		}
+
+		/* Function key press up */
+		if ((key == tc->pd.function_key) && !isdown) {
+			/*
+			 * dequeue the queue,
+			 * where keys stored while FN is pressed
+			 */
+			int j;
+			unsigned short temp_key;
+			for (j = 0; j < tail; j++) { /* keys up */
+				temp_key = tc->pd.keymap[TC_ALT_KEYMAP][queue[j]];
+				submit_key(tc, queue[j], temp_key, 0);
+			}
+			tail = 0;
+
+			tc->keymap_index = TC_DEFAULT_KEYMAP;
+			set_keymap_bit(tc);
+			return;
+		}
+
+		if (tc->keymap_index == TC_ALT_KEYMAP)
+			queue[tail++] = key;
+
+		submit_key(tc, key, keycode, isdown);
+	}
+
+}
+
+/*
+ * Bottom Half: handle the interrupt by posting key events, or dealing with
+ * errors appropriately
+ */
+static void keypad_work(struct work_struct *work)
+{
+	struct tc35894xbg_keypad_chip *tc = work_to_keypad(work);
+	u8 ints = 0;
+
+
+	mutex_lock(&tc->lock);
+	while ((keypad_read(tc, TC_REG_IRQST, &ints, 1) == 1) && ints) {
+		if (ints & TC_VAL_KBDIRQ) {
+			/* keycode revert from the FIFO buffer */
+			process_keys(tc);
+		}
+	}
+	mutex_unlock(&tc->lock);
+}
+
+/*
+ * We cannot use I2c in interrupt context, so we just schedule work.
+ */
+static irqreturn_t keypad_irq(int irq, void *data)
+{
+	struct tc35894xbg_keypad_chip *tc = data;
+	schedule_work(&tc->work);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Sysfs interface
+ */
+static ssize_t keypad_show_disable(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct tc35894xbg_keypad_chip *tc = dev_get_drvdata(dev);
+	return sprintf(buf, "%u\n", !tc->kp_enabled);
+}
+
+static ssize_t keypad_set_disable(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct tc35894xbg_keypad_chip *tc = dev_get_drvdata(dev);
+	int ret;
+	unsigned long i;
+
+	ret = strict_strtoul(buf, 10, &i);
+
+	mutex_lock(&tc->lock);
+	tc->kp_enabled = !i;
+	mutex_unlock(&tc->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable_kp, 0644,
+		keypad_show_disable, keypad_set_disable);
+
+static ssize_t keypad_show_addr(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct tc35894xbg_keypad_chip *tc = dev_get_drvdata(dev);
+	return sprintf(buf, "0x%02X\n", tc->kp_reg_addr);
+}
+
+static ssize_t keypad_set_addr(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct tc35894xbg_keypad_chip *tc = dev_get_drvdata(dev);
+	int ret;
+	unsigned long i;
+
+	ret = strict_strtoul(buf, 0, &i);
+
+	mutex_lock(&tc->lock);
+	tc->kp_reg_addr = i;
+	mutex_unlock(&tc->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(addr_kp, 0644,
+		   keypad_show_addr, keypad_set_addr);
+
+static ssize_t keypad_show_data(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct tc35894xbg_keypad_chip *tc = dev_get_drvdata(dev);
+	u8 val;
+
+	mutex_lock(&tc->lock);
+	if (keypad_read(tc, tc->kp_reg_addr, &val, 1) == 1) {
+		mutex_unlock(&tc->lock);
+		return sprintf(buf, "0x%02X\n", val);
+	}
+	mutex_unlock(&tc->lock);
+	return 0;
+}
+
+static ssize_t keypad_set_data(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	return 0;
+}
+
+static DEVICE_ATTR(data_kp, 0644,
+		   keypad_show_data, keypad_set_data);
+
+static struct attribute *tc35894_attributes[] = {
+	&dev_attr_disable_kp.attr,
+	&dev_attr_addr_kp.attr,
+	&dev_attr_data_kp.attr,
+	NULL
+};
+
+static const struct attribute_group tc35894_attr_group = {
+	.attrs = tc35894_attributes,
+};
+
+static int __devinit
+keypad_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+
+	struct tc35894xbg_platform_data *pdata = client->dev.platform_data;
+	struct input_dev *idev;
+	struct tc35894xbg_keypad_chip *tc;
+
+	int err;
+	int sw_rev;
+	int mfg_id;
+	unsigned long tmo;
+	u8 data[2];
+	unsigned int irq;
+
+
+	dev_dbg(&client->dev, "keypad probe\n");
+
+	if (!pdata || !pdata->size_x || !pdata->size_y) {
+		dev_err(&client->dev, "missing platform_data\n");
+		return -EINVAL;
+	}
+
+	if (pdata->size_x > 8) {
+		dev_err(&client->dev, "invalid x size %d specified\n",
+				pdata->size_x);
+		return -EINVAL;
+	}
+
+	if (pdata->size_y > 12) {
+		dev_err(&client->dev, "invalid y size %d specified\n",
+				pdata->size_y);
+		return -EINVAL;
+	}
+
+	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
+	if (!tc) {
+		err = -ENOMEM;
+		goto fail0;
+	}
+	idev = input_allocate_device();
+	if (!idev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	memcpy(&tc->pd, pdata, sizeof(struct tc35894xbg_platform_data));
+
+	i2c_set_clientdata(client, tc);
+
+	tc->client = client;
+	tc->idev = idev;
+	mutex_init(&tc->lock);
+	INIT_WORK(&tc->work, keypad_work);
+
+	dev_dbg(&client->dev, "Reset GPIO ID: %d\n", tc->pd.gpio_reset);
+	dev_dbg(&client->dev, "Keypad size:%d x %d\n",
+			tc->pd.size_x, tc->pd.size_y);
+
+	/*
+	 * Take controller out of reset
+	 */
+	if (pdata->gpio_reset != -1) {
+		dev_dbg(&client->dev, "Release TC35894XBG reset\n");
+		if (pdata->reset_ctrl == NULL) {
+			dev_err(&client->dev, "No reset_ctrl function\n");
+			return -ENODEV;
+		}
+		pdata->reset_ctrl(client, 1);
+	}
+
+	/*
+	 * Nothing's set up to service the IRQ yet, so just spin for max.
+	 * 280us util we can configure.(Tp1 + Tp2)
+	 */
+	tmo = jiffies + usecs_to_jiffies(280);
+	while (keypad_read(tc, TC_REG_IRQST, data, 1) == 1) {
+		if (data[0] & TC_VAL_PORIRQ) { /* power on reset complete */
+			/* clear the PORIRQ bit */
+			keypad_write(tc, 2, TC_REG_RSTINTCLR,
+							TC_VAL_IRQCLR);
+			break;
+		}
+		if (time_after(jiffies, tmo)) {
+			dev_err(&client->dev,
+				"timeout waiting for initialisation\n");
+			break;
+		}
+		udelay(1);
+	}
+
+	/* Confirm device ID register */
+	err = keypad_checkid(tc, &mfg_id, &sw_rev);
+	if (err != 0) {
+		dev_err(&client->dev, "Could not read ID and revision\n");
+		goto fail1;
+	} else {
+		dev_dbg(&client->dev, "Controller ID/Rev: 0x%02X/0x%02X\n",
+							mfg_id, sw_rev);
+	}
+
+	/* Software reset can be achieved only after power-on complete */
+	dev_dbg(&client->dev, "Controller reset by software\n");
+	keypad_reset(tc);
+
+	/* detach the RESETN from the global reset tree */
+	keypad_write(tc, 2, TC_REG_EXTRSTN, TC_VAL_EXTRSTN);
+
+	dev_dbg(&client->dev, "keypad configure start\n");
+	keypad_configure(tc);
+
+	tc->kp_enabled = true;
+
+	idev->name = "KEYPAD";
+	snprintf(tc->phys, sizeof(tc->phys), "%s/input-kp",
+					dev_name(&client->dev));
+	idev->phys = tc->phys;
+	/* the two bit set */
+	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) | BIT_MASK(EV_REL);
+
+	tc->keymap_index = TC_DEFAULT_KEYMAP;
+	set_keymap_bit(tc);
+
+	err = input_register_device(idev);
+	if (err) {
+		dev_dbg(&client->dev, "error register input device\n");
+		goto fail2;
+	}
+
+	irq = gpio_to_irq(pdata->gpio_irq);
+	if (irq < 0) {
+		dev_err(&client->dev, "Failed to get IRQ to GPIO %d\n", irq);
+		goto fail2;
+	}
+	client->irq = irq;
+
+	dev_dbg(&client->dev, "keypad irq register\n");
+	err = request_irq(client->irq, keypad_irq, IRQ_TYPE_EDGE_FALLING
+					| IRQF_SHARED, "keypad", tc);
+	if (err) {
+		dev_err(&client->dev, "could not get IRQ %d\n", irq);
+		goto fail3;
+	}
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &tc35894_attr_group);
+	if (err)
+		goto fail3;
+
+	device_init_wakeup(&client->dev, 1);
+	enable_irq_wake(client->irq);
+
+	return 0;
+
+fail3:	input_unregister_device(idev);
+	idev = NULL;
+
+fail2:	device_remove_file(&client->dev, &dev_attr_disable_kp);
+
+fail1:	input_free_device(idev);
+
+fail0:	kfree(tc);
+
+	return err;
+}
+
+static int __devexit keypad_remove(struct i2c_client *client)
+{
+	struct tc35894xbg_keypad_chip *tc = i2c_get_clientdata(client);
+
+	dev_dbg(&client->dev, "keypad driver remove\n");
+
+	disable_irq_wake(client->irq);
+	free_irq(client->irq, tc);
+	cancel_work_sync(&tc->work);
+
+	dev_dbg(&client->dev, "keypad input device unregister\n");
+	sysfs_remove_group(&client->dev.kobj, &tc35894_attr_group);
+	input_unregister_device(tc->idev);
+	device_remove_file(&tc->client->dev, &dev_attr_disable_kp);
+
+	kfree(tc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/*
+ * the chip can switch off when no activity, so
+ * explicitly suspend is no need
+ */
+
+static int keypad_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct tc35894xbg_keypad_chip *tc = i2c_get_clientdata(client);
+
+	set_irq_wake(client->irq, 0);
+	disable_irq(client->irq);
+
+	mutex_lock(&tc->lock);
+	tc->pm_suspend = true;
+	mutex_unlock(&tc->lock);
+	return 0;
+}
+
+static int keypad_resume(struct i2c_client *client)
+{
+	struct tc35894xbg_keypad_chip *tc = i2c_get_clientdata(client);
+
+	mutex_lock(&tc->lock);
+	tc->pm_suspend = false;
+	mutex_unlock(&tc->lock);
+
+	enable_irq(client->irq);
+	set_irq_wake(client->irq, 1);
+	return 0;
+}
+
+#else
+#define keypad_suspend NULL
+#define keypad_resume NULL
+
+#endif
+
+static const struct i2c_device_id keypad_id[] = {
+	{ "i2c_TC35894-nEB1", 0 },
+	{ "i2c_TC35894-i", 0 },
+	{ }
+};
+
+static struct i2c_driver keypad_i2c_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {.name = "keypad",},
+	.probe = keypad_probe,
+	.remove = __devexit_p(keypad_remove),
+	.suspend = keypad_suspend,
+	.resume = keypad_resume,
+	.id_table = keypad_id,
+};
+
+MODULE_DEVICE_TABLE(i2c, keypad_id);
+
+static int __init keypad_init(void)
+{
+	return i2c_add_driver(&keypad_i2c_driver);
+}
+
+static void __exit keypad_exit(void)
+{
+	i2c_del_driver(&keypad_i2c_driver);
+}
+
+module_init(keypad_init);
+module_exit(keypad_exit);
+
+MODULE_AUTHOR("Charlie Paul");
+MODULE_DESCRIPTION("TC35894XBG expander driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/keyboard/tc35894xbg_regs.h b/drivers/input/keyboard/tc35894xbg_regs.h
new file mode 100644
index 0000000..87bf7a8
--- /dev/null
+++ b/drivers/input/keyboard/tc35894xbg_regs.h
@@ -0,0 +1,1528 @@
+/*
+ * tc35894_regs.h: Register definitions for Toshiba TC35894XBG
+ *
+ * (C) Copyright 2010 Intel Corporation
+ * Author: Charlie Paul (z8cpaul@windriver.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#ifndef __TC3589XBG_REGS_H
+#define __TC3589XBG_REGS_H
+
+#include <linux/types.h>
+#include <linux/input.h>
+
+/******************************************************************************
+ * REGISTER DEFINITIONS
+ ******************************************************************************/
+/******************************************************************************
+ * Setup of Wait Period register
+ ******************************************************************************/
+#define TC_REG_KBDSETTLE            (0x01)
+
+/*
+ * Initial wait time for keys to settle, before key scan is started. Each unit
+ * of this timer equals for SYSCLK clock cycles or approx. 61us on a 65.536kHz
+ * SYSCLK. 4 times the value programmed to WAIT0 divided by the SYSCLK
+ * frequency in Hz.
+ * 0xFF: 15.6ms
+ * 0xA3: 9.68ms
+ * 0x7F: 7.8ms
+ * 0x52: 5.0ms
+ * 0x40: 3.9ms
+ * 0x00: 0ms
+ */
+#define TC_VAL_WAIT_15_6MS          (0xFF)
+#define TC_VAL_WAIT_9_68MS          (0xA3)
+#define TC_VAL_WAIT_7_8MS           (0x7F)
+#define TC_VAL_WAIT_5_0MS           (0x52)
+#define TC_VAL_WAIT_3_9MS           (0x40)
+
+/******************************************************************************
+ * Setup of Debouncing Register
+ *****************************************************************************/
+#define TC_REG_KBD_BOUNCE           (0x02)
+
+/*
+ * De-bounce time between detection of any key change and the keyboard
+ * scan. Each unit of this time equals for SYSCLK clock cycles or approx 61us
+ * on a 65.536KHz clock. Debounce time is calculated to:
+ * 4 times the value programmed to BOUNCETIM0 divided by the SYSCLK frequency
+ * in Hz
+ * 0xFF: 15.6ms
+ * 0xA3: 9.68ms
+ * 0x7F: 7.8ms
+ * 0x52: 5.0ms
+ * 0x40: 3.9ms
+ * 0x00: 0ms
+ */
+#define TC_VAL_BOUNCE_15_6MS        (0xFF)
+#define TC_VAL_BOUNCE_9_68MS        (0xA3)
+#define TC_VAL_BOUNCE_7_8MS         (0x7F)
+#define TC_VAL_BOUNCE_5_0MS         (0x52)
+#define TC_VAL_BOUNCE_3_9MS         (0x40)
+
+/******************************************************************************
+ * Keyboard Matrix Setup
+ ******************************************************************************/
+#define TC_REG_KBDSIZE              (0x03)
+
+/*
+ * Number of rows in the keyboard matrix, between 2 and 8
+ * 0: A value of 0 will free all rows to become GPIO lines.
+ * 1: Inhibition
+ * 2-8: Number of Rows
+ */
+#define TC_VAL_ROW_SIZE_MASK        (0xF0)
+
+/*
+ * Number of columns in the keyboard matrix, betwee 2 and 12.
+ * 0: A value of 0 will free all rows to become GPIO lines
+ * 1: Inhibition
+ * 2-12: Number of columns
+ */
+#define TC_VAL_COL_SIZE_MASK        (0x0F)
+
+/******************************************************************************
+ * Dedicated Key Setup register (0x04 and 0x05)
+ *****************************************************************************/
+#define TC_REG_DEDCFG_COL           (0x04)
+
+/*
+ * Each bit in COL[8:2] corresponds to ball KPY8..KPY2 and can be
+ * configured individually.
+ * 0: Dedicated key
+ * 1: No dedicated key (standard GPIO, alternative functionality according
+ *    to register BALLCFG or keyboard)
+ */
+#define TC_VAL_COL9                 (0x01 << 7)
+#define TC_VAL_COL8                 (0x01 << 6)
+#define TC_VAL_COL7                 (0x01 << 5)
+#define TC_VAL_COL6                 (0x01 << 4)
+#define TC_VAL_COL5                 (0x01 << 3)
+#define TC_VAL_COL4                 (0x01 << 2)
+#define TC_VAL_COL3                 (0x01 << 1)
+#define TC_VAL_COL2                 (0x01)
+
+#define TC_REG_DEDCFG_ROW_COL       (0x05)
+
+/*
+ * Each bit in ROW[7:2] corresponds to ball KPX7..KPX2 and can be
+ * configured individually.
+ * 0: Dedicated key
+ * 1: No dedicated key (standard GPIO or keyboard matrix)
+ */
+#define TC_VAL_ROW7                 (0x01 << 7)
+#define TC_VAL_ROW6                 (0x01 << 6)
+#define TC_VAL_ROW5                 (0x01 << 5)
+#define TC_VAL_ROW4                 (0x01 << 4)
+#define TC_VAL_ROW3                 (0x01 << 3)
+#define TC_VAL_ROW2                 (0x01 << 2)
+
+/*
+ * Each bit in COL[11:10] corresponds to ball KPY11..KPY10 and can be
+ * configured individually.
+ * 0: Dedicated key
+ * 1: No dedicated key (standard GPIO, alternative functionality according
+ *    to register BALLCFG or keyboard)
+ */
+#define TC_VAL_COL11                (0x01 << 1)
+#define TC_VAL_COL10                (0x01)
+
+/******************************************************************************
+ * Keyboard Raw Interrupt Register
+ *****************************************************************************/
+#define TC_REG_KBDRIS               (0x06)      /* Read Only */
+
+/*
+ * Raw Event Lost Interrupt.
+ * This bit is cleared by writing into EVTIC
+ * 0: No interrupt
+ * 1: More than 8 keyboard event shave been detected and caused
+ *    the event buffer to overflow.
+ */
+#define TC_VAL_RELINT               (0x01 << 3)
+
+/*
+ * Raw keyboard event interrupt
+ * Reading from EVTCODE until the buffer is empty will automatically
+ * clear this interrupt.
+ * 0: No interrupt
+ * 1: At least one key press or key release is in the keyboard
+ *    event buffer.
+ */
+#define TC_VAL_REVT_INT             (0x01 << 2)
+
+/*
+ * Raw Key Lost interrupt (indicates a lost keycode)
+ * The meaning of this interrupt bit changes depending on the
+ * configuration of KBDMFS register.
+ * 0: No interrupt
+ * 1: If KBDMFS is set to 0: When RSINT has not been clear upon
+ *                           detection of a new key press or key
+ *                           release, or when more than 4 keys are pressed
+ *                           simultaneously.
+ * If KBDMFS is set to 1: Indicates that more than 4 keys are pressed
+ *                        simultaneously, i.e. key presses are lost
+ */
+#define TC_VAL_RKLINT               (0x01 << 1)
+
+/*
+ * Raw scan interrupt
+ * 0: No interrupt
+ * 1: Interrupt generated after keyboard scan, if the keyboard status has
+ *    changed
+ */
+#define TC_VAL_RSINT                (0x01)
+
+/******************************************************************************
+ * Keyboard Mask Interrupt Register
+ *****************************************************************************/
+#define TC_REG_KBDMIS               (0x07)      /* Read Only */
+
+/*
+ * Masked Event Lost Interrupt
+ * 0: No interrupt
+ * 1: More than 8 keyboard events have been detected
+ *    and caused the event buffer to overflow.
+ */
+#define TC_VAL_MELINT               (0x01 << 3)
+
+/*
+ * Masked keyboard event interrupt
+ * 0: No interrupt
+ * 1: At least one key press or key release is in the keyboard
+ * event buffer.
+ */
+#define TC_VAL_MEVT_INT             (0x01 << 2)
+
+/*
+ * Masked key lose interrupt
+ * 0: No interrupt
+ * 1: Masked key lost interrupt.
+ */
+#define TC_VAL_MKLINT               (0x01 << 1)
+
+/*
+ * Masked scan interrupt
+ * 0: No interrupt
+ * 1: Interrupt generated after keyboard scan,
+ * if the keyboard status has changed, after masking process.
+ */
+#define TC_VAL_MSINT                (0x01)
+
+/******************************************************************************
+ * Keyboard Interrupt Clear Register
+ *****************************************************************************/
+#define TC_REG_KBDIC                (0x08)      /* Write Only */
+
+/*
+ * Switches off scanning of special function
+ * keys, when keyboard has no special function
+ * layout.
+ * 0: Scans keyboard layout with or without special function keys
+ * 1: Scans keyboard layout without special function keys
+ */
+#define TC_VAL_SFOFF                (0x01 << 7)
+
+/*
+ * Clear event buffer an corresponding interrupts
+ * REVTINT and RELINT. The host does not need to write "0".
+ * Write "1" every time when clearing the event buffer.
+ * 0: No action
+ * 1: Clear event buffer and corresponding interrupts REVTINT and RELINT
+ */
+#define TC_VAL_EVTIC                (0x01 << 1)
+
+/*
+ * Clear RSINT and RKLINT interrupt bits.
+ * The host does not need to write "0". Write "1" every time when clearing
+ * RSINT and RKLINT.
+ * 0: No action
+ * 1: Clear RSINT and RKLINT interrupt bits.
+*/
+#define TC_VAL_KBDIC                (0x01)
+
+/******************************************************************************
+ * Keyboard Mask Register
+ *****************************************************************************/
+#define TC_REG_KBDMSK               (0x09)
+
+/*
+ * Enable keyboard event lost interrupt
+ * 0: Enabled
+ * 1: Disabled
+ */
+#define TC_VAL_MSKELINT             (0x01 << 3)
+
+/*
+ * Enable keyboard event interrupt
+ * 0: Enabled
+ * 1: Disabled
+ */
+#define TC_VAL_MSKEINT              (0x01 << 2)
+
+/*
+ * Enable keycode lost interrupt
+ * 0: Enabled
+ * 1: Disabled
+ */
+#define TC_VAL_MSKKLINT             (0x01 << 1)
+
+/*
+ * Enable keyboard status interrupt
+ * 0: Enable
+ * 1: Disable
+ */
+#define TC_VAL_MSKSINT              (0x01)
+
+/****************************************************************************
+ * Keyboard Code Registers
+ ***************************************************************************/
+#define TC_REG_KBDCODE0             (0x0B)
+#define TC_REG_KBDCODE1             (0x0C)
+#define TC_REG_KBDCODE2             (0x0D)
+#define TC_REG_KBDCODE3             (0x0E)
+
+/*
+ * Multiple key press. Another key code is available in KEYCODE(X+1) register
+ * 0: Another key code is not available
+ * 1: Another key code is available.
+ */
+#define TC_VAL_MULTIKEY             (0x01 << 7)
+
+/* Row index of key that is pressed (0..7) */
+#define TC_VAL_KEYROW_MASK          (0x70)
+
+/*
+ * Column index of key that is pressed (0..11 and 12 for special
+ * function key)
+ */
+#define TC_VAL_KEYCOL_MASK          (0x0F)
+
+/******************************************************************************
+ * Event Code Register
+ *****************************************************************************/
+#define TC_REG_EVTCODE              (0x10)
+
+/*
+ * Indicates, whether keyboard event was a key press or a key release
+ * 0: Key was pressed
+ * 1: Key was released
+ */
+#define TC_VAL_RELEASE              (0x01 << 7)
+
+
+/******************************************************************************
+ * Timer configuration registers
+ *****************************************************************************/
+#define TC_REG_TIMCFG0              (0x60)
+#define TC_REG_TIMCFG1              (0x68)
+#define TC_REG_TIMCFG2              (0x70)
+
+/*
+ * Interrupt mask for CYCIRQ
+ * 0: interrupt enabled
+ * 1: interrupt masked
+ */
+#define TC_VAL_TIM_IRQMASK          (0x01 << 4)
+
+/*
+ * CYCLE counter control register
+ * 0: Timer/counter stops after TIMLOAD cycles of CNTCLK (One-shot operation)
+ *    An interrupt is (only) issued, when the NUM Counter (TIMCYCLE controlled)
+ *    is at 0.
+ * 1: Timer/counter counts down from TIMLOAD to 0 as many times as are
+ *    specified in the TIMCYCLE register. The, the timer stops and an
+ *    interrupt is generated.
+ */
+#define TC_VAL_CYCCTRL              (0x01 << 3)
+
+/*
+ * Switches between free-running timer and one time count. In both operating
+ * modes the register TIMCYCLE influences the behavior of the interrupt
+ * generation.
+ * 0: CYCLE mode, behavior depends on CYCLE bit
+ * 1: Timer/counter counts down from TIMLOAD to 0, re-loads the value of
+ *    TIMLOAD and restarts counting down. (FREE-running mode)
+ */
+#define TC_VAL_FREE                 (0x01 << 2)
+
+/*
+ * Synchronization of pattern generator and timer
+ * 0: Pattern generator is started and stopped by the PWMCFG. PGE bit
+ * 1: Pattern generator and Timer are enabled simultaneously setting bit
+ *    TIMCFG START, pattern generator is stopped by PWMCFG.PGE=0, timer
+ *    is stopped by TIMCFG.START=0
+ */
+#define TC_VAL_SYNC                 (0x01 << 1)
+
+/*
+ * Timer start/stop control (WRITE_ONLY)
+ * 0: Timer is stopped (can also be stopped from internal state machine)
+ * 1: Timer is started
+ */
+#define TC_VAL_START                (0x01)
+
+/******************************************************************************
+ * Pattern Configuration registers
+ *****************************************************************************/
+#define TC_REG_PWMCFG0              (0x61)
+#define TC_REG_PWMCFG1              (0x69)
+#define TC_REG_PWMCFG2              (0x71)
+
+/*
+ * Mask for CDIRQ
+ * 0: CDIRQ enabled
+ * 1: CDIRQ disabled/masked
+ */
+#define TC_VAL_PWM_MASK             (0x01 << 3)
+
+/*
+ * Pattern Generator Enable
+ * This bit is ignored, if the SYCN bit of the corresponding
+ * TIMCFG register is set
+ * 0: Pattern generator disabled
+ * 1: Pattern generator enabled
+ */
+#define TC_VAL_PGE                  (0x01 << 2)
+
+/*
+ * PWM Enable
+ * 0: PWM disabled
+ * PWM timer output assumes value programmed in PWMPOL
+ * 1: PWM enabled
+ */
+#define TC_VAL_PWMEN                (0x01 << 1)
+
+/* OFF-state of PWM output, when PWMEN=0
+ * 0: PWM off-state is low
+ * 1: PWM off-state is high
+ */
+#define TC_VAL_PWMPOL               (0x01)
+
+/******************************************************************************
+ * Timer Scale registers
+ *
+ * SCAL7:0   : Load value for timer pre-scaler.
+ *             The system clock is divided by (SCAL+1). The resulting CNTCLK is
+ *             the reference clock for timer related operations.
+ ******************************************************************************/
+#define TC_REG_TIMSCAL0             (0x62)
+#define TC_REG_TIMSCAL1             (0x6A)
+#define TC_REG_TIMSCAL2             (0x72)
+#define TC_VAL_SCAL_MASK            (0xFF)
+
+/******************************************************************************
+ * Timer CYCLE registers
+ *
+ * CYCLE7:0  : Additional number of elapsed timer/counter expires, before
+ *             CYCIRQ is released. When  programmed to a value N, an interrupt
+ *             is issued every (N+1) expiry. This register is active in
+ *             one-shot and free-running mode. In one-shot mode, the timer
+ *             needs to be restarted under host control N times before an
+ *             interrupt is generated.
+ *             0: Interrupt generated immediately, when timer/counter expired
+ *             1: Interrupt generated after N+1 expires of timer/counter
+ *****************************************************************************/
+#define TC_REG_TIMCYCLE0            (0x63)
+#define TC_REG_TIMCYCLE1            (0x6B)
+#define TC_REG_TIMCYCLE2            (0x73)
+#define TC_VAL_CYCLE_MASK           (0xFF)
+
+/******************************************************************************
+ * Timer LOAD registers
+ *
+ * LOAD7:0  : The register contents define together with TIMSCAL the PWM
+ *            frequency. The timer/counter counts down from LOAD value to 0 in
+ *            (LOAD+1) steps. The value programmed into this register is
+ *            transferred into the timer/counter synchronously to the pre-scaled
+ *            timer clock CNTCLK. Therefore, the settings become only effective,
+ *            when the timer clock is running (TIMCFG.START bit set). If duty
+ *            cycle modulation is enabled, this register defines also the
+ *            resolution of possible duty cycle settings
+ *
+ *****************************************************************************/
+#define TC_REG_TIM_LOAD0            (0x64)
+#define TC_REG_TIM_LOAD1            (0x6C)
+#define TC_REG_TIM_LOAD2            (0x74)
+#define TC_VAL_LOAD_MASK            (0xFF)
+
+/******************************************************************************
+ * Timer Software Reset register
+ *****************************************************************************/
+#define TC_REG_SWRES                (0x78)
+
+/*
+ * Software reset of TIMER2
+ * 0: no action
+ * 1: Software reset on timer 2, needs not to be
+ *    written back to 0
+ */
+#define TC_VAL_SWRES2               (0x01 << 2)
+
+/*
+ * Software reset of TIMER1
+ * 0: no action
+ * 1: Software reset on timer 1, needs not to be
+ *    written back to 0
+ */
+#define TC_VAL_SWRES1               (0x01 << 1)
+
+/*
+ * Software reset of TIMER0
+ * 0: no action
+ * 1: Software reset on timer 0, needs not to be
+ *    written back to 0
+ */
+#define TC_VAL_SWRES0               (0x01)
+
+/******************************************************************************
+ * Timer Raw input status register
+ *
+ * CDIRQ2:0  : Raw interrupt status for CDIRQ timer2,1 and 0
+ *             0: No interrupt pending
+ *             1: Unmasked interrupt generated
+ *
+ * CYCIRQ2:0 : Raw interrupt status for CYCIRQ timer 2, 1 and 0
+ *
+ *****************************************************************************/
+#define TC_REG_TIMRIS               (0x7A)
+
+/******************************************************************************
+ * Timer Mask Interrupt Status register
+ *
+ * CDIRQ2:0  : Interrupt after masking, indicates active contribution to the
+ *             interrupt ball, when set. Status for CDIRQ timer2, 1 and 0
+ *             0: No interrupt pending
+ *             1: Interrupt generated.
+ *
+ * CYCIRQ2:0 : Interrupt after masking, indicates active contribution to the
+ *             interrupt ball, when set. Status for CYCIRQtimer2,1 and 0
+ *             0: No interrupt pending
+ *             1: interrupt generated
+ *****************************************************************************/
+#define TC_REG_TIMMIS               (0x7B)
+
+/******************************************************************************
+ * Timer Interrupt Clear register
+ *
+ * CDIRQ2:0: Clears interrupt CDIRQ timer 2,1, and 0
+ *           0: No effect
+ *           1: Interrupt is cleared. Does not need to be written back to 0
+ *
+ * CYCIRQ2:0 Clears interrupt CYCIRQ timer 2,1, and 0
+ *           0: No effect
+ *           1: Interrupt is cleared. Does not need to be written back to 0
+ *****************************************************************************/
+#define TC_REG_TIMIC                (0x7C)
+#define TC_VAL_CDIRQ2               (0x01 << 5)
+#define TC_VAL_CDIRQ1               (0x01 << 4)
+#define TC_VAL_CDIRQ0               (0x01 << 3)
+#define TC_VAL_CYCIRQ2              (0x01 << 2)
+#define TC_VAL_CYCIRQ1              (0x01 << 1)
+#define TC_VAL_CYCIRQ0              (0x01)
+
+/******************************************************************************
+ * Patter Storage Register
+ *****************************************************************************/
+#define TC_REG_PWMWP                (0x7D)
+
+/*
+ * POINTER6:0 Points to the pattern position configuration register,
+ * which will be overwritten by the next write access
+ * to the PWMPAT register
+ * 0 <= POINTER < 32  : Timer0 patterns 0 to 31
+ * 32 <= POINTER < 64 : Timer1 patterns 0 to 31
+ * 64 <= POINTER < 96 : Timer2 patterns 0 to 31
+ * 96 <= POINTER < 128: Not Valid
+ */
+#define TC_VAL_POINTER_MASK         (0x7F)
+
+/******************************************************************************
+ * PWMPAT register
+ *
+ * PAT15:0 : Input port to the pattern storage register indexed by PWMWP,
+ *           After I2C write, PWMWP is incremented. Cannot be written in two
+ *           byte accesses, must be written in a single I2C burst command.
+ *
+ *****************************************************************************/
+#define TC_REG_PWMPAT_HIGH          (0x7E)
+#define TC_REG_PWMPAT_LOW           (0x7F)
+
+/******************************************************************************
+ * Manufacture Code register
+ *****************************************************************************/
+#define TC_REG_MANUFACT_CODE        (0x80) /* Read Only */
+#define TC_VAL_MANUFACTURE_CODE     (0x03)
+
+/******************************************************************************
+ * Software Version register
+ *****************************************************************************/
+#define TC_REG_SW_VERSION           (0x81)
+#define TC_VAL_SW_VERSION           (0xC0)
+
+/******************************************************************************
+ * I2C register
+ *****************************************************************************/
+#define TC_REG_I2CA                 (0x80) /* Write Only */
+
+/******************************************************************************
+ * Reset Register
+ *****************************************************************************/
+#define TC_REG_RSTCTRL              (0x82)
+
+/*
+ * Interrupt Controller Reset
+ * Status on ball IRQN remains unaffected. This register bit is only used
+ * to control IRA module register. Interrupt status read out is not
+ * possible, when this bit is set. It is recommended to leave this bit always
+ * at zero.
+ * 0: Interrupt Controller not reset
+ * 1: Interrupt Controller is reset (Need to write back to 0, once reset)
+ */
+#define TC_VAL_IRQRST               (0x01 << 4)
+
+/*
+ * Timer Reset for timers 0,1,2
+ * 0: Timer not reset
+ * 1: Timer is reset (Need to write back to 0, once reset)
+ */
+#define TC_VAL_TIMRST               (0x01 << 3)
+
+/*
+ * Keyboard interface reset
+ * 0: Keyboard not reset
+ * 1: Keyboard is reset (Need to write back to 0, once reset)
+ */
+#define TC_VAL_KBDRST               (0x01 << 1)
+
+/*
+ * GPIO reset
+ * 0: GPIO not reset
+ * 1: GPIO reset (Need to write back to 0, once reset)
+ */
+#define TC_VAL_GPIRST               (0x01)
+
+/******************************************************************************
+ * External Reset Register
+ *****************************************************************************/
+#define TC_REG_EXTRSTN              (0x83)
+
+/*
+ * External Reset ball (RESETN) enable
+ * This register is not on the global reset line, it is reset
+ * only by a power-on reset
+ * 0: RESETN ball is not used as hardware reset
+ * 1: RESETN is used as hardware reset
+ */
+#define TC_VAL_EXTRSTN              (0x01)
+
+/******************************************************************************
+ * Reset Interrupt Clear register
+ *****************************************************************************/
+#define TC_REG_RSTINTCLR            (0x84)
+
+/*
+ * Clears the RSTINT interrupt
+ * 0: No impact
+ * 1: Clear PORSTN interrupt (does not need to be re-written to 0)
+ */
+#define TC_VAL_IRQCLR               (0X01)
+
+/******************************************************************************
+ * Power on Watch dog Register
+ *****************************************************************************/
+#define TC_REG_PORTRIM              (0X85)
+
+/*
+ * Override factory setting for Power-on-reset with PRO_TRIMSEL value
+ * 0: Use factory setting
+ * 1: Use value defined in POR_TRIM
+ */
+#define TC_VAL_POR_SEL              (0x01 << 7)
+
+/*
+ * 5 bit setting for Power-on-reset level, twos complement
+ * This value affects reset behavior for power-on reset judged on the
+ * voltage found on VCC.
+ */
+#define TC_VAL_POR_TRIM_MASK        (0x1F)
+
+/******************************************************************************
+ * Clock Mode register
+ *****************************************************************************/
+#define TC_REG_CLKMODE              (0x88)
+
+/*
+ * This register determines the operating mode
+ * 0: SLEEP mode, no SYSCLK generation
+ * 1: OPERATION mode
+ */
+#define TC_VAL_MODCTL               (0x01)
+
+/******************************************************************************
+ * Clock Configure Register
+ *****************************************************************************/
+#define TC_REG_CLKCFG               (0x89)
+
+/*
+ * Clock source selector
+ * This switch shall not be modified, if CLKMODE.MODCTL is at SLEEP
+ * 0: LVCMOS clock input
+ * 1: Internal RC-oscillator
+ */
+#define TC_VAL_CLKSRCSEL            (0x01 << 6)
+
+/*
+ *  Clock frequency doubler enable (should only be enabled when CLKDIV=0)
+ * 0: Disable clock frequency doubler
+ * 1: Enable clock frequency doubler
+ */
+#define TC_VAL_CLKFDEN              (0x01 << 4)
+
+/* Clock divider for SYSCLK
+ * Used to divide a high frequency LVCMOS input clock DIR24 or alternatively
+ * the internal RC clock to the SYSCLK frequency. Keep in mind that SYSCLK
+ * frequency *6.5 must exceed the maximum allowed SCL frequency.
+ * Clock division ratio is 2
+ *
+ * 0x0: Divide by 1
+ * 0x1: Divide by 2
+ * 0x2: Divide by 4
+ * ...
+ * 0x9: Divide by 512 (Maximum legal division factor)
+ * 0xA: Not allowed
+ * ...
+ * 0xF: Not allowed
+ */
+#define TC_VAL_CLKDIV_MASK          (0x0F)
+
+/******************************************************************************
+ * Clock Enable Register
+ *****************************************************************************/
+#define TC_REG_CLKEN                (0x8A)
+
+/* Clock output enable Mask */
+#define TC_VAL_CLKOUTEN_MASK        (0xC0)
+/* CLKOUT clock disabled */
+#define TC_VAL_CLKOUTEN_DISABLE     (0x00)
+/* CLKOUT clock frequency = SYSCLK frequency */
+#define TC_VAL_CLKOUTEN_SYSCLK      (0x40)
+/* CLKOUT clock frequency = 1/2 SYSCLK frequency */
+#define TC_VAL_CLKOUTEN_HALF_SYSCLK (0x80)
+
+/*
+ * Timer 0,1,2 clock enable
+ * 0: Timer 0,1 and 2 disabled
+ * 1: Timer 0,1 and 2 enabled
+ * The Timer clock can only be enabled, if an external clock feed
+ * (LVCMOS line) is used.
+ */
+#define TC_VAL_TIMEN                (0x01 << 2)
+
+/*
+ * Keyboard clock enable
+ * 0: Keyboard clock disabled
+ * 1: Keyboard clock enabled
+ */
+#define TC_VAL_KBDEN                (0x01)
+
+/******************************************************************************
+ * Auto Sleep Timer Enable register
+ *****************************************************************************/
+#define TC_REG_AUTOSLPENA           (0x8B)
+
+/*
+ * Auto Sleep feature enable
+ * When Auto-sleep is on, the register MODCTL is controlled
+ * under a state machine and should not be programmed directly
+ * via I2C. Also, the register CLKCFG should not be programmed,
+ * when Auto-sleep is enabled
+ * 0: Auto-sleep feature is off
+ * 1: Auto-sleep feature is on
+ */
+#define TC_VAL_AUTO_ENABLE          (0x01)
+
+/******************************************************************************
+ * AUTO Sleep Timer Register
+ *
+ * UPTIME10:0  : Minimum time the TC35894XBG stays in OPERATION mode
+ *               Counts SYSCLK cycles before going into SLEEP mode
+ *               The value programmed here is multiplied by 64 and copied into
+ *               the timer at the time AUTOSLPENA.ENABLE is set to 1.
+ *****************************************************************************/
+#define TC_REG_AUTOSLPTIMER_HIGH    (0x8C)
+#define TC_REG_AUTOSLPTIMER_LOW     (0x8D)
+#define TC_VAL_UPTIME_LOW_MASK      (0x03)
+
+/******************************************************************************
+ * I2C wakeup register
+ *****************************************************************************/
+#define TC_REG_I2CWAKEUP_EN         (0x8E)
+
+/*
+ * I2C wake-up enable
+ * 0: Device does not wake-up b I2C access to KBD/TIM module when in SLEEP
+ * 1: Device wakes up by I2C access to KBD/TIM module in SLEEP.
+ */
+#define TC_VAL_I2CWEN               (0x01)
+
+/******************************************************************************
+ * Modified Feature Set Register
+ *****************************************************************************/
+#define TC_REG_KBDMFS               (0x8F)      /* Write Only */
+
+/*
+ * Modified feature set enable / disable
+ * 0: TC35892XBG compatibility mode (modified features disabled)
+ * 1: Modified features enabled
+ */
+#define TC_VAL_MFSEN                (0x01)
+
+/******************************************************************************
+ * Interrupt Status Register
+ *****************************************************************************/
+#define TC_REG_IRQST                (0x91)      /* Read Only */
+
+/*
+ * Supply failure on VCC. Also Power-on is considered
+ * as an initial supply failure.
+ * 0: No failure recoreded
+ * 1: Failure Occurred
+ */
+#define TC_VAL_PORIRQ               (0x01 << 7)
+
+/*
+ * Keyboard Interrupt (further key selection in keyboard
+ * module)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_KBDIRQ               (0x01 << 6)
+
+/*
+ * Direct keyboard interrupt (further key selection
+ * in GPIO module)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_DKBD_IRQ             (0x01 << 5)
+
+/*
+ * Timer 2 Expire (CDIRQ or CYCIRG)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_TIM2IRQ              (0x01 << 3)
+
+/*
+ * Timer 1 Expire (CDIRA or CYCIRQ)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_TIM1IRQ              (0x01 << 2)
+
+/*
+ * Timer 0 Expire (CDIRA or CYCIRQ)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_TIM0IRQ              (0x01 << 1)
+
+/*
+ * GPIO interrupt (further selectionin GPIO module)
+ * 0: Inactive
+ * 1: Active
+ */
+#define TC_VAL_GPIIRQ               (0x01)
+
+/******************************************************************************
+ * Drive0 Strength register
+ *
+ * KPX[7:0]DRV1:0 : Output drive strength for KPX[7:0] ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ ******************************************************************************/
+#define TC_REG_DRIVE0_HIGH          (0xA0)
+#define TC_VAL_KPX7_LOW             (0x00)
+#define TC_VAL_KPX7_MED_LOW         (0x40)
+#define TC_VAL_KPX7_MED_HI          (0x80)
+#define TC_VAL_KPX7_HI              (0xC0)
+#define TC_VAL_KPX6_LOW             (0x00)
+#define TC_VAL_KPX6_MED_LOW         (0x01)
+#define TC_VAL_KPX6_MED_HI          (0x02)
+#define TC_VAL_KPX6_HI              (0x03)
+#define TC_VAL_KPX5_LOW             (0x00)
+#define TC_VAL_KPX5_MED_LOW         (0x04)
+#define TC_VAL_KPX5_MED_HI          (0x08)
+#define TC_VAL_KPX5_HI              (0x0C)
+#define TC_VAL_KPX4_LOW             (0x00)
+#define TC_VAL_KPX4_MED_LOW         (0x01)
+#define TC_VAL_KPX4_MED_HI          (0x02)
+#define TC_VAL_KPX4_HI              (0x03)
+
+#define TC_REG_DRIVE0_LOW           (0xA1)
+#define TC_VAL_KPX3_LOW             (0x00)
+#define TC_VAL_KPX3_MED_LOW         (0x40)
+#define TC_VAL_KPX3_MED_HI          (0x80)
+#define TC_VAL_KPX3_HI              (0xC0)
+#define TC_VAL_KPX2_LOW             (0x00)
+#define TC_VAL_KPX2_MED_LOW         (0x01)
+#define TC_VAL_KPX2_MED_HI          (0x02)
+#define TC_VAL_KPX2_HI              (0x03)
+#define TC_VAL_KPX1_LOW             (0x00)
+#define TC_VAL_KPX1_MED_LOW         (0x04)
+#define TC_VAL_KPX1_MED_HI          (0x08)
+#define TC_VAL_KPX1_HI              (0x0C)
+#define TC_VAL_KPX0_LOW             (0x00)
+#define TC_VAL_KPX0_MED_LOW         (0x01)
+#define TC_VAL_KPX0_MED_HI          (0x02)
+#define TC_VAL_KPX0_HI              (0x03)
+
+/******************************************************************************
+ * Drive1 Strength register
+ *
+ * KPY[7:0]DRV1:0 : Output drive strength for KPY[7:0] ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ *****************************************************************************/
+#define TC_REG_DRIVE1_HIGH          (0xA2)
+#define TC_VAL_KPY7_LOW             (0x00)
+#define TC_VAL_KPY7_MED_LOW         (0x40)
+#define TC_VAL_KPY7_MED_HI          (0x80)
+#define TC_VAL_KPY7_HI              (0xC0)
+#define TC_VAL_KPY6_LOW             (0x00)
+#define TC_VAL_KPY6_MED_LOW         (0x01)
+#define TC_VAL_KPY6_MED_HI          (0x02)
+#define TC_VAL_KPY6_HI              (0x03)
+#define TC_VAL_KPY5_LOW             (0x00)
+#define TC_VAL_KPY5_MED_LOW         (0x04)
+#define TC_VAL_KPY5_MED_HI          (0x08)
+#define TC_VAL_KPY5_HI              (0x0C)
+#define TC_VAL_KPY4_LOW             (0x00)
+#define TC_VAL_KPY4_MED_LOW         (0x01)
+#define TC_VAL_KPY4_MED_HI          (0x02)
+#define TC_VAL_KPY4_HI              (0x03)
+
+#define TC_REG_DRIVE1_LOW           (0xA3)
+#define TC_VAL_KPY3_LOW             (0x00)
+#define TC_VAL_KPY3_MED_LOW         (0x40)
+#define TC_VAL_KPY3_MED_HI          (0x80)
+#define TC_VAL_KPY3_HI              (0xC0)
+#define TC_VAL_KPY2_LOW             (0x00)
+#define TC_VAL_KPY2_MED_LOW         (0x01)
+#define TC_VAL_KPY2_MED_HI          (0x02)
+#define TC_VAL_KPY2_HI              (0x03)
+#define TC_VAL_KPY1_LOW             (0x00)
+#define TC_VAL_KPY1_MED_LOW         (0x04)
+#define TC_VAL_KPY1_MED_HI          (0x08)
+#define TC_VAL_KPY1_HI              (0x0C)
+#define TC_VAL_KPY0_LOW             (0x00)
+#define TC_VAL_KPY0_MED_LOW         (0x01)
+#define TC_VAL_KPY0_MED_HI          (0x02)
+#define TC_VAL_KPY0_HI              (0x03)
+
+/******************************************************************************
+ * Drive2 Strength register
+ *
+ * EXTIO0DRV1:0   : Output drive strength for EXTIO0 ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ * PWM[2:0]DRV1:0 : Output drive strength for PWM2, PWM1, PWM0 ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ * KPY[11:8]DRV1:0 : Output drive strength for KPY[11:8] ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ *
+ *****************************************************************************/
+#define TC_REG_DRIVE2_HIGH          (0xA4)
+#define TC_VAL_EXTIO0_LOW           (0x00)
+#define TC_VAL_EXTIO0_MED_LOW       (0x40)
+#define TC_VAL_EXTIO0_MED_HI        (0x80)
+#define TC_VAL_EXTIO0_HI            (0xC0)
+#define TC_VAL_PWM2_LOW             (0x00)
+#define TC_VAL_PWM2_MED_LOW         (0x10)
+#define TC_VAL_PWM2_MED_HI          (0x20)
+#define TC_VAL_PWM2_HI              (0x30)
+#define TC_VAL_PWM1_LOW             (0x00)
+#define TC_VAL_PWM1_MED_LOW         (0x04)
+#define TC_VAL_PWM1_MED_HI          (0x08)
+#define TC_VAL_PWM1_HI              (0x0C)
+#define TC_VAL_PWM0_LOW             (0x00)
+#define TC_VAL_PWM0_MED_LOW         (0x01)
+#define TC_VAL_PWM0_MED_HI          (0x02)
+#define TC_VAL_PWM0_HI              (0x03)
+
+#define TC_REG_DRIVE2_LOW           (0xA5)
+#define TC_VAL_KPY11_LOW            (0x00)
+#define TC_VAL_KPY11_MED_LOW        (0x40)
+#define TC_VAL_KPY11_MED_HI         (0x80)
+#define TC_VAL_KPY11_HI             (0xC0)
+#define TC_VAL_KPY10_LOW            (0x00)
+#define TC_VAL_KPY10_MED_LOW        (0x01)
+#define TC_VAL_KPY10_MED_HI         (0x02)
+#define TC_VAL_KPY10_HI             (0x03)
+#define TC_VAL_KPY9_LOW             (0x00)
+#define TC_VAL_KPY9_MED_LOW         (0x04)
+#define TC_VAL_KPY9_MED_HI          (0x08)
+#define TC_VAL_KPY9_HI              (0x0C)
+#define TC_VAL_KPY8_LOW             (0x00)
+#define TC_VAL_KPY8_MED_LOW         (0x01)
+#define TC_VAL_KPY8_MED_HI          (0x02)
+#define TC_VAL_KPY8_HI              (0x03)
+
+/******************************************************************************
+ * Drive3 Strength register
+ *
+ * IRQNDRV1:0  : Output drive strength for IRANDRV ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ * SDADRV1:0   : Output drive strength for SDADRV ball
+ *               00: Lowest strength
+ *               01: Medium strength
+ *               10: Medium strength
+ *               11: Highest strength
+ *
+ *****************************************************************************/
+#define TC_REG_DRIVE_3              (0xA6)
+#define TC_VAL_IRQNDRV_LOW          (0x00)
+#define TC_VAL_IRQNDRV_MED_LOW      (0x04)
+#define TC_VAL_IRQNDRV_MED_HI       (0x08)
+#define TC_VAL_IRQNDRV_HI           (0x0C)
+#define TC_VAL_SDADRV_LOW           (0x00)
+#define TC_VAL_SDADRV_MED_LOW       (0x01)
+#define TC_VAL_SDADRV_MED_HI        (0x02)
+#define TC_VAL_SDADRV_HI            (0x03)
+
+/******************************************************************************
+ * IOCF Configuration register
+ *
+ * GPIOSEL3:0  : Overrides BALLCFG with GPIO functionality for DIR24 and
+ *               PWM[2:0] balls.
+ *               0: Use functionality defined in BALLCFG for DIR24 and
+ *                  PWM[2:0] balls
+ *               1: Override DIR24 and PWM[2:0] functionality with GPIO
+ *
+ * IG          : Global input gate
+ *               0: Disable all inputs
+ *               1: Enable all inputs
+ *
+ * BALLCFG1:0  : Ball configuration Setting
+ *               See Data sheet for tables.
+ *****************************************************************************/
+#define TC_REG_IOCFG                (0xA7)
+
+/******************************************************************************
+ * IOPC Ext registers
+ *
+ * DIR[25:24]PR 1:0 : Resistor enable for DIR[25:24] ball
+ *                    00: No pull resistor
+ *                    01: Pull down resistor
+ *                    10: Pull up resistor
+ *                    11: Pull up resistor
+ *****************************************************************************/
+#define TC_REG_IOPCEXT              (0xA8)
+#define TC_VAL_DIR25_NO_RESISTOR    (0x00)
+#define TC_VAL_DIR25_PULL_DOWN      (0x04)
+#define TC_VAL_DIR25_PULL_UP        (0x08)
+#define TC_VAL_DIR25_PULL_UP_HI     (0x0C)
+#define TC_VAL_DIR24_NO_RESISTOR    (0x00)
+#define TC_VAL_DIR24_PULL_DOWN      (0x01)
+#define TC_VAL_DIR24_PULL_UP        (0x02)
+#define TC_VAL_DIR24_PULL_UP_HI     (0x03)
+
+/******************************************************************************
+ * IOPC0 Registers
+ *
+ * KPX[7:0]DRV1:0 : Resistor enable  for KPX[7:0] ball
+ *                 00: No pull resistor
+ *                 01: Pull down resistor
+ *                 10: Pull up resistor
+ *                 11: Pull up resistor
+ *****************************************************************************/
+#define TC_REG_IOPC0_HIGH           (0xAA)
+#define TC_VAL_KPX7_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX7_PULL_DOWN       (0x40)
+#define TC_VAL_KPX7_PULL_UP         (0x80)
+#define TC_VAL_KPX7_PULL_UP_HI      (0xC0)
+#define TC_VAL_KPX6_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX6_PULL_DOWN       (0x01)
+#define TC_VAL_KPX6_PULL_UP         (0x02)
+#define TC_VAL_KPX6_PULL_UP_HI      (0x03)
+#define TC_VAL_KPX5_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX5_PULL_DOWN       (0x04)
+#define TC_VAL_KPX5_PULL_UP         (0x08)
+#define TC_VAL_KPX5_PULL_UP_HI      (0x0C)
+#define TC_VAL_KPX4_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX4_PULL_DOWN       (0x01)
+#define TC_VAL_KPX4_PULL_UP         (0x02)
+#define TC_VAL_KPX4_PULL_UP_HI      (0x03)
+
+#define TC_REG_IOPC0_LOW            (0xAB)
+#define TC_VAL_KPX3_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX3_PULL_DOWN       (0x40)
+#define TC_VAL_KPX3_PULL_UP         (0x80)
+#define TC_VAL_KPX3_PULL_UP_HI      (0xC0)
+#define TC_VAL_KPX2_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX2_PULL_DOWN       (0x01)
+#define TC_VAL_KPX2_PULL_UP         (0x02)
+#define TC_VAL_KPX2_PULL_UP_HI      (0x03)
+#define TC_VAL_KPX1_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX1_PULL_DOWN       (0x04)
+#define TC_VAL_KPX1_PULL_UP         (0x08)
+#define TC_VAL_KPX1_PULL_UP_HI      (0x0C)
+#define TC_VAL_KPX0_NO_RESISTOR     (0x00)
+#define TC_VAL_KPX0_PULL_DOWN       (0x01)
+#define TC_VAL_KPX0_PULL_UP         (0x02)
+#define TC_VAL_KPX0_PULL_UP_HI      (0x03)
+
+/******************************************************************************
+ * IOPC1 Registers (0xAC, 0xAD)
+ *
+ * KPY[7:0]DRV1:0 : Resistor enable  for KPY[7:0] ball
+ *                 00: No pull resistor
+ *                 01: Pull down resistor
+ *                 10: Pull up resistor
+ *                 11: Pull up resistor
+ *****************************************************************************/
+#define TC_REG_IOPC1_HIGH           (0xAC)
+#define TC_VAL_KPY7_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY7_PULL_DOWN       (0x40)
+#define TC_VAL_KPY7_PULL_UP         (0x80)
+#define TC_VAL_KPY7_PULL_UP_HI      (0xC0)
+#define TC_VAL_KPY6_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY6_PULL_DOWN       (0x01)
+#define TC_VAL_KPY6_PULL_UP         (0x02)
+#define TC_VAL_KPY6_PULL_UP_HI      (0x03)
+#define TC_VAL_KPY5_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY5_PULL_DOWN       (0x04)
+#define TC_VAL_KPY5_PULL_UP         (0x08)
+#define TC_VAL_KPY5_PULL_UP_HI      (0x0C)
+#define TC_VAL_KPY4_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY4_PULL_DOWN       (0x01)
+#define TC_VAL_KPY4_PULL_UP         (0x02)
+#define TC_VAL_KPY4_PULL_UP_HI      (0x03)
+
+#define TC_REG_IOPC1_LOW            (0xAD)
+#define TC_VAL_KPY3_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY3_PULL_DOWN       (0x40)
+#define TC_VAL_KPY3_PULL_UP         (0x80)
+#define TC_VAL_KPY3_PULL_UP_HI      (0xC0)
+#define TC_VAL_KPY2_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY2_PULL_DOWN       (0x01)
+#define TC_VAL_KPY2_PULL_UP         (0x02)
+#define TC_VAL_KPY2_PULL_UP_HI      (0x03)
+#define TC_VAL_KPY1_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY1_PULL_DOWN       (0x04)
+#define TC_VAL_KPY1_PULL_UP         (0x08)
+#define TC_VAL_KPY1_PULL_UP_HI      (0x0C)
+#define TC_VAL_KPY0_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY0_PULL_DOWN       (0x01)
+#define TC_VAL_KPY0_PULL_UP         (0x02)
+#define TC_VAL_KPY0_PULL_UP_HI      (0x03)
+
+/******************************************************************************
+ * IOPC2 Registers (0xAE, 0xAF)
+ *
+ * EXTIO0PR1:0   : Resistor enable for EXTIO0 ball
+ *                 00: No pull resistor
+ *                 01: Pull down resistor
+ *                 10: Pull up resistor
+ *                 11: Pull up resistor
+ * PWM[2:0]PR1:0 : Resistor enable for PWM[2:0] ball
+ *                 00: No pull resistor
+ *                 01: Pull down resistor
+ *                 10: Pull up resistor
+ *                 11: Pull up resistor
+ * KPY[11:8]PR1:0: Resistor enable for KPY[11:8] ball
+ *                 00: No pull resistor
+ *                 01: Pull down resistor
+ *                 10: Pull up resistor
+ *                 11: Pull up resistor
+ *****************************************************************************/
+#define TC_REG_IOPC2_HIGH           (0xAE)
+#define TC_VAL_EXTIO0_NO_RESISTOR   (0x00)
+#define TC_VAL_EXTIO0_PULL_DOWN     (0x40)
+#define TC_VAL_EXTIO0_PULL_UP       (0x80)
+#define TC_VAL_EXTIO0_PULL_UP_HI    (0xC0)
+#define TC_VAL_PWM2_NO_RESISTOR     (0x00)
+#define TC_VAL_PWM2_PULL_DOWN       (0x10)
+#define TC_VAL_PWM2_PULL_UP         (0x20)
+#define TC_VAL_PWM2_PULL_UP_HI      (0x30)
+#define TC_VAL_PWM1_NO_RESISTOR     (0x00)
+#define TC_VAL_PWM1_PULL_DOWN       (0x04)
+#define TC_VAL_PWM1_PULL_UP         (0x08)
+#define TC_VAL_PWM1_PULL_UP_HI      (0x0C)
+#define TC_VAL_PWM0_NO_RESISTOR     (0x00)
+#define TC_VAL_PWM0_PULL_DOWN       (0x01)
+#define TC_VAL_PWM0_PULL_UP         (0x02)
+#define TC_VAL_PWM0_PULL_UP_HI      (0x03)
+
+#define TC_REG_IOPC2_LOW            (0xAF)
+#define TC_VAL_KPY11_NO_RESISTOR    (0x00)
+#define TC_VAL_KPY11_PULL_DOWN      (0x40)
+#define TC_VAL_KPY11_PULL_UP        (0x80)
+#define TC_VAL_KPY11_PULL_UP_HI     (0xC0)
+#define TC_VAL_KPY10_NO_RESISTOR    (0x00)
+#define TC_VAL_KPY10_PULL_DOWN      (0x01)
+#define TC_VAL_KPY10_PULL_UP        (0x02)
+#define TC_VAL_KPY10_PULL_UP_HI     (0x03)
+#define TC_VAL_KPY9_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY9_PULL_DOWN       (0x04)
+#define TC_VAL_KPY9_PULL_UP         (0x08)
+#define TC_VAL_KPY9_PULL_UP_HI      (0x0C)
+#define TC_VAL_KPY8_NO_RESISTOR     (0x00)
+#define TC_VAL_KPY8_PULL_DOWN       (0x01)
+#define TC_VAL_KPY8_PULL_UP         (0x02)
+#define TC_VAL_KPY8_PULL_UP_HI      (0x03)
+
+/******************************************************************************
+ * GPIO Dat registers
+ *
+ * DATA23:0 : Data 23:0 (on ball EXTIO0, PWM[2:0], KPY[11:0] and KPX[7:0] when
+ *            GPIO selected)
+ *            0: Output "0" when corresponding MASK bit is set to "1"
+ *            1: Output "1" when corresponding MASK bit is set to "1"
+ *****************************************************************************/
+#define TC_REG_GPIODATA0            (0xC0)
+#define TC_REG_GPIODATA1            (0xC2)
+#define TC_REG_GPIODATA2            (0xC4)
+
+/******************************************************************************
+ * GPIO Data Mask Registers
+ *
+ * MASK23:0 Mask bit for DATA23:0 (WRITE_ONLY)
+ *          0: Disbale DATA23:0 bit setting
+ *          1: Enable DATA23:0 bit setting
+ *****************************************************************************/
+#define TC_REG_GPIODATA0_MASK       (0xC1)
+#define TC_REG_GPIODATA1_MASK       (0xC3)
+#define TC_REG_GPIODATA2_MASK       (0xC5)
+
+/******************************************************************************
+ * GPIO Direction Registers
+ *
+ * DIR23:0 : Direction bits for DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0] and
+ *           KPX[7:0])
+ *           0: Input Mode
+ *           1: Output Mode
+ *****************************************************************************/
+#define TC_REG_GPIODIR0             (0xC6)
+#define TC_REG_GPIODIR1             (0xC7)
+#define TC_REG_GPIODIR2             (0xC8)
+
+/******************************************************************************
+ * GPIO Interrupt Sense register
+ *
+ * IS23:0 : Interrupt sense bits for DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0] and
+ *          KPX[7:0])
+ *          0: Edge sensitive interrupt
+ *          1: Level sensitive
+ *****************************************************************************/
+#define TC_REG_GPIOIS0              (0xC9)
+#define TC_REG_GPIOIS1              (0xCA)
+#define TC_REG_GPIOIS2              (0xCB)
+
+/*****************************************************************************
+ * GPIO Both Edges Interrupt register
+ *
+ * BE23:0 : Interrupt both edges bits for DATA23:0 (EXTIO0, PWM[2:0],
+ *          KPY[11:0] and KPX[7:0]) IBE23 register bit is used also for DIR24
+ *          input and DIR25 input when they are configured as direct key input.
+ *          0: Interrupt generated at the active edges
+ *          1: Interrupt generated at both edges
+ *****************************************************************************/
+#define TC_REG_GPIOIBE0             (0xCC)
+#define TC_REG_GPIOIBE1             (0xCD)
+#define TC_REG_GPIOIBE2             (0xCE)
+
+/******************************************************************************
+ * GPIO Interrupt Event register
+ *
+ * IEV23:0 : Interrupt event select from DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0]
+ *           and KPX[7:0]) IEV23 register bit is used also for DIR24 input and
+ *           DIR25 input when they are configured as direct key input
+ *           0: Interrupt at low level of falling edge
+ *           1: Interrupt at high level of rising edge
+ *****************************************************************************/
+#define TC_REG_GPIOIEV0             (0xCF)
+#define TC_REG_GPIOIEV1             (0xD0)
+#define TC_REG_GPIOIEV2             (0xD1)
+
+/******************************************************************************
+ * GPIO Interrupt Enable register
+ *
+ * IE23:0 : Interrupt enable for DATE23:0 (EXTIO0, PWM[2:0], KPY[11:0] and
+ *          KPX[7:0])
+ *          0: Disable Interrupt
+ *          1: Enable Interrupt
+ *****************************************************************************/
+#define TC_REG_GPIOIE0              (0xD2)
+#define TC_REG_GPIOIE1              (0xD3)
+#define TC_REG_GPIOIE2              (0xD4)
+
+/******************************************************************************
+ * GPIO Raw Input Status register
+ *
+ * RIS23:0 : Raw interrupt status for DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0] and
+ *           KPX[7:0])
+ *           0: No interrupt condition at GPIO
+ *           1: Interrupt condtionat GPIO
+ *****************************************************************************/
+#define TC_REG_GPIORIS0             (0xD6)
+#define TC_REG_GPIORIS1             (0xD7)
+#define TC_REG_GPIORIS2             (0xD8)
+
+/******************************************************************************
+ * GPIO Mask Interrupt Status register
+ *
+ * MIS23:0 : Masked interrupt status for (EXTIO0, PWM[2:0], KPY[11:0] and
+ *           KPX[7:0])
+ *           0: No interrupt condition from GPIO
+ *           1: Interrupt at GPIO is active
+ *****************************************************************************/
+#define TC_REG_GPIOMIS0             (0xD9)
+#define TC_REG_GPIOMIS1             (0xDA)
+#define TC_REG_GPIOMIS2             (0xDB)
+
+/******************************************************************************
+ * GPIO Interrupt Clear register
+ *
+ * IC23:0 : Clear interrupt of DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0] and
+ *          KPX[7:0])
+ *          0: No effect
+ *          1: Clear corresponding interrupt
+ *****************************************************************************/
+#define TC_REG_GPIOIC0              (0xDC)
+#define TC_REG_GPIOIC1              (0xDD)
+#define TC_REG_GPIOIC2              (0xDE)
+
+/******************************************************************************
+ * GPIO OMS Registers
+ *
+ * ODM23:0 : Open Drain Mode Select for DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0]
+ *           and KPX[7:0])
+ *           0: Only N-MOS transistor is active in output driver stage.
+ *              Output can be driven to GND or HI-Z
+ *           1: Only P-MOS transistor is active in output driver stage.
+ *              Output can be driven to VCC or Hi-Z
+ *
+ * ODE23:0:  Open Drain Enable for DATA23:0 (EXTIO0, PWM[2:0], KPY[11:0]
+ *           and KPX[7:0])
+ *           0: Full buffer
+ *           1: Open Drain Functionality
+ *****************************************************************************/
+#define TC_REG_GPIOOMS0_A           (0xE0)
+#define TC_REG_GPIOOMS0_B           (0xE1)
+#define TC_REG_GPIOOMS1_A           (0xE2)
+#define TC_REG_GPIOOMS1_B           (0xE3)
+#define TC_REG_GPIOOMS2_A           (0xE4)
+#define TC_REG_GPIOOMS2_B           (0xE5)
+
+/******************************************************************************
+ * GPIO Wake Registers
+ *
+ * WAKE23:0 : Each bit corresponds to a ball except WAKE23. WAKE23 is
+ *            corresponding DIR25:24 and EXTIO0 balls. When bit set, the
+ *            corresponding ball contributes to wake-up from Auto-sleep
+ *            mode. When set, the corresponding ball is also used as a trigger
+ *            event to the TRIGGER pattern of the Timer module.
+ *            0: Wakeup from Auto-sleep mode on corresponding ball is disabled.
+ *            1: The corresponding ball contributes to wake-up from Auto-Sleep
+ *               mode. And, the corresponding ball is also used as a trigger
+ *               event to the TRIGGER pattern of the timer module.
+ *****************************************************************************/
+#define TC_REG_GPIOWAKE0            (0xE9)
+#define TC_REG_GPIOWAKE1            (0xEA)
+#define TC_REG_GPIOWAKE2            (0xEB)
+
+/******************************************************************************
+ * Direct Key Event Code register
+ *****************************************************************************/
+#define TC_REG_DEVTCODE             (0xE6)
+
+/*
+ * Indicates, whether keyboard event was a key press or a key relese
+ * 0: Key was pressed
+ * 1: Key was released
+ */
+#define TC_VAL_DKEYSTAT             (0x01 << 5)
+
+/*
+ * Direct key event code
+ * 0x01: event on KPX0 ball
+ * 0x02: event on KPX1 ball
+ * ...
+ * 0x19: event on DIR24 ball
+ * 0x1A: event on DIR25 ball
+ * 0x1F: event buffer empty
+ */
+#define TC_VAL_DKEYCODE_MASK        (0x1F)
+
+/******************************************************************************
+ * Input De-Bounce register
+ *****************************************************************************/
+#define TC_REG_DBOUNCE              (0xE8)
+
+/*
+ * Enables de-bouncing feature on general purpose input lines.
+ * Debouncing makes the input lines immune to noise.
+ * 0: No synchronization
+ * 1: Synchronization of the GPIO input lines according the value
+ *    conf. in DBOUNCE.
+ */
+#define TC_VAL_DB_SYNC              (0x01 << 5)
+
+/*
+ * De-Bounce time for the inputs.
+ * 00: 1.5ms
+ * 01: 3.0ms
+ * 02: 4.5ms
+ * ...
+ * 1F: 48ms
+ */
+#define TC_VAL_DBOUNCE_MASK         (0x1F)
+
+/******************************************************************************
+ * Direct Keypad Registers (0-3)
+ *
+ * DIRECT23-0: Direct keypad bits take priority over anything else These bits
+ *             must be cleared to '0' before IOCFG is accessed to set other
+ *             functions for the pins.
+ *             0: General purpose input/output functionality is active
+ *             1: Direct keypad functionality is active.
+ *****************************************************************************/
+#define TC_REG_DIRECT0              (0xEC)
+#define TC_VAL_DIRECT7              (0x01 << 7)
+#define TC_VAL_DIRECT6              (0x01 << 6)
+#define TC_VAL_DIRECT5              (0x01 << 5)
+#define TC_VAL_DIRECT4              (0x01 << 4)
+#define TC_VAL_DIRECT3              (0x01 << 3)
+#define TC_VAL_DIRECT2              (0x01 << 2)
+#define TC_VAL_DIRECT1              (0x01 << 1)
+#define TC_VAL_DIRECT0              (0x01)
+
+#define TC_REG_DIRECT1              (0xED)
+#define TC_VAL_DIRECT15             (0x01 << 7)
+#define TC_VAL_DIRECT14             (0x01 << 6)
+#define TC_VAL_DIRECT13             (0x01 << 5)
+#define TC_VAL_DIRECT12             (0x01 << 4)
+#define TC_VAL_DIRECT11             (0x01 << 3)
+#define TC_VAL_DIRECT10             (0x01 << 2)
+#define TC_VAL_DIRECT9              (0x01 << 1)
+#define TC_VAL_DIRECT8              (0x01)
+
+#define TC_REG_DIRECT2              (0xEE)
+#define TC_VAL_DIRECT23             (0x01 << 7)
+#define TC_VAL_DIRECT22             (0x01 << 6)
+#define TC_VAL_DIRECT21             (0x01 << 5)
+#define TC_VAL_DIRECT20             (0x01 << 4)
+#define TC_VAL_DIRECT19             (0x01 << 3)
+#define TC_VAL_DIRECT18             (0x01 << 2)
+#define TC_VAL_DIRECT17             (0x01 << 1)
+#define TC_VAL_DIRECT16             (0x01)
+
+#define TC_REG_DIRECT3              (0xEF)
+#define TC_VAL_DIRECT25             (0x01 << 1)
+#define TC_VAL_DIRECT24             (0x01)
+
+/******************************************************************************
+ * Direct Key Raw Interrupt register
+ *****************************************************************************/
+#define TC_REG_DKBDRIS              (0xF0)
+
+/*
+ * Raw Event Lost Interrupt
+ * This bit is cleared by writing int DEVTIC
+ * 0: No interrupt
+ * 1: More than 8 direct key events have been detected and
+ *    caused the event buffer to overflow.
+ */
+#define TC_VAL_DRELINT              (0x01 << 1)
+
+/*
+ * Raw direct key event interrupt
+ * Reading from DEVTCODE until the buffer is empty will automatically clear
+ * this interrupt
+ * 0: No interrupt
+ * 1: At lest one direct key press or direct key release in the event buffer.
+ */
+#define TC_VAL_DREVTINT             (0x01)
+
+/******************************************************************************
+ * Direct Key Mask Interrupt register
+ *****************************************************************************/
+#define TC_REG_DKBDMIS              (0xF1)
+
+/*
+ * Masked Event Lost Interrupt
+ * 0: No interrupt
+ * 1: More than 8 direct key events have been detected and
+ * and caused the event buffer to overflow.
+ */
+#define TC_VAL_DMELINT              (0x01 << 1)
+
+/*
+ * Masked Direct key Event interrupt
+ * 0: No interrupt
+ * 1: At least one direct key press or direct key release is in
+ * the event buffer.
+ */
+#define TC_VAL_DMEVTINT             (0x01)
+
+/******************************************************************************
+ * Direct Key Interrupt Clear register
+ *****************************************************************************/
+#define TC_REG_DKBDIC               (0xF2)
+
+/*
+ * Clear event buffer an corresponding interrupt DREVTINT and DRELINT
+ * The host does not need to write "0". Write "1" every time when clearing
+ * the event buffer.
+ * 0: No action
+ * 1: Clear event buffer and corresponding interrupts REVTINT and RELINT
+ */
+#define TC_VAL_DEVTIC               (0x01)
+
+/******************************************************************************
+ * Direct Key Mask Register
+ *****************************************************************************/
+#define TC_REG_DKBDMSK              (0xF3)
+
+/*
+ * Enable keyboard event lost interrupt
+ * 0: Keyboard event lost interrupt is enabled
+ * 1: Keyboard event lost interrupt is disabled
+ */
+#define TC_VAL_DMSKELINT            (0x01 << 1)
+
+/* Enable keyboard event interrupt
+ * 0: Keyboard event interrupt is enabled
+ * 1: Keyboard event interrupt is disabled
+ */
+#define TC_VAL_DMSKEINT             (0x01)
+
+#endif /* __TC3589XBG_REGS_H */
diff --git a/include/linux/i2c/tc35894xbg.h b/include/linux/i2c/tc35894xbg.h
new file mode 100644
index 0000000..7e3fec3
--- /dev/null
+++ b/include/linux/i2c/tc35894xbg.h
@@ -0,0 +1,72 @@
+/*
+ * tc35894xbg.h - Configuration for TC35894XBG keypad driver.
+ *
+ * (C) Copyright 2010 Intel Corporation
+ * Author: Charlie Paul (z8cpaul@windriver.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#ifndef __LINUX_TC35894XBG_H
+#define __LINUX_TC35894XBG_H
+
+#include <linux/types.h>
+
+/*
+ * Largest keycode that the chip can send, plus one,
+ * so keys can be mapped directly at the index of the
+ * TC35894XBG keycode instead of subtracting one.
+ */
+#define TC35894XBG_KEYMAP_SIZE      (0x7f + 1)
+
+#define SHIFT_NEEDED    (0x1000)
+
+#define KEY_EXCLAM      (KEY_1 + SHIFT_NEEDED)  /* '!' -> shift+1 */
+#define KEY_AT          (KEY_2 + SHIFT_NEEDED)  /* '@' -> shift+2 */
+#define KEY_NUMBER_SIGN (KEY_3 + SHIFT_NEEDED)  /* '#' -> shift+3 */
+#define KEY_DOLLAR_SIGN (KEY_4 + SHIFT_NEEDED)  /* '$' -> shift+4 */
+#define KEY_NOR         (KEY_6 + SHIFT_NEEDED)  /* '^' -> shift+6 */
+#define KEY_PERCENT     (KEY_5 + SHIFT_NEEDED)  /* '%' -> shift+5 */
+#define KEY_AMPERSAND   (KEY_7 + SHIFT_NEEDED)  /* '&' -> shift+7 */
+#define KEY_PLUS        (KEY_EQUAL + SHIFT_NEEDED) /* '+' -> shift+= */
+
+#define KEY_BAR         (KEY_BACKSLASH + SHIFT_NEEDED)  /* '|' -> shift+\ */
+#define KEY_COLON       (KEY_SEMICOLON + SHIFT_NEEDED)  /* ':' -> shift+; */
+#define KEY_UNDERSCORE  (KEY_MINUS + SHIFT_NEEDED) /* '_' -> shift+- */
+#define KEY_QUOTE_DBL   (KEY_APOSTROPHE + SHIFT_NEEDED) /* '"' -> shift+' */
+
+
+#define TC_MAX_KEYMAPS          (2)
+#define TC_DEFAULT_KEYMAP       (0)
+#define TC_ALT_KEYMAP           (1)
+#define TC35894XBG_MAX_FIFO     (8)
+
+
+struct tc35894xbg_platform_data {
+
+	unsigned char debounce_time;  /* Time to watch for bouncing, in ms. */
+	unsigned char settle_time;    /* Idle time until sleep, in ms. */
+	unsigned char col_setting;    /* Sets up ball settings in reg 0x04 */
+	unsigned char rowcol_setting; /* Sets up ball settings in reg 0x05 */
+
+	int gpio_reset; /* reset output GPIO index (-1 if not implemented) */
+	int gpio_irq;   /* interrupt GPIO */
+	int keymap_size;
+	int size_x;
+	int size_y;
+	int function_key;
+	int right_shift_key;
+
+	void	(*reset_ctrl)(struct i2c_client *client, int value);
+
+	int n_keymaps;
+	unsigned short keymap[TC_MAX_KEYMAPS][TC35894XBG_KEYMAP_SIZE];
+
+	/* Device name. */
+	const char *name;
+};
+
+#endif /* __LINUX_TC35894XBG_H */

