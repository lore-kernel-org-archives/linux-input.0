From: Marcin Tolysz <tolysz@gmail.com>
Subject: [RFC] Simple but effective way of chaging HID device descriptors
Date: Thu, 24 Dec 2009 02:12:23 +0000
Message-ID: <4B32CE07.6020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:56507 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZLXCMl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 21:12:41 -0500
Received: by ey-out-2122.google.com with SMTP id 25so636546eya.19
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2009 18:12:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Simple but effective way of chaging HID device descriptorsusing firmware 
loading mechanism.
Just place your new descriptor in a location specified by driver
i.e. somewhere in /lib/firmware/hid/
If it is there it will replace HID descriptor from the device.
I do not do any parsing or checking, as it is done by hid driver.

Signed-off-by: Marcin Tolysz <tolysz@gmail.com>

---
  drivers/hid/hid-core.c |   26 +++++++++++++++++++++++++-
  1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 80792d3..5d8d656 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -27,6 +27,7 @@
  #include <linux/wait.h>
  #include <linux/vmalloc.h>
  #include <linux/sched.h>
+#include <linux/firmware.h>

  #include <linux/hid.h>
  #include <linux/hiddev.h>
@@ -640,6 +641,10 @@ int hid_parse_report(struct hid_device *device, 
__u8 *start,
  	struct hid_item item;
  	__u8 *end;
  	int ret;
+	const struct firmware *fw;
+	int succ;
+	char *file;
+
  	static int (*dispatch_type[])(struct hid_parser *parser,
  				      struct hid_item *item) = {
  		hid_parser_main,
@@ -650,10 +655,27 @@ int hid_parse_report(struct hid_device *device, 
__u8 *start,

  	if (device->driver->report_fixup)
  		device->driver->report_fixup(device, start, size);
+	/* Now load a hid descriptor from a file firmware
+	ignoring this fixup thing */
+	file=kmalloc(29, GFP_KERNEL);
+ 
sprintf(file,"hid/%04X:%04X:%04X:%04X.bin",device->bus,device->vendor,device->product,device->version);
+
+	succ = request_firmware(&fw, file, &device->dev);
+
+	if (succ)
+		printk(KERN_INFO "To relace HID descriptor place it in 
/lib/firmaware/%s\n", file);
+	else{
+		start = fw->data;
+		size = fw->size;
+		printk(KERN_INFO "HID descriptor relaced with /lib/firmaware/%s\n", 
file);
+	}
+	kfree(file);

  	device->rdesc = kmalloc(size, GFP_KERNEL);
-	if (device->rdesc == NULL)
+	if (device->rdesc == NULL){
+		if(!succ)release_firmware(fw);
  		return -ENOMEM;
+	}
  	memcpy(device->rdesc, start, size);
  	device->rsize = size;

@@ -690,6 +712,7 @@ int hid_parse_report(struct hid_device *device, __u8 
*start,
  				dbg_hid("unbalanced delimiter at end of report description\n");
  				goto err;
  			}
+			if(!succ)release_firmware(fw);
  			vfree(parser);
  			return 0;
  		}
@@ -697,6 +720,7 @@ int hid_parse_report(struct hid_device *device, __u8 
*start,

  	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
  err:
+	if(!succ)release_firmware(fw);
  	vfree(parser);
  	return ret;
  }
-- 1.6.5.7
