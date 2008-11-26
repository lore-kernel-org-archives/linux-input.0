From: =?utf-8?q?=C5=81ukasz_Luboja=C5=84ski?= <lukasz@lubojanski.info>
Subject: New Force Feedback device support - GreenAsia 0x12
Date: Wed, 26 Nov 2008 23:33:44 +0100
Message-ID: <200811262333.45245.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J7cLJ45jOh8b4rc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:26247 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYKZWd5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2008 17:33:57 -0500
Received: by ik-out-1112.google.com with SMTP id c29so606371ika.5
        for <linux-input@vger.kernel.org>; Wed, 26 Nov 2008 14:33:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--Boundary-00=_J7cLJ45jOh8b4rc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi..

I have implemented Force Feedback driver for another "GreeAsia" based device
(0e8f:0012 "GreenAsia Inc. =C2=A0 =C2=A0USB Joystick =C2=A0 =C2=A0 ").
The functionality was tested with MANTA Warior MM816 and SpeedLink Strike2
SL-6635 and fftest software - everything seems to work right.

Is there anyone able to check the code say if this good enough to include it
into official kernel ?

If there are any suggestion what I should additionally check or what I
should change before posting it please let me know.

ps. I hope the attachement will be visible :D

Thanx
Lukasz Lubojanski


--Boundary-00=_J7cLJ45jOh8b4rc
Content-Type: text/x-patch;
  charset="utf-8";
  name="greenasia.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="greenasia.diff"

Index: include/linux/hid.h
===================================================================
--- include/linux/hid.h	(wersja 1)
+++ include/linux/hid.h	(kopia robocza)
@@ -547,6 +547,7 @@
 int hid_lgff_init(struct hid_device *hid);
 int hid_lg2ff_init(struct hid_device *hid);
 int hid_plff_init(struct hid_device *hid);
+int hid_gaff_init(struct hid_device *hid);
 int hid_tmff_init(struct hid_device *hid);
 int hid_zpff_init(struct hid_device *hid);
 #ifdef CONFIG_HID_PID
Index: drivers/hid/usbhid/Kconfig
===================================================================
--- drivers/hid/usbhid/Kconfig	(wersja 1)
+++ drivers/hid/usbhid/Kconfig	(kopia robocza)
@@ -87,6 +87,15 @@
 	  Say Y here if you have a PantherLord/GreenAsia based game controller
 	  or adapter and want to enable force feedback support for it.
 
+config GREENASIA_FF
+	bool "GreenAsia (Product ID 0x12) based device support"
+	depends on HID_FF
+	select INPUT_FF_MEMLESS if USB_HID
+	help
+	  Say Y here if you have a GreenAsia (Product ID 0x12) based game controller
+	  or adapter and want to enable force feedback support for it.
+	  It was tested with MANTA Warior MM816 and SpeedLink Strike2 SL-6635.
+
 config THRUSTMASTER_FF
 	bool "ThrustMaster devices support"
 	depends on HID_FF
Index: drivers/hid/usbhid/hid-gaff.c
===================================================================
--- drivers/hid/usbhid/hid-gaff.c	(wersja 0)
+++ drivers/hid/usbhid/hid-gaff.c	(wersja 3)
@@ -0,0 +1,198 @@
+/*
+ *  Force feedback support for GreenAsia (Product ID 0x12) based devices
+ *
+ *  The devices are distributed under various names and the same USB device ID
+ *  can be used in many game controllers.
+ *
+ *
+ *  0e8f:0012 "GreenAsia Inc.    USB Joystick     "
+ *   - tested with MANTA Warior MM816 and SpeedLink Strike2 SL-6635.
+ *
+ *  Copyright (c) 2008 Lukasz Lubojanski <lukasz@lubojanski.info>
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
+/* #define DEBUG */
+
+#define debug(format, arg...) pr_debug("hid-gaff: " format "\n" , ## arg)
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include "usbhid.h"
+
+struct gaff_device {
+	struct hid_report *report;
+};
+
+static int hid_gaff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct gaff_device *gaff = data;
+	int left, right;
+	
+	switch (effect->type) {
+    	    case FF_CONSTANT:
+	    
+        	left = effect->u.ramp.start_level;
+	        right = effect->u.ramp.end_level ;
+	    	debug("called with %d %d", left, right);
+		
+		if ( left )
+		{
+		    if ( left < 0 )
+			left = abs(left) * 0xfe / 0x80;
+		    else
+		    	left = left * 0xfe / 0x7f;
+		}
+		
+		if (right )
+		{
+		    if (right < 0 )
+			right = abs(right) * 0xfe / 0x80;
+		    else
+			right = right * 0xfe / 0x7f;
+		}
+
+				
+		gaff->report->field[0]->value[0] = 0x51;
+		gaff->report->field[0]->value[1] = 0x0;
+		gaff->report->field[0]->value[2] = right;
+		gaff->report->field[0]->value[3] = 0;
+		gaff->report->field[0]->value[4] = left;
+		gaff->report->field[0]->value[5] = 0;
+		debug("running with 0x%02x 0x%02x", left, right);
+
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+	
+		gaff->report->field[0]->value[0] = 0xfa;
+		gaff->report->field[0]->value[1] = 0xfe;
+		gaff->report->field[0]->value[2] = 0x0;
+	    	gaff->report->field[0]->value[4] = 0x0;
+	
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+
+		
+	    break;
+	    
+	    case FF_RUMBLE:
+	
+																																				
+
+		left = effect->u.rumble.strong_magnitude;
+		right = effect->u.rumble.weak_magnitude;
+
+		debug("called with 0x%04x 0x%04x", left, right);
+
+		left = left * 0xfe / 0xffff;
+	    	right = right * 0xfe / 0xffff;
+	
+		gaff->report->field[0]->value[0] = 0x51;
+		gaff->report->field[0]->value[1] = 0x0;
+		gaff->report->field[0]->value[2] = right;
+		gaff->report->field[0]->value[3] = 0;
+		gaff->report->field[0]->value[4] = left;
+		gaff->report->field[0]->value[5] = 0;
+		debug("running with 0x%02x 0x%02x", left, right);
+
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+	
+		gaff->report->field[0]->value[0] = 0xfa;
+		gaff->report->field[0]->value[1] = 0xfe;
+		gaff->report->field[0]->value[2] = 0x0;
+	    	gaff->report->field[0]->value[4] = 0x0;
+	
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+	
+		break;
+	};
+
+	return 0;
+}
+
+int hid_gaff_init(struct hid_device *hid)
+{
+	struct gaff_device *gaff;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct list_head *report_ptr = report_list;
+	struct input_dev *dev;
+	int error;
+
+	if (list_empty(report_list)) {
+		printk(KERN_ERR "hid-gaff: no output reports found\n");
+		return -ENODEV;
+	}
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+
+		report_ptr = report_ptr->next;
+
+		if (report_ptr == report_list) {
+			printk(KERN_ERR "hid-gaff: required output report is missing\n");
+			return -ENODEV;
+		}
+
+		report = list_entry(report_ptr, struct hid_report, list);
+		if (report->maxfield < 1) {
+			printk(KERN_ERR "hid-gaff: no fields in the report\n");
+			return -ENODEV;
+		}
+
+		if (report->field[0]->report_count < 4) {
+			printk(KERN_ERR "hid-gaff: not enough values in the field\n");
+			return -ENODEV;
+		}
+
+		gaff = kzalloc(sizeof(struct gaff_device), GFP_KERNEL);
+		if (!gaff)
+			return -ENOMEM;
+
+		dev = hidinput->input;
+
+		set_bit(FF_CONSTANT, dev->ffbit);
+		set_bit(FF_RUMBLE, dev->ffbit);
+
+		error = input_ff_create_memless(dev, gaff, hid_gaff_play);
+		if (error) {
+			kfree(gaff);
+			return error;
+		}
+
+		gaff->report = report;
+		gaff->report->field[0]->value[0] = 0x51;
+		gaff->report->field[0]->value[1] = 0x00;
+		gaff->report->field[0]->value[2] = 0x00;
+		gaff->report->field[0]->value[3] = 0x00;
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+		
+		gaff->report->field[0]->value[0] = 0xfa;
+		gaff->report->field[0]->value[1] = 0xfe;
+		usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
+
+	}
+
+	printk(KERN_INFO "hid-gaff: Force feedback for GreenAsia gamepads"
+	       "devices by Lukasz Lubojanski <lukasz@lubojanski.info>\n");
+
+	return 0;
+}
Index: drivers/hid/usbhid/Makefile
===================================================================
--- drivers/hid/usbhid/Makefile	(wersja 1)
+++ drivers/hid/usbhid/Makefile	(kopia robocza)
@@ -22,6 +22,9 @@
 ifeq ($(CONFIG_PANTHERLORD_FF),y)
 	usbhid-objs	+= hid-plff.o
 endif
+ifeq ($(CONFIG_GREENASIA_FF),y)
+	usbhid-objs	+= hid-gaff.o
+endif
 ifeq ($(CONFIG_THRUSTMASTER_FF),y)
 	usbhid-objs	+= hid-tmff.o
 endif
Index: drivers/hid/usbhid/hid-ff.c
===================================================================
--- drivers/hid/usbhid/hid-ff.c	(wersja 1)
+++ drivers/hid/usbhid/hid-ff.c	(kopia robocza)
@@ -66,6 +66,9 @@
 	{ 0x810, 0x0001, hid_plff_init }, /* "Twin USB Joystick" */
 	{ 0xe8f, 0x0003, hid_plff_init }, /* "GreenAsia Inc.    USB Joystick     " */
 #endif
+#ifdef CONFIG_GREENASIA_FF
+	{ 0xe8f, 0x0012, hid_gaff_init }, /* "GreenAsia Inc.    USB Joystick     " */
+#endif
 #ifdef CONFIG_THRUSTMASTER_FF
 	{ 0x44f, 0xb300, hid_tmff_init },
 	{ 0x44f, 0xb304, hid_tmff_init },

--Boundary-00=_J7cLJ45jOh8b4rc--
