From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [PATCH] HP Jornada 7xx keyboard support
Date: Fri, 20 Jul 2007 22:02:17 -0700
Message-ID: <20070720220217.b7374ec9.Kristoffer.Ericson@Gmail.com>
References: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com>
	<d120d5000707180800k5e4d6538p7df9be9e134609fc@mail.gmail.com>
	<20070718191119.18bf1e9c.Kristoffer.Ericson@Gmail.com>
	<d120d5000707201154r4c95d365u7d9dd1189fbc4a29@mail.gmail.com>
	<20070720212549.ca0e38f4.Kristoffer.Ericson@Gmail.com>
	<d120d5000707201229m45088b66wd7474ad06d16e813@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707201229m45088b66wd7474ad06d16e813@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

#try 4:

Ive changed the error handling so it only should release stuff it actually had aquired.

Best wishes
Kristoffer


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c97d5eb..4a77c87 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
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
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 28d211b..5145005 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,4 +21,4 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
-
+obj-$(CONFIG_KEYBOARD_JORNADA720)       += jornada720_kbd.o
\ No newline at end of file
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
new file mode 100644
index 0000000..f5af7f6
--- /dev/null
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -0,0 +1,167 @@
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
+static unsigned char jornada_normal_keymap[128] = {					/* ROW */
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
+	unsigned char jornada_keymap[ARRAY_SIZE(jornada_normal_keymap)];
+	struct input_dev *input;
+};
+
+static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
+{
+	int count, kbd_data, ret;
+			
+	jornada_ssp_start();
+	ret = jornada_ssp_inout(GETSCANKEYCODE);
+
+	if (ret == -ETIMEOUT) {
+		printk(KERN_WARNING "jornada720_kdb:GetKeycode command failed with ETIMEOUT, flushed bus\n");
+		jornada_ssp_end(); /* End transmission */
+		return IRQ_HANDLED;
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
+				    jornada_normal_keymap[kbb_data & 0x7f],
+				    !(kbd_data & 0x80));
+		input_sync(input_dev);
+	}
+	jornada_ssp_end(); /* End Transmission */
+	return IRQ_HANDLED;
+};
+
+static int __init jornada720_kbd_probe(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd;
+	struct input_dev *input_dev;
+	int i, ret, err;
+	
+	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	if (!jornadakbd)
+		return -ENOMEM;
+		
+	input_dev = input_allocate_device();
+	if (!input_dev) 
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, jornadakbd);
+
+	input_dev->dev.parent = &pdev.dev;
+	
+	memcpy(jornadakbd->jornada_keymap, normal_jornada_keymap, sizeof(jornadakbd->jornada_keymap);
+		
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->name = "HP Jornada 720 keyboard";
+	input_dev->phys = "jornadakbd/input0";
+	input_dev->keycode = jornadakbd->jornada_keymap;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(normal_jornada_keymap);
+
+	for (i = 0; i < ARRAY_SIZE(jornadakbd_keymap); i++)
+			set_bit(jornadakbd->jornada_keymap[i], input_dev->keybit);
+	
+	ret = request_irq(IRQ_GPIO0,
+			jornada720_kbd_interrupt,
+			IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			"jornadakbd", input_dev);
+	if (ret) {
+		printk(KERN_WARNING "jornadakbd : Unable to grab IRQ\n");
+		goto failed1;
+	}
+
+	err = input_register_device(jornadakbd->input);
+	if (err)
+		goto failed2;
+	
+	return 0;
+
+failed2: /* IRQ, DEVICE, MEMORY */
+	free_irq(IRQ_GPIO0, input_dev);
+failed1: /* DEVICE, MEMORY */
+	input_free_device(input_dev);
+	kfree(jornadakbd);
+	return err;
+};
+
+static int jornada720_kbd_remove(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+
+	free_irq(IRQ_GPIO0, input_dev);
+	input_unregister_device(input_dev);
+	kfree(jornadakbd);
+	
+	return 0;
+}
+
+static struct platform_driver jornada720_kbd_driver = {
+        .driver  = {
+	           .name    = "jornada720_kbd",
+		 },
+	.probe   = jornada720_kbd_probe,
+	.remove  = jornada720_kbd_remove,
+};
+
+static int __devinit jornada720_kbd_init(void)
+{
+        return platform_driver_register(&jornada720_kbd_driver);
+}
+
+static void __exit jornada720_kbd_exit(void)
+{
+	platform_driver_unregister(&jornada720_kbd_driver);
+}
+
+module_init(jornada720_kbd_init);
+module_exit(jornada720_kbd_exit);



On Fri, 20 Jul 2007 15:29:08 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> On 7/21/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > Greetings,
> >
> > Ive added it to free IRQ as you said, a minor change is also that jornada720.h defines are set in CAPS (just changed that for Russell).
> > Ive also added the Kconfig and Makefile.
> >
> > Btw, do you keep patchtracker (like Russell) or drag from mail (like Paul)?
> 
> Get from the mail.
> 
> > +
> > +failed:
> > +       free_irq(IRQ_GPIO0, input_dev);
> 
> Still not quire right - you may get to failed: when memory allocation
> fails or request_irq fails. We should not free IRQ that we did not
> get. Please split into 2 labels and jump accordingly.
> 
> -- 
> Dmitry


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
