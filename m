From: JamChen <jam.chen.egalax@gmail.com>
Subject: [PATCH] HID: core: assign usbhid to handle EETI PID=0x0001 HID device
Date: Fri, 11 Aug 2017 15:42:01 +0800
Message-ID: <20170811074201.2747-1-jam.chen.egalax@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36911 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdHKHmR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 03:42:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zboszor@pr.hu, jam.chen.egalax@gmail.com

From: Jam Chen <jam.chen.egalax@gmail.com>

The vendor used the same PID(0x0001) for multiple touch IC controllers.
The newer ICs can support HID class and report the multitouch collection
in the descriptor. So they were handled by the hid-multitouch driver.
But some customized firmwares don't support multitouch protocol even if
driver have got the Win8 blob data.

Actually, those ICs only support the single touch function, and report
the mouse protocol by default. We can assign usbhid to handle them all.

Signed-off-by: Jam Chen <jam.chen.egalax@gmail.com>
---
 drivers/hid/hid-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9017dcc14502..df4696022488 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -828,6 +828,10 @@ static int hid_scan_report(struct hid_device *hid)
 				 */
 				hid->group = HID_GROUP_RMI;
 		break;
+	case USB_VENDOR_ID_DWAV:
+		if (hid->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
+			hid->group = HID_GROUP_GENERIC;
+		break;
 	}
 
 	/* fall back to generic driver in case specific driver doesn't exist */
-- 
2.11.0

