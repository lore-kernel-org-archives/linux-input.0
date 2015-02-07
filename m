From: Lauri Kasanen <cand@gmx.com>
Subject: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Sat, 7 Feb 2015 15:48:59 +0200
Message-ID: <20150207154859.89a7e4e3.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54423 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbbBGNqx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Feb 2015 08:46:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ao2@ao2.it, AndrewD207@aol.com

Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
any events. Now everything works including the leds.

Based on work by Andrew Haines and Antonio Ospite.

cc: Antonio Ospite <ao2@ao2.it>
cc: Andrew Haines <AndrewD207@aol.com>
Signed-off-by: Lauri Kasanen <cand@gmx.com>
---
 drivers/hid/hid-sony.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

Antonio's original approach was not enough; it enabled the events,
but only for a few seconds, then the controller timed out and sent
no more. Andrew's did more than was necessary. This is a combination
of the two, against Linus' git.

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..de93386 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 #include <linux/input/mt.h>
+#include <linux/usb/input.h>
 
 #include "hid-ids.h"
 
@@ -1130,8 +1131,12 @@ static void sony_input_configured(struct hid_device *hdev,
  */
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *dev = interface_to_usbdev(intf);
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	char *buf = kmalloc(65, GFP_KERNEL);
+	unsigned char buf2[] = { 0x00 };
+	int transfered;
 
 	if (!buf)
 		return -ENOMEM;
@@ -1140,7 +1145,24 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 				 HID_REQ_GET_REPORT);
 
 	if (ret < 0)
-		hid_err(hdev, "can't set operational mode\n");
+		hid_err(hdev, "can't set operational mode on the control EP\n");
+
+	/*
+	 * Some compatible controllers like the Speedlink Strike FX and
+	 * Gasia need another query plus an USB interrupt to get operational.
+	 */
+	ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+
+	if (ret < 0)
+		hid_err(hdev, "can't set operational mode on the interrupt EP\n");
+
+	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
+				buf2, sizeof(buf2),
+				&transfered, USB_CTRL_SET_TIMEOUT);
+
+	if (ret < 0)
+		hid_err(hdev, "can't set operational mode on the interrupt EP\n");
 
 	kfree(buf);
 
-- 
1.8.3.1

