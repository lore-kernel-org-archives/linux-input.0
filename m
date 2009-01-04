From: "Marcin Tolysz" <tolysz@gmail.com>
Subject: [HID : improvement] Allow drivers to replace report descriptors
Date: Sun, 4 Jan 2009 19:35:58 +0000
Message-ID: <54bbe4e00901041135r37af208hae69cc9df6e407e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:47795 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbZADTgC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2009 14:36:02 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org

[HID : improvement] Allow drivers to replace report descriptors completely
   Some devices present themselves as a HID device, however if we pass
their device descriptor to HID subsystem they
  might be bogus or broken. The idea behind this patch is to allow a
device driver to decide how descriptor should look at the end.

  Why bother?
  Once we will be able to fix broken descriptors we could look into
other bits of system i.e. completing support for other HID
  extensions and then improving descriptors to support that new
extensions.  And descriptors are static, one we have one
  it act as a "firmware" for a kernel to tell how device's events
should be interpreted.

  Having encapsulated hid descriptors for bogus devices we could fix
them:just supplying a good one in place of the original one.
  Or latter keep them outside kernel, and relay on user space to
supply valid descriptor for a particular usage when possibly different
  one  being requested by a user.

  To modify a descriptor is a fairy easy task, its format is allmost
so natural that we could forget about any extra tools.
  However changing descriptor is a task far more easier than debugging
pre- i post- parsed trees. Descriptors are static!

  Idea of allowing a complete change of a descriptor came to me when I
decided to improve PS3 Controller in Linux.
  As this device is one of the "bogus" ones. I had a choice go the
hard way: implement USB drivers debug locks..., Implement
  Bluetooth driver debug locks...,
  OR make HID driver to be happy with this device. And trust other
developers in their job.

  One of obstacles was a set size of the descriptor NB it is needed i
a very narrow scope and for a very short time: namely from
  reading from device to parsing it in a HID driver.
  I have chosen a simplest way to fix it:
		before descriptor is set with data from device,  I allocate maximum
allowed in specification memory area now 4K:
                         rdesc = kmalloc( HID_MAX_DESCRIPTOR_SIZE , GFP_KERNEL)
		and this was happening only in two places in Bluetooth and USB backends.

Now we can play with the allocated memory. Up to date possible changes
could only be done in data itself we couldn't  change length or a
descriptor.
	It was so obvious that we do not need it that even in headers
<linux/hid.h> was that assumption.
       	 report_fixup(struct hid_device *hdev, __u8 *rdesc,unsigned int rsize)
  	solution very simple change it to:
         report_fixup(struct hid_device *hdev, __u8 *rdesc,unsigned int *rsize)
   and update all devices using this function. This will allow us to
change size(a value)  of descriptor as memory is already allocated and
it is a maximum!
   Last bit was to update descriptor parser to make it aware that size
might change, and to use this new value.

So after all this work implementation of PS3 Controller is easy: just
copy prepared descriptor onto already allocated memory,
and say what _size_ it was.
The replacement descriptor included in this patch is a bit lengthy,
but I hope it will be a good tutorial how to write such descriptors
with pen and a paper. This driver is open to USB and Bluetooth
devices. This new driver works much better than former,  and is open
for further enhancements, by improving the descriptor alone.

  What next.: If we offload this: others could now focus on
implementing improvements to a HID itself.
  And more important someone could write a generic driver handling all
broken HID devices by supplying
  to a parser a working  descriptor  or change applications or a usage
of a device. and everything let say via sysfs.

 Signed-off-by:  Marcin Tolysz <tolysz@gmail.com>

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index b4fd8ca..90c653f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -232,8 +232,9 @@ config HID_SAMSUNG
 	Support for Samsung InfraRed remote control.

 config HID_SONY
-	tristate "Sony" if EMBEDDED
-	depends on USB_HID
+	#tristate "Sony" if EMBEDDED
+	tristate "Sony"
+	depends on (USB_HID || BT_HIDP)
 	default y
 	---help---
 	Support for Sony PS3 controller.
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index aa28aed..cfc6882 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -239,11 +239,11 @@ static int apple_event(struct hid_device *hdev,
struct hid_field *field,
  * MacBook JIS keyboard has wrong logical maximum
  */
 static void apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);

-	if ((asc->quirks & APPLE_RDESC_JIS) && rsize >= 60 &&
+	if ((asc->quirks & APPLE_RDESC_JIS) && *rsize >= 60 &&
 			rdesc[53] == 0x65 && rdesc[59] == 0x65) {
 		dev_info(&hdev->dev, "fixing up MacBook JIS keyboard report "
 				"descriptor\n");
diff --git a/drivers/hid/hid-cherry.c b/drivers/hid/hid-cherry.c
index b833b97..66237c5 100644
--- a/drivers/hid/hid-cherry.c
+++ b/drivers/hid/hid-cherry.c
@@ -27,9 +27,9 @@
  * that needs fixing before we can parse it.
  */
 static void ch_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
-	if (rsize >= 17 && rdesc[11] == 0x3c && rdesc[12] == 0x02) {
+	if (*rsize >= 17 && rdesc[11] == 0x3c && rdesc[12] == 0x02) {
 		dev_info(&hdev->dev, "fixing up Cherry Cymotion report "
 				"descriptor\n");
 		rdesc[11] = rdesc[16] = 0xff;
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 40df3e1..9c04e23 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -643,7 +643,9 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 	struct hid_parser *parser;
 	struct hid_item item;
 	__u8 *end;
-	int ret;
+	int ret,n;
+	unsigned int possibly_new_size=size;
+
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
 		hid_parser_main,
@@ -652,13 +654,18 @@ int hid_parse_report(struct hid_device *device,
__u8 *start,
 		hid_parser_reserved
 	};

-	if (device->driver->report_fixup)
-		device->driver->report_fixup(device, start, size);
+	if (device->driver->report_fixup){
+		device->driver->report_fixup(device, start, &possibly_new_size);

-	device->rdesc = kmalloc(size, GFP_KERNEL);
+		dbg_hid("updated report descriptor (size %u) = ", possibly_new_size);
+		for (n = 0; n < possibly_new_size; n++)
+			dbg_hid_line(" %02x", (unsigned char) start[n]);
+		dbg_hid_line("\n");
+	};
+	device->rdesc = kmalloc(possibly_new_size, GFP_KERNEL);
 	if (device->rdesc == NULL)
 		return -ENOMEM;
-	memcpy(device->rdesc, start, size);
+	memcpy(device->rdesc, start, possibly_new_size);
 	device->rsize = size;

 	parser = vmalloc(sizeof(struct hid_parser));
@@ -670,7 +677,7 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 	memset(parser, 0, sizeof(struct hid_parser));
 	parser->device = device;

-	end = start + size;
+	end = start + possibly_new_size;
 	ret = -EINVAL;
 	while ((start = fetch_item(start, end, &item)) != NULL) {

@@ -699,7 +706,7 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 		}
 	}

-	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
+	dbg_hid("item fetching failed at offset %d\n", (int)(end -
possibly_new_size));
 err:
 	vfree(parser);
 	return ret;
@@ -1300,6 +1307,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },

diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index 5d69d27..70aa0c6 100644
--- a/drivers/hid/hid-cypress.c
+++ b/drivers/hid/hid-cypress.c
@@ -32,7 +32,7 @@
  * the wrong order
  */
 static void cp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
 	unsigned int i;
@@ -40,7 +40,7 @@ static void cp_report_fixup(struct hid_device *hdev,
__u8 *rdesc,
 	if (!(quirks & CP_RDESC_SWAPPED_MIN_MAX))
 		return;

-	for (i = 0; i < rsize - 4; i++)
+	for (i = 0; i < *rsize - 4; i++)
 		if (rdesc[i] == 0x29 && rdesc[i + 2] == 0x19) {
 			__u8 tmp;

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 2bae340..66518a2 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -41,11 +41,11 @@
  * the original value of 0x28c of logical maximum to 0x104d
  */
 static void lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);

-	if ((quirks & LG_RDESC) && rsize >= 90 && rdesc[83] == 0x26 &&
+	if ((quirks & LG_RDESC) && *rsize >= 90 && rdesc[83] == 0x26 &&
 			rdesc[84] == 0x8c && rdesc[85] == 0x02) {
 		dev_info(&hdev->dev, "fixing up Logitech keyboard report "
 				"descriptor\n");
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index d718b16..41843d2 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -34,11 +34,11 @@
  * 'Usage Min/Max' where it ought to have 'Physical Min/Max'
  */
 static void ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);

-	if ((quirks & MS_RDESC) && rsize == 571 && rdesc[284] == 0x19 &&
+	if ((quirks & MS_RDESC) && *rsize == 571 && rdesc[284] == 0x19 &&
 			rdesc[286] == 0x2a && rdesc[304] == 0x19 &&
 			rdesc[306] == 0x29 && rdesc[352] == 0x1a &&
 			rdesc[355] == 0x2a && rdesc[557] == 0x19 &&
diff --git a/drivers/hid/hid-monterey.c b/drivers/hid/hid-monterey.c
index f3a85a0..a522c1f 100644
--- a/drivers/hid/hid-monterey.c
+++ b/drivers/hid/hid-monterey.c
@@ -23,9 +23,9 @@
 #include "hid-ids.h"

 static void mr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
-	if (rsize >= 30 && rdesc[29] == 0x05 && rdesc[30] == 0x09) {
+	if (*rsize >= 30 && rdesc[29] == 0x05 && rdesc[30] == 0x09) {
 		dev_info(&hdev->dev, "fixing up button/consumer in HID report "
 				"descriptor\n");
 		rdesc[30] = 0x0c;
diff --git a/drivers/hid/hid-petalynx.c b/drivers/hid/hid-petalynx.c
index 10945fe..2d81313 100644
--- a/drivers/hid/hid-petalynx.c
+++ b/drivers/hid/hid-petalynx.c
@@ -24,9 +24,9 @@

 /* Petalynx Maxter Remote has maximum for consumer page set too low */
 static void pl_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
-	if (rsize >= 60 && rdesc[39] == 0x2a && rdesc[40] == 0xf5 &&
+	if (*rsize >= 60 && rdesc[39] == 0x2a && rdesc[40] == 0xf5 &&
 			rdesc[41] == 0x00 && rdesc[59] == 0x26 &&
 			rdesc[60] == 0xf9 && rdesc[61] == 0x00) {
 		dev_info(&hdev->dev, "fixing up Petalynx Maxter Remote report "
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 15f3c04..cd5136b 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -32,9 +32,9 @@
  * The burden to reconstruct the data is moved into user space.
  */
 static void samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
-	if (rsize >= 182 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
+	if (*rsize >= 182 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
 			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
 			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
 			rdesc[182] == 0x40) {
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 86e563b..66a8cbc 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -7,6 +7,7 @@
  *  Copyright (c) 2007 Paul Walmsley
  *  Copyright (c) 2008 Jiri Slaby
  *  Copyright (c) 2006-2008 Jiri Kosina
+ *  Copyright (c) 2008-2009 Marcin Tolysz <tolysz@gmail.com>
  */

 /*
@@ -22,8 +23,12 @@
 #include <linux/usb.h>

 #include "hid-ids.h"
+#include "sixaxis-report.h"

 #define VAIO_RDESC_CONSTANT 0x0001
+#define PS3_SIXAXIS_REMAP 0x0002
+#define PS3_SIXAXIS_OPERATIONAL 0x0004
+

 struct sony_sc {
 	unsigned long quirks;
@@ -31,16 +36,21 @@ struct sony_sc {

 /* Sony Vaio VGX has wrongly mouse pointer declared as constant */
 static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);

 	if ((sc->quirks & VAIO_RDESC_CONSTANT) &&
-			rsize >= 56 && rdesc[54] == 0x81 && rdesc[55] == 0x07) {
+			*rsize >= 56 && rdesc[54] == 0x81 && rdesc[55] == 0x07) {
 		dev_info(&hdev->dev, "Fixing up Sony Vaio VGX report "
 				"descriptor\n");
 		rdesc[55] = 0x06;
 	}
+	if (sc->quirks & PS3_SIXAXIS_REMAP ){
+		/*The goal is to replace it, with rdesc supplied from user-space*/
+		memcpy (rdesc , six_rep  , sizeof (six_rep));
+		*rsize=sizeof (six_rep);
+	}
 }

 /*
@@ -73,6 +83,12 @@ static int sony_set_operational(struct hid_device *hdev)
 	return ret;
 }

+static int sony_set_operational_bluetooth(struct hid_device *hdev)
+{
+	/*TODO: Add bluetooth fix for dualshock/sixaxis */
+	return 0;
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -81,7 +97,7 @@ static int sony_probe(struct hid_device *hdev, const
struct hid_device_id *id)

 	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
-		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
+		dev_err(&hdev->dev, "can't alloc sony descriptor\n");
 		return -ENOMEM;
 	}

@@ -100,11 +116,22 @@ static int sony_probe(struct hid_device *hdev,
const struct hid_device_id *id)
 		dev_err(&hdev->dev, "hw start failed\n");
 		goto err_free;
 	}
-
-	ret = sony_set_operational(hdev);
-	if (ret)
+
+    if(quirks & PS3_SIXAXIS_OPERATIONAL){
+    	switch (hdev->bus) {
+			case BUS_USB:
+				ret = sony_set_operational(hdev);
+				break;
+			case BUS_BLUETOOTH:
+				ret = sony_set_operational_bluetooth(hdev);
+				break;
+			//default:
+		}
+	}
+	if (ret < 0)
 		goto err_stop;

+
 	return 0;
 err_stop:
 	hid_hw_stop(hdev);
@@ -120,7 +147,11 @@ static void sony_remove(struct hid_device *hdev)
 }

 static const struct hid_device_id sony_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
+		.driver_data = PS3_SIXAXIS_REMAP | PS3_SIXAXIS_OPERATIONAL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
+		.driver_data = PS3_SIXAXIS_REMAP | PS3_SIXAXIS_OPERATIONAL },
+
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
 		.driver_data = VAIO_RDESC_CONSTANT },
 	{ }
diff --git a/drivers/hid/hid-sunplus.c b/drivers/hid/hid-sunplus.c
index 5ba68f7..993a248 100644
--- a/drivers/hid/hid-sunplus.c
+++ b/drivers/hid/hid-sunplus.c
@@ -23,9 +23,9 @@
 #include "hid-ids.h"

 static void sp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int rsize)
+		unsigned int *rsize)
 {
-	if (rsize >= 107 && rdesc[104] == 0x26 && rdesc[105] == 0x80 &&
+	if (*rsize >= 107 && rdesc[104] == 0x26 && rdesc[105] == 0x80 &&
 			rdesc[106] == 0x03) {
 		dev_info(&hdev->dev, "fixing up Sunplus Wireless Desktop "
 				"report descriptor\n");
diff --git a/drivers/hid/sixaxis-report.h b/drivers/hid/sixaxis-report.h
new file mode 100644
index 0000000..63bd422
--- /dev/null
+++ b/drivers/hid/sixaxis-report.h
@@ -0,0 +1,389 @@
+/*
+ *  HID fixed report descriptor some sony "special" devices
+ *  Copyright (c) 2008-2009 Marcin Tolysz <tolysz@gmail.com>
+ *
+ * It is unpolished as it is not finished yet, as to finish
+ * it rdesc should be loadable from user-space at will.
+ * This way helps to grasp an idea how to manipulate the descriptors
+ *
+ * all tools I've used are on: http://www.usb.org/developers/hidpage
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+/*
+* Comments show connection between a descriptor and a report i.e. a position.
+*/
+
+
+__u8  six_rep[] ={
+	0x05 , 0x01, //   Generic Desktop Controls
+	0x09 , 0x04, //   Usage  Joystick
+
+	0xA1 , 0x01, //  Collection   Application
+	0xA1 , 0x02, //  Collection   Logical
+	0x85 , 0x01, //  Report ID  1
+/*
+byte 1 ID
+	[00 01] 00 00 00 00 00 84 82 8D 7C 00 00 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 00 00 00 03 05 14 00 00 00 00 23 0F 77 01
+	81 02 07 01 EA 01 9B 00 02
+*/
+	0x75, 0x08, //   Report Size  8
+	0x95, 0x01, //   Report Count 1
+	0x15, 0x00,  //   Logical Minimum 0
+	0x26, 0xff, 0x00,// Logical Maximum 255
+	0x81, 0x03,//   Input 3
+/*
+byte 2 ?
+      00 01 [00] 00 00 00 00 84 82 8D 7C 00 00 00 00 00 00 00 00 00 00
+      00 00 00 00 00 00 00 00 00 03 05 14 00 00 00 00 23 0F 77 01
+      81 02 07 01 EA 01 9B 00 02
+*/
+
+//Buttons will be reversed + hat switch on a keyboard
+	0x05, 0x09,// buttons
+	0x75, 0x01,//   Report Size  1
+	0x95, 0x01, //   Report Count, 1 /// unfortunetly one-by-one only
//first 4(special) + hat + rest
+	0x15, 0x00,//    Logical Minimum 0
+	0x25, 0x01,//    Logical Maximum  1
+	0x35, 0x00, //   Physical Minimum 0
+	0x45, 0x01,//    Physical Maximum  1
+
+// buttons are arbitrary mapped
+	0x19, 0x0c, //Button select 0 -> 12
+	0x29, 0x0c,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x0a, //Button L3 1 -> 10
+	0x29, 0x0a,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x09, //Button R3 2 -> 9
+	0x29, 0x09,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x0b, //Button start 3 -> 11
+	0x29, 0x0b,
+	0x81, 0x02, // Input
+
+//                                [w]
+	0x05, 0x07, //keyboard     [a][s][d]
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x07, //[d]
+	0x29, 0x07,
+	0x81, 0x02, // Input
+
+	0x05, 0x07, //keyboard
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x16, //[s]
+	0x29, 0x16,
+	0x81, 0x02, // Input
+
+	0x05, 0x07, //keyboard
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x04, //[a]
+	0x29, 0x04,
+	0x81, 0x02, // Input
+
+	0x05, 0x07, // keyboard
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x1a, // [w]
+	0x29, 0x1a,
+	0x81, 0x02, // Input
+
+ //buttons
+	0x05, 0x09,// buttons
+	0x75, 0x01,// Report Size  1
+	0x95, 0x01,// Report Count 1
+	0x15, 0x00,// Logical Minimum 0
+	0x25, 0x01,// Logical Maximum 1
+	0x35, 0x00,// Physical Minimum 0
+	0x45, 0x01,// Physical Maximum 1
+
+	0x19, 0x08, //Button L2 8  -> 8
+	0x29, 0x08,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x07, //Button R2 9  -> 7
+	0x29, 0x07,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x06, //Button L1 10 -> 6
+	0x29, 0x06,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x05, //Button R1 11 -> 5
+	0x29, 0x05,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x04, //Button tri 12 -> 4
+	0x29, 0x04,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x02, //Button o 13 -> 2
+	0x29, 0x02,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x01, //Button x  14 -> 1
+	0x29, 0x01,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x03, //Button squ 15 -> 3
+	0x29, 0x03,
+	0x81, 0x02, // Input
+
+	0x05, 0x09,// buttons
+	0x75, 0x01, // RSize
+	0x95, 0x01, // RCount
+	0x19, 0x0d, //Button PS 16-> 13
+	0x29, 0x0d,
+	0x81, 0x02, // Input
+
+/*
++ 17 bits = 2B + 1   (Buttons)
+byte 4
+	00 01 00 [00 00 0]0 00 84 82 8D 7C 00 00 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 00 00 00 03 05 14 00 00 00 00 23 0F 77 01
+	81 02 07 01 EA 01 9B 00 02
+*/
+
+	0x75, 0x01, //  1
+	0x95, 0x0f, //  RSize 15
+
+	0x06, 0x00,0xff, // Usage Page, data= [ 0x00 0xff ]  might be an error?
+	0x81, 0x03,    //  Input 3
+
+/*
++ 15b = 1B + 7  (vendor specific)
+byte 6
+	 00 01 00 00 00 0[0 00] 84 82 8D 7C 00 00 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 00 00 00 03 05 14 00 00 00 00 23 0F 77 01
+	81 02 07 01 EA 01 9B 00 02
+*/
+	0x15, 0x00, //   Logical Minimum 0
+	0x26, 0xff,0x00, //  Logical Maximum, data= [ 0xff 0x00 ] 255
+	0x05, 0x01,//   Usage Page,  Generic Desktop Controls
+	0x09, 0x01,//   Usage, data Pointer
+
+	0xA1, 0x00,//   Collection  Physical
+	0x75, 0x08,//   Report Size, 8
+	0x95, 0x04,//   Report Count 4
+	0x35, 0x00,//   Physical Minimum  0
+	0x46, 0xff,0x00,//  Physical Maximum  255
+	0x09, 0x30,//         Direction-X
+	0x09, 0x31,//         Direction-Y
+	0x09, 0x32,//         Direction-Z
+	0x09, 0x33,//    /////////////    Rotate-x
+	0x81, 0x02,//     Input,
+	0xC0,//         End Collection, data=none
+
+/*+ 4 x 8b = 4B standard directions
+byte 10
+	00 01 00 00 00 00 00 [81 81 7d 7e] 00 00 00 00 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 00 03 ef 16 00 00 00 00 33 f2 77 01 9e 01 e4 01 f8 01
+	8e 01 ea
+*/
+
+	0x05, 0x01,// Usage Page   Generic Desktop Controls
+/*
+Thist is why I pushed myself to do this "quickfix"/tutorial!
+===========================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
+wrong:
+            Item(Global): Report Size, data= [ 0x08 ] 8
+            Item(Global): Report Count, data= [ 0x27 ] 39
+            Item(Local ): Usage, data= [ 0x01 ] 1
+                            Pointer
+            Item(Main  ): Input, data= [ 0x02 ] 2
+                            Data Variable Absolute No_Wrap Linear
+                            Preferred_State No_Null_Position
Non_Volatile Bitfield
++ 39B of pointers
+byte 49
+00 01 00 00 00 00 00 81 81 7d 7e [00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 03 ef 16 00 00 00 00 33 f2 77 01 9e 01 e4 01 f8
01 8e 01 ea]
+=======================================================================================
+*/
+	0x75, 0x08,  //Report Size, data= 0x08
+	0x95, 0x04,  //Report Count, data=0x04
+	0x81, 0x03,  //Input,Constant
+/*+4B
+byte 14
+	00 01 00 10 80 00 00 81 81 80 7e [00 00 00 00] ff 00 00 00 00 00
+	00 00 00 00 00 ff 00 00 00 03 ef 16 00 00 00 00 33 f2 77 01 9e 01
+	fb 01 f6 01 8d 01 df
+*/
+
+	0x75, 0x08,// Report Size 8
+	0x95, 0x0c,// Report Count, 12 button axis
+	0x09, 0x46,// Usage, data  Vno
+	0x15, 0x00,//  Logical Minimum 0
+	0x26, 0xff, 0x00,//  Logical Maximum 255
+	0x81, 0x02, // input
+/*+12B
+byte 26
+	00 01 00 10 80 00 00 81 81 80 7e 00 00 00 00 [ff 00 00 00 00 00 00 00
+	00 00 00 ff] 00 00 00 03 ef 16 00 00 00 00 33 f2 77 01 9e 01 fb 01 f6
+	01 8d 01 df
+*/
+
+	0x75, 0x08, //Report Size, data= 0x08
+	0x95, 0x0f, //Report Count, data=0xf 15
+	0x81, 0x03, //Input,Constant
+/*+15B const rubbish?
+byte 41
+	00 01 00 00 00 00 00 7e 80 7f 7e 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 00 00 [00 00 00 03 ef 16 00 00 00 00 33
+	f2 77 01 9e] 01 f9 01 f2 01 8d 01 ea
+*/
+
+	0x75, 0x01,   //Report Size, data= 0x
+	0x95, 0x06,  //Report Count, data=0xf 13
+	0x81, 0x03,  //Input,Constant
+
+	0x75, 0x0a,  //of info 10 bits
+	0x95, 0x01,  //Report Count, 1
+	0x16, 0x01, 0xFE, //Ligical Min -511
+	0x26, 0x00, 0x02, //Logical Max 512
+	0x35, 0x00,  //physical Min 0
+	0x46, 0x00, 0x04, //physical Max 1024
+
+	0x09, 0x34,  //Usage Rx
+	0x81, 0x02,  //Input,Data.
+
+// all axes are padded with 6 bits
+	0x75, 0x01,  //Report Size 1
+	0x95, 0x06,  //Report Count, 6
+	0x81, 0x03,  //Input,Constant
+
+
+	0x75, 0x0a,  //of info 10 bits
+	0x95, 0x01,  //Report Count 1
+	0x16, 0x01, 0xFE, //Ligical Min -511
+	0x26, 0x00, 0x02, //Logical Max 512
+	0x35, 0x00,  //physical Min 0
+	0x46, 0x00, 0x04, //physical Max 1024
+
+	0x09, 0x35,  //Usage VRx
+	0x81, 0x02,  //Input,Data..
+
+
+// all axes are padded with 6 bits
+	0x75, 0x01,   //Report Size,1
+	0x95, 0x06,  //Report Count, 6
+	0x81, 0x03,  //Input,Constant
+
+	0x75, 0x0a,  //of info 10 bits
+	0x95, 0x01,  //Report Count, data=0x04
+	0x16, 0x01, 0xFE, //Ligical Min -511
+	0x26, 0x00, 0x02, //Logical Max 512
+	0x36, 0x01, 0xfe,  //physical Min -512
+	0x46, 0x00, 0x02, //physical Max 512
+
+	0x09, 0x36,  //Usage VbRy
+	0x81, 0x02,  //Input,Data..
+
+
+// all axes are padded with 6 bits
+	0x75, 0x01,   //Report Size 1
+	0x95, 0x06,  //Report Count 6
+	0x81, 0x03,  //Input,Constant
+
+	0x75, 0x0a,  //of info 10 bits
+	0x95, 0x01,  //Report Count 1
+	0x16, 0x01, 0xFE, //Ligical Min -511
+	0x26, 0x00, 0x02, //Logical Max 512
+	0x36, 0x01, 0xfe,  //physical Min -512
+	0x46, 0x00, 0x02, //physical Max 512
+
+	0x09, 0x37,  //Usage Vbrz
+	0x81, 0x02,  //Input,Data..
+
+/*+ 4 x 16 = 8B
+
+byte 49
+	00 01 00 00 00 00 00 7e 80 7f 7e 00 00 00 00 00 00 00 00 00 00 00 00 00
+	00 00 00 00 00 00 03 ef 16 00 00 00 00 33 f2 77 01 9e [01 f9 01 f2 01
+	8d 01 ea]
+
+=======================================================================================
+rest stays the same :) at least for now!
+*/
+	0x15, 0x00, // Logical Minimum  0
+	0x26, 0xff,0x00, //  Logical Maximum  255
+	0x35, 0x00,  //physical Min 0
+	0x46, 0xff, 0x00, //physical Max 256
+
+	0x75, 0x08,// Report Size  8
+	0x95, 0x30,// Report Count  48
+	0x09, 0x01,// Usage Pointer
+	0x91, 0x02,// Output  2
+
+	0x75, 0x08,// Report Size 8
+	0x95, 0x30,// Report Count 48
+	0x09, 0x01,// Usage Pointer
+	0xB1, 0x02,// Feature  2
+	0xC0, // End Collection
+
+	0xA1,0x02,//  Collection  2    Logical
+	0x85,0x02,//  Report ID 2
+	0x75,0x08,//  Report Size  8
+	0x95,0x30,//  Report Count  48
+	0x09,0x01,//  Usage  Pointer
+	0xB1,0x02,//  Feature 2
+	0xC0,//     End Collection
+
+	0xA1,0x02,//  Collection Logical
+	0x85,0xee,//  Report ID  238
+	0x75,0x08,//  Report Size  8
+	0x95,0x30,//  Report Count  48
+	0x09,0x01,//  Usage Pointer
+	0xB1,0x02,//  Featur 2
+	0xC0,//    End Collection
+
+	0xA1,0x02,//   Collection  Logical
+	0x85,0xef,//   Report ID  239
+	0x75,0x08,//   Report Size  8
+	0x95,0x30,//   Report Count 48
+	0x09,0x01,//   Usage Pointer
+	0xB1,0x02,// Feature  2
+	0xC0,// End Collection, data=none
+	0xC0 //  Endpoint Descriptor:
+};
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 606369e..9bf3b4e 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -737,8 +737,9 @@ static int usbhid_parse(struct hid_device *hid)
 		dbg_hid("weird size of report descriptor (%u)\n", rsize);
 		return -EINVAL;
 	}
-
-	if (!(rdesc = kmalloc(rsize, GFP_KERNEL))) {
+	/* by allocating maximum possible size:HID_MAX_DESCRIPTOR_SIZE
+	 will allow us to add some bits to it latter*/
+	if (!(rdesc = kmalloc( HID_MAX_DESCRIPTOR_SIZE , GFP_KERNEL))) {
 		dbg_hid("couldn't allocate rdesc memory\n");
 		return -ENOMEM;
 	}
diff --git a/include/linux/hid.h b/include/linux/hid.h
index e5780f8..ef411e1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -578,7 +578,7 @@ struct hid_driver {
 			struct hid_usage *usage, __s32 value);

 	void (*report_fixup)(struct hid_device *hdev, __u8 *buf,
-			unsigned int size);
+			unsigned int *size);

 	int (*input_mapping)(struct hid_device *hdev,
 			struct hid_input *hidinput, struct hid_field *field,
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b186768..71b1710 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -684,8 +684,13 @@ static int hidp_parse(struct hid_device *hid)
 	struct hidp_connadd_req *req = session->req;
 	unsigned char *buf;
 	int ret;
-
-	buf = kmalloc(req->rd_size, GFP_KERNEL);
+	
+	/*by allocating possible maximum size:HID_MAX_DESCRIPTOR_SIZE
+	we will have space to add some bits latter*/
+	if(!req->rd_size || req->rd_size > HID_MAX_DESCRIPTOR_SIZE)
+		return -EINVAL;
+	
+	buf = kmalloc(HID_MAX_DESCRIPTOR_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
