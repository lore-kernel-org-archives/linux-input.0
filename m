From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] hid: force feedback support for Logitech Rumblepad 2
Date: Mon, 31 Mar 2008 22:42:46 +0300
Message-ID: <47F13EB6.2090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:61329 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139AbYCaTmv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2008 15:42:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Add force feedback support for Logitech Rumblepad 2.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
Tested-By: Edgar Simo <bobbens@gmail.com>

---

Index: linux-2.6.24-hid-rumble/drivers/hid/usbhid/Kconfig
===================================================================
--- linux-2.6.24-hid-rumble/drivers/hid/usbhid/Kconfig
+++ linux-2.6.24-hid-rumble/drivers/hid/usbhid/Kconfig	2008-03-21 12:38:05.000000000 +0200
@@ -70,6 +70,14 @@
 	  Note: if you say N here, this device will still be supported, but without
 	  force feedback.
 
+config LOGIRUMBLEPAD2_FF
+	bool "Logitech Rumblepad 2 support"
+	depends on HID_FF
+	select INPUT_FF_MEMLESS if USB_HID
+	help
+	  Say Y here if you want to enable force feedback support for Logitech
+	  Rumblepad 2 devices.
+
 config PANTHERLORD_FF
 	bool "PantherLord/GreenAsia based device support"
 	depends on HID_FF
Index: linux-2.6.24-hid-rumble/drivers/hid/usbhid/Makefile
===================================================================
--- linux-2.6.24-hid-rumble/drivers/hid/usbhid/Makefile
+++ linux-2.6.24-hid-rumble/drivers/hid/usbhid/Makefile	2008-03-21 12:47:21.000000000 +0200
@@ -16,6 +16,9 @@
 ifeq ($(CONFIG_LOGITECH_FF),y)
 	usbhid-objs	+= hid-lgff.o
 endif
+ifeq ($(CONFIG_LOGIRUMBLEPAD2_FF),y)
+	usbhid-objs	+= hid-lg2ff.o
+endif
 ifeq ($(CONFIG_PANTHERLORD_FF),y)
 	usbhid-objs	+= hid-plff.o
 endif
Index: linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-ff.c
===================================================================
--- linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-ff.c
+++ linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-ff.c	2008-03-21 12:24:40.000000000 +0200
@@ -59,6 +59,9 @@
 	{ 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */
 	{ 0x46d, 0xca03, hid_lgff_init }, /* Logitech MOMO force wheel */
 #endif
+#ifdef CONFIG_LOGIRUMBLEPAD2_FF
+	{ 0x46d, 0xc218, hid_lg2ff_init }, /* Logitech Rumblepad 2 */
+#endif
 #ifdef CONFIG_PANTHERLORD_FF
 	{ 0x810, 0x0001, hid_plff_init }, /* "Twin USB Joystick" */
 	{ 0xe8f, 0x0003, hid_plff_init }, /* "GreenAsia Inc.    USB Joystick     " */
Index: linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-lg2ff.c
===================================================================
--- linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-lg2ff.c
+++ linux-2.6.24-hid-rumble/drivers/hid/usbhid/hid-lg2ff.c	2008-03-31 22:33:19.000000000 +0300
@@ -0,0 +1,114 @@
+/*
+ *  Force feedback support for Logitech Rumblepad 2
+ *
+ *  Copyright (c) 2008 Anssi Hannula <anssi.hannula@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include "usbhid.h"
+
+struct lg2ff_device {
+	struct hid_report *report;
+};
+
+static int play_effect(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct lg2ff_device *lg2ff = data;
+	int weak, strong;
+
+	strong = effect->u.rumble.strong_magnitude;
+	weak = effect->u.rumble.weak_magnitude;
+
+	if (weak || strong) {
+		weak = weak * 0xff / 0xffff;
+		strong = strong * 0xff / 0xffff;
+
+		lg2ff->report->field[0]->value[0] = 0x51;
+		lg2ff->report->field[0]->value[2] = weak;
+		lg2ff->report->field[0]->value[4] = strong;
+	} else {
+		lg2ff->report->field[0]->value[0] = 0xf3;
+		lg2ff->report->field[0]->value[2] = 0x00;
+		lg2ff->report->field[0]->value[4] = 0x00;
+	}
+
+	usbhid_submit_report(hid, lg2ff->report, USB_DIR_OUT);
+	return 0;
+}
+
+int hid_lg2ff_init(struct hid_device *hid)
+{
+	struct lg2ff_device *lg2ff;
+	struct hid_report *report;
+	struct hid_input *hidinput = list_entry(hid->inputs.next,
+						struct hid_input, list);
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev = hidinput->input;
+	int error;
+
+	if (list_empty(report_list)) {
+		printk(KERN_ERR "hid-lg2ff: no output report found\n");
+		return -ENODEV;
+	}
+
+	report = list_entry(report_list->next, struct hid_report, list);
+
+	if (report->maxfield < 1) {
+		printk(KERN_ERR "hid-lg2ff: output report is empty\n");
+		return -ENODEV;
+	}
+	if (report->field[0]->report_count < 7) {
+		printk(KERN_ERR "hid-lg2ff: not enough values in the field\n");
+		return -ENODEV;
+	}
+
+	lg2ff = kmalloc(sizeof(struct lg2ff_device), GFP_KERNEL);
+	if (!lg2ff)
+		return -ENOMEM;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	error = input_ff_create_memless(dev, lg2ff, play_effect);
+	if (error) {
+		kfree(lg2ff);
+		return error;
+	}
+
+	lg2ff->report = report;
+	report->field[0]->value[0] = 0xf3;
+	report->field[0]->value[1] = 0x00;
+	report->field[0]->value[2] = 0x00;
+	report->field[0]->value[3] = 0x00;
+	report->field[0]->value[4] = 0x00;
+	report->field[0]->value[5] = 0x00;
+	report->field[0]->value[6] = 0x00;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+
+	printk(KERN_INFO "Force feedback for Logitech Rumblepad 2 by "
+	       "Anssi Hannula <anssi.hannula@gmail.com>\n");
+
+	return 0;
+}
Index: linux-2.6.24-hid-rumble/include/linux/hid.h
===================================================================
--- linux-2.6.24-hid-rumble/include/linux/hid.h
+++ linux-2.6.24-hid-rumble/include/linux/hid.h	2008-03-21 12:32:32.000000000 +0200
@@ -536,6 +536,7 @@
 int hid_ff_init(struct hid_device *hid);
 
 int hid_lgff_init(struct hid_device *hid);
+int hid_lg2ff_init(struct hid_device *hid);
 int hid_plff_init(struct hid_device *hid);
 int hid_tmff_init(struct hid_device *hid);
 int hid_zpff_init(struct hid_device *hid);



-- 
Anssi Hannula

