From: Kevin Daughtridge <kevin@kdau.com>
Subject: [PATCH v2] HID: leave dev_rdesc unmodified and use it for comparisons
Date: Tue, 18 Sep 2012 19:36:33 -0700
Message-ID: <50592FB1.7000800@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38735 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab2ISCgg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 22:36:36 -0400
Received: by pbbrr13 with SMTP id rr13so1312976pbb.19
        for <linux-input@vger.kernel.org>; Tue, 18 Sep 2012 19:36:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Kevin Daughtridge <kevin@kdau.com>

The dev_rdesc member of the hid_device structure is meant to store the original
report descriptor received from the device, but it is currently passed to any
report_fixup method before it is copied to the rdesc member. This patch moves
the kmemdup to before, not after, the report_fixup call, keeping dev_rdesc
unchanged.

usbhid's hid_post_reset checks the report descriptor currently returned by the
device against a descriptor that may have been modified by a driver's
report_fixup method. That leaves some devices nonfunctional after a resume, with
a "reset_resume error 1" reported. This patch checks the new descriptor against
the unmodified dev_rdesc instead.

BugLink:http://bugs.launchpad.net/bugs/1049623
Signed-off-by: Kevin Daughtridge<kevin@kdau.com>
---
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -775,12 +775,14 @@ int hid_open_report(struct hid_device *d
  		return -ENODEV;
  	size = device->dev_rsize;
  
+	start = kmemdup(start, size, GFP_KERNEL);
+	if (start == NULL)
+		return -ENOMEM;
+
  	if (device->driver->report_fixup)
  		start = device->driver->report_fixup(device, start, &size);
  
-	device->rdesc = kmemdup(start, size, GFP_KERNEL);
-	if (device->rdesc == NULL)
-		return -ENOMEM;
+	device->rdesc = start;
  	device->rsize = size;
  
  	parser = vzalloc(sizeof(struct hid_parser));
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1436,7 +1436,7 @@ static int hid_post_reset(struct usb_int
  		kfree(rdesc);
  		return 1;
  	}
-	status = memcmp(rdesc, hid->rdesc, hid->rsize);
+	status = memcmp(rdesc, hid->dev_rdesc, hid->rsize);
  	kfree(rdesc);
  	if (status != 0) {
  		dbg_hid("report descriptor changed\n");

