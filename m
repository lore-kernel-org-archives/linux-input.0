From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Fix for N-trig touch panel with recent firmware
Date: Tue, 06 Apr 2010 22:22:58 +0200
Message-ID: <20100406202258.837F19520E@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:49928 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab0DFUcz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 16:32:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: micki@n-trig.com, rafi@seas.upenn.edu, dmitry.torokhov@gmail.com, chatty@enac.fr

Added an init message that avoids device freeze with recent firmware.

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Rafi Rubin <rafi@seas.upenn.edu>

diff -rupN a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
--- a/drivers/hid/hid-ntrig.c	2010-03-20 02:17:57.000000000 +0100
+++ b/drivers/hid/hid-ntrig.c	2010-04-02 01:06:11.000000000 +0200
@@ -1,8 +1,8 @@
 /*
  *  HID driver for N-Trig touchscreens
  *
- *  Copyright (c) 2008 Rafi Rubin
- *  Copyright (c) 2009 Stephane Chatty
+ *  Copyright (c) 2008-2010 Rafi Rubin
+ *  Copyright (c) 2009-2010 Stephane Chatty
  *
  */
 
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
 
 #include "hid-ids.h"
 
@@ -285,6 +287,7 @@ static int ntrig_probe(struct hid_device
 	struct ntrig_data *nd;
 	struct hid_input *hidinput;
 	struct input_dev *input;
+	struct hid_report *report;
 
 	if (id->driver_data)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
@@ -348,6 +351,11 @@ static int ntrig_probe(struct hid_device
 		}
 	}
 
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0x0a]; 
+	if (report)
+		usbhid_submit_report(hdev, report, USB_DIR_OUT);
+
+
 	return 0;
 err_free:
 	kfree(nd);

