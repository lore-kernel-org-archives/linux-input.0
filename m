From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Sat, 25 Aug 2007 20:57:13 -0700
Message-ID: <20070825205713.0c960e1e.Kristoffer.Ericson@Gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	<200707220145.10563.dtor@insightbb.com>
	<20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
	<d120d5000707300539haa26ae8sdfee043ae9e64688@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__25_Aug_2007_20_57_13_-0700_3S63o3mX5mTQR9b2"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707300539haa26ae8sdfee043ae9e64688@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__25_Aug_2007_20_57_13_-0700_3S63o3mX5mTQR9b2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey Dmitry,

Here's the new driver for HP Jornada onboard keyboard (HP6XX). It compiles cleanly and works perfectly. It uses the polldev that you
suggested.

On Mon, 30 Jul 2007 08:39:20 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Hi Kristoffer,
> 
> On 7/27/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > Dmitry,
> >
> > Ive merged scan_keyb and started to minimize it for just one keyboard, just want to hear from you if this is an acceptable approach.
> > Its a work in progress, just want to know if im on the right path.
> >
> 
> Like I said, please look at input-polldev
> (drivers/input/input-polldev.c). It takes care of setting up workqueue
> used for polling and will only poll if there are users so the driver
> only needs to provide miplementation of scan function. Take a look at
> drivers/input/keyboard/aaed2000_kbd.c to see how it is used.
> 
> -- 
> Dmitry

diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
new file mode 100644
index 0000000..2575d88
--- /dev/null
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -0,0 +1,276 @@
+/*
+ * drivers/input/keyboard/jornada680_kbd.c
+ *
+ * HP Jornada 620/660/680/690 scan keyboard platform driver
+ *  Copyright (C) 2007  Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
+ *
+ * Based on hp680_keyb.c
+ *  Copyright (C) 2006 Paul Mundt
+ *  Copyright (C) 2005 Andriy Skulysh
+ * Splited from drivers/input/keyboard/hp600_keyb.c
+ *  Copyright (C) 2000 Yaegashi Takeshi (hp6xx kbd scan routine and translation table)
+ *  Copyright (C) 2000 Niibe Yutaka (HP620 Keyb translation table)
+ *
+ * This program is free software; you can redistribute it and/or modify it 
+ * under the terms of the GNU General Public License version 2 as 
+ * published by the Free Software Foundation.
+ * 
+ */
+
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input-polldev.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#define SCANHZ (HZ/20)
+
+#define PCCR 0xa4000104
+#define PDCR 0xa4000106
+#define PECR 0xa4000108
+#define PFCR 0xa400010a
+#define PCDR 0xa4000124
+#define PDDR 0xa4000126
+#define PEDR 0xa4000128
+#define PFDR 0xa400012a
+#define PGDR 0xa400012c
+#define PHDR 0xa400012e
+#define PJDR 0xa4000130
+#define PKDR 0xa4000132
+#define PLDR 0xa4000134
+
+static unsigned char jornada_scancodes[] = {
+/* PTD1 */	KEY_CAPSLOCK, KEY_MACRO, KEY_LEFTCTRL, 0, KEY_ESC, 0, 0, 0,	/*  1  -> 8   */
+		KEY_F1, KEY_F2, KEY_F3, KEY_F8, KEY_F7, KEY_F2, KEY_F4, KEY_F5,	/*  9  -> 16  */
+/* PTD5 */	KEY_SLASH, KEY_APOSTROPHE, KEY_ENTER, 0, KEY_Z, 0, 0, 0,	/*  17 -> 24  */
+		KEY_X, KEY_C, KEY_V, KEY_DOT, KEY_COMMA, KEY_M, KEY_B, KEY_N,	/*  25 -> 32  */
+/* PTD7 */	KEY_KP2, KEY_KP6, 0, 0, 0, 0, 0, 0,				/*  33 -> 40  */
+		0, 0, 0, KEY_KP4, 0, 0, KEY_LEFTALT, KEY_HANJA,			/*  41 -> 48  */
+/* PTE0 */	0, 0, 0, 0, KEY_FINANCE, 0, 0, 0,				/*  49 -> 56  */
+		KEY_LEFTCTRL, 0, KEY_SPACE, KEY_KPDOT, KEY_VOLUMEUP, 249, 0, 0, /*  57 -> 64  */
+/* PTE1 */	KEY_SEMICOLON, KEY_RIGHTBRACE, KEY_BACKSLASH, 0, KEY_A, 0, 0, 0,/*  65 -> 72  */
+		KEY_S, KEY_D, KEY_F, KEY_L, KEY_K, KEY_J, KEY_G, KEY_H,		/*  73 -> 80  */
+/* PTE3 */	KEY_KP8, KEY_LEFTMETA, KEY_RIGHTSHIFT, 0, KEY_TAB, 0, 0,0,	/*  81 -> 88  */
+		0, KEY_LEFTSHIFT, 0, 0, 0, 0, 0, 0,				/*  89 -> 96  */
+/* PTE6 */	KEY_P, KEY_LEFTBRACE, KEY_BACKSPACE, 0, KEY_Q, 0, 0, 0,		/*  97 -> 104 */
+		KEY_W, KEY_E, KEY_R, KEY_O, KEY_I, KEY_U, KEY_T, KEY_R,		/* 105 -> 112 */
+/* PTE7 */	KEY_0, KEY_MINUS, KEY_EQUAL, 0, KEY_1, 0, 0, 0,			/* 113 -> 120 */
+		KEY_2, KEY_3, KEY_4, KEY_9, KEY_8, KEY_7, KEY_5, KEY_6,		/* 121 -> 128 */
+/* **** */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0
+};
+
+struct jornadakbd {
+	unsigned char jornada_keymap[ARRAY_SIZE(jornada_scancodes)];
+	struct input_polled_dev *poll_dev;
+	unsigned char length;
+	unsigned char s0[18], s1[18];
+};
+
+unsigned int scan_jiffies;
+
+void jornada_check_kbd(struct jornadakbd *jornadakbd, unsigned char *new, unsigned char *old)
+{
+	unsigned char *table = jornadakbd->jornada_keymap;
+	unsigned char length = jornadakbd->length;
+	unsigned int bit, xor;
+	unsigned int sync_me = 0;
+
+	while (length-- > 0) {
+		if ((xor = *new ^ *old) == 0)
+			table += 8;
+		else {
+			for (bit = 0x01; bit < 0x100;bit <<= 1) {
+				if (xor & bit) {
+					input_report_key(jornadakbd->poll_dev->input, *table, !(*new & bit));
+					sync_me = 1;
+				}
+
+				table++;
+			}
+		}
+
+		new++;
+		old++;
+	}
+	if (sync_me)
+	    input_sync(jornadakbd->poll_dev->input);
+
+}
+
+int jornada_scan_keyb(unsigned char *s)
+{
+	int i;
+	unsigned short ec_static, dc_static; /* = UINT16_t */
+	unsigned char matrix_switch[] = {
+		0xfd, 0xff,   /* PTD1 PD(1) */
+		0xdf, 0xff,   /* PTD5 PD(5) */
+		0x7f, 0xff,   /* PTD7 PD(7) */
+		0xff, 0xfe,   /* PTE0 PE(0) */
+		0xff, 0xfd,   /* PTE1 PE(1) */
+		0xff, 0xf7,   /* PTE3 PE(3) */
+		0xff, 0xbf,   /* PTE6 PE(6) */
+		0xff, 0x7f,   /* PTE7 PE(7) */
+	}, *t = matrix_switch;
+	/* PD(x) :
+	1.   0xcc0c & (1~(1 << (2*(x)+1)))))
+	2.   (0xf0cf & 0xfffff) */
+	/* PE(x) :
+	1.   0xcc0c & 0xffff
+	2.   0xf0cf & (1~(1 << (2*(x)+1))))) */
+	unsigned short matrix_PDE[] = {
+		0xcc04, 0xf0cf,  /* PD(1) */
+		0xc40c, 0xf0cf,	 /* PD(5) */
+		0x4c0c, 0xf0cf,  /* PD(7) */
+		0xcc0c, 0xf0cd,  /* PE(0) */
+		0xcc0c, 0xf0c7,	 /* PE(1) */
+		0xcc0c, 0xf04f,  /* PE(3) */
+		0xcc0c, 0xd0cf,	 /* PE(6) */
+		0xcc0c, 0x70cf,	 /* PE(7) */
+	}, *y = matrix_PDE;
+	/* Save these control reg bits */
+	dc_static = (ctrl_inw(PDCR) & (~0xcc0c));
+	ec_static = (ctrl_inw(PECR) & (~0xf0cf));
+
+	for (i = 0; i < 8; i++) {
+		/* disable output for all but the one we want to scan */
+		ctrl_outw((dc_static | *y++), PDCR);
+		ctrl_outw((ec_static | *y++), PECR);
+		udelay(5);
+
+		/* Get scanline row */
+		ctrl_outb(*t++, PDDR);
+		ctrl_outb(*t++, PEDR);
+		udelay(50);
+
+		/* Read data */
+		*s++ = ctrl_inb(PCDR);
+		*s++ = ctrl_inb(PFDR);
+	}
+	/* Scan no lines */
+	ctrl_outb(0xff, PDDR);
+	ctrl_outb(0xff, PEDR);
+
+	/* Enable all scanlines */
+	ctrl_outw((dc_static | (0x5555 & 0xcc0c)),PDCR);
+	ctrl_outw((ec_static | (0x5555 & 0xf0cf)),PECR);
+	/* Ignore extra keys and events */
+	*s++ = ctrl_inb(PGDR);
+	*s++ = ctrl_inb(PHDR);
+
+	return 0;
+}
+
+static void jornadakbd680_poll(struct input_polled_dev *dev)
+{
+    struct jornadakbd *jornadakbd = dev->private;
+    scan_jiffies++;
+
+	if (scan_jiffies & 1) {
+		if (!jornada_scan_keyb(jornadakbd->s0))
+			jornada_check_kbd(jornadakbd, jornadakbd->s0, jornadakbd->s1);
+		else
+			memcpy(jornadakbd->s0, jornadakbd->s1, jornadakbd->length);
+	} else {
+		if (!jornada_scan_keyb(jornadakbd->s1))
+			jornada_check_kbd(jornadakbd, jornadakbd->s1, jornadakbd->s0);
+		else
+			memcpy(jornadakbd->s1, jornadakbd->s0, jornadakbd->length);
+		}
+}
+
+static int __init jornada680kbd_probe(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input_dev;
+	int i, error;
+
+	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	if (!jornadakbd)
+		return -ENOMEM;
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev)
+		goto failed;
+
+	platform_set_drvdata(pdev, jornadakbd);
+
+	jornadakbd->poll_dev = poll_dev;
+	jornadakbd->length   = 18;
+
+	memcpy(jornadakbd->jornada_keymap, jornada_scancodes, sizeof(jornadakbd->jornada_keymap));
+
+	poll_dev->private = jornadakbd;
+	poll_dev->poll = jornadakbd680_poll;
+	poll_dev->poll_interval = (HZ/20);
+
+	input_dev = poll_dev->input;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->name = "HP Jornada 680 keyboard";
+	input_dev->phys = "jornadakbd/input0";
+	input_dev->keycode = jornadakbd->jornada_keymap;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(jornada_scancodes);
+	input_dev->dev.parent = &pdev->dev;
+
+	for (i = 0; i < 128; i++)
+		if (jornadakbd->jornada_keymap[i])
+		    set_bit(jornadakbd->jornada_keymap[i], jornadakbd->poll_dev->input->keybit);
+
+	clear_bit(0, jornadakbd->poll_dev->input->keybit);
+
+	error = input_register_polled_device(jornadakbd->poll_dev);
+	if (error)
+	    goto failed;
+
+	printk(KERN_INFO "We have successfully registerd the keyboard driver\n");
+	return 0;
+
+failed:
+	printk(KERN_INFO "Jornadakbd: failed to register driver, bailing\n");
+	kfree(jornadakbd);
+	return -ENOMEM;
+
+}
+
+static int jornada680kbd_remove(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+
+	input_unregister_polled_device(jornadakbd->poll_dev);
+	input_free_polled_device(jornadakbd->poll_dev);
+	kfree(jornadakbd);
+	return 0;
+}
+
+static struct platform_driver jornada680kbd_driver = {
+	.driver	= {
+		    .name = "jornada680_kbd",
+		},
+	.probe = jornada680kbd_probe,
+	.remove = jornada680kbd_remove,
+};
+
+static int __devinit jornada680kbd_init(void)
+{
+	return platform_driver_register(&jornada680kbd_driver);
+}
+
+static void __exit jornada680kbd_exit(void)
+{
+	platform_driver_unregister(&jornada680kbd_driver);
+}
+
+module_init(jornada680kbd_init);
+module_exit(jornada680kbd_exit);
+
+MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 620/660/680/690 Keyboard Driver");
+MODULE_LICENSE("GPLv2");
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 28d211b..7ecd2b0 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
+obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c97d5eb..99fa19b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -208,6 +208,14 @@ config KEYBOARD_HIL
 	  This driver implements support for HIL-keyboards attached
 	  to your machine, so normally you should say Y here.
 
+config KEYBOARD_HP6XX
+       tristate "HP Jornada 6XX Keyboard support"
+       depends on SH_HP6XX
+       select INPUT_POLLDEV
+       help
+    	   This adds support for the onboard keyboard found on
+	   HP Jornada 620/660/680/690.
+
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
 	depends on (ARCH_OMAP1 || ARCH_OMAP2)

-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>

--Multipart=_Sat__25_Aug_2007_20_57_13_-0700_3S63o3mX5mTQR9b2
Content-Type: application/octet-stream;
 name="hp6xx-keyboard.patch"
Content-Disposition: attachment;
 filename="hp6xx-keyboard.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvam9ybmFkYTY4MF9rYmQuYyBiL2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvam9ybmFkYTY4MF9rYmQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwLi4yNTc1ZDg4Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9pbnB1
dC9rZXlib2FyZC9qb3JuYWRhNjgwX2tiZC5jCkBAIC0wLDAgKzEsMjc2IEBACisvKgorICogZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9qb3JuYWRhNjgwX2tiZC5jCisgKgorICogSFAgSm9ybmFkYSA2
MjAvNjYwLzY4MC82OTAgc2NhbiBrZXlib2FyZCBwbGF0Zm9ybSBkcml2ZXIKKyAqICBDb3B5cmln
aHQgKEMpIDIwMDcgIEtyaXN0b2ZmZXIgRXJpY3NvbiA8S3Jpc3RvZmZlci5Fcmljc29uQGdtYWls
LmNvbT4KKyAqCisgKiBCYXNlZCBvbiBocDY4MF9rZXliLmMKKyAqICBDb3B5cmlnaHQgKEMpIDIw
MDYgUGF1bCBNdW5kdAorICogIENvcHlyaWdodCAoQykgMjAwNSBBbmRyaXkgU2t1bHlzaAorICog
U3BsaXRlZCBmcm9tIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvaHA2MDBfa2V5Yi5jCisgKiAgQ29w
eXJpZ2h0IChDKSAyMDAwIFlhZWdhc2hpIFRha2VzaGkgKGhwNnh4IGtiZCBzY2FuIHJvdXRpbmUg
YW5kIHRyYW5zbGF0aW9uIHRhYmxlKQorICogIENvcHlyaWdodCAoQykgMjAwMCBOaWliZSBZdXRh
a2EgKEhQNjIwIEtleWIgdHJhbnNsYXRpb24gdGFibGUpCisgKgorICogVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQg
CisgKiB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZl
cnNpb24gMiBhcyAKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
LgorICogCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW5p
dC5oPgorI2luY2x1ZGUgPGxpbnV4L2lucHV0LXBvbGxkZXYuaD4KKyNpbmNsdWRlIDxsaW51eC9q
aWZmaWVzLmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8
bGludXgvaW50ZXJydXB0Lmg+CisKKyNpbmNsdWRlIDxhc20vZGVsYXkuaD4KKyNpbmNsdWRlIDxh
c20vaW8uaD4KKworI2RlZmluZSBTQ0FOSFogKEhaLzIwKQorCisjZGVmaW5lIFBDQ1IgMHhhNDAw
MDEwNAorI2RlZmluZSBQRENSIDB4YTQwMDAxMDYKKyNkZWZpbmUgUEVDUiAweGE0MDAwMTA4Cisj
ZGVmaW5lIFBGQ1IgMHhhNDAwMDEwYQorI2RlZmluZSBQQ0RSIDB4YTQwMDAxMjQKKyNkZWZpbmUg
UEREUiAweGE0MDAwMTI2CisjZGVmaW5lIFBFRFIgMHhhNDAwMDEyOAorI2RlZmluZSBQRkRSIDB4
YTQwMDAxMmEKKyNkZWZpbmUgUEdEUiAweGE0MDAwMTJjCisjZGVmaW5lIFBIRFIgMHhhNDAwMDEy
ZQorI2RlZmluZSBQSkRSIDB4YTQwMDAxMzAKKyNkZWZpbmUgUEtEUiAweGE0MDAwMTMyCisjZGVm
aW5lIFBMRFIgMHhhNDAwMDEzNAorCitzdGF0aWMgdW5zaWduZWQgY2hhciBqb3JuYWRhX3NjYW5j
b2Rlc1tdID0geworLyogUFREMSAqLwlLRVlfQ0FQU0xPQ0ssIEtFWV9NQUNSTywgS0VZX0xFRlRD
VFJMLCAwLCBLRVlfRVNDLCAwLCAwLCAwLAkvKiAgMSAgLT4gOCAgICovCisJCUtFWV9GMSwgS0VZ
X0YyLCBLRVlfRjMsIEtFWV9GOCwgS0VZX0Y3LCBLRVlfRjIsIEtFWV9GNCwgS0VZX0Y1LAkvKiAg
OSAgLT4gMTYgICovCisvKiBQVEQ1ICovCUtFWV9TTEFTSCwgS0VZX0FQT1NUUk9QSEUsIEtFWV9F
TlRFUiwgMCwgS0VZX1osIDAsIDAsIDAsCS8qICAxNyAtPiAyNCAgKi8KKwkJS0VZX1gsIEtFWV9D
LCBLRVlfViwgS0VZX0RPVCwgS0VZX0NPTU1BLCBLRVlfTSwgS0VZX0IsIEtFWV9OLAkvKiAgMjUg
LT4gMzIgICovCisvKiBQVEQ3ICovCUtFWV9LUDIsIEtFWV9LUDYsIDAsIDAsIDAsIDAsIDAsIDAs
CQkJCS8qICAzMyAtPiA0MCAgKi8KKwkJMCwgMCwgMCwgS0VZX0tQNCwgMCwgMCwgS0VZX0xFRlRB
TFQsIEtFWV9IQU5KQSwJCQkvKiAgNDEgLT4gNDggICovCisvKiBQVEUwICovCTAsIDAsIDAsIDAs
IEtFWV9GSU5BTkNFLCAwLCAwLCAwLAkJCQkvKiAgNDkgLT4gNTYgICovCisJCUtFWV9MRUZUQ1RS
TCwgMCwgS0VZX1NQQUNFLCBLRVlfS1BET1QsIEtFWV9WT0xVTUVVUCwgMjQ5LCAwLCAwLCAvKiAg
NTcgLT4gNjQgICovCisvKiBQVEUxICovCUtFWV9TRU1JQ09MT04sIEtFWV9SSUdIVEJSQUNFLCBL
RVlfQkFDS1NMQVNILCAwLCBLRVlfQSwgMCwgMCwgMCwvKiAgNjUgLT4gNzIgICovCisJCUtFWV9T
LCBLRVlfRCwgS0VZX0YsIEtFWV9MLCBLRVlfSywgS0VZX0osIEtFWV9HLCBLRVlfSCwJCS8qICA3
MyAtPiA4MCAgKi8KKy8qIFBURTMgKi8JS0VZX0tQOCwgS0VZX0xFRlRNRVRBLCBLRVlfUklHSFRT
SElGVCwgMCwgS0VZX1RBQiwgMCwgMCwwLAkvKiAgODEgLT4gODggICovCisJCTAsIEtFWV9MRUZU
U0hJRlQsIDAsIDAsIDAsIDAsIDAsIDAsCQkJCS8qICA4OSAtPiA5NiAgKi8KKy8qIFBURTYgKi8J
S0VZX1AsIEtFWV9MRUZUQlJBQ0UsIEtFWV9CQUNLU1BBQ0UsIDAsIEtFWV9RLCAwLCAwLCAwLAkJ
LyogIDk3IC0+IDEwNCAqLworCQlLRVlfVywgS0VZX0UsIEtFWV9SLCBLRVlfTywgS0VZX0ksIEtF
WV9VLCBLRVlfVCwgS0VZX1IsCQkvKiAxMDUgLT4gMTEyICovCisvKiBQVEU3ICovCUtFWV8wLCBL
RVlfTUlOVVMsIEtFWV9FUVVBTCwgMCwgS0VZXzEsIDAsIDAsIDAsCQkJLyogMTEzIC0+IDEyMCAq
LworCQlLRVlfMiwgS0VZXzMsIEtFWV80LCBLRVlfOSwgS0VZXzgsIEtFWV83LCBLRVlfNSwgS0VZ
XzYsCQkvKiAxMjEgLT4gMTI4ICovCisvKiAqKioqICovCTAsIDAsIDAsIDAsIDAsIDAsIDAsIDAs
IDAsIDAsCisJCTAsIDAsIDAsIDAsIDAKK307CisKK3N0cnVjdCBqb3JuYWRha2JkIHsKKwl1bnNp
Z25lZCBjaGFyIGpvcm5hZGFfa2V5bWFwW0FSUkFZX1NJWkUoam9ybmFkYV9zY2FuY29kZXMpXTsK
KwlzdHJ1Y3QgaW5wdXRfcG9sbGVkX2RldiAqcG9sbF9kZXY7CisJdW5zaWduZWQgY2hhciBsZW5n
dGg7CisJdW5zaWduZWQgY2hhciBzMFsxOF0sIHMxWzE4XTsKK307CisKK3Vuc2lnbmVkIGludCBz
Y2FuX2ppZmZpZXM7CisKK3ZvaWQgam9ybmFkYV9jaGVja19rYmQoc3RydWN0IGpvcm5hZGFrYmQg
Kmpvcm5hZGFrYmQsIHVuc2lnbmVkIGNoYXIgKm5ldywgdW5zaWduZWQgY2hhciAqb2xkKQorewor
CXVuc2lnbmVkIGNoYXIgKnRhYmxlID0gam9ybmFkYWtiZC0+am9ybmFkYV9rZXltYXA7CisJdW5z
aWduZWQgY2hhciBsZW5ndGggPSBqb3JuYWRha2JkLT5sZW5ndGg7CisJdW5zaWduZWQgaW50IGJp
dCwgeG9yOworCXVuc2lnbmVkIGludCBzeW5jX21lID0gMDsKKworCXdoaWxlIChsZW5ndGgtLSA+
IDApIHsKKwkJaWYgKCh4b3IgPSAqbmV3IF4gKm9sZCkgPT0gMCkKKwkJCXRhYmxlICs9IDg7CisJ
CWVsc2UgeworCQkJZm9yIChiaXQgPSAweDAxOyBiaXQgPCAweDEwMDtiaXQgPDw9IDEpIHsKKwkJ
CQlpZiAoeG9yICYgYml0KSB7CisJCQkJCWlucHV0X3JlcG9ydF9rZXkoam9ybmFkYWtiZC0+cG9s
bF9kZXYtPmlucHV0LCAqdGFibGUsICEoKm5ldyAmIGJpdCkpOworCQkJCQlzeW5jX21lID0gMTsK
KwkJCQl9CisKKwkJCQl0YWJsZSsrOworCQkJfQorCQl9CisKKwkJbmV3Kys7CisJCW9sZCsrOwor
CX0KKwlpZiAoc3luY19tZSkKKwkgICAgaW5wdXRfc3luYyhqb3JuYWRha2JkLT5wb2xsX2Rldi0+
aW5wdXQpOworCit9CisKK2ludCBqb3JuYWRhX3NjYW5fa2V5Yih1bnNpZ25lZCBjaGFyICpzKQor
eworCWludCBpOworCXVuc2lnbmVkIHNob3J0IGVjX3N0YXRpYywgZGNfc3RhdGljOyAvKiA9IFVJ
TlQxNl90ICovCisJdW5zaWduZWQgY2hhciBtYXRyaXhfc3dpdGNoW10gPSB7CisJCTB4ZmQsIDB4
ZmYsICAgLyogUFREMSBQRCgxKSAqLworCQkweGRmLCAweGZmLCAgIC8qIFBURDUgUEQoNSkgKi8K
KwkJMHg3ZiwgMHhmZiwgICAvKiBQVEQ3IFBEKDcpICovCisJCTB4ZmYsIDB4ZmUsICAgLyogUFRF
MCBQRSgwKSAqLworCQkweGZmLCAweGZkLCAgIC8qIFBURTEgUEUoMSkgKi8KKwkJMHhmZiwgMHhm
NywgICAvKiBQVEUzIFBFKDMpICovCisJCTB4ZmYsIDB4YmYsICAgLyogUFRFNiBQRSg2KSAqLwor
CQkweGZmLCAweDdmLCAgIC8qIFBURTcgUEUoNykgKi8KKwl9LCAqdCA9IG1hdHJpeF9zd2l0Y2g7
CisJLyogUEQoeCkgOgorCTEuICAgMHhjYzBjICYgKDF+KDEgPDwgKDIqKHgpKzEpKSkpKQorCTIu
ICAgKDB4ZjBjZiAmIDB4ZmZmZmYpICovCisJLyogUEUoeCkgOgorCTEuICAgMHhjYzBjICYgMHhm
ZmZmCisJMi4gICAweGYwY2YgJiAoMX4oMSA8PCAoMiooeCkrMSkpKSkpICovCisJdW5zaWduZWQg
c2hvcnQgbWF0cml4X1BERVtdID0geworCQkweGNjMDQsIDB4ZjBjZiwgIC8qIFBEKDEpICovCisJ
CTB4YzQwYywgMHhmMGNmLAkgLyogUEQoNSkgKi8KKwkJMHg0YzBjLCAweGYwY2YsICAvKiBQRCg3
KSAqLworCQkweGNjMGMsIDB4ZjBjZCwgIC8qIFBFKDApICovCisJCTB4Y2MwYywgMHhmMGM3LAkg
LyogUEUoMSkgKi8KKwkJMHhjYzBjLCAweGYwNGYsICAvKiBQRSgzKSAqLworCQkweGNjMGMsIDB4
ZDBjZiwJIC8qIFBFKDYpICovCisJCTB4Y2MwYywgMHg3MGNmLAkgLyogUEUoNykgKi8KKwl9LCAq
eSA9IG1hdHJpeF9QREU7CisJLyogU2F2ZSB0aGVzZSBjb250cm9sIHJlZyBiaXRzICovCisJZGNf
c3RhdGljID0gKGN0cmxfaW53KFBEQ1IpICYgKH4weGNjMGMpKTsKKwllY19zdGF0aWMgPSAoY3Ry
bF9pbncoUEVDUikgJiAofjB4ZjBjZikpOworCisJZm9yIChpID0gMDsgaSA8IDg7IGkrKykgewor
CQkvKiBkaXNhYmxlIG91dHB1dCBmb3IgYWxsIGJ1dCB0aGUgb25lIHdlIHdhbnQgdG8gc2NhbiAq
LworCQljdHJsX291dHcoKGRjX3N0YXRpYyB8ICp5KyspLCBQRENSKTsKKwkJY3RybF9vdXR3KChl
Y19zdGF0aWMgfCAqeSsrKSwgUEVDUik7CisJCXVkZWxheSg1KTsKKworCQkvKiBHZXQgc2Nhbmxp
bmUgcm93ICovCisJCWN0cmxfb3V0YigqdCsrLCBQRERSKTsKKwkJY3RybF9vdXRiKCp0KyssIFBF
RFIpOworCQl1ZGVsYXkoNTApOworCisJCS8qIFJlYWQgZGF0YSAqLworCQkqcysrID0gY3RybF9p
bmIoUENEUik7CisJCSpzKysgPSBjdHJsX2luYihQRkRSKTsKKwl9CisJLyogU2NhbiBubyBsaW5l
cyAqLworCWN0cmxfb3V0YigweGZmLCBQRERSKTsKKwljdHJsX291dGIoMHhmZiwgUEVEUik7CisK
KwkvKiBFbmFibGUgYWxsIHNjYW5saW5lcyAqLworCWN0cmxfb3V0dygoZGNfc3RhdGljIHwgKDB4
NTU1NSAmIDB4Y2MwYykpLFBEQ1IpOworCWN0cmxfb3V0dygoZWNfc3RhdGljIHwgKDB4NTU1NSAm
IDB4ZjBjZikpLFBFQ1IpOworCS8qIElnbm9yZSBleHRyYSBrZXlzIGFuZCBldmVudHMgKi8KKwkq
cysrID0gY3RybF9pbmIoUEdEUik7CisJKnMrKyA9IGN0cmxfaW5iKFBIRFIpOworCisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyB2b2lkIGpvcm5hZGFrYmQ2ODBfcG9sbChzdHJ1Y3QgaW5wdXRfcG9s
bGVkX2RldiAqZGV2KQoreworICAgIHN0cnVjdCBqb3JuYWRha2JkICpqb3JuYWRha2JkID0gZGV2
LT5wcml2YXRlOworICAgIHNjYW5famlmZmllcysrOworCisJaWYgKHNjYW5famlmZmllcyAmIDEp
IHsKKwkJaWYgKCFqb3JuYWRhX3NjYW5fa2V5Yihqb3JuYWRha2JkLT5zMCkpCisJCQlqb3JuYWRh
X2NoZWNrX2tiZChqb3JuYWRha2JkLCBqb3JuYWRha2JkLT5zMCwgam9ybmFkYWtiZC0+czEpOwor
CQllbHNlCisJCQltZW1jcHkoam9ybmFkYWtiZC0+czAsIGpvcm5hZGFrYmQtPnMxLCBqb3JuYWRh
a2JkLT5sZW5ndGgpOworCX0gZWxzZSB7CisJCWlmICgham9ybmFkYV9zY2FuX2tleWIoam9ybmFk
YWtiZC0+czEpKQorCQkJam9ybmFkYV9jaGVja19rYmQoam9ybmFkYWtiZCwgam9ybmFkYWtiZC0+
czEsIGpvcm5hZGFrYmQtPnMwKTsKKwkJZWxzZQorCQkJbWVtY3B5KGpvcm5hZGFrYmQtPnMxLCBq
b3JuYWRha2JkLT5zMCwgam9ybmFkYWtiZC0+bGVuZ3RoKTsKKwkJfQorfQorCitzdGF0aWMgaW50
IF9faW5pdCBqb3JuYWRhNjgwa2JkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cit7CisJc3RydWN0IGpvcm5hZGFrYmQgKmpvcm5hZGFrYmQ7CisJc3RydWN0IGlucHV0X3BvbGxl
ZF9kZXYgKnBvbGxfZGV2OworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldjsKKwlpbnQgaSwg
ZXJyb3I7CisKKwlqb3JuYWRha2JkID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGpvcm5hZGFrYmQp
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIWpvcm5hZGFrYmQpCisJCXJldHVybiAtRU5PTUVNOworCisJ
cG9sbF9kZXYgPSBpbnB1dF9hbGxvY2F0ZV9wb2xsZWRfZGV2aWNlKCk7CisJaWYgKCFwb2xsX2Rl
dikKKwkJZ290byBmYWlsZWQ7CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBqb3JuYWRh
a2JkKTsKKworCWpvcm5hZGFrYmQtPnBvbGxfZGV2ID0gcG9sbF9kZXY7CisJam9ybmFkYWtiZC0+
bGVuZ3RoICAgPSAxODsKKworCW1lbWNweShqb3JuYWRha2JkLT5qb3JuYWRhX2tleW1hcCwgam9y
bmFkYV9zY2FuY29kZXMsIHNpemVvZihqb3JuYWRha2JkLT5qb3JuYWRhX2tleW1hcCkpOworCisJ
cG9sbF9kZXYtPnByaXZhdGUgPSBqb3JuYWRha2JkOworCXBvbGxfZGV2LT5wb2xsID0gam9ybmFk
YWtiZDY4MF9wb2xsOworCXBvbGxfZGV2LT5wb2xsX2ludGVydmFsID0gKEhaLzIwKTsKKworCWlu
cHV0X2RldiA9IHBvbGxfZGV2LT5pbnB1dDsKKwlpbnB1dF9kZXYtPmV2Yml0WzBdID0gQklUKEVW
X0tFWSkgfCBCSVQoRVZfUkVQKTsKKwlpbnB1dF9kZXYtPm5hbWUgPSAiSFAgSm9ybmFkYSA2ODAg
a2V5Ym9hcmQiOworCWlucHV0X2Rldi0+cGh5cyA9ICJqb3JuYWRha2JkL2lucHV0MCI7CisJaW5w
dXRfZGV2LT5rZXljb2RlID0gam9ybmFkYWtiZC0+am9ybmFkYV9rZXltYXA7CisJaW5wdXRfZGV2
LT5rZXljb2Rlc2l6ZSA9IHNpemVvZih1bnNpZ25lZCBjaGFyKTsKKwlpbnB1dF9kZXYtPmtleWNv
ZGVtYXggPSBBUlJBWV9TSVpFKGpvcm5hZGFfc2NhbmNvZGVzKTsKKwlpbnB1dF9kZXYtPmRldi5w
YXJlbnQgPSAmcGRldi0+ZGV2OworCisJZm9yIChpID0gMDsgaSA8IDEyODsgaSsrKQorCQlpZiAo
am9ybmFkYWtiZC0+am9ybmFkYV9rZXltYXBbaV0pCisJCSAgICBzZXRfYml0KGpvcm5hZGFrYmQt
Pmpvcm5hZGFfa2V5bWFwW2ldLCBqb3JuYWRha2JkLT5wb2xsX2Rldi0+aW5wdXQtPmtleWJpdCk7
CisKKwljbGVhcl9iaXQoMCwgam9ybmFkYWtiZC0+cG9sbF9kZXYtPmlucHV0LT5rZXliaXQpOwor
CisJZXJyb3IgPSBpbnB1dF9yZWdpc3Rlcl9wb2xsZWRfZGV2aWNlKGpvcm5hZGFrYmQtPnBvbGxf
ZGV2KTsKKwlpZiAoZXJyb3IpCisJICAgIGdvdG8gZmFpbGVkOworCisJcHJpbnRrKEtFUk5fSU5G
TyAiV2UgaGF2ZSBzdWNjZXNzZnVsbHkgcmVnaXN0ZXJkIHRoZSBrZXlib2FyZCBkcml2ZXJcbiIp
OworCXJldHVybiAwOworCitmYWlsZWQ6CisJcHJpbnRrKEtFUk5fSU5GTyAiSm9ybmFkYWtiZDog
ZmFpbGVkIHRvIHJlZ2lzdGVyIGRyaXZlciwgYmFpbGluZ1xuIik7CisJa2ZyZWUoam9ybmFkYWti
ZCk7CisJcmV0dXJuIC1FTk9NRU07CisKK30KKworc3RhdGljIGludCBqb3JuYWRhNjgwa2JkX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBqb3JuYWRha2Jk
ICpqb3JuYWRha2JkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisKKwlpbnB1dF91bnJl
Z2lzdGVyX3BvbGxlZF9kZXZpY2Uoam9ybmFkYWtiZC0+cG9sbF9kZXYpOworCWlucHV0X2ZyZWVf
cG9sbGVkX2RldmljZShqb3JuYWRha2JkLT5wb2xsX2Rldik7CisJa2ZyZWUoam9ybmFkYWtiZCk7
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGpvcm5hZGE2
ODBrYmRfZHJpdmVyID0geworCS5kcml2ZXIJPSB7CisJCSAgICAubmFtZSA9ICJqb3JuYWRhNjgw
X2tiZCIsCisJCX0sCisJLnByb2JlID0gam9ybmFkYTY4MGtiZF9wcm9iZSwKKwkucmVtb3ZlID0g
am9ybmFkYTY4MGtiZF9yZW1vdmUsCit9OworCitzdGF0aWMgaW50IF9fZGV2aW5pdCBqb3JuYWRh
Njgwa2JkX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZq
b3JuYWRhNjgwa2JkX2RyaXZlcik7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBqb3JuYWRhNjgw
a2JkX2V4aXQodm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rlcigmam9ybmFkYTY4
MGtiZF9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChqb3JuYWRhNjgwa2JkX2luaXQpOworbW9k
dWxlX2V4aXQoam9ybmFkYTY4MGtiZF9leGl0KTsKKworTU9EVUxFX0FVVEhPUigiS3Jpc3RvZmZl
ciBFcmljc29uIDxrcmlzdG9mZmVyLmVyaWNzb25AZ21haWwuY29tPiIpOworTU9EVUxFX0RFU0NS
SVBUSU9OKCJIUCBKb3JuYWRhIDYyMC82NjAvNjgwLzY5MCBLZXlib2FyZCBEcml2ZXIiKTsKK01P
RFVMRV9MSUNFTlNFKCJHUEx2MiIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9NYWtlZmlsZSBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUKaW5kZXggMjhkMjEx
Yi4uN2VjZDJiMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQor
KysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlCkBAIC0yMSw0ICsyMSw1IEBAIG9i
ai0kKENPTkZJR19LRVlCT0FSRF9PTUFQKQkJKz0gb21hcC1rZXlwYWQubwogb2JqLSQoQ09ORklH
X0tFWUJPQVJEX1BYQTI3eCkJCSs9IHB4YTI3eF9rZXlib2FyZC5vCiBvYmotJChDT05GSUdfS0VZ
Qk9BUkRfQUFFRDIwMDApCQkrPSBhYWVkMjAwMF9rYmQubwogb2JqLSQoQ09ORklHX0tFWUJPQVJE
X0dQSU8pCQkrPSBncGlvX2tleXMubworb2JqLSQoQ09ORklHX0tFWUJPQVJEX0hQNlhYKQkJKz0g
am9ybmFkYTY4MF9rYmQubwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tj
b25maWcgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKaW5kZXggYzk3ZDVlYi4uOTlm
YTE5YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnCisrKyBiL2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZwpAQCAtMjA4LDYgKzIwOCwxNCBAQCBjb25maWcg
S0VZQk9BUkRfSElMCiAJICBUaGlzIGRyaXZlciBpbXBsZW1lbnRzIHN1cHBvcnQgZm9yIEhJTC1r
ZXlib2FyZHMgYXR0YWNoZWQKIAkgIHRvIHlvdXIgbWFjaGluZSwgc28gbm9ybWFsbHkgeW91IHNo
b3VsZCBzYXkgWSBoZXJlLgogCitjb25maWcgS0VZQk9BUkRfSFA2WFgKKyAgICAgICB0cmlzdGF0
ZSAiSFAgSm9ybmFkYSA2WFggS2V5Ym9hcmQgc3VwcG9ydCIKKyAgICAgICBkZXBlbmRzIG9uIFNI
X0hQNlhYCisgICAgICAgc2VsZWN0IElOUFVUX1BPTExERVYKKyAgICAgICBoZWxwCisgICAgCSAg
IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgb25ib2FyZCBrZXlib2FyZCBmb3VuZCBvbgorCSAg
IEhQIEpvcm5hZGEgNjIwLzY2MC82ODAvNjkwLgorCiBjb25maWcgS0VZQk9BUkRfT01BUAogCXRy
aXN0YXRlICJUSSBPTUFQIGtleXBhZCBzdXBwb3J0IgogCWRlcGVuZHMgb24gKEFSQ0hfT01BUDEg
fHwgQVJDSF9PTUFQMikK

--Multipart=_Sat__25_Aug_2007_20_57_13_-0700_3S63o3mX5mTQR9b2--
