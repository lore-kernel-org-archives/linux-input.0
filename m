From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5 UPDATED] [ARM] pxa: lx: add keyboard driver
Date: Wed, 22 Apr 2009 19:56:36 +0100
Message-ID: <20090422185636.GF2850@n2100.arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com> <20090420110640.GC3653@n2100.arm.linux.org.uk> <20090420111347.GD3653@n2100.arm.linux.org.uk> <20090421021644.GB13617@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40576 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZDVS4s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2009 14:56:48 -0400
Content-Disposition: inline
In-Reply-To: <20090421021644.GB13617@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

> Otherwise you may add:
> 
> 	Acked-by: Dmitry Torokhov <dtor@mail.ru>
> 
> I assume the driver will be merged with the rest of LX changes through
> your tree, is that right?

Yes.

Final version below, I'm assuming you have no further comments so added
your acked by as above.

Subject: [PATCH] [ARM] pxa: lx: add keyboard driver

This adds support for the keyboard support on the LX platform.
We aren't directly connected to the keyboard itself, but the
keyboard is managed by PCON via the system I2C bus.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>
---
 drivers/input/keyboard/Kconfig  |    9 +
 drivers/input/keyboard/Makefile |    1 +
 drivers/input/keyboard/lx-kbd.c |  347 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/lx-kbd.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ea2638b..996ff38 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -289,6 +289,15 @@ config KEYBOARD_AAED2000
 	  To compile this driver as a module, choose M here: the
 	  module will be called aaed2000_kbd.
 
+config KEYBOARD_LX
+	tristate "LX Keyboard support"
+	depends on MACH_NETBOOKPRO && INPUT
+	help
+	  Say Y here if you want to use the LX keyboard integrated in
+	  your system.
+
+	  If you have a LX platform, you should say Y.
+
 config KEYBOARD_GPIO
 	tristate "GPIO Buttons"
 	depends on GENERIC_GPIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 36351e1..c475f79 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
+obj-$(CONFIG_KEYBOARD_LX)		+= lx-kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
diff --git a/drivers/input/keyboard/lx-kbd.c b/drivers/input/keyboard/lx-kbd.c
new file mode 100644
index 0000000..98986cb
--- /dev/null
+++ b/drivers/input/keyboard/lx-kbd.c
@@ -0,0 +1,347 @@
+/*
+ * drivers/input/keyboard/lx-kbd.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ * Written by Ben Dooks
+ *
+ * http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/apm-emulation.h>
+
+#include <mach/lx-pcon.h>
+
+#define LX_NUMKEYCODES (0x80)
+
+static unsigned short normal_map[LX_NUMKEYCODES] = {
+	[0x5b]  = KEY_ESC,
+	[0x5c]  = KEY_1,
+	[0x5d]  = KEY_2,
+	[0x47]  = KEY_3,
+	[0x36]  = KEY_4,
+	[0x37]  = KEY_5,
+	[0x5e]  = KEY_6,
+	[0x2d]  = KEY_7,
+	[0x1d]  = KEY_8,
+	[0x1e]  = KEY_9,
+	[0x11]  = KEY_0,
+	[0x0f]  = KEY_MINUS,
+	[0x0d]  = KEY_BACKSPACE,  /* delete or backspace? */
+
+	[0x02]  = KEY_TAB,
+	[0x4f]  = KEY_Q,
+	[0x53]  = KEY_W,
+	[0x46]  = KEY_E,
+	[0x35]  = KEY_R,
+	[0x38]  = KEY_T,
+	[0x03]  = KEY_Y,
+	[0x2c]  = KEY_U,
+	[0x1c]  = KEY_I,
+	[0x1f]  = KEY_O,
+	[0x12]  = KEY_P,
+	[0x10]  = KEY_EQUAL,
+	[0x00]  = KEY_ENTER,
+
+	[0x3f]  = KEY_BACKSLASH,   /* ? correct */
+	[0x50]  = KEY_A,
+	[0x52]  = KEY_S,
+	[0x45]  = KEY_D,
+	[0x42]  = KEY_F,
+	[0x39]  = KEY_G,
+	[0x61]  = KEY_H,
+	[0x2b]  = KEY_J,
+	[0x1b]  = KEY_K,
+	[0x20]  = KEY_L,
+	[0x13]  = KEY_SEMICOLON,
+	[0x29]  = KEY_APOSTROPHE,
+
+	[0x07]  = KEY_LEFTSHIFT,
+	[0x51]  = KEY_Z,
+	[0x54]  = KEY_X,
+	[0x44]  = KEY_C,
+	[0x43]  = KEY_V,
+	[0x3a]  = KEY_B,
+	[0x06]  = KEY_N,
+	[0x2a]  = KEY_M,
+	[0x28]  = KEY_COMMA,
+	[0x5f]  = KEY_DOT,
+	[0x60]  = KEY_UP,
+	[0x15]  = KEY_RIGHTSHIFT,
+
+	[0x23]  = KEY_LEFTCTRL,
+	[0x41]  = KEY_LEFTALT,
+	[0x31]  = KEY_LEFTMETA,
+	[0x34]  = KEY_SPACE,
+	[0x4d]  = KEY_SLASH,
+	[0x04]  = KEY_LEFT,
+	[0x05]  = KEY_DOWN,
+	[0x01]  = KEY_RIGHT,
+};
+
+/*
+ * Numlock mappings.  This table defines only the special keys
+ * which are affected by the numlock mode.  Other keys are mapped
+ * by the above table.
+ */
+static unsigned short numlck_map[LX_NUMKEYCODES] = {
+	[0x2d]      = KEY_KP7,
+	[0x1d]      = KEY_KP8,
+	[0x1e]      = KEY_KP9,
+	[0x11]      = KEY_KPSLASH,
+
+	[0x2c]      = KEY_KP4,
+	[0x1c]      = KEY_KP5,
+	[0x1f]      = KEY_KP6,
+	[0x12]      = KEY_KPASTERISK,
+
+	[0x2b]      = KEY_KP1,
+	[0x1b]      = KEY_KP2,
+	[0x20]      = KEY_KP3,
+	[0x13]      = KEY_KPMINUS,
+
+	[0x2a]      = KEY_KP0,
+	[0x28]      = KEY_KPDOT,
+	[0x5f]      = KEY_KPPLUS,
+};
+
+/*
+ * mappings for function key - note *ONLY* keys that produce a unique
+ * keycode should be here - others should be handled in userspace as
+ * keymap modifiers , fn is the left meta modifier
+ */
+static unsigned short fn_map[LX_NUMKEYCODES] = {
+	[0x02]	= KEY_CAPSLOCK,
+	[0x41]	= KEY_UNKNOWN,
+	[0x4d]	= KEY_F1,
+	[0x04]	= KEY_HOME,
+	[0x60]	= KEY_PAGEUP,
+	[0x05]	= KEY_PAGEDOWN,
+	[0x01]	= KEY_END,
+	[0x28]	= KEY_BRIGHTNESSDOWN,
+	[0x5f]	= KEY_BRIGHTNESSUP,
+	[0x5b]	= KEY_SUSPEND,
+};
+
+/*
+ * Record the state of key presses, so that we can do the right thing
+ * after the FN key is released.
+ */
+#define KP_NONE		(0)
+#define KP_DOWN		(1 << 0)
+#define KP_FN		(1 << 1)
+#define KP_NUMLCK	(1 << 2)
+
+static unsigned char keystate[LX_NUMKEYCODES];
+
+static int num_lck;
+
+#define key_fn		(keystate[0x31] & KP_DOWN)
+#define key_shift	(keystate[0x15] & KP_DOWN)
+#define key_alt		(keystate[0x41] & KP_DOWN)
+
+static void lx_keyb_process_key(struct input_dev *kbd, unsigned int key)
+{
+	unsigned short *map = normal_map;
+	unsigned int up;
+
+	up = key & 0x80;
+	key &= 0x7f;
+
+	if (key >= LX_NUMKEYCODES)
+		return;
+
+	/*
+	 * Use the Fn map if the function key is pressed and this
+	 * is a key press, or the key is currently in "pressed Fn"
+	 * state.  We do not want to map a press without Fn and a
+	 * subsequent release of the same key with Fn to different
+	 * keycodes.
+	 *
+	 * Ditto for the numlock state.
+	 */
+	if (fn_map[key] && ((key_fn && !up) || keystate[key] & KP_FN)) {
+		keystate[key] |= KP_FN;
+		map = fn_map;
+	} else if (numlck_map[key] &&
+		   ((num_lck && !up) || keystate[key] & KP_NUMLCK)) {
+		keystate[key] |= KP_NUMLCK;
+		map = numlck_map;
+	}
+
+	/*
+	 * The KP_DOWN bit always indicates whether a key is
+	 * pressed or released.  Releases always clear all
+	 * state about the key.
+	 */
+	if (up)
+		keystate[key] = KP_NONE;
+	else
+		keystate[key] |= KP_DOWN;
+
+	/*
+	 * Now handle the special right-shift + alt combination
+	 * for numlock.
+	 */
+	if (key == 0x41 && key_shift && key_alt) /* alt key */
+		num_lck ^= 1;
+
+	/*
+	 * Map the keycode from the LX keyboard code to the input
+	 * subsystem keycode, using the appropriate mapping table.
+	 */
+	key = map[key];
+
+	/*
+	 * Some keys have additional operations after we have
+	 * decoded them.  We don't report these "special" keys
+	 * to the input layer.
+	 */
+	switch (key) {
+	case KEY_BRIGHTNESSUP:
+	case KEY_BRIGHTNESSDOWN:
+		input_event(kbd, EV_PWR, key, !up);
+		break;
+
+	case KEY_SUSPEND:
+		input_event(kbd, EV_PWR, key, !up);
+#if defined(CONFIG_APM_EMULATION) && !defined(CONFIG_INPUT_APMPOWER)
+		if (!up)
+			apm_queue_event(APM_SYS_SUSPEND);
+#endif
+		break;
+
+	default:
+		input_report_key(kbd, key, !up);
+		break;
+	}
+}
+
+static void lx_keyb_reset(struct input_dev *kbd)
+{
+	unsigned short *map;
+	int key;
+
+	for (key = 0; key < LX_NUMKEYCODES; key++)
+		if (keystate[key] & KP_DOWN) {
+			map = normal_map;
+			if (keystate[key] & KP_FN)
+				map = fn_map;
+			else if (keystate[key] & KP_NUMLCK)
+				map = numlck_map;
+			keystate[key] = KP_NONE;
+			input_report_key(kbd, map[key], 0);
+		}
+
+	num_lck = 0;
+}
+
+static void lx_keyb_write(void *data, unsigned int addr, unsigned char val)
+{
+	struct input_dev *kbd = data;
+
+	pcon_kbd_ack();
+	lx_keyb_process_key(kbd, val);
+}
+
+static struct lx_i2cslave_watcher lx_keyb_watcher = {
+	.start	= PHST_KEYBOARD_START,
+	.size	= PHST_KEYBOARD_SIZE,
+	.write	= lx_keyb_write,
+};
+
+static int lx_keyb_probe(struct platform_device *dev)
+{
+	struct input_dev *kbd;
+	int i, ret;
+
+	kbd = input_allocate_device();
+	if (!kbd)
+		return -ENOMEM;
+
+	kbd->name        = "LX Keyboard";
+	kbd->phys        = "pcon/input0";
+	kbd->dev.parent  = &dev->dev;
+	kbd->evbit[0]    = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+			   BIT_MASK(EV_PWR);
+	kbd->keycode     = normal_map;
+	kbd->keycodesize = sizeof(normal_map[0]);
+	kbd->keycodemax  = ARRAY_SIZE(normal_map);
+
+	for (i = 0; i < ARRAY_SIZE(normal_map); i++) {
+		if (normal_map[i])
+			__set_bit(normal_map[i], kbd->keybit);
+	}
+	for (i = 0; i < ARRAY_SIZE(numlck_map); i++) {
+		if (numlck_map[i])
+			__set_bit(numlck_map[i], kbd->keybit);
+	}
+	for (i = 0; i < ARRAY_SIZE(fn_map); i++) {
+		if (fn_map[i])
+			__set_bit(fn_map[i], kbd->keybit);
+	}
+
+	ret = input_register_device(kbd);
+	if (ret == 0) {
+		platform_set_drvdata(dev, kbd);
+		lx_i2cslave_addwatcher(&lx_keyb_watcher, kbd);
+	} else {
+		input_free_device(kbd);
+	}
+	return ret;
+}
+
+static int __devexit lx_keyb_remove(struct platform_device *dev)
+{
+	struct input_dev *kbd = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+	lx_i2cslave_delwatcher(&lx_keyb_watcher, kbd);
+	input_unregister_device(kbd);
+	return 0;
+}
+
+static int lx_keyb_resume(struct platform_device *dev)
+{
+	struct input_dev *kbd = platform_get_drvdata(dev);
+
+	lx_keyb_reset(kbd);
+	return 0;
+}
+
+static struct platform_driver lx_kbd = {
+	.driver = {
+		.name	= "lx-kbd",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= lx_keyb_probe,
+	.remove	= __devexit_p(lx_keyb_remove),
+	.resume	= lx_keyb_resume,
+};
+
+static int __init lx_keyb_init(void)
+{
+	return platform_driver_register(&lx_kbd);
+}
+
+static void __exit lx_keyb_exit(void)
+{
+	platform_driver_unregister(&lx_kbd);
+}
+
+module_init(lx_keyb_init);
+module_exit(lx_keyb_exit);
+
+MODULE_AUTHOR("Ben Dooks, Simtec Electronics <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LX Keyboard Driver");
-- 
1.6.0.6

