From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] HP Jornada 7xx keyboard support
Date: Sun, 22 Jul 2007 01:29:08 -0400
Message-ID: <200707220129.08564.dtor@insightbb.com>
References: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com> <d120d5000707201336s50e6e27nbb424bb1a510d27b@mail.gmail.com> <20070721174836.d719f5c9.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070721174836.d719f5c9.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On Saturday 21 July 2007 20:48, Kristoffer Ericson wrote:
> Greetings,
> 
> You got the description text before right?.
> 
> Here's the signoff line:
> signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> 

I must say I am really pissed off. The code that you send not only was
never tested on a real hardware, it was not even compiled once. I see
a stream of missing parens, wrongly named variables, etc, etc, starting
with rev 2 of your patch and going into rev 4 (the last one).

I tried to fix all the issues I found, please make sure the code
compiles and _works_ before resubmitting. I will not be able to
apply it at the time anyway because jornada ssp pieces have not been
merged yet.

I am a bit concerned with -ETIMEOUT error code. It is not a standard error,
is it something that is going to be added to arm arch code?

-- 
Dmitry

Subject: HP Jornada 7xx keyboard support
From: Kristoffer Ericson <kristoffer.ericson@gmail.com>

Input: HP Jornada 7xx keyboard driver

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Kconfig          |    7 +
 drivers/input/keyboard/Makefile         |    1 
 drivers/input/keyboard/jornada720_kbd.c |  173 ++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

Index: work/drivers/input/keyboard/Kconfig
===================================================================
--- work.orig/drivers/input/keyboard/Kconfig
+++ work/drivers/input/keyboard/Kconfig
@@ -68,6 +68,13 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  right-hand column will be interpreted as the key shown in the
 	  left-hand column.
 
+config KEYBOARD_JORNADA720
+	 tristate "HP 720 Keyboard Driver"
+	 depends on SA1100_JORNADA720_SSP && SA1100_SSP
+	 help
+	  Say Y here to add support for the HP Jornada 7xx (710/720/728) onboard
+	  keyboard. Its generally a good idea.
+
 config KEYBOARD_SUNKBD
 	tristate "Sun Type 4 and Type 5 keyboard"
 	select SERIO
Index: work/drivers/input/keyboard/Makefile
===================================================================
--- work.orig/drivers/input/keyboard/Makefile
+++ work/drivers/input/keyboard/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-key
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
+obj-$(CONFIG_KEYBOARD_JORNADA720)	+= jornada720_kbd.o
 
Index: work/drivers/input/keyboard/jornada720_kbd.c
===================================================================
--- /dev/null
+++ work/drivers/input/keyboard/jornada720_kbd.c
@@ -0,0 +1,173 @@
+/*
+ * drivers/input/keyboard/jornada720_kbd.c
+ *
+ * HP Jornada 720 keyboard platform driver
+ *
+ * Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
+ *    Copyright (C) 2006 jornada 720 kbd driver by Filip Zyzniewsk <Filip.Zyzniewski@tefnet.plX
+ *     based on (C) 2004 jornada 720 kbd driver by Alex Lange <chicken@handhelds.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/jornada720.h>
+#include <asm/hardware.h>
+
+MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 720 keyboard driver");
+MODULE_LICENSE("GPL");
+
+static unsigned char jornada_standard_keymap[128] = {					/* ROW */
+	0, KEY_ESC, KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7,		/* #1  */
+	KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_MUTE,	/*  -> */
+	0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,		/* #2  */
+	KEY_0, KEY_MINUS, KEY_EQUAL,0, 0, 0,						/*  -> */
+	0, KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O,		/* #3  */
+	KEY_P, KEY_BACKSLASH, KEY_BACKSPACE, 0, 0, 0,					/*  -> */
+	0, KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L,		/* #4  */
+	KEY_SEMICOLON, KEY_LEFTBRACE, KEY_RIGHTBRACE, 0, 0, 0,				/*  -> */
+	0, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M, KEY_COMMA,			/* #5  */
+	KEY_DOT, KEY_KPMINUS, KEY_APOSTROPHE, KEY_ENTER, 0, 0,0,			/*  -> */
+	0, KEY_TAB, 0, KEY_LEFTSHIFT, 0, KEY_APOSTROPHE, 0, 0, 0, 0,			/* #6  */
+	KEY_UP, 0, KEY_RIGHTSHIFT, 0, 0, 0,0, 0, 0, 0, 0, KEY_LEFTALT, KEY_GRAVE,	/*  -> */
+	0, 0, KEY_LEFT, KEY_DOWN, KEY_RIGHT, 0, 0, 0, 0,0, KEY_KPASTERISK,		/*  -> */
+	KEY_LEFTCTRL, 0, KEY_SPACE, 0, 0, 0, KEY_SLASH, KEY_DELETE, 0, 0,		/*  -> */
+	0, 0, 0, KEY_POWER,								/*  -> */
+};
+
+struct jornadakbd {
+	unsigned char keymap[ARRAY_SIZE(jornada_standard_keymap)];
+	struct input_dev *input;
+};
+
+static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = jornadakbd->input;
+	int count, kbd_data, ret;
+
+	jornada_ssp_start();
+	ret = jornada_ssp_inout(GETSCANKEYCODE);
+
+	if (ret == -ETIMEOUT) {
+		printk(KERN_WARNING "jornada720_kbd: "
+			"GetKeycode command failed with ETIMEOUT\n");
+		goto out;
+	}
+
+	/* How many keycodes are waiting for us? */
+	count = jornada_ssp_inout(TXDUMMY);
+
+	/* Lets drag them out one at a time */
+	while (count-- > 0) {
+		/* Exchange TxDummy for location inside keymap */
+		kbd_data = jornada_ssp_inout(TXDUMMY);
+
+		input_report_key(input_dev,
+				 jornadakbd->keymap[kbd_data & 0x7f],
+				 !(kbd_data & 0x80));
+		input_sync(input_dev);
+	}
+ out:
+	jornada_ssp_end(); /* End Transmission */
+	return IRQ_HANDLED;
+};
+
+static int __devinit jornada720_kbd_probe(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd;
+	struct input_dev *input_dev;
+	int i, error;
+
+	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!jornadakbd || !input_dev) {
+		error = -ENOMEM;
+		goto fail1;
+	}
+
+	platform_set_drvdata(pdev, jornadakbd);
+
+	memcpy(jornadakbd->keymap, jornada_standard_keymap,
+		sizeof(jornadakbd->keymap));
+	jornadakbd->input = input_dev;
+
+	input_dev->name = "HP Jornada 720 keyboard";
+	input_dev->phys = "jornadakbd/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->keycode = jornadakbd->keymap;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(jornadakbd->keymap);
+
+	for (i = 0; i < ARRAY_SIZE(jornadakbd->keymap); i++)
+		__set_bit(jornadakbd->keymap[i], input_dev->keybit);
+
+	error = request_irq(IRQ_GPIO0, jornada720_kbd_interrupt,
+			    IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			    "jornadakbd", pdev);
+	if (error) {
+		printk(KERN_WARNING "jornadakbd : Unable to grab IRQ\n");
+		goto fail1;
+	}
+
+	error = input_register_device(jornadakbd->input);
+	if (error)
+		goto fail2;
+
+	return 0;
+
+ fail2: /* IRQ, DEVICE, MEMORY */
+	free_irq(IRQ_GPIO0, input_dev);
+ fail1: /* DEVICE, MEMORY */
+	platform_set_drvdata(pdev, NULL);
+	input_free_device(input_dev);
+	kfree(jornadakbd);
+	return error;
+}
+
+static int __devexit jornada720_kbd_remove(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+
+	free_irq(IRQ_GPIO0, pdev);
+	platform_set_drvdata(pdev, NULL);
+	input_unregister_device(jornadakbd->input);
+	kfree(jornadakbd);
+
+	return 0;
+}
+
+static struct platform_driver jornada720_kbd_driver = {
+	.driver	= {
+		.name	= "jornada720_kbd",
+	 },
+	.probe	= jornada720_kbd_probe,
+	.remove	= __devexit_p(jornada720_kbd_remove),
+};
+
+static int __init jornada720_kbd_init(void)
+{
+	return platform_driver_register(&jornada720_kbd_driver);
+}
+
+static void __exit jornada720_kbd_exit(void)
+{
+	platform_driver_unregister(&jornada720_kbd_driver);
+}
+
+module_init(jornada720_kbd_init);
+module_exit(jornada720_kbd_exit);
