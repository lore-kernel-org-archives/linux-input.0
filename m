From: Gary Stein <lordcnidarian@gmail.com>
Subject: [PATCH] Add Driver for Logitech Flight System G940
Date: Tue, 8 Dec 2009 17:39:09 -0500
Message-ID: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47475 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbZLHWjE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 17:39:04 -0500
Received: by fxm5 with SMTP id 5so6828387fxm.28
        for <linux-input@vger.kernel.org>; Tue, 08 Dec 2009 14:39:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com

This implements a new driver for the Logitech Flight System G940
http://www.logitech.com/index.cfm/gaming/joysticks/devices/5855&cl=us,en

It is a force feedback joystick with HOTAS, the input part is
supported through normal /dev/input/js0, however it appears the FF
USB-HID is not the same as in hid-lgff for the Force 3D Pro or G27/G25
Racing Wheels.

This patch is applied to 2.6.31 (the stable development branch at the
time).  I tried to follow the code style of the hid-lg2ff branch for
the changed up rumble of another logitech device and created a
hid-lg3ff.c

I then had to appropriately modify Kconfig so it was in menuconfig,
add the USB ID hid-ids and hid-core.c, change hid-lg to create a new
v3 lgff, and overload the function pointers for autocentering etc.

I have comments in the code to help explain what is happening, I
actually had to probe the USB-HID with a series of numbers to find
which fields provided what response, as I could not obtain
documentation from Logitech.

It appears that Logitech has expanded to a two-complement system with
64 fields with 0 being the command, 1-4 being the X axis, and 31-24
being the Y axis.  I have seen online that in windows you can turn on
light (red and green) on the stick, but I have not figured those out
yet/should not be part of the FF device.

It supports the same form of FF_CONSTANT as any other joystick in
ff-memless.c.  Probably less appreciated is included in this patch, I
have made revisions to ff-memless to account for my specific
application.

There was a signed/unsigned bug with gcc 4.4.2 producing invalid
values using a gain in 2.6.31 that was added recently in which I had
to add a int cast to fix.

And I added the ability to bypass the polar coordinate system used by
FF_CONSTANT to a Cartesian coordinate system directly by overloading
FF_RAMP.  This was done because (at least for the ff-memless drivers),
you have to do polar coordinate math to get a level and direction as a
16 bit number, set with FF_CONSTANT which then calls fixp to convert
to Cartesian coordinates (x,y) which is then put in the FF_RAMP fields
and then fed to the HID.  I just created a way to set those FF_RAMP
fields of the input.h union that goes right to the joystick.  However,
it does support the normal way also.

This was done because I needed independent X,Y control and was losing
accuracy through the Cartesian to Polar to Cartesian process.  For the
driver I can remove this and resubmit if necessary.

I have been using this code in production for several weeks and has
not had problems, but it obviously needs to have testing by other
individuals that own this stick.  I have posted this to linux-input
but if it needs to be cross posted to linux-kernel@vger.kernel.org
please let me know.

Thank You,
gary

Signed-off-by: Gary Stein <LordCnidarian@gmail.com>


diff -uprN linux-2.6.31.orig/drivers/hid/Kconfig
linux-2.6.31.next/drivers/hid/Kconfig
--- linux-2.6.31.orig/drivers/hid/Kconfig	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/Kconfig	2009-12-01 12:29:44.000000000 -0500
@@ -190,6 +190,14 @@ config LOGIRUMBLEPAD2_FF
 	  Say Y here if you want to enable force feedback support for Logitech
 	  Rumblepad 2 devices.

+config LOGIG940_FF
+	bool "Logitech Flight System G940 force feedback support"
+	depends on HID_LOGITECH
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here if you want to enable force feedback support for Logitech
+	  Flight System G940 devices.
+
 config HID_MICROSOFT
 	tristate "Microsoft" if EMBEDDED
 	depends on USB_HID
diff -uprN linux-2.6.31.orig/drivers/hid/Makefile
linux-2.6.31.next/drivers/hid/Makefile
--- linux-2.6.31.orig/drivers/hid/Makefile	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/Makefile	2009-12-01 12:29:44.000000000 -0500
@@ -15,6 +15,9 @@ endif
 ifdef CONFIG_LOGIRUMBLEPAD2_FF
 	hid-logitech-objs	+= hid-lg2ff.o
 endif
+ifdef CONFIG_LOGIG940_FF
+	hid-logitech-objs	+= hid-lg3ff.o
+endif

 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
diff -uprN linux-2.6.31.orig/drivers/hid/hid-core.c
linux-2.6.31.next/drivers/hid/hid-core.c
--- linux-2.6.31.orig/drivers/hid/hid-core.c	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-core.c	2009-12-01 12:29:44.000000000 -0500
@@ -1293,6 +1293,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
diff -uprN linux-2.6.31.orig/drivers/hid/hid-ids.h
linux-2.6.31.next/drivers/hid/hid-ids.h
--- linux-2.6.31.orig/drivers/hid/hid-ids.h	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-ids.h	2009-12-01 12:29:44.000000000 -0500
@@ -295,6 +295,7 @@
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
+#define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
 #define USB_DEVICE_ID_LOGITECH_WHEEL	0xc294
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
diff -uprN linux-2.6.31.orig/drivers/hid/hid-lg.c
linux-2.6.31.next/drivers/hid/hid-lg.c
--- linux-2.6.31.orig/drivers/hid/hid-lg.c	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-lg.c	2009-12-01 12:29:44.000000000 -0500
@@ -33,6 +33,7 @@
 #define LG_NOGET		0x100
 #define LG_FF			0x200
 #define LG_FF2			0x400
+#define LG_FF3			0x800

 /*
  * Certain Logitech keyboards send in report #3 keys which are far
@@ -238,7 +239,7 @@ static int lg_probe(struct hid_device *h
 		goto err_free;
 	}

-	if (quirks & (LG_FF | LG_FF2))
+	if (quirks & (LG_FF | LG_FF2 | LG_FF3))
 		connect_mask &= ~HID_CONNECT_FF;

 	ret = hid_hw_start(hdev, connect_mask);
@@ -251,6 +252,8 @@ static int lg_probe(struct hid_device *h
 		lgff_init(hdev);
 	if (quirks & LG_FF2)
 		lg2ff_init(hdev);
+	if (quirks & LG_FF3)
+		lg3ff_init(hdev);

 	return 0;
 err_free:
@@ -301,6 +304,8 @@ static const struct hid_device_id lg_dev
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
 		.driver_data = LG_FF2 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
+		.driver_data = LG_FF3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, lg_devices);
diff -uprN linux-2.6.31.orig/drivers/hid/hid-lg.h
linux-2.6.31.next/drivers/hid/hid-lg.h
--- linux-2.6.31.orig/drivers/hid/hid-lg.h	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-lg.h	2009-12-01 12:29:44.000000000 -0500
@@ -15,4 +15,10 @@ int lg2ff_init(struct hid_device *hdev);
 static inline int lg2ff_init(struct hid_device *hdev) { return -1; }
 #endif

+#ifdef CONFIG_LOGIG940_FF
+int lg3ff_init(struct hid_device *hdev);
+#else
+static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
+#endif
+
 #endif
diff -uprN linux-2.6.31.orig/drivers/hid/hid-lg3ff.c
linux-2.6.31.next/drivers/hid/hid-lg3ff.c
--- linux-2.6.31.orig/drivers/hid/hid-lg3ff.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-lg3ff.c	2009-12-01
15:19:45.000000000 -0500
@@ -0,0 +1,202 @@
+/*
+ *  Force feedback support for Logitech Flight System G940
+ *
+ *  Copyright (c) 2009 Gary Stein <LordCnidarian@gmail.com>
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
+
+#include "usbhid/usbhid.h"
+#include "hid-lg.h"
+
+struct lg3ff_device {
+	struct hid_report *report;
+};
+
+static int hid_lg3ff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list =
&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct
hid_report, list);
+    int x, y;
+
+#define CLAMP(x) if (x < 0) x = 0; if (x > 0xff) x = 0xff
+
+    //only constant supported
+    switch (effect->type) {
+        case FF_RAMP:
+        //these values are supposed to be -127 to 127
+        x = effect->u.ramp.start_level;
+        y = effect->u.ramp.end_level;
+
+        //There are 63 fields, only really figured out 3 of them
+        //0 - seems to be command field
+        //1 - 30 deal with the x axis?
+        //31 -60 deal with the y axis?
+
+        //1 is x axis constant force
+        //31 is y axis constant force
+
+        //other interesting things for fields 1,2,3,4 on x axis (same
for 31,32,33,34 on y axis)
+        //0 0 127 127 makes the joystick autocenter hard
+        //127 0 127 127 makes the joystick loose on the right, but
stops all movemnt left
+        //-127 0 -127 -127 makes the joystick loose on the left, but
stops all movement right
+        //0 0 -127 -127 makes the joystick rattle very hard
+
+        //I'm sure these are effects that I don't know enough about
+
+
+        memset(report->field[0]->value,0,sizeof(__s32)*63);
+
+        report->field[0]->value[0] = 0x51;
+
+        //which get recast here in two's complement 8 bits
+        report->field[0]->value[1]=(unsigned char)x;
+
+        //pitch opposite of carteasian
+        report->field[0]->value[31]=(unsigned char)(-y);
+
+        //printk("Size: %d %d\n",report->size,report->maxfield);
+        //printk("Field: %d
%d\n",report->field[0]->report_size,report->field[0]->maxusage);
+        //Size: 504 1
+        //Field: 8 63
+
+        //dbg_hid("(x, y)=(%04x, %04x)\n", x, y);
+        //printk("Custom (x, y)=(%04x, %04x)\n", x, y);
+        usbhid_submit_report(hid, report, USB_DIR_OUT);
+        break;
+    case FF_CONSTANT:
+
+        //Already clamped in ff_memless
+        //0 is center
+        x = effect->u.ramp.start_level;
+        y = effect->u.ramp.end_level;
+
+        memset(report->field[0]->value,0,sizeof(__s32)*63);
+
+        report->field[0]->value[0] = 0x51;
+
+        //sign backwards from other Force3d pro
+
+        //which get recast here in two's complement 8 bits
+        report->field[0]->value[1]=(unsigned char)(-x);
+
+        //pitch opposite of carteasian
+        report->field[0]->value[31]=(unsigned char)(-y);
+
+        //printk("Size: %d %d\n",report->size,report->maxfield);
+        //printk("Field: %d
%d\n",report->field[0]->report_size,report->field[0]->maxusage);
+        //Size: 504 1
+        //Field: 8 63
+
+        //dbg_hid("(x, y)=(%04x, %04x)\n", x, y);
+        //printk("Custom (x, y)=(%04x, %04x)\n", x, y);
+        usbhid_submit_report(hid, report, USB_DIR_OUT);
+        break;
+
+        default:
+            printk("FF Type Not Supported: %d\n",effect->type);
+    }
+    return 0;
+}
+static void hid_lg3ff_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list =
&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct
hid_report, list);
+
+	report->field[0]->value[0] = 0x51;
+	report->field[0]->value[1] = 0x00;
+	report->field[0]->value[2] = 0x00;
+	report->field[0]->value[3] = 0x7F;
+	report->field[0]->value[4] = 0x7F;
+	report->field[0]->value[31] = 0x00;
+	report->field[0]->value[32] = 0x00;
+	report->field[0]->value[33] = 0x7F;
+	report->field[0]->value[34] = 0x7F;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
+
+static const signed short ff3_joystick_ac[] = {
+	FF_CONSTANT,
+	FF_RAMP,
+	FF_AUTOCENTER,
+	-1
+};
+
+int lg3ff_init(struct hid_device* hid)
+{
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct
hid_input, list);
+	struct list_head *report_list =
&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev = hidinput->input;
+	struct hid_report *report;
+	struct hid_field *field;
+	const signed short *ff_bits = ff3_joystick_ac;
+	int error;
+	int i;
+
+	/* Find the report to use */
+	if (list_empty(report_list)) {
+		err_hid("No output report found");
+		return -1;
+	}
+
+	/* Check that the report looks ok */
+	report = list_entry(report_list->next, struct hid_report, list);
+	if (!report) {
+		err_hid("NULL output report");
+		return -1;
+	}
+
+	field = report->field[0];
+	if (!field) {
+		err_hid("NULL field");
+		return -1;
+	}
+
+    //don't search
+	/*for (i = 0; i < ARRAY_SIZE(devices); i++) {
+		if (dev->id.vendor == devices[i].idVendor &&
+		    dev->id.product == devices[i].idProduct) {
+			ff_bits = devices[i].ff;
+			break;
+		}
+	}*/
+
+	for (i = 0; ff_bits[i] >= 0; i++)
+		set_bit(ff_bits[i], dev->ffbit);
+
+	error = input_ff_create_memless(dev, NULL, hid_lg3ff_play);
+	if (error)
+		return error;
+
+	if ( test_bit(FF_AUTOCENTER, dev->ffbit) )
+		dev->ff->set_autocenter = hid_lg3ff_set_autocenter;
+
+	dev_info(&hid->dev, "Force feedback for Logitech Flight System G940 by "
+	       "Gary Stein <LordCnidarian@gmail.com>\n");
+	return 0;
+}
+
diff -uprN linux-2.6.31.orig/drivers/hid/hid-lgff.c
linux-2.6.31.next/drivers/hid/hid-lgff.c
--- linux-2.6.31.orig/drivers/hid/hid-lgff.c	2009-09-09 17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/hid/hid-lgff.c	2009-12-01 15:19:49.000000000 -0500
@@ -67,6 +67,7 @@ static const struct dev_type devices[] =
 	{ 0x046d, 0xc219, ff_rumble },
 	{ 0x046d, 0xc283, ff_joystick },
 	{ 0x046d, 0xc286, ff_joystick_ac },
+	{ 0x046d, 0xc287, ff_joystick_ac },
 	{ 0x046d, 0xc294, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
 	{ 0x046d, 0xca03, ff_wheel },
@@ -95,7 +96,6 @@ static int hid_lgff_play(struct input_de
 		dbg_hid("(x, y)=(%04x, %04x)\n", x, y);
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
-
 	case FF_RUMBLE:
 		right = effect->u.rumble.strong_magnitude;
 		left = effect->u.rumble.weak_magnitude;
diff -uprN linux-2.6.31.orig/drivers/input/ff-memless.c
linux-2.6.31.next/drivers/input/ff-memless.c
--- linux-2.6.31.orig/drivers/input/ff-memless.c	2009-09-09
17:13:59.000000000 -0500
+++ linux-2.6.31.next/drivers/input/ff-memless.c	2009-12-01
15:20:34.000000000 -0500
@@ -77,6 +77,8 @@ static const struct ff_envelope *get_env
 			return &effect->u.periodic.envelope;
 		case FF_CONSTANT:
 			return &effect->u.constant.envelope;
+		case FF_RAMP:
+			return &effect->u.ramp.envelope;
 		default:
 			return &empty_envelope;
 	}
@@ -239,8 +241,8 @@ static void ml_combine_effects(struct ff
 		level = fixp_new16(apply_envelope(state,
 					new->u.constant.level,
 					&new->u.constant.envelope));
-		x = fixp_mult(fixp_sin(i), level) * gain / 0xffff;
-		y = fixp_mult(-fixp_cos(i), level) * gain / 0xffff;
+		x = (int)(fixp_mult(fixp_sin(i), level) * gain) / 0xffff;
+		y = (int)(fixp_mult(-fixp_cos(i), level) * gain) / 0xffff;
 		/*
 		 * here we abuse ff_ramp to hold x and y of constant force
 		 * If in future any driver wants something else than x and y
@@ -274,6 +276,19 @@ static void ml_combine_effects(struct ff
 		effect->u.rumble.weak_magnitude =
 			min(i + effect->u.rumble.weak_magnitude, 0xffffU);
 		break;
+	case FF_RAMP:
+		/*
+		* Another abuse of ff_ramp, but use the values exactly
+		* with start being the x axis and end being the y axis
+		* instead of fixed point sine and cosine (polar)
+		*/
+		level = fixp_new16(apply_envelope(state,
+					new->u.constant.level,
+					&new->u.ramp.envelope));
+
+		effect->u.ramp.start_level=new->u.ramp.start_level;
+		effect->u.ramp.end_level=new->u.ramp.end_level;
+		break;

 	default:
 		printk(KERN_ERR "ff-memless: invalid type in ml_combine_effects()\n");
