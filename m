From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/3] input: remove obsolete {corgi,spitz,tosa}kbd.c
Date: Wed, 28 Apr 2010 19:54:12 +0800
Message-ID: <n2if17812d71004280454gebc991b7k5e954b2d20024ba5@mail.gmail.com>
References: <m2mf17812d71004270025xc4ced0a8y188c525184304dec@mail.gmail.com>
	<20100428083835.GA13085@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:34695 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab0D1Lyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 07:54:33 -0400
Received: by qyk9 with SMTP id 9so21106570qyk.1
        for <linux-input@vger.kernel.org>; Wed, 28 Apr 2010 04:54:32 -0700 (PDT)
In-Reply-To: <20100428083835.GA13085@rainbow>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org

On Wed, Apr 28, 2010 at 4:38 PM, Dmitry Artamonow <mad_soft@inbox.ru> w=
rote:
> On 15:25 Tue 27 Apr =C2=A0 =C2=A0 , Eric Miao wrote:
>> commit 856661df1bfb7c90bc83fa97d8f98fc4740fca9d
>> Author: Eric Miao <eric.y.miao@gmail.com>
>> Date: =C2=A0 Tue Apr 27 14:50:54 2010 +0800
>>
>> =C2=A0 =C2=A0 input: remove obsolete {corgi,spitz,tosa}kbd.c
>>
>> =C2=A0 =C2=A0 Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>
> Don't forget to update Documentation/feature-removal-schedule.txt as
> well.

Thanks Dmitry, you are right. Patch updated:

commit 9a27fe777e0ac008e5a43b5162353fd1c3950e0d
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Tue Apr 27 14:50:54 2010 +0800

    input: remove obsolete {corgi,spitz,tosa}kbd.c

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/Documentation/feature-removal-schedule.txt
b/Documentation/feature-removal-schedule.txt
index ed511af..c8659ad 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -520,17 +520,6 @@ Who:	Hans de Goede <hdegoede@redhat.com>

 ----------------------------

-What:	corgikbd, spitzkbd, tosakbd driver
-When:	2.6.35
-Files:	drivers/input/keyboard/{corgi,spitz,tosa}kbd.c
-Why:	We now have a generic GPIO based matrix keyboard driver that
-	are fully capable of handling all the keys on these devices.
-	The original drivers manipulate the GPIO registers directly
-	and so are difficult to maintain.
-Who:	Eric Miao <eric.y.miao@gmail.com>
-
-----------------------------
-
 What:	corgi_ssp and corgi_ts driver
 When:	2.6.35
 Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_=
ts.c
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
index a74ee12..a829338 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -143,19 +143,6 @@ config KEYBOARD_BFIN
 	  To compile this driver as a module, choose M here: the
 	  module will be called bf54x-keys.

-config KEYBOARD_CORGI
-	tristate "Corgi keyboard (deprecated)"
-	depends on PXA_SHARPSL
-	help
-	  Say Y here to enable the keyboard on the Sharp Zaurus SL-C7xx
-	  series of PDAs.
-
-	  This driver is now deprecated, use generic GPIO based matrix
-	  keyboard driver instead.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called corgikbd.
-
 config KEYBOARD_LKKBD
 	tristate "DECstation/VAXstation LK201/LK401 keyboard"
 	select SERIO
@@ -339,19 +326,6 @@ config KEYBOARD_PXA930_ROTARY
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa930_rotary.

-config KEYBOARD_SPITZ
-	tristate "Spitz keyboard (deprecated)"
-	depends on PXA_SHARPSL
-	help
-	  Say Y here to enable the keyboard on the Sharp Zaurus SL-C1000,
-	  SL-C3000 and Sl-C3100 series of PDAs.
-
-	  This driver is now deprecated, use generic GPIO based matrix
-	  keyboard driver instead.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called spitzkbd.
-
 config KEYBOARD_STOWAWAY
 	tristate "Stowaway keyboard"
 	select SERIO
@@ -414,18 +388,6 @@ config KEYBOARD_TWL4030
 	  To compile this driver as a module, choose M here: the
 	  module will be called twl4030_keypad.

-config KEYBOARD_TOSA
-	tristate "Tosa keyboard (deprecated)"
-	depends on MACH_TOSA
-	help
-	  Say Y here to enable the keyboard on the Sharp Zaurus SL-6000x (Tos=
a)
-
-	  This driver is now deprecated, use generic GPIO based matrix
-	  keyboard driver instead.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called tosakbd.
-
 config KEYBOARD_XTKBD
 	tristate "XT keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
index 706c6b5..9a74127 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_KEYBOARD_AMIGA)		+=3D amikbd.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+=3D atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+=3D atkbd.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+=3D bf54x-keys.o
-obj-$(CONFIG_KEYBOARD_CORGI)		+=3D corgikbd.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+=3D davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+=3D ep93xx_keypad.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+=3D gpio_keys.o
@@ -33,10 +32,8 @@ obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+=3D pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+=3D qt2160.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
-obj-$(CONFIG_KEYBOARD_SPITZ)		+=3D spitzkbd.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
-obj-$(CONFIG_KEYBOARD_TOSA)		+=3D tosakbd.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+=3D twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+=3D xtkbd.o
 obj-$(CONFIG_KEYBOARD_W90P910)		+=3D w90p910_keypad.o
diff --git a/drivers/input/keyboard/corgikbd.c
b/drivers/input/keyboard/corgikbd.c
deleted file mode 100644
index 634af6a..0000000
--- a/drivers/input/keyboard/corgikbd.c
+++ /dev/null
@@ -1,414 +0,0 @@
-/*
- *  Keyboard driver for Sharp Corgi models (SL-C7xx)
- *
- *  Copyright (c) 2004-2005 Richard Purdie
- *
- *  Based on xtkbd.c/locomkbd.c
- *
- *  This program is free software; you can redistribute it and/or modi=
fy
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/jiffies.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include <mach/corgi.h>
-#include <mach/pxa2xx-gpio.h>
-#include <asm/hardware/scoop.h>
-
-#define KB_ROWS				8
-#define KB_COLS				12
-#define KB_ROWMASK(r)		(1 << (r))
-#define SCANCODE(r,c)		( ((r)<<4) + (c) + 1 )
-/* zero code, 124 scancodes */
-#define	NR_SCANCODES		( SCANCODE(KB_ROWS-1,KB_COLS-1) +1 +1 )
-
-#define SCAN_INTERVAL		(50) /* ms */
-#define HINGE_SCAN_INTERVAL	(250) /* ms */
-
-#define CORGI_KEY_CALENDER	KEY_F1
-#define CORGI_KEY_ADDRESS	KEY_F2
-#define CORGI_KEY_FN		KEY_F3
-#define CORGI_KEY_CANCEL	KEY_F4
-#define CORGI_KEY_OFF		KEY_SUSPEND
-#define CORGI_KEY_EXOK		KEY_F5
-#define CORGI_KEY_EXCANCEL	KEY_F6
-#define CORGI_KEY_EXJOGDOWN	KEY_F7
-#define CORGI_KEY_EXJOGUP	KEY_F8
-#define CORGI_KEY_JAP1		KEY_LEFTCTRL
-#define CORGI_KEY_JAP2		KEY_LEFTALT
-#define CORGI_KEY_MAIL		KEY_F10
-#define CORGI_KEY_OK		KEY_F11
-#define CORGI_KEY_MENU		KEY_F12
-
-static unsigned char corgikbd_keycode[NR_SCANCODES] =3D {
-	0,
                                             /* 0 */
-	0, KEY_1, KEY_3, KEY_5, KEY_6, KEY_7, KEY_9, KEY_0, KEY_BACKSPACE,
0, 0, 0, 0, 0, 0, 0, 	                      /* 1-16 */
-	0, KEY_2, KEY_4, KEY_R, KEY_Y, KEY_8, KEY_I, KEY_O, KEY_P, 0, 0, 0,
0, 0, 0, 0,                                   /* 17-32 */
-	KEY_TAB, KEY_Q, KEY_E, KEY_T, KEY_G, KEY_U, KEY_J, KEY_K, 0, 0, 0,
0, 0, 0, 0, 0,                                 /* 33-48 */
-	CORGI_KEY_CALENDER, KEY_W, KEY_S, KEY_F, KEY_V, KEY_H, KEY_M, KEY_L,
0, KEY_RIGHTSHIFT, 0, 0, 0, 0, 0, 0,         /* 49-64 */
-	CORGI_KEY_ADDRESS, KEY_A, KEY_D, KEY_C, KEY_B, KEY_N, KEY_DOT, 0,
KEY_ENTER, 0, KEY_LEFTSHIFT, 0, 0, 0, 0, 0, 	  /* 65-80 */
-	CORGI_KEY_MAIL, KEY_Z, KEY_X, KEY_MINUS, KEY_SPACE, KEY_COMMA, 0,
KEY_UP, 0, 0, 0, CORGI_KEY_FN, 0, 0, 0, 0,            /* 81-96 */
-	KEY_SYSRQ, CORGI_KEY_JAP1, CORGI_KEY_JAP2, CORGI_KEY_CANCEL,
CORGI_KEY_OK, CORGI_KEY_MENU, KEY_LEFT, KEY_DOWN, KEY_RIGHT, 0, 0, 0,
0, 0, 0, 0,  /* 97-112 */
-	CORGI_KEY_OFF, CORGI_KEY_EXOK, CORGI_KEY_EXCANCEL,
CORGI_KEY_EXJOGDOWN, CORGI_KEY_EXJOGUP, 0, 0, 0, 0, 0, 0, 0,   /*
113-124 */
-};
-
-
-struct corgikbd {
-	unsigned char keycode[ARRAY_SIZE(corgikbd_keycode)];
-	struct input_dev *input;
-
-	spinlock_t lock;
-	struct timer_list timer;
-	struct timer_list htimer;
-
-	unsigned int suspended;
-	unsigned long suspend_jiffies;
-};
-
-#define KB_DISCHARGE_DELAY	10
-#define KB_ACTIVATE_DELAY	10
-
-/* Helper functions for reading the keyboard matrix
- * Note: We should really be using the generic gpio functions to alter
- *       GPDR but it requires a function call per GPIO bit which is
- *       excessive when we need to access 12 bits at once, multiple ti=
mes.
- * These functions must be called within local_irq_save()/local_irq_re=
store()
- * or similar.
- */
-static inline void corgikbd_discharge_all(void)
-{
-	/* STROBE All HiZ */
-	GPCR2  =3D CORGI_GPIO_ALL_STROBE_BIT;
-	GPDR2 &=3D ~CORGI_GPIO_ALL_STROBE_BIT;
-}
-
-static inline void corgikbd_activate_all(void)
-{
-	/* STROBE ALL -> High */
-	GPSR2  =3D CORGI_GPIO_ALL_STROBE_BIT;
-	GPDR2 |=3D CORGI_GPIO_ALL_STROBE_BIT;
-
-	udelay(KB_DISCHARGE_DELAY);
-
-	/* Clear any interrupts we may have triggered when altering the GPIO =
lines */
-	GEDR1 =3D CORGI_GPIO_HIGH_SENSE_BIT;
-	GEDR2 =3D CORGI_GPIO_LOW_SENSE_BIT;
-}
-
-static inline void corgikbd_activate_col(int col)
-{
-	/* STROBE col -> High, not col -> HiZ */
-	GPSR2 =3D CORGI_GPIO_STROBE_BIT(col);
-	GPDR2 =3D (GPDR2 & ~CORGI_GPIO_ALL_STROBE_BIT) | CORGI_GPIO_STROBE_BI=
T(col);
-}
-
-static inline void corgikbd_reset_col(int col)
-{
-	/* STROBE col -> Low */
-	GPCR2 =3D CORGI_GPIO_STROBE_BIT(col);
-	/* STROBE col -> out, not col -> HiZ */
-	GPDR2 =3D (GPDR2 & ~CORGI_GPIO_ALL_STROBE_BIT) | CORGI_GPIO_STROBE_BI=
T(col);
-}
-
-#define GET_ROWS_STATUS(c)	(((GPLR1 & CORGI_GPIO_HIGH_SENSE_BIT) >>
CORGI_GPIO_HIGH_SENSE_RSHIFT) | ((GPLR2 & CORGI_GPIO_LOW_SENSE_BIT) <<
CORGI_GPIO_LOW_SENSE_LSHIFT))
-
-/*
- * The corgi keyboard only generates interrupts when a key is pressed.
- * When a key is pressed, we enable a timer which then scans the
- * keyboard to detect when the key is released.
- */
-
-/* Scan the hardware keyboard and push any changes up through the
input layer */
-static void corgikbd_scankeyboard(struct corgikbd *corgikbd_data)
-{
-	unsigned int row, col, rowd;
-	unsigned long flags;
-	unsigned int num_pressed;
-
-	if (corgikbd_data->suspended)
-		return;
-
-	spin_lock_irqsave(&corgikbd_data->lock, flags);
-
-	num_pressed =3D 0;
-	for (col =3D 0; col < KB_COLS; col++) {
-		/*
-		 * Discharge the output driver capacitatance
-		 * in the keyboard matrix. (Yes it is significant..)
-		 */
-
-		corgikbd_discharge_all();
-		udelay(KB_DISCHARGE_DELAY);
-
-		corgikbd_activate_col(col);
-		udelay(KB_ACTIVATE_DELAY);
-
-		rowd =3D GET_ROWS_STATUS(col);
-		for (row =3D 0; row < KB_ROWS; row++) {
-			unsigned int scancode, pressed;
-
-			scancode =3D SCANCODE(row, col);
-			pressed =3D rowd & KB_ROWMASK(row);
-
-			input_report_key(corgikbd_data->input,
corgikbd_data->keycode[scancode], pressed);
-
-			if (pressed)
-				num_pressed++;
-
-			if (pressed && (corgikbd_data->keycode[scancode] =3D=3D CORGI_KEY_O=
=46F)
-					&& time_after(jiffies, corgikbd_data->suspend_jiffies + HZ)) {
-				input_event(corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
-				corgikbd_data->suspend_jiffies=3Djiffies;
-			}
-		}
-		corgikbd_reset_col(col);
-	}
-
-	corgikbd_activate_all();
-
-	input_sync(corgikbd_data->input);
-
-	/* if any keys are pressed, enable the timer */
-	if (num_pressed)
-		mod_timer(&corgikbd_data->timer, jiffies + msecs_to_jiffies(SCAN_INT=
ERVAL));
-
-	spin_unlock_irqrestore(&corgikbd_data->lock, flags);
-}
-
-/*
- * corgi keyboard interrupt handler.
- */
-static irqreturn_t corgikbd_interrupt(int irq, void *dev_id)
-{
-	struct corgikbd *corgikbd_data =3D dev_id;
-
-	if (!timer_pending(&corgikbd_data->timer)) {
-		/** wait chattering delay **/
-		udelay(20);
-		corgikbd_scankeyboard(corgikbd_data);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * corgi timer checking for released keys
- */
-static void corgikbd_timer_callback(unsigned long data)
-{
-	struct corgikbd *corgikbd_data =3D (struct corgikbd *) data;
-	corgikbd_scankeyboard(corgikbd_data);
-}
-
-/*
- * The hinge switches generate no interrupt so they need to be
- * monitored by a timer.
- *
- * We debounce the switches and pass them to the input system.
- *
- *  gprr =3D=3D 0x00 - Keyboard with Landscape Screen
- *          0x08 - No Keyboard with Portrait Screen
- *          0x0c - Keyboard and Screen Closed
- */
-
-#define READ_GPIO_BIT(x)    (GPLR(x) & GPIO_bit(x))
-#define HINGE_STABLE_COUNT 2
-static int sharpsl_hinge_state;
-static int hinge_count;
-
-static void corgikbd_hinge_timer(unsigned long data)
-{
-	struct corgikbd *corgikbd_data =3D (struct corgikbd *) data;
-	unsigned long gprr;
-	unsigned long flags;
-
-	gprr =3D read_scoop_reg(&corgiscoop_device.dev, SCOOP_GPRR) &
(CORGI_SCP_SWA | CORGI_SCP_SWB);
-	gprr |=3D (READ_GPIO_BIT(CORGI_GPIO_AK_INT) !=3D 0);
-	if (gprr !=3D sharpsl_hinge_state) {
-		hinge_count =3D 0;
-		sharpsl_hinge_state =3D gprr;
-	} else if (hinge_count < HINGE_STABLE_COUNT) {
-		hinge_count++;
-		if (hinge_count >=3D HINGE_STABLE_COUNT) {
-			spin_lock_irqsave(&corgikbd_data->lock, flags);
-
-			input_report_switch(corgikbd_data->input, SW_LID,
((sharpsl_hinge_state & CORGI_SCP_SWA) !=3D 0));
-			input_report_switch(corgikbd_data->input, SW_TABLET_MODE,
((sharpsl_hinge_state & CORGI_SCP_SWB) !=3D 0));
-			input_report_switch(corgikbd_data->input, SW_HEADPHONE_INSERT,
(READ_GPIO_BIT(CORGI_GPIO_AK_INT) !=3D 0));
-			input_sync(corgikbd_data->input);
-
-			spin_unlock_irqrestore(&corgikbd_data->lock, flags);
-		}
-	}
-	mod_timer(&corgikbd_data->htimer, jiffies +
msecs_to_jiffies(HINGE_SCAN_INTERVAL));
-}
-
-#ifdef CONFIG_PM
-static int corgikbd_suspend(struct platform_device *dev, pm_message_t =
state)
-{
-	int i;
-	struct corgikbd *corgikbd =3D platform_get_drvdata(dev);
-
-	corgikbd->suspended =3D 1;
-	/* strobe 0 is the power key so this can't be made an input for
-	   powersaving therefore i =3D 1 */
-	for (i =3D 1; i < CORGI_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_IN);
-
-	return 0;
-}
-
-static int corgikbd_resume(struct platform_device *dev)
-{
-	int i;
-	struct corgikbd *corgikbd =3D platform_get_drvdata(dev);
-
-	for (i =3D 1; i < CORGI_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_OUT | GPIO_DFLT_HIGH);
-
-	/* Upon resume, ignore the suspend key for a short while */
-	corgikbd->suspend_jiffies=3Djiffies;
-	corgikbd->suspended =3D 0;
-
-	return 0;
-}
-#else
-#define corgikbd_suspend	NULL
-#define corgikbd_resume		NULL
-#endif
-
-static int __devinit corgikbd_probe(struct platform_device *pdev)
-{
-	struct corgikbd *corgikbd;
-	struct input_dev *input_dev;
-	int i, err =3D -ENOMEM;
-
-	corgikbd =3D kzalloc(sizeof(struct corgikbd), GFP_KERNEL);
-	input_dev =3D input_allocate_device();
-	if (!corgikbd || !input_dev)
-		goto fail;
-
-	platform_set_drvdata(pdev, corgikbd);
-
-	corgikbd->input =3D input_dev;
-	spin_lock_init(&corgikbd->lock);
-
-	/* Init Keyboard rescan timer */
-	init_timer(&corgikbd->timer);
-	corgikbd->timer.function =3D corgikbd_timer_callback;
-	corgikbd->timer.data =3D (unsigned long) corgikbd;
-
-	/* Init Hinge Timer */
-	init_timer(&corgikbd->htimer);
-	corgikbd->htimer.function =3D corgikbd_hinge_timer;
-	corgikbd->htimer.data =3D (unsigned long) corgikbd;
-
-	corgikbd->suspend_jiffies=3Djiffies;
-
-	memcpy(corgikbd->keycode, corgikbd_keycode, sizeof(corgikbd->keycode)=
);
-
-	input_dev->name =3D "Corgi Keyboard";
-	input_dev->phys =3D "corgikbd/input0";
-	input_dev->id.bustype =3D BUS_HOST;
-	input_dev->id.vendor =3D 0x0001;
-	input_dev->id.product =3D 0x0001;
-	input_dev->id.version =3D 0x0100;
-	input_dev->dev.parent =3D &pdev->dev;
-
-	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
-		BIT_MASK(EV_PWR) | BIT_MASK(EV_SW);
-	input_dev->keycode =3D corgikbd->keycode;
-	input_dev->keycodesize =3D sizeof(unsigned char);
-	input_dev->keycodemax =3D ARRAY_SIZE(corgikbd_keycode);
-
-	for (i =3D 0; i < ARRAY_SIZE(corgikbd_keycode); i++)
-		set_bit(corgikbd->keycode[i], input_dev->keybit);
-	clear_bit(0, input_dev->keybit);
-	set_bit(SW_LID, input_dev->swbit);
-	set_bit(SW_TABLET_MODE, input_dev->swbit);
-	set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
-
-	err =3D input_register_device(corgikbd->input);
-	if (err)
-		goto fail;
-
-	mod_timer(&corgikbd->htimer, jiffies + msecs_to_jiffies(HINGE_SCAN_IN=
TERVAL));
-
-	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs =
*/
-	for (i =3D 0; i < CORGI_KEY_SENSE_NUM; i++) {
-		pxa_gpio_mode(CORGI_GPIO_KEY_SENSE(i) | GPIO_IN);
-		if (request_irq(CORGI_IRQ_GPIO_KEY_SENSE(i), corgikbd_interrupt,
-				IRQF_DISABLED | IRQF_TRIGGER_RISING,
-				"corgikbd", corgikbd))
-			printk(KERN_WARNING "corgikbd: Can't get IRQ: %d!\n", i);
-	}
-
-	/* Set Strobe lines as outputs - set high */
-	for (i =3D 0; i < CORGI_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_OUT | GPIO_DFLT_HIGH);
-
-	/* Setup the headphone jack as an input */
-	pxa_gpio_mode(CORGI_GPIO_AK_INT | GPIO_IN);
-
-	return 0;
-
- fail:	input_free_device(input_dev);
-	kfree(corgikbd);
-	return err;
-}
-
-static int __devexit corgikbd_remove(struct platform_device *pdev)
-{
-	int i;
-	struct corgikbd *corgikbd =3D platform_get_drvdata(pdev);
-
-	for (i =3D 0; i < CORGI_KEY_SENSE_NUM; i++)
-		free_irq(CORGI_IRQ_GPIO_KEY_SENSE(i), corgikbd);
-
-	del_timer_sync(&corgikbd->htimer);
-	del_timer_sync(&corgikbd->timer);
-
-	input_unregister_device(corgikbd->input);
-
-	kfree(corgikbd);
-
-	return 0;
-}
-
-static struct platform_driver corgikbd_driver =3D {
-	.probe		=3D corgikbd_probe,
-	.remove		=3D __devexit_p(corgikbd_remove),
-	.suspend	=3D corgikbd_suspend,
-	.resume		=3D corgikbd_resume,
-	.driver		=3D {
-		.name	=3D "corgi-keyboard",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-static int __init corgikbd_init(void)
-{
-	return platform_driver_register(&corgikbd_driver);
-}
-
-static void __exit corgikbd_exit(void)
-{
-	platform_driver_unregister(&corgikbd_driver);
-}
-
-module_init(corgikbd_init);
-module_exit(corgikbd_exit);
-
-MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
-MODULE_DESCRIPTION("Corgi Keyboard Driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:corgi-keyboard");
diff --git a/drivers/input/keyboard/spitzkbd.c
b/drivers/input/keyboard/spitzkbd.c
deleted file mode 100644
index 1396742..0000000
--- a/drivers/input/keyboard/spitzkbd.c
+++ /dev/null
@@ -1,496 +0,0 @@
-/*
- *  Keyboard driver for Sharp Spitz, Borzoi and Akita (SL-Cxx00 series=
)
- *
- *  Copyright (c) 2005 Richard Purdie
- *
- *  Based on corgikbd.c
- *
- *  This program is free software; you can redistribute it and/or modi=
fy
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/jiffies.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include <mach/spitz.h>
-#include <mach/pxa2xx-gpio.h>
-
-#define KB_ROWS			7
-#define KB_COLS			11
-#define KB_ROWMASK(r)		(1 << (r))
-#define SCANCODE(r,c)		(((r)<<4) + (c) + 1)
-#define	NR_SCANCODES		((KB_ROWS<<4) + 1)
-
-#define SCAN_INTERVAL		(50) /* ms */
-#define HINGE_SCAN_INTERVAL	(150) /* ms */
-
-#define SPITZ_KEY_CALENDER	KEY_F1
-#define SPITZ_KEY_ADDRESS	KEY_F2
-#define SPITZ_KEY_FN		KEY_F3
-#define SPITZ_KEY_CANCEL	KEY_F4
-#define SPITZ_KEY_EXOK		KEY_F5
-#define SPITZ_KEY_EXCANCEL	KEY_F6
-#define SPITZ_KEY_EXJOGDOWN	KEY_F7
-#define SPITZ_KEY_EXJOGUP	KEY_F8
-#define SPITZ_KEY_JAP1		KEY_LEFTALT
-#define SPITZ_KEY_JAP2		KEY_RIGHTCTRL
-#define SPITZ_KEY_SYNC		KEY_F9
-#define SPITZ_KEY_MAIL		KEY_F10
-#define SPITZ_KEY_OK		KEY_F11
-#define SPITZ_KEY_MENU		KEY_F12
-
-static unsigned char spitzkbd_keycode[NR_SCANCODES] =3D {
-	0,
                                             /* 0 */
-	KEY_LEFTCTRL, KEY_1, KEY_3, KEY_5, KEY_6, KEY_7, KEY_9, KEY_0,
KEY_BACKSPACE, SPITZ_KEY_EXOK, SPITZ_KEY_EXCANCEL, 0, 0, 0, 0, 0,  /*
1-16 */
-	0, KEY_2, KEY_4, KEY_R, KEY_Y, KEY_8, KEY_I, KEY_O, KEY_P,
SPITZ_KEY_EXJOGDOWN, SPITZ_KEY_EXJOGUP, 0, 0, 0, 0, 0, /* 17-32 */
-	KEY_TAB, KEY_Q, KEY_E, KEY_T, KEY_G, KEY_U, KEY_J, KEY_K, 0, 0, 0,
0, 0, 0, 0, 0,                                 /* 33-48 */
-	SPITZ_KEY_ADDRESS, KEY_W, KEY_S, KEY_F, KEY_V, KEY_H, KEY_M, KEY_L,
0, KEY_RIGHTSHIFT, 0, 0, 0, 0, 0, 0,         /* 49-64 */
-	SPITZ_KEY_CALENDER, KEY_A, KEY_D, KEY_C, KEY_B, KEY_N, KEY_DOT, 0,
KEY_ENTER, KEY_LEFTSHIFT, 0, 0, 0, 0, 0, 0,	  /* 65-80 */
-	SPITZ_KEY_MAIL, KEY_Z, KEY_X, KEY_MINUS, KEY_SPACE, KEY_COMMA, 0,
KEY_UP, 0, 0, SPITZ_KEY_FN, 0, 0, 0, 0, 0,      /* 81-96 */
-	KEY_SYSRQ, SPITZ_KEY_JAP1, SPITZ_KEY_JAP2, SPITZ_KEY_CANCEL,
SPITZ_KEY_OK, SPITZ_KEY_MENU, KEY_LEFT, KEY_DOWN, KEY_RIGHT, 0, 0, 0,
0, 0, 0, 0  /* 97-112 */
-};
-
-static int spitz_strobes[] =3D {
-	SPITZ_GPIO_KEY_STROBE0,
-	SPITZ_GPIO_KEY_STROBE1,
-	SPITZ_GPIO_KEY_STROBE2,
-	SPITZ_GPIO_KEY_STROBE3,
-	SPITZ_GPIO_KEY_STROBE4,
-	SPITZ_GPIO_KEY_STROBE5,
-	SPITZ_GPIO_KEY_STROBE6,
-	SPITZ_GPIO_KEY_STROBE7,
-	SPITZ_GPIO_KEY_STROBE8,
-	SPITZ_GPIO_KEY_STROBE9,
-	SPITZ_GPIO_KEY_STROBE10,
-};
-
-static int spitz_senses[] =3D {
-	SPITZ_GPIO_KEY_SENSE0,
-	SPITZ_GPIO_KEY_SENSE1,
-	SPITZ_GPIO_KEY_SENSE2,
-	SPITZ_GPIO_KEY_SENSE3,
-	SPITZ_GPIO_KEY_SENSE4,
-	SPITZ_GPIO_KEY_SENSE5,
-	SPITZ_GPIO_KEY_SENSE6,
-};
-
-struct spitzkbd {
-	unsigned char keycode[ARRAY_SIZE(spitzkbd_keycode)];
-	struct input_dev *input;
-	char phys[32];
-
-	spinlock_t lock;
-	struct timer_list timer;
-	struct timer_list htimer;
-
-	unsigned int suspended;
-	unsigned long suspend_jiffies;
-};
-
-#define KB_DISCHARGE_DELAY	10
-#define KB_ACTIVATE_DELAY	10
-
-/* Helper functions for reading the keyboard matrix
- * Note: We should really be using the generic gpio functions to alter
- *       GPDR but it requires a function call per GPIO bit which is
- *       excessive when we need to access 11 bits at once, multiple ti=
mes.
- * These functions must be called within local_irq_save()/local_irq_re=
store()
- * or similar.
- */
-static inline void spitzkbd_discharge_all(void)
-{
-	/* STROBE All HiZ */
-	GPCR0  =3D  SPITZ_GPIO_G0_STROBE_BIT;
-	GPDR0 &=3D ~SPITZ_GPIO_G0_STROBE_BIT;
-	GPCR1  =3D  SPITZ_GPIO_G1_STROBE_BIT;
-	GPDR1 &=3D ~SPITZ_GPIO_G1_STROBE_BIT;
-	GPCR2  =3D  SPITZ_GPIO_G2_STROBE_BIT;
-	GPDR2 &=3D ~SPITZ_GPIO_G2_STROBE_BIT;
-	GPCR3  =3D  SPITZ_GPIO_G3_STROBE_BIT;
-	GPDR3 &=3D ~SPITZ_GPIO_G3_STROBE_BIT;
-}
-
-static inline void spitzkbd_activate_all(void)
-{
-	/* STROBE ALL -> High */
-	GPSR0  =3D  SPITZ_GPIO_G0_STROBE_BIT;
-	GPDR0 |=3D  SPITZ_GPIO_G0_STROBE_BIT;
-	GPSR1  =3D  SPITZ_GPIO_G1_STROBE_BIT;
-	GPDR1 |=3D  SPITZ_GPIO_G1_STROBE_BIT;
-	GPSR2  =3D  SPITZ_GPIO_G2_STROBE_BIT;
-	GPDR2 |=3D  SPITZ_GPIO_G2_STROBE_BIT;
-	GPSR3  =3D  SPITZ_GPIO_G3_STROBE_BIT;
-	GPDR3 |=3D  SPITZ_GPIO_G3_STROBE_BIT;
-
-	udelay(KB_DISCHARGE_DELAY);
-
-	/* Clear any interrupts we may have triggered when altering the GPIO =
lines */
-	GEDR0 =3D SPITZ_GPIO_G0_SENSE_BIT;
-	GEDR1 =3D SPITZ_GPIO_G1_SENSE_BIT;
-	GEDR2 =3D SPITZ_GPIO_G2_SENSE_BIT;
-	GEDR3 =3D SPITZ_GPIO_G3_SENSE_BIT;
-}
-
-static inline void spitzkbd_activate_col(int col)
-{
-	int gpio =3D spitz_strobes[col];
-	GPDR0 &=3D ~SPITZ_GPIO_G0_STROBE_BIT;
-	GPDR1 &=3D ~SPITZ_GPIO_G1_STROBE_BIT;
-	GPDR2 &=3D ~SPITZ_GPIO_G2_STROBE_BIT;
-	GPDR3 &=3D ~SPITZ_GPIO_G3_STROBE_BIT;
-	GPSR(gpio) =3D GPIO_bit(gpio);
-	GPDR(gpio) |=3D GPIO_bit(gpio);
-}
-
-static inline void spitzkbd_reset_col(int col)
-{
-	int gpio =3D spitz_strobes[col];
-	GPDR0 &=3D ~SPITZ_GPIO_G0_STROBE_BIT;
-	GPDR1 &=3D ~SPITZ_GPIO_G1_STROBE_BIT;
-	GPDR2 &=3D ~SPITZ_GPIO_G2_STROBE_BIT;
-	GPDR3 &=3D ~SPITZ_GPIO_G3_STROBE_BIT;
-	GPCR(gpio) =3D GPIO_bit(gpio);
-	GPDR(gpio) |=3D GPIO_bit(gpio);
-}
-
-static inline int spitzkbd_get_row_status(int col)
-{
-	return ((GPLR0 >> 12) & 0x01) | ((GPLR0 >> 16) & 0x02)
-		| ((GPLR2 >> 25) & 0x04) | ((GPLR1 << 1) & 0x08)
-		| ((GPLR1 >> 0) & 0x10) | ((GPLR1 >> 1) & 0x60);
-}
-
-/*
- * The spitz keyboard only generates interrupts when a key is pressed.
- * When a key is pressed, we enable a timer which then scans the
- * keyboard to detect when the key is released.
- */
-
-/* Scan the hardware keyboard and push any changes up through the
input layer */
-static void spitzkbd_scankeyboard(struct spitzkbd *spitzkbd_data)
-{
-	unsigned int row, col, rowd;
-	unsigned long flags;
-	unsigned int num_pressed, pwrkey =3D ((GPLR(SPITZ_GPIO_ON_KEY) &
GPIO_bit(SPITZ_GPIO_ON_KEY)) !=3D 0);
-
-	if (spitzkbd_data->suspended)
-		return;
-
-	spin_lock_irqsave(&spitzkbd_data->lock, flags);
-
-	num_pressed =3D 0;
-	for (col =3D 0; col < KB_COLS; col++) {
-		/*
-		 * Discharge the output driver capacitatance
-		 * in the keyboard matrix. (Yes it is significant..)
-		 */
-
-		spitzkbd_discharge_all();
-		udelay(KB_DISCHARGE_DELAY);
-
-		spitzkbd_activate_col(col);
-		udelay(KB_ACTIVATE_DELAY);
-
-		rowd =3D spitzkbd_get_row_status(col);
-		for (row =3D 0; row < KB_ROWS; row++) {
-			unsigned int scancode, pressed;
-
-			scancode =3D SCANCODE(row, col);
-			pressed =3D rowd & KB_ROWMASK(row);
-
-			input_report_key(spitzkbd_data->input,
spitzkbd_data->keycode[scancode], pressed);
-
-			if (pressed)
-				num_pressed++;
-		}
-		spitzkbd_reset_col(col);
-	}
-
-	spitzkbd_activate_all();
-
-	input_report_key(spitzkbd_data->input, SPITZ_KEY_SYNC,
(GPLR(SPITZ_GPIO_SYNC) & GPIO_bit(SPITZ_GPIO_SYNC)) !=3D 0 );
-	input_report_key(spitzkbd_data->input, KEY_SUSPEND, pwrkey);
-
-	if (pwrkey && time_after(jiffies, spitzkbd_data->suspend_jiffies +
msecs_to_jiffies(1000))) {
-		input_event(spitzkbd_data->input, EV_PWR, KEY_SUSPEND, 1);
-		spitzkbd_data->suspend_jiffies =3D jiffies;
-	}
-
-	input_sync(spitzkbd_data->input);
-
-	/* if any keys are pressed, enable the timer */
-	if (num_pressed)
-		mod_timer(&spitzkbd_data->timer, jiffies + msecs_to_jiffies(SCAN_INT=
ERVAL));
-
-	spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
-}
-
-/*
- * spitz keyboard interrupt handler.
- */
-static irqreturn_t spitzkbd_interrupt(int irq, void *dev_id)
-{
-	struct spitzkbd *spitzkbd_data =3D dev_id;
-
-	if (!timer_pending(&spitzkbd_data->timer)) {
-		/** wait chattering delay **/
-		udelay(20);
-		spitzkbd_scankeyboard(spitzkbd_data);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * spitz timer checking for released keys
- */
-static void spitzkbd_timer_callback(unsigned long data)
-{
-	struct spitzkbd *spitzkbd_data =3D (struct spitzkbd *) data;
-
-	spitzkbd_scankeyboard(spitzkbd_data);
-}
-
-/*
- * The hinge switches generate an interrupt.
- * We debounce the switches and pass them to the input system.
- */
-
-static irqreturn_t spitzkbd_hinge_isr(int irq, void *dev_id)
-{
-	struct spitzkbd *spitzkbd_data =3D dev_id;
-
-	if (!timer_pending(&spitzkbd_data->htimer))
-		mod_timer(&spitzkbd_data->htimer, jiffies +
msecs_to_jiffies(HINGE_SCAN_INTERVAL));
-
-	return IRQ_HANDLED;
-}
-
-#define HINGE_STABLE_COUNT 2
-static int sharpsl_hinge_state;
-static int hinge_count;
-
-static void spitzkbd_hinge_timer(unsigned long data)
-{
-	struct spitzkbd *spitzkbd_data =3D (struct spitzkbd *) data;
-	unsigned long state;
-	unsigned long flags;
-
-	state =3D GPLR(SPITZ_GPIO_SWA) &
(GPIO_bit(SPITZ_GPIO_SWA)|GPIO_bit(SPITZ_GPIO_SWB));
-	state |=3D (GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT));
-	if (state !=3D sharpsl_hinge_state) {
-		hinge_count =3D 0;
-		sharpsl_hinge_state =3D state;
-	} else if (hinge_count < HINGE_STABLE_COUNT) {
-		hinge_count++;
-	}
-
-	if (hinge_count >=3D HINGE_STABLE_COUNT) {
-		spin_lock_irqsave(&spitzkbd_data->lock, flags);
-
-		input_report_switch(spitzkbd_data->input, SW_LID,
((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) !=3D 0));
-		input_report_switch(spitzkbd_data->input, SW_TABLET_MODE,
((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) !=3D 0));
-		input_report_switch(spitzkbd_data->input, SW_HEADPHONE_INSERT,
((GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT)) !=3D 0));
-		input_sync(spitzkbd_data->input);
-
-		spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
-	} else {
-		mod_timer(&spitzkbd_data->htimer, jiffies +
msecs_to_jiffies(HINGE_SCAN_INTERVAL));
-	}
-}
-
-#ifdef CONFIG_PM
-static int spitzkbd_suspend(struct platform_device *dev, pm_message_t =
state)
-{
-	int i;
-	struct spitzkbd *spitzkbd =3D platform_get_drvdata(dev);
-	spitzkbd->suspended =3D 1;
-
-	/* Set Strobe lines as inputs - *except* strobe line 0 leave this
-	   enabled so we can detect a power button press for resume */
-	for (i =3D 1; i < SPITZ_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(spitz_strobes[i] | GPIO_IN);
-
-	return 0;
-}
-
-static int spitzkbd_resume(struct platform_device *dev)
-{
-	int i;
-	struct spitzkbd *spitzkbd =3D platform_get_drvdata(dev);
-
-	for (i =3D 0; i < SPITZ_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(spitz_strobes[i] | GPIO_OUT | GPIO_DFLT_HIGH);
-
-	/* Upon resume, ignore the suspend key for a short while */
-	spitzkbd->suspend_jiffies =3D jiffies;
-	spitzkbd->suspended =3D 0;
-
-	return 0;
-}
-#else
-#define spitzkbd_suspend	NULL
-#define spitzkbd_resume		NULL
-#endif
-
-static int __devinit spitzkbd_probe(struct platform_device *dev)
-{
-	struct spitzkbd *spitzkbd;
-	struct input_dev *input_dev;
-	int i, err =3D -ENOMEM;
-
-	spitzkbd =3D kzalloc(sizeof(struct spitzkbd), GFP_KERNEL);
-	input_dev =3D input_allocate_device();
-	if (!spitzkbd || !input_dev)
-		goto fail;
-
-	platform_set_drvdata(dev, spitzkbd);
-	strcpy(spitzkbd->phys, "spitzkbd/input0");
-
-	spin_lock_init(&spitzkbd->lock);
-
-	/* Init Keyboard rescan timer */
-	init_timer(&spitzkbd->timer);
-	spitzkbd->timer.function =3D spitzkbd_timer_callback;
-	spitzkbd->timer.data =3D (unsigned long) spitzkbd;
-
-	/* Init Hinge Timer */
-	init_timer(&spitzkbd->htimer);
-	spitzkbd->htimer.function =3D spitzkbd_hinge_timer;
-	spitzkbd->htimer.data =3D (unsigned long) spitzkbd;
-
-	spitzkbd->suspend_jiffies =3D jiffies;
-
-	spitzkbd->input =3D input_dev;
-
-	input_dev->name =3D "Spitz Keyboard";
-	input_dev->phys =3D spitzkbd->phys;
-	input_dev->dev.parent =3D &dev->dev;
-
-	input_dev->id.bustype =3D BUS_HOST;
-	input_dev->id.vendor =3D 0x0001;
-	input_dev->id.product =3D 0x0001;
-	input_dev->id.version =3D 0x0100;
-
-	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
-		BIT_MASK(EV_PWR) | BIT_MASK(EV_SW);
-	input_dev->keycode =3D spitzkbd->keycode;
-	input_dev->keycodesize =3D sizeof(unsigned char);
-	input_dev->keycodemax =3D ARRAY_SIZE(spitzkbd_keycode);
-
-	memcpy(spitzkbd->keycode, spitzkbd_keycode, sizeof(spitzkbd->keycode)=
);
-	for (i =3D 0; i < ARRAY_SIZE(spitzkbd_keycode); i++)
-		set_bit(spitzkbd->keycode[i], input_dev->keybit);
-	clear_bit(0, input_dev->keybit);
-	set_bit(KEY_SUSPEND, input_dev->keybit);
-	set_bit(SW_LID, input_dev->swbit);
-	set_bit(SW_TABLET_MODE, input_dev->swbit);
-	set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
-
-	err =3D input_register_device(input_dev);
-	if (err)
-		goto fail;
-
-	mod_timer(&spitzkbd->htimer, jiffies + msecs_to_jiffies(HINGE_SCAN_IN=
TERVAL));
-
-	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs =
*/
-	for (i =3D 0; i < SPITZ_KEY_SENSE_NUM; i++) {
-		pxa_gpio_mode(spitz_senses[i] | GPIO_IN);
-		if (request_irq(IRQ_GPIO(spitz_senses[i]), spitzkbd_interrupt,
-				IRQF_DISABLED|IRQF_TRIGGER_RISING,
-				"Spitzkbd Sense", spitzkbd))
-			printk(KERN_WARNING "spitzkbd: Can't get Sense IRQ: %d!\n", i);
-	}
-
-	/* Set Strobe lines as outputs - set high */
-	for (i =3D 0; i < SPITZ_KEY_STROBE_NUM; i++)
-		pxa_gpio_mode(spitz_strobes[i] | GPIO_OUT | GPIO_DFLT_HIGH);
-
-	pxa_gpio_mode(SPITZ_GPIO_SYNC | GPIO_IN);
-	pxa_gpio_mode(SPITZ_GPIO_ON_KEY | GPIO_IN);
-	pxa_gpio_mode(SPITZ_GPIO_SWA | GPIO_IN);
-	pxa_gpio_mode(SPITZ_GPIO_SWB | GPIO_IN);
-
-	request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt,
-		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd Sync", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt,
-		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd PwrOn", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr,
-		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd SWA", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
-		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd SWB", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
-		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd HP", spitzkbd);
-
-	return 0;
-
- fail:	input_free_device(input_dev);
-	kfree(spitzkbd);
-	return err;
-}
-
-static int __devexit spitzkbd_remove(struct platform_device *dev)
-{
-	int i;
-	struct spitzkbd *spitzkbd =3D platform_get_drvdata(dev);
-
-	for (i =3D 0; i < SPITZ_KEY_SENSE_NUM; i++)
-		free_irq(IRQ_GPIO(spitz_senses[i]), spitzkbd);
-
-	free_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd);
-	free_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd);
-	free_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd);
-	free_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd);
-	free_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd);
-
-	del_timer_sync(&spitzkbd->htimer);
-	del_timer_sync(&spitzkbd->timer);
-
-	input_unregister_device(spitzkbd->input);
-
-	kfree(spitzkbd);
-
-	return 0;
-}
-
-static struct platform_driver spitzkbd_driver =3D {
-	.probe		=3D spitzkbd_probe,
-	.remove		=3D __devexit_p(spitzkbd_remove),
-	.suspend	=3D spitzkbd_suspend,
-	.resume		=3D spitzkbd_resume,
-	.driver		=3D {
-		.name	=3D "spitz-keyboard",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-static int __init spitzkbd_init(void)
-{
-	return platform_driver_register(&spitzkbd_driver);
-}
-
-static void __exit spitzkbd_exit(void)
-{
-	platform_driver_unregister(&spitzkbd_driver);
-}
-
-module_init(spitzkbd_init);
-module_exit(spitzkbd_exit);
-
-MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
-MODULE_DESCRIPTION("Spitz Keyboard Driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:spitz-keyboard");
diff --git a/drivers/input/keyboard/tosakbd.c b/drivers/input/keyboard/=
tosakbd.c
deleted file mode 100644
index 3910f26..0000000
--- a/drivers/input/keyboard/tosakbd.c
+++ /dev/null
@@ -1,431 +0,0 @@
-/*
- *  Keyboard driver for Sharp Tosa models (SL-6000x)
- *
- *  Copyright (c) 2005 Dirk Opfer
- *  Copyright (c) 2007 Dmitry Baryshkov
- *
- *  Based on xtkbd.c/locomkbd.c/corgikbd.c
- *
- *  This program is free software; you can redistribute it and/or modi=
fy
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#include <mach/gpio.h>
-#include <mach/tosa.h>
-
-#define KB_ROWMASK(r)		(1 << (r))
-#define SCANCODE(r, c)		(((r)<<4) + (c) + 1)
-#define NR_SCANCODES		SCANCODE(TOSA_KEY_SENSE_NUM - 1,
TOSA_KEY_STROBE_NUM - 1) + 1
-
-#define SCAN_INTERVAL		(HZ/10)
-
-#define KB_DISCHARGE_DELAY	10
-#define KB_ACTIVATE_DELAY	10
-
-static unsigned short tosakbd_keycode[NR_SCANCODES] =3D {
-0,
-0, KEY_W, 0, 0, 0, KEY_K, KEY_BACKSPACE, KEY_P,
-0, 0, 0, 0, 0, 0, 0, 0,
-KEY_Q, KEY_E, KEY_T, KEY_Y, 0, KEY_O, KEY_I, KEY_COMMA,
-0, 0, 0, 0, 0, 0, 0, 0,
-KEY_A, KEY_D, KEY_G, KEY_U, 0, KEY_L, KEY_ENTER, KEY_DOT,
-0, 0, 0, 0, 0, 0, 0, 0,
-KEY_Z, KEY_C, KEY_V, KEY_J, TOSA_KEY_ADDRESSBOOK, TOSA_KEY_CANCEL,
TOSA_KEY_CENTER, TOSA_KEY_OK,
-KEY_LEFTSHIFT, 0, 0, 0, 0, 0, 0, 0,
-KEY_S, KEY_R, KEY_B, KEY_N, TOSA_KEY_CALENDAR, TOSA_KEY_HOMEPAGE,
KEY_LEFTCTRL, TOSA_KEY_LIGHT,
-0, KEY_RIGHTSHIFT, 0, 0, 0, 0, 0, 0,
-KEY_TAB, KEY_SLASH, KEY_H, KEY_M, TOSA_KEY_MENU, 0, KEY_UP, 0,
-0, 0, TOSA_KEY_FN, 0, 0, 0, 0, 0,
-KEY_X, KEY_F, KEY_SPACE, KEY_APOSTROPHE, TOSA_KEY_MAIL, KEY_LEFT,
KEY_DOWN, KEY_RIGHT,
-0, 0, 0,
-};
-
-struct tosakbd {
-	unsigned short keycode[ARRAY_SIZE(tosakbd_keycode)];
-	struct input_dev *input;
-	bool suspended;
-	spinlock_t lock; /* protect kbd scanning */
-	struct timer_list timer;
-};
-
-
-/* Helper functions for reading the keyboard matrix
- * Note: We should really be using the generic gpio functions to alter
- *       GPDR but it requires a function call per GPIO bit which is
- *       excessive when we need to access 12 bits at once, multiple ti=
mes.
- * These functions must be called within local_irq_save()/local_irq_re=
store()
- * or similar.
- */
-#define GET_ROWS_STATUS(c)	((GPLR2 & TOSA_GPIO_ALL_SENSE_BIT) >>
TOSA_GPIO_ALL_SENSE_RSHIFT)
-
-static inline void tosakbd_discharge_all(void)
-{
-	/* STROBE All HiZ */
-	GPCR1  =3D TOSA_GPIO_HIGH_STROBE_BIT;
-	GPDR1 &=3D ~TOSA_GPIO_HIGH_STROBE_BIT;
-	GPCR2  =3D TOSA_GPIO_LOW_STROBE_BIT;
-	GPDR2 &=3D ~TOSA_GPIO_LOW_STROBE_BIT;
-}
-
-static inline void tosakbd_activate_all(void)
-{
-	/* STROBE ALL -> High */
-	GPSR1  =3D TOSA_GPIO_HIGH_STROBE_BIT;
-	GPDR1 |=3D TOSA_GPIO_HIGH_STROBE_BIT;
-	GPSR2  =3D TOSA_GPIO_LOW_STROBE_BIT;
-	GPDR2 |=3D TOSA_GPIO_LOW_STROBE_BIT;
-
-	udelay(KB_DISCHARGE_DELAY);
-
-	/* STATE CLEAR */
-	GEDR2 |=3D TOSA_GPIO_ALL_SENSE_BIT;
-}
-
-static inline void tosakbd_activate_col(int col)
-{
-	if (col <=3D 5) {
-		/* STROBE col -> High, not col -> HiZ */
-		GPSR1 =3D TOSA_GPIO_STROBE_BIT(col);
-		GPDR1 =3D (GPDR1 & ~TOSA_GPIO_HIGH_STROBE_BIT) | TOSA_GPIO_STROBE_BI=
T(col);
-	} else {
-		/* STROBE col -> High, not col -> HiZ */
-		GPSR2 =3D TOSA_GPIO_STROBE_BIT(col);
-		GPDR2 =3D (GPDR2 & ~TOSA_GPIO_LOW_STROBE_BIT) | TOSA_GPIO_STROBE_BIT=
(col);
-	}
-}
-
-static inline void tosakbd_reset_col(int col)
-{
-	if (col <=3D 5) {
-		/* STROBE col -> Low */
-		GPCR1 =3D TOSA_GPIO_STROBE_BIT(col);
-		/* STROBE col -> out, not col -> HiZ */
-		GPDR1 =3D (GPDR1 & ~TOSA_GPIO_HIGH_STROBE_BIT) | TOSA_GPIO_STROBE_BI=
T(col);
-	} else {
-		/* STROBE col -> Low */
-		GPCR2 =3D TOSA_GPIO_STROBE_BIT(col);
-		/* STROBE col -> out, not col -> HiZ */
-		GPDR2 =3D (GPDR2 & ~TOSA_GPIO_LOW_STROBE_BIT) | TOSA_GPIO_STROBE_BIT=
(col);
-	}
-}
-/*
- * The tosa keyboard only generates interrupts when a key is pressed.
- * So when a key is pressed, we enable a timer.  This timer scans the
- * keyboard, and this is how we detect when the key is released.
- */
-
-/* Scan the hardware keyboard and push any changes up through the
input layer */
-static void tosakbd_scankeyboard(struct platform_device *dev)
-{
-	struct tosakbd *tosakbd =3D platform_get_drvdata(dev);
-	unsigned int row, col, rowd;
-	unsigned long flags;
-	unsigned int num_pressed =3D 0;
-
-	spin_lock_irqsave(&tosakbd->lock, flags);
-
-	if (tosakbd->suspended)
-		goto out;
-
-	for (col =3D 0; col < TOSA_KEY_STROBE_NUM; col++) {
-		/*
-		 * Discharge the output driver capacitatance
-		 * in the keyboard matrix. (Yes it is significant..)
-		 */
-		tosakbd_discharge_all();
-		udelay(KB_DISCHARGE_DELAY);
-
-		tosakbd_activate_col(col);
-		udelay(KB_ACTIVATE_DELAY);
-
-		rowd =3D GET_ROWS_STATUS(col);
-
-		for (row =3D 0; row < TOSA_KEY_SENSE_NUM; row++) {
-			unsigned int scancode, pressed;
-			scancode =3D SCANCODE(row, col);
-			pressed =3D rowd & KB_ROWMASK(row);
-
-			if (pressed && !tosakbd->keycode[scancode])
-				dev_warn(&dev->dev,
-						"unhandled scancode: 0x%02x\n",
-						scancode);
-
-			input_report_key(tosakbd->input,
-					tosakbd->keycode[scancode],
-					pressed);
-			if (pressed)
-				num_pressed++;
-		}
-
-		tosakbd_reset_col(col);
-	}
-
-	tosakbd_activate_all();
-
-	input_sync(tosakbd->input);
-
-	/* if any keys are pressed, enable the timer */
-	if (num_pressed)
-		mod_timer(&tosakbd->timer, jiffies + SCAN_INTERVAL);
-
- out:
-	spin_unlock_irqrestore(&tosakbd->lock, flags);
-}
-
-/*
- * tosa keyboard interrupt handler.
- */
-static irqreturn_t tosakbd_interrupt(int irq, void *__dev)
-{
-	struct platform_device *dev =3D __dev;
-	struct tosakbd *tosakbd =3D platform_get_drvdata(dev);
-
-	if (!timer_pending(&tosakbd->timer)) {
-		/** wait chattering delay **/
-		udelay(20);
-		tosakbd_scankeyboard(dev);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * tosa timer checking for released keys
- */
-static void tosakbd_timer_callback(unsigned long __dev)
-{
-	struct platform_device *dev =3D (struct platform_device *)__dev;
-
-	tosakbd_scankeyboard(dev);
-}
-
-#ifdef CONFIG_PM
-static int tosakbd_suspend(struct platform_device *dev, pm_message_t s=
tate)
-{
-	struct tosakbd *tosakbd =3D platform_get_drvdata(dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&tosakbd->lock, flags);
-	tosakbd->suspended =3D true;
-	spin_unlock_irqrestore(&tosakbd->lock, flags);
-
-	del_timer_sync(&tosakbd->timer);
-
-	return 0;
-}
-
-static int tosakbd_resume(struct platform_device *dev)
-{
-	struct tosakbd *tosakbd =3D platform_get_drvdata(dev);
-
-	tosakbd->suspended =3D false;
-	tosakbd_scankeyboard(dev);
-
-	return 0;
-}
-#else
-#define tosakbd_suspend		NULL
-#define tosakbd_resume		NULL
-#endif
-
-static int __devinit tosakbd_probe(struct platform_device *pdev) {
-
-	int i;
-	struct tosakbd *tosakbd;
-	struct input_dev *input_dev;
-	int error;
-
-	tosakbd =3D kzalloc(sizeof(struct tosakbd), GFP_KERNEL);
-	if (!tosakbd)
-		return -ENOMEM;
-
-	input_dev =3D input_allocate_device();
-	if (!input_dev) {
-		kfree(tosakbd);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, tosakbd);
-
-	spin_lock_init(&tosakbd->lock);
-
-	/* Init Keyboard rescan timer */
-	init_timer(&tosakbd->timer);
-	tosakbd->timer.function =3D tosakbd_timer_callback;
-	tosakbd->timer.data =3D (unsigned long) pdev;
-
-	tosakbd->input =3D input_dev;
-
-	input_set_drvdata(input_dev, tosakbd);
-	input_dev->name =3D "Tosa Keyboard";
-	input_dev->phys =3D "tosakbd/input0";
-	input_dev->dev.parent =3D &pdev->dev;
-
-	input_dev->id.bustype =3D BUS_HOST;
-	input_dev->id.vendor =3D 0x0001;
-	input_dev->id.product =3D 0x0001;
-	input_dev->id.version =3D 0x0100;
-
-	input_dev->evbit[0] =3D BIT(EV_KEY) | BIT(EV_REP);
-	input_dev->keycode =3D tosakbd->keycode;
-	input_dev->keycodesize =3D sizeof(tosakbd->keycode[0]);
-	input_dev->keycodemax =3D ARRAY_SIZE(tosakbd_keycode);
-
-	memcpy(tosakbd->keycode, tosakbd_keycode, sizeof(tosakbd_keycode));
-
-	for (i =3D 0; i < ARRAY_SIZE(tosakbd_keycode); i++)
-		__set_bit(tosakbd->keycode[i], input_dev->keybit);
-	__clear_bit(KEY_RESERVED, input_dev->keybit);
-
-	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs =
*/
-	for (i =3D 0; i < TOSA_KEY_SENSE_NUM; i++) {
-		int gpio =3D TOSA_GPIO_KEY_SENSE(i);
-		int irq;
-		error =3D gpio_request(gpio, "tosakbd");
-		if (error < 0) {
-			printk(KERN_ERR "tosakbd: failed to request GPIO %d, "
-				" error %d\n", gpio, error);
-			goto fail;
-		}
-
-		error =3D gpio_direction_input(TOSA_GPIO_KEY_SENSE(i));
-		if (error < 0) {
-			printk(KERN_ERR "tosakbd: failed to configure input"
-				" direction for GPIO %d, error %d\n",
-				gpio, error);
-			gpio_free(gpio);
-			goto fail;
-		}
-
-		irq =3D gpio_to_irq(gpio);
-		if (irq < 0) {
-			error =3D irq;
-			printk(KERN_ERR "gpio-keys: Unable to get irq number"
-				" for GPIO %d, error %d\n",
-				gpio, error);
-			gpio_free(gpio);
-			goto fail;
-		}
-
-		error =3D request_irq(irq, tosakbd_interrupt,
-					IRQF_DISABLED | IRQF_TRIGGER_RISING,
-					"tosakbd", pdev);
-
-		if (error) {
-			printk("tosakbd: Can't get IRQ: %d: error %d!\n",
-					irq, error);
-			gpio_free(gpio);
-			goto fail;
-		}
-	}
-
-	/* Set Strobe lines as outputs - set high */
-	for (i =3D 0; i < TOSA_KEY_STROBE_NUM; i++) {
-		int gpio =3D TOSA_GPIO_KEY_STROBE(i);
-		error =3D gpio_request(gpio, "tosakbd");
-		if (error < 0) {
-			printk(KERN_ERR "tosakbd: failed to request GPIO %d, "
-				" error %d\n", gpio, error);
-			goto fail2;
-		}
-
-		error =3D gpio_direction_output(gpio, 1);
-		if (error < 0) {
-			printk(KERN_ERR "tosakbd: failed to configure input"
-				" direction for GPIO %d, error %d\n",
-				gpio, error);
-			gpio_free(gpio);
-			goto fail2;
-		}
-
-	}
-
-	error =3D input_register_device(input_dev);
-	if (error) {
-		printk(KERN_ERR "tosakbd: Unable to register input device, "
-			"error: %d\n", error);
-		goto fail2;
-	}
-
-	printk(KERN_INFO "input: Tosa Keyboard Registered\n");
-
-	return 0;
-
-fail2:
-	while (--i >=3D 0)
-		gpio_free(TOSA_GPIO_KEY_STROBE(i));
-
-	i =3D TOSA_KEY_SENSE_NUM;
-fail:
-	while (--i >=3D 0) {
-		free_irq(gpio_to_irq(TOSA_GPIO_KEY_SENSE(i)), pdev);
-		gpio_free(TOSA_GPIO_KEY_SENSE(i));
-	}
-
-	platform_set_drvdata(pdev, NULL);
-	input_free_device(input_dev);
-	kfree(tosakbd);
-
-	return error;
-}
-
-static int __devexit tosakbd_remove(struct platform_device *dev)
-{
-	int i;
-	struct tosakbd *tosakbd =3D platform_get_drvdata(dev);
-
-	for (i =3D 0; i < TOSA_KEY_STROBE_NUM; i++)
-		gpio_free(TOSA_GPIO_KEY_STROBE(i));
-
-	for (i =3D 0; i < TOSA_KEY_SENSE_NUM; i++) {
-		free_irq(gpio_to_irq(TOSA_GPIO_KEY_SENSE(i)), dev);
-		gpio_free(TOSA_GPIO_KEY_SENSE(i));
-	}
-
-	del_timer_sync(&tosakbd->timer);
-
-	input_unregister_device(tosakbd->input);
-
-	kfree(tosakbd);
-
-	return 0;
-}
-
-static struct platform_driver tosakbd_driver =3D {
-	.probe		=3D tosakbd_probe,
-	.remove		=3D __devexit_p(tosakbd_remove),
-	.suspend	=3D tosakbd_suspend,
-	.resume		=3D tosakbd_resume,
-	.driver		=3D {
-		.name	=3D "tosa-keyboard",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-static int __devinit tosakbd_init(void)
-{
-	return platform_driver_register(&tosakbd_driver);
-}
-
-static void __exit tosakbd_exit(void)
-{
-	platform_driver_unregister(&tosakbd_driver);
-}
-
-module_init(tosakbd_init);
-module_exit(tosakbd_exit);
-
-MODULE_AUTHOR("Dirk Opfer <Dirk@Opfer-Online.de>");
-MODULE_DESCRIPTION("Tosa Keyboard Driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:tosa-keyboard");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
