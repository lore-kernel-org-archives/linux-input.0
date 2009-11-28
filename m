From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Date: Sat, 28 Nov 2009 21:44:41 +0800
Message-ID: <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42381 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbZK1Nou (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 08:44:50 -0500
Received: by pwi3 with SMTP id 3so1415798pwi.21
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 05:44:56 -0800 (PST)
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, linux-input@vger.kernel.org, Wu Zhangjin <wuzhangjin@gmail.com>

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Hotkey Driver, which will do relative actions for The
hotkey event and report the corresponding input keys to the user-space
applications.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/setup.c                           |    1 +
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   12 +
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../loongson/lemote-2f/yeeloong_laptop/hotkey.c    |  468 ++++++++++++++++++++
 4 files changed, 482 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hotkey.c

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bd55f71..b1e1272 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -60,6 +60,7 @@ struct boot_mem_map boot_mem_map;
 
 static char command_line[COMMAND_LINE_SIZE];
        char arcs_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+EXPORT_SYMBOL(arcs_cmdline);
 
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 49d63c5..ec3b28b 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -54,4 +54,16 @@ config YEELOONG_SUSPEND
 	  This option adds Suspend Driver, which will suspend the YeeLoong
 	  Platform specific devices.
 
+config YEELOONG_HOTKEY
+	tristate "Hotkey Driver"
+	depends on YEELOONG_VO
+	select INPUT
+	select INPUT_EVDEV
+	select SUSPEND
+	default y
+	help
+	  This option adds Hotkey Driver, which will do relative actions for
+	  The hotkey event and report the corresponding input keys to the
+	  user-space applications.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index cfe736f..6aad103 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_YEELOONG_BATTERY) += battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += hwmon.o
 obj-$(CONFIG_YEELOONG_VO) += video_output.o
 obj-$(CONFIG_YEELOONG_SUSPEND) += suspend.o
+obj-$(CONFIG_YEELOONG_HOTKEY) += hotkey.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/hotkey.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/hotkey.c
new file mode 100644
index 0000000..8e30e58
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/hotkey.c
@@ -0,0 +1,468 @@
+/*
+ * YeeLoong Hotkey Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *          Liu Junliang <liujl@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/bootinfo.h>	/* for arcs_cmdline */
+
+#include <cs5536/cs5536.h>
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>; Liu Junliang <liujl@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop hotkey driver");
+MODULE_LICENSE("GPL");
+
+static struct input_dev *yeeloong_hotkey_dev;
+static int event, status;
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	int event;		/* event from SCI */
+	u16 keycode;		/* KEY_* or SW_* */
+};
+
+enum { KE_KEY, KE_SW, KE_END };
+
+static struct key_entry yeeloong_keymap[] = {
+	{KE_SW, EVENT_LID, SW_LID},
+	{KE_KEY, EVENT_CAMERA, KEY_CAMERA},	/* Fn + ESC */
+	{KE_KEY, EVENT_SLEEP, KEY_SLEEP},	/* Fn + F1 */
+	{KE_KEY, EVENT_DISPLAY_TOGGLE, KEY_SWITCHVIDEOMODE},	/* Fn + F3 */
+	{KE_KEY, EVENT_AUDIO_MUTE, KEY_MUTE},	/* Fn + F4 */
+	{KE_KEY, EVENT_WLAN, KEY_WLAN},	/* Fn + F5 */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSUP},	/* Fn + up */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSDOWN},	/* Fn + down */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEUP},	/* Fn + right */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEDOWN},	/* Fn + left */
+	{KE_END, 0}
+};
+
+static int get_event_keycode(void)
+{
+	struct key_entry *key;
+
+	for (key = yeeloong_keymap; key->type != KE_END; key++) {
+		if (key->event != event)
+			continue;
+		else {
+			if (EVENT_DISPLAY_BRIGHTNESS == event) {
+				static int old_brightness_status = -1;
+				/* current status > old one, means up */
+				if ((status < old_brightness_status)
+				    || (0 == status))
+					key++;
+				old_brightness_status = status;
+			} else if (EVENT_AUDIO_VOLUME == event) {
+				static int old_volume_status = -1;
+				if ((status < old_volume_status)
+				    || (0 == status))
+					key++;
+				old_volume_status = status;
+			}
+			break;
+		}
+	}
+	return key->keycode;
+}
+
+static int report_lid_switch(int status)
+{
+	input_report_switch(yeeloong_hotkey_dev, SW_LID, !status);
+	input_sync(yeeloong_hotkey_dev);
+
+	return status;
+}
+
+void report_key(void)
+{
+	int keycode;
+
+	keycode = get_event_keycode();
+
+	if (keycode == SW_LID)
+		report_lid_switch(status);
+	else {
+		input_report_key(yeeloong_hotkey_dev, keycode, 1);
+		input_sync(yeeloong_hotkey_dev);
+		input_report_key(yeeloong_hotkey_dev, keycode, 0);
+		input_sync(yeeloong_hotkey_dev);
+	}
+}
+
+enum { NO_REG, MUL_REG, REG_END };
+
+static int event_reg[15] = {
+	REG_LID_DETECT,		/*  LID open/close */
+	NO_REG,			/*  Fn+F3 for display switch */
+	NO_REG,			/*  Fn+F1 for entering sleep mode */
+	MUL_REG,		/*  Over-temperature happened */
+	REG_CRT_DETECT,		/*  CRT is connected */
+	REG_CAMERA_STATUS,	/*  Camera on/off */
+	REG_USB2_FLAG,		/*  USB2 Over Current occurred */
+	REG_USB0_FLAG,		/*  USB0 Over Current occurred */
+	REG_DISPLAY_LCD,	/*  Black screen on/off */
+	REG_AUDIO_MUTE,		/*  Mute on/off */
+	REG_DISPLAY_BRIGHTNESS,	/*  LCD backlight brightness adjust */
+	NO_REG,			/*  AC & Battery relative issue */
+	REG_AUDIO_VOLUME,	/*  Volume adjust */
+	REG_WLAN,		/*  Wlan on/off */
+	REG_END
+};
+
+static int ec_get_event_status(void)
+{
+	int reg;
+
+	reg = event_reg[event - EVENT_LID];
+
+	if (reg == NO_REG || reg == MUL_REG)
+		return 1;
+	else if (reg != REG_END)
+		return ec_read(reg);
+
+	return -1;
+}
+
+static int crt_detect_handler(int status)
+{
+	if (status == BIT_CRT_DETECT_PLUG) {
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	} else {
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	}
+	return status;
+}
+
+#define EC_VER_LEN 64
+
+static int black_screen_handler(int status)
+{
+	char *p, ec_ver[EC_VER_LEN];
+
+	p = strstr(arcs_cmdline, "EC_VER=");
+	if (!p)
+		memset(ec_ver, 0, EC_VER_LEN);
+	else {
+		strncpy(ec_ver, p, EC_VER_LEN);
+		p = strstr(ec_ver, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume to the normal level! */
+	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
+		lcd_vo_set(status);
+
+	return status;
+}
+
+static int display_toggle_handler(int status)
+{
+	static int video_output_status;
+
+	/* Only enable switch video output button
+	 * when CRT is connected */
+	if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_UNPLUG)
+		return 0;
+	/* 0. no CRT connected: LCD on, CRT off
+	 * 1. BOTH on
+	 * 2. LCD off, CRT on
+	 * 3. BOTH off
+	 * 4. LCD on, CRT off
+	 */
+	video_output_status++;
+	if (video_output_status > 4)
+		video_output_status = 1;
+
+	switch (video_output_status) {
+	case 1:
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 2:
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 3:
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	case 4:
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	default:
+		/* Ensure LCD is on */
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		break;
+	}
+	return video_output_status;
+}
+
+static int camera_handler(int status)
+{
+	int value;
+	static int camera_status;
+
+	status = !!status;
+	camera_status = ec_read(REG_CAMERA_STATUS);
+	if (status != camera_status) {
+		value = ec_read(REG_CAMERA_CONTROL);
+		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
+	}
+	return ec_read(REG_CAMERA_STATUS);
+}
+
+static int usb2_handler(int status)
+{
+	pr_emerg("USB2 Over Current occurred\n");
+
+	return status;
+}
+
+static int usb0_handler(int status)
+{
+	pr_emerg("USB0 Over Current occurred\n");
+
+	return status;
+}
+
+/* yeeloong_wifi_handler may be implemented in the wifi driver */
+sci_handler yeeloong_wifi_handler;
+EXPORT_SYMBOL(yeeloong_wifi_handler);
+
+static void do_event_action(void)
+{
+	sci_handler handler;
+
+	handler = NULL;
+
+	switch (event) {
+	case EVENT_DISPLAY_TOGGLE:
+		handler = display_toggle_handler;
+		break;
+	case EVENT_CRT_DETECT:
+		handler = crt_detect_handler;
+		break;
+	case EVENT_CAMERA:
+		handler = camera_handler;
+		break;
+	case EVENT_USB_OC2:
+		handler = usb2_handler;
+		break;
+	case EVENT_USB_OC0:
+		handler = usb0_handler;
+		break;
+	case EVENT_BLACK_SCREEN:
+		handler = black_screen_handler;
+		break;
+	case EVENT_WLAN:
+		/*
+		 * Use the key as a switch button, not care about the real
+		 * status
+		 */
+		status = 2;
+		handler = yeeloong_wifi_handler;
+		break;
+	default:
+		break;
+	}
+
+	if (handler)
+		status = handler(status);
+}
+
+/*
+ * SCI(system control interrupt) main interrupt routine
+ *
+ * We will do the query and get event number together so the interrupt routine
+ * should be longer than 120us now at least 3ms elpase for it.
+ */
+static irqreturn_t sci_irq_handler(int irq, void *dev_id)
+{
+	int ret;
+
+	if (SCI_IRQ_NUM != irq)
+		return IRQ_NONE;
+
+	/* Query the event number */
+	ret = ec_query_event_num();
+	if (ret < 0)
+		return IRQ_NONE;
+
+	event = ec_get_event_num();
+	if (event < 0)
+		return IRQ_NONE;
+
+	if ((event != 0x00) && (event != 0xff)) {
+		/* Get status of current event */
+		status = ec_get_event_status();
+		pr_info("%s: event: %d, status: %d\n", __func__, event, status);
+		if (status == -1)
+			return IRQ_NONE;
+		/* Execute corresponding actions */
+		do_event_action();
+		/* Report current key */
+		report_key();
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Config and init some msr and gpio register properly.
+ */
+static int sci_irq_init(void)
+{
+	u32 hi, lo;
+	u32 gpio_base;
+	unsigned long flags;
+	int ret;
+
+	/* Get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* Filter the former kb3310 interrupt for security */
+	ret = ec_query_event_num();
+	if (ret)
+		return ret;
+
+	/* For filtering next number interrupt */
+	udelay(10000);
+
+	/* Set gpio native registers and msrs for GPIO27 SCI EVENT PIN
+	 * gpio :
+	 *      input, pull-up, no-invert, event-count and value 0,
+	 *      no-filter, no edge mode
+	 *      gpio27 map to Virtual gpio0
+	 * msr :
+	 *      no primary and lpc
+	 *      Unrestricted Z input to IG10 from Virtual gpio 0.
+	 */
+	local_irq_save(flags);
+	_rdmsr(0x80000024, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000024, hi, lo);
+	_rdmsr(0x80000025, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000025, hi, lo);
+	_rdmsr(0x80000023, &hi, &lo);
+	lo |= (0x0a << 0);
+	_wrmsr(0x80000023, hi, lo);
+	local_irq_restore(flags);
+
+	/* Set gpio27 as sci interrupt
+	 *
+	 * input, pull-up, no-fliter, no-negedge, invert
+	 * the sci event is just about 120us
+	 */
+	asm(".set noreorder\n");
+	/*  input enable */
+	outl(0x00000800, (gpio_base | 0xA0));
+	/*  revert the input */
+	outl(0x00000800, (gpio_base | 0xA4));
+	/*  event-int enable */
+	outl(0x00000800, (gpio_base | 0xB8));
+	asm(".set reorder\n");
+
+	return 0;
+}
+
+static struct irqaction sci_irqaction = {
+	.handler = sci_irq_handler,
+	.name = "sci",
+	.flags = IRQF_SHARED,
+};
+
+static int __init yeeloong_hotkey_init(void)
+{
+	int ret;
+	struct key_entry *key;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	ret = sci_irq_init();
+	if (ret)
+		return -EFAULT;
+
+	ret = setup_irq(SCI_IRQ_NUM, &sci_irqaction);
+	if (ret)
+		return -EFAULT;
+
+	yeeloong_hotkey_dev = input_allocate_device();
+
+	if (!yeeloong_hotkey_dev) {
+		remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+		return -ENOMEM;
+	}
+
+	yeeloong_hotkey_dev->name = "HotKeys";
+	yeeloong_hotkey_dev->phys = "button/input0";
+	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
+	yeeloong_hotkey_dev->dev.parent = NULL;
+
+	for (key = yeeloong_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, yeeloong_hotkey_dev->evbit);
+			set_bit(key->keycode, yeeloong_hotkey_dev->keybit);
+			break;
+		case KE_SW:
+			set_bit(EV_SW, yeeloong_hotkey_dev->evbit);
+			set_bit(key->keycode, yeeloong_hotkey_dev->swbit);
+			break;
+		}
+	}
+
+	ret = input_register_device(yeeloong_hotkey_dev);
+	if (ret) {
+		input_free_device(yeeloong_hotkey_dev);
+		return ret;
+	}
+
+	if (ret) {
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+	/* Update the current status of LID */
+	report_lid_switch(BIT_LID_DETECT_ON);
+
+	/* Install the real yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = report_lid_switch;
+
+	return 0;
+}
+
+static void __exit yeeloong_hotkey_exit(void)
+{
+	/* Free irq */
+	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+
+	/* Uninstall yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = NULL;
+
+	if (yeeloong_hotkey_dev) {
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+}
+
+module_init(yeeloong_hotkey_init);
+module_exit(yeeloong_hotkey_exit);
-- 
1.6.2.1

