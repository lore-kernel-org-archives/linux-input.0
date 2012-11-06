From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH] HID: Ignore D-WAV/eGalax devices handled by usbtouchscreen
Date: Tue, 6 Nov 2012 13:41:22 -0500
Message-ID: <20121106184122.GT12501@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:42210 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab2KFSop (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Nov 2012 13:44:45 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

From: Forest Bond <forest.bond@rapidrollout.com>

Previously, both usbhid and usbtouchscreen would bind to D-WAV devices
with class HID and protocol None, so they would be claimed by whichever
driver was loaded first.  Some of these devices do in fact work with
usbhid, but not all of them do.  OTOH they all work with usbtouchscreen
as of commit 037a833ed05a86d01ea27a2c32043b86c549be1b ("Input:
usbtouchscreen - initialize eGalax devices").  So we ignore them in
usbhid to prevent getting in the way of usbtouchscreen and claiming an
interface that we may not be able to do anything useful with.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 drivers/hid/hid-core.c |   11 ++++++++++-
 drivers/hid/hid-ids.h  |    1 +
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f4109fd..f2d614e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2188,7 +2188,16 @@ static bool hid_ignore(struct hid_device *hdev)
 		if (hdev->product == USB_DEVICE_ID_JESS_YUREX &&
 				hdev->type == HID_TYPE_USBNONE)
 			return true;
-	break;
+		break;
+	case USB_VENDOR_ID_DWAV:
+		/* These are handled by usbtouchscreen. hdev->type is probably
+		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
+		 * usbtouchscreen. */
+		if ((hdev->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER ||
+		     hdev->product == USB_DEVICE_ID_DWAV_TOUCHCONTROLLER) &&
+		    hdev->type != HID_TYPE_USBMOUSE)
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9d7a428..3d73774 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -257,6 +257,7 @@
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
+#define USB_DEVICE_ID_DWAV_TOUCHCONTROLLER	0x0002
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480D	0x480d
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480E	0x480e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
-- 
1.7.0.4
