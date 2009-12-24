From: Marcin Tolysz <tolysz@gmail.com>
Subject: [RFC v2] [HID] allow using external Hid Descriptors.
Date: Thu, 24 Dec 2009 13:52:38 +0000
Message-ID: <4B337226.6050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64533 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZLXNwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 08:52:42 -0500
Received: by ewy19 with SMTP id 19so7324710ewy.21
        for <linux-input@vger.kernel.org>; Thu, 24 Dec 2009 05:52:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

It simple yet effective way of changing HID device descriptors
using kernel firmware loading mechanism.
Each time kernel will initialise a new hid device it will print
as INFO the searched location for new descriptor.

Just place your new descriptor in binary format in this location
i.e. somewhere in /lib/firmware/hid/
and it will use it in-place of HID descriptor of the device.

This is good enough for now but ideally there should be a way of
hotswaping it (i.e. while using this device) now we need to reconnect it.
This would be ideal for some game controllers where you change its layout
dynamically depending on add-ons you connect to it (i.e. wii)

There are few questions:
1) What file name should have in it? What in it: SN, VEN,PROD,BUS,VER,...
 giving the ability to hard code each device, or to rely on "hotplug".
2) Should we print the info each time as we can see the info from
 the firmware_class telling us the location.

Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
---
 drivers/hid/hid-core.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 80792d3..4ee4299 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -27,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/firmware.h>
 
 #include <linux/hid.h>
 #include <linux/hiddev.h>
@@ -640,6 +641,10 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 	struct hid_item item;
 	__u8 *end;
 	int ret;
+	const struct firmware *fw;
+	int fw_fail;
+	const char *file;
+
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
 		hid_parser_main,
@@ -650,10 +655,28 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 
 	if (device->driver->report_fixup)
 		device->driver->report_fixup(device, start, size);
+	/* Now try to load a hid descriptor from a file firmware
+	if succesful ignoring this fixup thing */
+	file = kasprintf(GFP_KERNEL, "hid/%04X:%04X:%04X:%04X.bin",
+			device->bus, device->vendor, device->product, device->version);
+
+	fw_fail = request_firmware(&fw, file, &device->dev);
+
+	if (fw_fail)
+		pr_info("To relace HID descriptor place it in /lib/firmaware/%s\n", file);
+	else{
+		start = fw->data;
+		size = fw->size;
+		pr_info("HID descriptor relaced with /lib/firmaware/%s\n", file);
+	}
+	kfree(file);
 
 	device->rdesc = kmalloc(size, GFP_KERNEL);
-	if (device->rdesc == NULL)
+	if (device->rdesc == NULL) {
+		if (!fw_fail)
+			release_firmware(fw);
 		return -ENOMEM;
+	}
 	memcpy(device->rdesc, start, size);
 	device->rsize = size;
 
@@ -690,6 +713,8 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 				dbg_hid("unbalanced delimiter at end of report description\n");
 				goto err;
 			}
+			if (!fw_fail)
+				release_firmware(fw);
 			vfree(parser);
 			return 0;
 		}
@@ -697,6 +722,8 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 
 	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
 err:
+	if (!fw_fail)
+		release_firmware(fw);
 	vfree(parser);
 	return ret;
 }
-- 
1.6.5.7

