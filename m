From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Thu, 26 Jul 2007 22:34:52 -0700
Message-ID: <20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	<200707220145.10563.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707220145.10563.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dmitry,

Ive merged scan_keyb and started to minimize it for just one keyboard, just want to hear from you if this is an acceptable approach. 
Its a work in progress, just want to know if im on the right path.


Best wishes
Kristoffer


diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
new file mode 100644
index 0000000..0191628
--- /dev/null
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -0,0 +1,283 @@
+/*
+ * drivers/input/keyboard/jornada680_keyb.c
+ *
+ * HP Jornada 680/690 Scan keyboard
+ *
+ *  Copyright (C) 2007  Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
+ *
+ * Based on jornada680_keyb.c
+ */
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
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
+/***************************************************************
+HP Jornada 680(SWEDISH version) keyboard
+[!] indicates Special Characters
+______________________________________________________________________
+| ESC     F1  F2   F3   F4   F5   F6   F7   F8   F9   F10        POWER|
+|  1    2    3    4    5    6    7    8    9    0    +   `    BKPSPACE|
+|*    Q    W    E    R    T    Y    U    I    O    P    !    ^   ENTER|
+| TAB   A    S    D    F    G    H    J    K    L    !    !   '  ENTER|
+| SHIFT   Z    X    C    V    B    N    M    ,    .    -     UP  SHIFT|
+| CTRL  WIN  ALT  ?  =======SPACE========  ALTG  DEL    LEF  DO  RI   ]
+-----------------------------------------------------------------------
+****************************************************************/
+
+static const unsigned char jornada_scancodes[] = {
+	/* PTD1 */
+	KEY_CAPSLOCK, KEY_MACRO, KEY_LEFTCTRL, 0, KEY_ESC, 0,
+	0, 0, KEY_F1, KEY_F2, KEY_F3, KEY_F8, KEY_F7, KEY_F2,
+	KEY_F4, KEY_F5,
+	/* PTD5 */
+	KEY_SLASH, KEY_APOSTROPHE, KEY_ENTER, 0, KEY_Z, 0,
+	0, 0, KEY_X, KEY_C, KEY_V, KEY_DOT, KEY_COMMA,
+	KEY_M, KEY_B, KEY_N,
+	/* PTD7 */
+	KEY_KP2, KEY_KP6, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, KEY_KP4,
+	0, 0, KEY_LEFTALT, KEY_HANJA,
+	/* PTE0 */
+	0, 0, 0, 0, KEY_FINANCE, 0,
+	0, 0, KEY_LEFTCTRL, 0, KEY_SPACE, KEY_KPDOT,
+	KEY_VOLUMEUP, 249, 0, 0,
+	/* PTE1 */
+	KEY_SEMICOLO, KEY_RIGHTBRACE, KEY_BACKSLASH, 0, KEY_A, 0,
+	0, 0, KEY_S, KEY_D, KEY_F, KEY_L, KEY_K, KEY_J, KEY_G, KEY_H,
+	/* PTE3 */
+	KEY_KP8, KEY_LEFTMETA, KEY_RIGHTSHIFT, 0, KEY_TAB, 0, 0,
+	0, 0, KEY_LEFTSHIFT, 0, 0, 0,
+	0, 0, 0,
+	/* PTE6 */
+	KEY_P, KEY_LEFTBRACE, KEY_BACKSPACE, 0, KEY_Q, 0, 0,
+	0, KEY_W, KEY_E, KEY_R, KEY_O, KEY_I, KEY_U, KEY_T, KEY_R,
+	/* PTE7 */
+	KEY_0, KEY_MINUS, KEY_EQUAL, 0, KEY_1, 0, 0,
+	0, KEY_2, KEY_3, KEY_4, KEY_9, KEY_8, KEY_7, KEY_5, KEY_6,
+	/* **** */
+	0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0,
+};
+
+struct jornadakbd {
+	unsigned char jornada_keymap[ARRAY_SIZE(jornada_keycodes)];
+	struct input_dev *input;
+	int length = 16;
+	int s0[16], s1[16];
+};
+
+/* Our global structures */
+struct jornadakbd *jornadakbd;
+struct timer_list scan_timer;
+static int scan_jiffies;
+
+static check_kbd(unsigned char *new, unsigned char *old)
+{
+    unsigned char *table = jornadakbd->jornada_keymap;
+    unsigned length = jornadakbd->length;
+    unsigned int xor,bit;
+
+    while (lenght-- > 0) {
+	/* if 0 (false) then they are both true or both false */
+	if ((xor = *new ^ *old) == 0)
+	    table += 8;
+	/* if 1 (true) then one is true and other is false */
+	else {
+		for (bit = 0x01; bit < 0x100; bit <<= 1) {
+		    if (xor & bit) {
+				input_report_key(jornadakbd->input, *table, !(*new & bit));
+				need_tasklet_schedule = 1;
+		    }
+		    table++;
+		}
+	}
+
+	new++;
+	old++;
+    }
+
+    if (need_tasklet_schedule) {
+	    input_sync(jornadakbd->input);
+	    tasklet_schedule(&keyboard_tasklet);
+    }
+}
+
+static void jornada_scan(unsigned long dummy)
+{
+    scan_jiffies++;
+
+    if (scan_jiffies & 1) {
+	/* This is always false */
+	if (!jornada_scan_keyb(jornadakbd->s0))
+	        check_kbd(jornadakbd->s0, jornadakbd->s1);
+	else
+		memcpy(jornadakbd->s0, jornadakbd->s1, jornadakbd->length);
+    } else {
+	/* This is always false? */
+	if (!jornada_scan_keyb(jornadakbd->s1))
+		check_kbd(jornadakbd->s1, jornadakbd->s0);
+	else
+		memcpy(jornadakbd->s1, jornadakbd->s2, jornadakbd->length);
+    }
+
+    mod_timer(&scan_timer, jiffies + SCANHZ);
+}
+
+static int jornada_scan_keyb(unsigned char *s)
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
+static struct platform_driver jornada680_kbd_driver = {
+	.driver		= {
+			    .name	= "jornada680_kbd",
+			},
+	.probe		= jornada680_kbd_probe,
+	.remove		= jornada680_kbd_remove,
+};
+
+static int __init jornada680_kbd_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	int i, err, ret;
+
+	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	if (!jornadakbd)
+	    return -ENOMEM;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+	    goto failed;
+
+	platform_set_drvdata(pdev, jornadakbd);
+
+	input_dev->dev.parent = &pdev.dev;
+	jornadakbd->input = input_dev;
+
+	memcpy(jornadakbd->jornada_keymap, jornada_normal_keymap, sizeof(jornadakbd->jornada_keymap));
+
+	input_dev->EVBIT[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->name = "HP Jornada 680 keyboard";
+	input_dev->phys = "jornadakbd/input0";
+	input_dev->keycode = jornadakbd->jornada_keymap;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(jornada_normal_keymap);
+
+	for (i = 0; i < ARRAY_SIZE(jornada_scancodes); i++)
+		set_bit(jornadakbd->jornada_keymap[i], input_dev->keybit);
+
+	input_register_device(jornadakbd->input);
+
+	init_timer(&scan_timer);
+	scan_timer.expires = jiffies + SCANHZ;
+	scan_timer.data	   = 0;
+	scan_timer.function = scan_kbd;
+	add_timer(&scan_timer);
+
+	return 0;
+
+failed:
+	kfree(jornadakbd);
+
+}
+
+static int jornada680_kbd_remove(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+
+	del_timer_sync(&scan_timer);
+	input_unregister_device(jornadakbd->input);
+	kfree(jornadakbd);
+}
+
+static int __devinit jornada680_kbd_init(void)
+{
+	return platform_driver_register(&jornada680_kbd_driver);
+}
+
+static void __exit hp680_kbd_exit(void)
+{
+	platform_driver_unregister(&jornada680_kbd_driver);
+}
+
+module_init(hp680_kbd_init_hw);
+module_exit(hp680_kbd_exit_hw);
+MODULE_LICENSE("GPL");



On Sun, 22 Jul 2007 01:45:10 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Saturday 21 July 2007 21:15, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > Here we go again with another keyboard patch (this time for hp6xx).
> > It consists of three files, where one contains the generic scan_keyb
> > routines with needed header and the third is the specific hp6xx driver.
> 
> Please do not use scan_keyb. It goes around input core and directly into
> legacy keyboard driver. For drivers that periodically poll/scan their
> device input_polldev might be of interest.
> 
> -- 
> Dmitry


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
