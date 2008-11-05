From: David Anders <dave123_aml@yahoo.com>
Subject: [PATCH] Add generic EV_LED handler and LED trigger
Date: Wed, 5 Nov 2008 09:54:24 -0800 (PST)
Message-ID: <779405.87509.qm@web54401.mail.yahoo.com>
Reply-To: dave123_aml@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web54401.mail.yahoo.com ([206.190.49.131]:44988 "HELO
	web54401.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753179AbYKESBG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Nov 2008 13:01:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>

this patch is to provide for an initial implementation of a generic EV_LED handler which supports LED triggers in the leds subsystem.

Signed-off-by: David Anders <danders at amltd.com>

diff -urN linux-2.6.27-clean/drivers/input/generic-leds.c linux-2.6.27/drivers/input/generic-leds.c
--- linux-2.6.27-clean/drivers/input/generic-leds.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.27/drivers/input/generic-leds.c	2008-11-05 10:27:06.000000000 -0600
@@ -0,0 +1,116 @@
+/*
+ *  Generic Leds Event
+ *
+ *  Copyright (c) 2008 David Anders
+ *
+ *  Based on the Input Power Event -> APM Bridge
+ *
+ *  Copyright (c) 2007 Richard Purdie
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/leds.h>
+
+static void generic_leds_event(struct input_handle *handle, unsigned int type,
+				unsigned int code, int value)
+{
+	switch (type) {
+	case EV_LED:
+		ledtrig_ev_led_activity(value);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int generic_leds_connect(struct input_handler *handler,
+					  struct input_dev *dev,
+					  const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "generic-leds";
+
+	error = input_register_handle(handle);
+	if (error) {
+		printk(KERN_ERR
+			"generic-leds: Failed to register generic-leds handler,"
+			" error %d\n", error);
+		kfree(handle);
+		return error;
+	}
+
+	error = input_open_device(handle);
+	if (error) {
+		printk(KERN_ERR
+			"generic-leds: Failed to open generic-leds device,"
+			" error %d\n", error);
+		input_unregister_handle(handle);
+		kfree(handle);
+		return error;
+	}
+
+	return 0;
+}
+
+static void generic_leds_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id generic_leds_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_LED) },
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(input, generic_leds_ids);
+
+
+static struct input_handler generic_leds_handler = {
+	.event =	generic_leds_event,
+	.connect =	generic_leds_connect,
+	.disconnect =	generic_leds_disconnect,
+	.name =		"generic-leds",
+	.id_table =	generic_leds_ids,
+};
+
+static int __init generic_leds_init(void)
+{
+	return input_register_handler(&generic_leds_handler);
+}
+
+static void __exit generic_leds_exit(void)
+{
+	input_unregister_handler(&generic_leds_handler);
+}
+
+module_init(generic_leds_init);
+module_exit(generic_leds_exit);
+
+MODULE_AUTHOR("David Anders <danders@amltd.com>");
+MODULE_DESCRIPTION("Generic Led Events");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.27-clean/drivers/input/Kconfig linux-2.6.27/drivers/input/Kconfig
--- linux-2.6.27-clean/drivers/input/Kconfig	2008-11-05 08:26:48.000000000 -0600
+++ linux-2.6.27/drivers/input/Kconfig	2008-11-05 11:24:57.000000000 -0600
@@ -52,6 +52,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called input-polldev.
 
+config INPUT_GENERICLEDS
+	tristate "Generic LED Handler"
+	depends on INPUT
+	---help---
+	  Say Y here if you want LED events to be passed to the
+	  leds subsystem as a trigger. This is useful on embedded
+	  systems where such behviour is desired without userspace
+	  interaction. If unsure, say N.
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
diff -urN linux-2.6.27-clean/drivers/input/Makefile linux-2.6.27/drivers/input/Makefile
--- linux-2.6.27-clean/drivers/input/Makefile	2008-11-05 08:26:49.000000000 -0600
+++ linux-2.6.27/drivers/input/Makefile	2008-11-05 10:17:00.000000000 -0600
@@ -9,6 +9,7 @@
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_POLLDEV)	+= input-polldev.o
+obj-$(CONFIG_INPUT_GENERICLEDS)	+= generic-leds.o
 
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
diff -urN linux-2.6.27-clean/drivers/leds/Kconfig linux-2.6.27/drivers/leds/Kconfig
--- linux-2.6.27-clean/drivers/leds/Kconfig	2008-11-05 08:27:05.000000000 -0600
+++ linux-2.6.27/drivers/leds/Kconfig	2008-11-05 11:14:02.000000000 -0600
@@ -172,6 +172,13 @@
 	  These triggers allow kernel events to drive the LEDs and can
 	  be configured via sysfs. If unsure, say Y.
 
+config LEDS_TRIGGER_EV_LED
+	tristate "EV_LED Input Trigger"
+	depends on LEDS_TRIGGERS
+	help
+	  This allows LEDs to be controlled by the use of the EV_LED
+	  events from the input system.
+
 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
 	depends on LEDS_TRIGGERS
diff -urN linux-2.6.27-clean/drivers/leds/ledtrig-ev-led.c linux-2.6.27/drivers/leds/ledtrig-ev-led.c
--- linux-2.6.27-clean/drivers/leds/ledtrig-ev-led.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.27/drivers/leds/ledtrig-ev-led.c	2008-11-05 11:27:32.000000000 -0600
@@ -0,0 +1,55 @@
+/*
+ * EV_LED event LED Trigger
+ *
+ * Copyright 2008 David Anders
+ *
+ * Author: David Anders <danders@amltd.com>
+ *
+ * Based on the LED IDE-Disk Activity Trigger - ledtrig-ide-disk.c
+ *
+ * Copyright 2006 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
+
+DEFINE_LED_TRIGGER(ledtrig_ev_led);
+
+void ledtrig_ev_led_activity(int value)
+{
+	if (!value)
+		led_trigger_event(ledtrig_ev_led, LED_FULL);
+	else
+		led_trigger_event(ledtrig_ev_led, LED_OFF);
+
+}
+EXPORT_SYMBOL(ledtrig_ev_led_activity);
+
+static int __init ledtrig_ev_led_init(void)
+{
+	led_trigger_register_simple("ev-led", &ledtrig_ev_led);
+	return 0;
+}
+
+static void __exit ledtrig_ev_led_exit(void)
+{
+	led_trigger_unregister_simple(ledtrig_ev_led);
+}
+
+module_init(ledtrig_ev_led_init);
+module_exit(ledtrig_ev_led_exit);
+
+MODULE_AUTHOR("David Anders <danders@amltd.com");
+MODULE_DESCRIPTION("EV_LED Input LED Trigger");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.27-clean/drivers/leds/Makefile linux-2.6.27/drivers/leds/Makefile
--- linux-2.6.27-clean/drivers/leds/Makefile	2008-11-05 08:27:05.000000000 -0600
+++ linux-2.6.27/drivers/leds/Makefile	2008-11-05 11:12:17.000000000 -0600
@@ -25,6 +25,7 @@
 obj-$(CONFIG_LEDS_PCA955X)		+= leds-pca955x.o
 
 # LED Triggers
+obj-$(CONFIG_LEDS_TRIGGER_EV_LED)	+= ledtrig-ev-led.o
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
 obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o
 obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+= ledtrig-heartbeat.o
diff -urN linux-2.6.27-clean/include/linux/leds.h linux-2.6.27/include/linux/leds.h
--- linux-2.6.27-clean/include/linux/leds.h	2008-11-05 08:26:39.000000000 -0600
+++ linux-2.6.27/include/linux/leds.h	2008-11-05 11:05:54.000000000 -0600
@@ -118,6 +118,12 @@
 #define ledtrig_ide_activity() do {} while(0)
 #endif
 
+#ifdef CONFIG_LEDS_TRIGGER_EV_LED
+extern void ledtrig_ev_led_activity(void);
+#else
+#define ledtrig_ev_led_activity() do {} while (0)
+#endif
+
 /*
  * Generic LED platform data for describing LED names and default triggers.
  */


      
