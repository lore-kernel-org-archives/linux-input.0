From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] Input: introduce medfield keypad driver
Date: Thu, 08 Jul 2010 17:41:33 +0100
Message-ID: <20100708164127.22458.31279.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29126 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab0GHRKL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jul 2010 13:10:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: Zheng Ba <zheng.ba@intel.com>

An i2c bus driver for the Intel Medfield keypad interface.

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/keyboard/Kconfig       |   10 +
 drivers/input/keyboard/Makefile      |    1 
 drivers/input/keyboard/mfld_keypad.c |  613 ++++++++++++++++++++++++++++++++++
 drivers/input/keyboard/mfld_keypad.h |   56 +++
 4 files changed, 680 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mfld_keypad.c
 create mode 100644 drivers/input/keyboard/mfld_keypad.h


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 950f6d1..10cc686 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -309,6 +309,16 @@ config KEYBOARD_MCS
 	  To compile this driver as a module, choose M here: the
 	  module will be called mcs_touchkey.
 
+config KEYBOARD_MFLD
+	tristate "Medfield I2C keypad support"
+	depends on I2C && GPIOLIB && X86_MRST
+	help
+	  Say Y here if you want to get support for the keypad controller
+	  on the Medfield (MFLD) platform of Intel MID.
+
+	  To compile this as a module, choose M here: the
+	  module will be called mfld_keypad.
+
 config KEYBOARD_IMX
 	tristate "IMX keypad support"
 	depends on ARCH_MXC
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a1f5e9d..9672c3d 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
 obj-$(CONFIG_KEYBOARD_INTEL_MID)	+= intel_mid_keypad.o
+obj-$(CONFIG_KEYBOARD_MFLD)		+= mfld_keypad.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
diff --git a/drivers/input/keyboard/mfld_keypad.c b/drivers/input/keyboard/mfld_keypad.c
new file mode 100644
index 0000000..096349a
--- /dev/null
+++ b/drivers/input/keyboard/mfld_keypad.c
@@ -0,0 +1,613 @@
+/*
+ * drivers/input/keyboard/mfld_keypad.c
+ *
+ * Copyright (c) 2010 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
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
+#include "mfld_keypad.h"
+
+/* commands to send to the chip */
+#define MFLD_KEYPAD_CMD_RSTCTRL		0x82	/* the reset register */
+#define MFLD_KEYPAD_CMD_EXTRSTN		0x83	/* external reset ball enable */
+#define MFLD_KEYPAD_CMD_RSTINTCLR	0x84	/* clear the intrrupt caused
+						   by power-on */
+
+#define MFLD_KEYPAD_CMD_READ_INT	0x91	/* get interrupt status */
+
+#define MFLD_KEYPAD_CMD_AUTOSLPENA	0x8B	/* auto sleep enable */
+#define MFLD_KEYPAD_CMD_AUTOSLPTIMER	0x8C	/* min time to switch
+						   into auto sleep */
+#define MFLD_KEYPAD_CMD_WAKEUPEN	0x8E	/* wake-up automatically
+						   when i2c access */
+#define MFLD_KEYPAD_CMD_CLKEN		0x8A	/* enable internal clock */
+#define MFLD_KEYPAD_CMD_CLKCFG		0x89	/* clock configure,2x */
+#define MFLD_KEYPAD_CMD_IOCFG		0xA7	/* input/output configure */
+#define MFLD_KEYPAD_CMD_IOPCEXT		0xA8	/* pull up resistor
+						   programming */
+#define MFLD_KEYPAD_CMD_IOPC0		0xAA
+#define MFLD_KEYPAD_CMD_IOPC1		0xAC
+#define MFLD_KEYPAD_CMD_IOPC2		0xAE
+
+/* keyboard read event */
+#define MFLD_KEYPAD_FIFO_LEN		8
+#define MFLD_KEYPAD_CMD_READ_FIFO	0x10	/* event buffer for key press,
+						   EVTCODE reg */
+#define MFLD_KEYPAD_CMD_KBDRIS		0x06	/* kbd raw interrupt register */
+#define MFLD_KEYPAD_CMD_KBDMIS		0x07	/* kbd mask interrupt reg */
+#define MFLD_KEYPAD_CMD_KBDIC		0x08	/* clear the kbd interrupt &
+						   event buffer */
+#define MFLD_KEYPAD_CMD_KBDMSK		0x09	/* KBD mask register */
+#define MFLD_KEYPAD_CMD_KBDMFS		0x8F	/* KBD modified feature set */
+#define MFLD_KEYPAD_CMD_GPIODIR2	0xC8	/* gpio input/ output */
+#define MFLD_KEYPAD_CMD_GPIODIR1	0xC7	/* bit clear after reset */
+#define MFLD_KEYPAD_CMD_GPIODIR0	0xC6
+#define MFLD_KEYPAD_CMD_GPIODATA2	0xC4	/* MASK & Data bit */
+#define MFLD_KEYPAD_CMD_GPIODATA1	0xC2
+#define MFLD_KEYPAD_CMD_GPIODATA0	0xC0
+
+/* About the direct key function, maybe non-used here */
+#define MFLD_KEYPAD_CMD_DEVTCODE	0xE6	/* direct key event */
+#define MFLD_KEYPAD_CMD_DEBOUNCE	0xE8	/* direct key debounce */
+#define MFLD_KEYPAD_CMD_DIRECT0		0xEC	/* direct key enable */
+#define MFLD_KEYPAD_CMD_DIRECT1		0xED
+#define MFLD_KEYPAD_CMD_DIRECT2		0xEE
+#define MFLD_KEYPAD_CMD_DIRECT3		0xEF
+#define MFLD_KEYPAD_CMD_DKBDRIS		0xF0	/* unmasked direct key intr */
+#define MFLD_KEYPAD_CMD_DKBDMIS		0xF1	/* key mask interrupt */
+#define MFLD_KEYPAD_CMD_DKBDIC		0xF2	/* direct key intr clear */
+#define MFLD_KEYPAD_CMD_DKBDMSK		0xF3	/* direct key mask register */
+
+/* keyboard setting registers */
+#define MFLD_KEYPAD_CMD_KBDSETTLE	0x01	/* setup of init wait period */
+#define MFLD_KEYPAD_CMD_KBDBOUNCE	0x02	/* setup of de-bouncing */
+#define MFLD_KEYPAD_CMD_KBDSIZE		0x03	/* keyboard matrix setup */
+#define MFLD_KEYPAD_CMD_KBDDEDCFG	0x04	/* dedicated key setup */
+
+/* For detected */
+#define MFLD_KEYPAD_CMD_MANUFACT	0x80	/* manufact.code */
+#define MFLD_KEYPAD_CMD_SWVERSION	0x81	/* SW version */
+
+/* interrupt status */
+#define INT_KEYPAD	0x40	/* kbd irq bit */
+#define INT_PORIRQ	0x80	/* when power on, the bit is set */
+#define INT_MELINT	0x08	/* more than 8 key events overflow */
+
+#define MFLD_KEYPAD_INT_GPIO	51
+#define MFLD_KEYPAD_RST_GPIO	173
+
+/* XXX backlight controls */
+#define PWM1CLKDIV0	0x64
+#define PWM2CLKDIV1	0x65
+#define PWM2DUTYCYCLE	0x69	/* brightness control */
+
+struct mfld_keypad_chip {
+	/* device lock */
+	struct mutex lock;
+	struct i2c_client *client;
+	struct work_struct work;
+	struct input_dev *idev;
+	bool kp_enabled;
+	bool pm_suspend;
+	char phys[32];
+	const unsigned short *keymap;
+	int size_x;
+	int size_y;
+	int shift_down;
+};
+
+#define work_to_mfld_keypad(w)	 container_of(w, struct	mfld_keypad_chip, work)
+#define client_to_mfld_keypad(c) container_of(c, struct mfld_keypad_chip, \
+						client)
+#define dev_to_mfld_keypad(d)	 container_of(c, struct mfld_keypad_chip, \
+						client->dev)
+
+#define MFLD_KEYPAD_MAX_DATA	8
+
+/*
+ * To write, access the chip's address in write mode, and dump the
+ * command and data on the bus. The command and data are taken as
+ * sequential u8s out of varargs, to a maxinum of MFLD_KEYPAD_MAX_DATA
+ */
+static int mfld_keypad_write(struct mfld_keypad_chip *tc, int len, ...)
+{
+	int ret, i;
+	va_list ap;
+	u8 data[MFLD_KEYPAD_MAX_DATA];
+
+	va_start(ap, len);
+	if (len > MFLD_KEYPAD_MAX_DATA) {
+		WARN_ON(1);
+		dev_err(&tc->client->dev, "tried to send %d bytes\n", len);
+		va_end(ap);
+		return 0;
+	}
+
+	for (i = 0; i < len; i++)
+		data[i] = va_arg(ap, int);
+	va_end(ap);
+
+	/*
+	 * If the host is asleep, send again when get NACK
+	 */
+	ret = i2c_master_send(tc->client, data, len);
+	if (unlikely(ret == -EREMOTEIO))
+		ret = i2c_master_send(tc->client, data, len);
+
+	if (unlikely(ret != len))
+		dev_err(&tc->client->dev, "sent %d bytes of %d total\n",
+			len, ret);
+
+	return ret;
+}
+
+/*
+ * To read, first send the command byte and end the transaction.
+ * Then we can get the data in read mode.
+ */
+static int mfld_keypad_read(struct mfld_keypad_chip *tc,
+			    u8 cmd, u8 *buf, int len)
+{
+	int ret;
+	/*
+	 * In case of host's asleep, send again when get NACK
+	 */
+	ret = i2c_master_send(tc->client, &cmd, 1);
+	if (unlikely(ret == -EREMOTEIO))
+		ret = i2c_master_send(tc->client, &cmd, 1);
+
+	if (unlikely(ret != 1)) {
+		dev_err(&tc->client->dev, "sending command 0x%2x failed.\n",
+			cmd);
+		return 0;
+	}
+
+	ret = i2c_master_recv(tc->client, buf, len);
+	if (unlikely(ret != len))
+		dev_err(&tc->client->dev, "want %d bytes, got %d\n", len, ret);
+
+	return ret;
+}
+
+static int mfld_keypad_configure(struct mfld_keypad_chip *tc)
+{
+	int keysize = (tc->size_x << 4) | tc->size_y;
+
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_CLKEN, 0x01);
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDSIZE, keysize);
+	mfld_keypad_write(tc, 3, MFLD_KEYPAD_CMD_KBDDEDCFG, 0xFF, 0xFF);
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_CLKCFG, 0x45);
+	/* maximum debounce time : 15.6ms */
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDBOUNCE, 0x02);
+
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDMSK, 0x0F);
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_DKBDMSK, 0x03);
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDIC, 0x83);
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_DKBDIC, 0x01);
+
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDMSK, 0x00);
+
+	return 0;
+}
+
+/*
+ * AT-style: low 7 bits are the keycode, and the top
+ * bit indicates the state( 1 for down, 0 for up)
+ */
+static inline u8 mfld_keypad_whichkey(u8 event)
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
+static inline int mfld_keypad_ispress(u8 event)
+{
+	/* 1: pressed, 0: released */
+	return (event & 0x80) ? 0 : 1;
+}
+
+/* Reset the keybit of input */
+static void set_keymap_bit(struct mfld_keypad_chip *tc)
+{
+	int i;
+	for (i = 0; i < KEYMAP_SIZE; i++)
+		__set_bit(tc->keymap[i], tc->idev->keybit);
+}
+
+/* Shift key report needed? */
+static int shift_key_needed(struct mfld_keypad_chip *tc, u8 key)
+{
+	if (tc->keymap == mfld_keymap_fn) {
+		switch (key) {
+		case 0: /* '~' */
+		case 1:	/* '@' */
+		case 2:	/* '#' */
+		case 3: /* '$' */
+		case 4:	/* '%' */
+		case 5:	/* '^' */
+		case 6:	/* '&' */
+		case 8:	/* '|' */
+		case 22:	/* ':' */
+		case 29:	/* '_' */
+		case 30:	/* '!' */
+		case 31:	/* '?' */
+		case 32:	/* '(' */
+		case 42:	/* '"' */
+		case 44:	/* ')' */
+			return 1;
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
+/* Report the 'right shift' key */
+static void report_shift_key(struct mfld_keypad_chip *tc, u8 key, int isdown)
+{
+	if (tc->kp_enabled) {
+		/* The right shift key stored at last position:47 */
+		input_report_key(tc->idev, tc->keymap[RIGHT_SHIFT_KEY], isdown);
+		input_sync(tc->idev);
+	}
+}
+
+/* Report the key code */
+static void submit_key(struct mfld_keypad_chip *tc, u8 key,
+		       unsigned short keycode, int isdown)
+{
+	/*
+	 * Translate the non-exist keycode keys.
+	 * when key press down, report the 'shift' key pressed ahead.
+	 */
+
+	if (shift_key_needed(tc, key) && isdown)
+		report_shift_key(tc, key, isdown);
+
+	/* report the key */
+	if (tc->kp_enabled) {
+		input_report_key(tc->idev, keycode, isdown);
+		input_sync(tc->idev);
+	}
+
+	/*
+	 * When key press up, report the 'shift' up followed.
+	 */
+	if (shift_key_needed(tc, key) && !isdown)
+		report_shift_key(tc, key, isdown);
+
+	/*
+	 * if no keys are pressed anymore, remove the 'shift'
+	 */
+	if (i2c_smbus_read_byte_data(tc->client, 0x0B) == 0x7F) {
+		input_report_key(tc->idev, KEY_RIGHTSHIFT, 0);
+		input_report_key(tc->idev, KEY_LEFTSHIFT, 0);
+		input_sync(tc->idev);
+	}
+}
+
+/* Key event interrupt handler */
+static inline void process_keys(struct mfld_keypad_chip *tc)
+{
+	int ret;
+	u8 key_queue[MFLD_KEYPAD_FIFO_LEN];
+	int tail = 0;
+
+	u8 evtcode;
+
+	ret = mfld_keypad_read(tc, MFLD_KEYPAD_CMD_READ_FIFO, &evtcode, 1);
+	if (ret < 0) {
+		dev_err(&tc->client->dev, "Failed reading fifo\n");
+		return;
+	}
+
+	/* clear event buffer */
+	mfld_keypad_write(tc, 2, MFLD_KEYPAD_CMD_KBDIC, 0x83);
+
+	if (evtcode != 0x7F && evtcode != 0xFF) {
+		u8 key = mfld_keypad_whichkey(evtcode);
+		int isdown = mfld_keypad_ispress(evtcode);
+		unsigned short keycode = tc->keymap[key];
+
+		/* The function key pressed */
+		if (key == FN_KEY && isdown) {
+			tc->keymap = mfld_keymap_fn;
+			set_keymap_bit(tc);
+			keycode = tc->keymap[key];
+		}
+
+		/* Function key press up */
+		if (key == FN_KEY && !isdown) {
+			/*
+			 * dequeue the key_queue,
+			 * where keys stored while FN is pressed
+			 */
+			int j;
+			for (j = 0; j < tail; j++)	/* keys up */
+				submit_key(tc, key_queue[j],
+					   mfld_keymap_fn[key_queue[j]], 0);
+			tail = 0;
+
+			tc->keymap = mfld_keymap;
+			set_keymap_bit(tc);
+		}
+
+		if (tc->keymap == mfld_keymap_fn)
+			key_queue[tail++] = key;
+
+		submit_key(tc, key, keycode, isdown);
+	}
+}
+
+/*
+ * Bottom Half: handle the interrupt by posting key events, or dealing with
+ * errors appropriately
+ */
+static void mfld_keypad_work(struct work_struct *work)
+{
+	struct mfld_keypad_chip *tc = work_to_mfld_keypad(work);
+	u8 ints = 0;
+
+	mutex_lock(&tc->lock);
+	while ((mfld_keypad_read(tc, MFLD_KEYPAD_CMD_READ_INT, &ints, 1) == 1)
+	       && ints) {
+		if (likely(ints & INT_KEYPAD))
+			process_keys(tc);
+	}
+
+	mutex_unlock(&tc->lock);
+}
+
+/*
+ * We cannot use I2c in interrupt context, so we just schedule work.
+ */
+static irqreturn_t mfld_keypad_irq(int irq, void *data)
+{
+	struct mfld_keypad_chip *tc = data;
+	schedule_work(&tc->work);
+	return IRQ_HANDLED;
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int mfld_keypad_detect(struct i2c_client *client,
+			      struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int manufact, sw_ver;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+
+		dev_err(&client->dev, "error checking function\n");
+		return -ENODEV;
+	}
+
+	/* validate vendor and revison */
+	manufact = i2c_smbus_read_byte_data(client,
+					    MFLD_KEYPAD_CMD_MANUFACT);
+	sw_ver = i2c_smbus_read_byte_data(client,
+					  MFLD_KEYPAD_CMD_SWVERSION);
+	if (manufact != 0x03 || sw_ver != 0xC0) {
+		dev_err(&client->dev, "error checking vendor and revision\n");
+		return -ENODEV;
+	}
+
+	i2c_smbus_write_byte_data(client, MFLD_KEYPAD_CMD_RSTINTCLR, 0x01);
+
+	dev_dbg(&client->dev, "Successfully detected the i2c keypad\n");
+	strlcpy(info->type, "mfld_keypad", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int __devinit mfld_keypad_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{
+	struct input_dev *idev;
+	struct mfld_keypad_chip *tc;
+	unsigned int irq;
+	int i, err;
+	int gpio;
+
+	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
+	idev = input_allocate_device();
+	if (!tc || !idev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	i2c_set_clientdata(client, tc);
+	tc->client = client;
+	tc->idev = idev;
+	tc->keymap = mfld_keymap;
+
+	mutex_init(&tc->lock);
+	INIT_WORK(&tc->work, mfld_keypad_work);
+
+	tc->size_x = SIZE_X;
+	tc->size_y = SIZE_Y;
+	dev_vdbg(&client->dev, "Keypad size: %d x %d\n",
+		 tc->size_x, tc->size_y);
+
+	mfld_keypad_configure(tc);
+
+	tc->kp_enabled = true;
+
+	idev->name = "mfld_keypad";
+	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+	    BIT_MASK(EV_REL);
+	idev->keycode = (unsigned short *)mfld_keymap;
+	idev->keycodesize = sizeof(unsigned short);
+	idev->keycodemax = sizeof(mfld_keymap);
+
+	for (i = 0; i < KEYMAP_SIZE; i++)
+		set_bit(mfld_keymap[i], idev->keybit);
+
+	err = input_register_device(idev);
+	if (err) {
+		dev_dbg(&client->dev, "error register input device\n");
+		goto fail1;
+	}
+
+	gpio = MFLD_KEYPAD_INT_GPIO;
+	irq = gpio_to_irq(gpio);
+	if (irq < 0) {
+		dev_dbg(&client->dev, "error acquire IRQ to GPIO %d\n", gpio);
+		err = irq;
+		goto fail2;
+	}
+	client->irq = irq;
+
+	err = request_irq(irq, mfld_keypad_irq,
+			  IRQF_SHARED | IRQ_TYPE_EDGE_FALLING,
+			  "mfld_keypad", tc);
+	if (err) {
+		dev_err(&client->dev, "could not get IRQ %d\n", irq);
+		goto fail2;
+	}
+
+	return 0;
+
+fail2:
+	input_unregister_device(idev);
+	idev = NULL;
+fail1:
+	input_free_device(idev);
+	kfree(tc);
+	return err;
+}
+
+static int __devexit mfld_keypad_remove(struct i2c_client *client)
+{
+	struct mfld_keypad_chip *tc = i2c_get_clientdata(client);
+
+	free_irq(client->irq, tc);
+	cancel_work_sync(&tc->work);
+
+	input_unregister_device(tc->idev);
+
+	kfree(tc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/*
+ * The chip can switch off when there is no activity, so
+ * explicit suspend is not needed
+ */
+
+static int mfld_keypad_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct mfld_keypad_chip *tc = i2c_get_clientdata(client);
+
+	set_irq_wake(client->irq, 0);
+	disable_irq(client->irq);
+
+	mutex_lock(&tc->lock);
+	tc->pm_suspend = true;
+	mutex_unlock(&tc->lock);
+
+	return 0;
+}
+
+static int mfld_keypad_resume(struct i2c_client *client)
+{
+	struct mfld_keypad_chip *tc = i2c_get_clientdata(client);
+
+	mutex_lock(&tc->lock);
+	tc->pm_suspend = false;
+	mutex_unlock(&tc->lock);
+
+	enable_irq(client->irq);
+	set_irq_wake(client->irq, 1);
+
+	return 0;
+}
+
+#else
+#define mfld_keypad_suspend NULL
+#define mfld_keypad_resume NULL
+#endif
+
+/* Address to scan: 0x45-i2c slave addr*/
+static const unsigned short normal_i2c[] = { 0x45, I2C_CLIENT_END };
+
+static const struct i2c_device_id mfld_keypad_id[] = {
+	{"mfld_keypad", 0},
+	{}
+};
+
+static struct i2c_driver mfld_keypad_i2c_driver = {
+	.driver = {
+		   .name = "mfld_keypad",
+		   },
+	.probe = mfld_keypad_probe,
+	.remove = __devexit_p(mfld_keypad_remove),
+	.suspend = mfld_keypad_suspend,
+	.resume = mfld_keypad_resume,
+	.id_table = mfld_keypad_id,
+	.detect = mfld_keypad_detect,
+	.address_list = normal_i2c,
+};
+
+MODULE_DEVICE_TABLE(i2c, mfld_keypad_id);
+
+static int __init mfld_keypad_init(void)
+{
+	/*
+	 * TODO
+	 * Should add platform detect here before hardware reset, or if
+	 * it loaded on a non-mfld system it might do unintended things.
+	 */
+	int gpio = MFLD_KEYPAD_RST_GPIO;
+	gpio_request(gpio, "mfld_keypad");
+	/* hardware reset */
+	gpio_direction_output(gpio, 0);
+	gpio_direction_output(gpio, 1);
+	return i2c_add_driver(&mfld_keypad_i2c_driver);
+}
+
+static void __exit mfld_keypad_exit(void)
+{
+	i2c_del_driver(&mfld_keypad_i2c_driver);
+	gpio_free(MFLD_KEYPAD_RST_GPIO);
+}
+
+module_init(mfld_keypad_init);
+module_exit(mfld_keypad_exit);
+
+MODULE_AUTHOR("Zheng Ba <zheng.ba@intel.com>");
+MODULE_AUTHOR("Yang Liang");
+MODULE_DESCRIPTION("Medfield keypad driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/keyboard/mfld_keypad.h b/drivers/input/keyboard/mfld_keypad.h
new file mode 100644
index 0000000..dbbf149
--- /dev/null
+++ b/drivers/input/keyboard/mfld_keypad.h
@@ -0,0 +1,56 @@
+#ifndef __MFLD_KEYPAD_H
+#define __MFLD_KEYPAD_H
+
+#include <linux/types.h>
+#include <linux/input.h>
+
+#define KEYMAP_SIZE 49		/* 6 x 8 + right_shift */
+#define SIZE_X 6
+#define SIZE_Y 8
+
+/* two keys index in keymap */
+#define FN_KEY	33	/* function key position */
+#define RIGHT_SHIFT_KEY	48	/* right shift key position */
+
+const unsigned short mfld_keymap[KEYMAP_SIZE] = {
+	KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8,
+	KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I,
+	KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K,
+	KEY_LEFTSHIFT, KEY_Z, KEY_X,
+	KEY_C, KEY_V, KEY_B, KEY_N, KEY_M,
+	KEY_9, KEY_FN, KEY_LEFTALT, KEY_SPACE,
+	KEY_DELETE, KEY_LEFT, KEY_DOWN, KEY_RIGHT,
+	KEY_LEFTCTRL, KEY_O, KEY_L, KEY_UP,
+	KEY_0, KEY_P, KEY_BACKSPACE, KEY_ENTER, KEY_RIGHTSHIFT,
+};
+
+/* Some FN_KEYS have no direct keycode */
+#define KEY_EXCLAM		KEY_1	/* '!' -> shift+1 */
+#define KEY_AT			KEY_2	/* '@' -> shift+2 */
+#define KEY_NUMER_SIGN	KEY_3	/* '#' -> shift+3 */
+#define KEY_NOR			KEY_6	/* '^' -> shift+6 */
+#define KEY_PERCENT		KEY_5	/* '%' -> shift+5 */
+#define KEY_AMPERSAND	KEY_7	/* '&' -> shift+7 */
+
+#define KEY_BAR			KEY_BACKSLASH	/* '|' -> shift+\ */
+#define KEY_COLON		KEY_SEMICOLON	/* ':' -> shift+; */
+#define KEY_UNDERSCORE	KEY_KPMINUS	/* '_' -> shift+- */
+#define KEY_QUOTE_DBL	KEY_APOSTROPHE	/* '"' -> shift+' */
+#define KEY_QUES	KEY_SLASH	/* '/' -> shift+/ */
+
+const unsigned short mfld_keymap_fn[KEYMAP_SIZE] = {
+	KEY_GRAVE, KEY_AT, KEY_NUMER_SIGN, KEY_4,
+	KEY_PERCENT, KEY_NOR, KEY_AMPERSAND, KEY_KPASTERISK,
+	KEY_BAR, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_RESERVED, KEY_BACKSLASH, KEY_SLASH, KEY_KPPLUS,
+	KEY_TAB, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_APOSTROPHE, KEY_SEMICOLON, KEY_COLON, KEY_COMMA,
+	KEY_CAPSLOCK, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_DOT, KEY_UNDERSCORE, KEY_EXCLAM, KEY_QUES,
+	KEY_9, KEY_RESERVED, KEY_RESERVED, KEY_COMMA,
+	KEY_RESERVED, KEY_RESERVED, KEY_PAGEDOWN, KEY_RESERVED,
+	KEY_RESERVED, KEY_KPMINUS, KEY_QUOTE_DBL, KEY_PAGEUP,
+	KEY_0, KEY_EQUAL, KEY_CONFIG, KEY_RESERVED, KEY_RIGHTSHIFT,
+};
+
+#endif /* __MFLD_KEYPAD_H */

