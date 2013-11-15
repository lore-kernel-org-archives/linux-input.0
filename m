From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4 v3] input: wacom - make sure touch_max is set for touch devices
Date: Fri, 15 Nov 2013 11:59:14 -0800
Message-ID: <1384545554-15472-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38190 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3KOT7Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 14:59:25 -0500
Received: by mail-pa0-f42.google.com with SMTP id kx10so3300531pab.29
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 11:59:25 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net, Ping Cheng <pingc@wacom.com>

Old single touch Tablet PCs do not have touch_max set at
wacom_features. Since touch device at lease supports one
finger, assign touch_max to 1 when touch usage is defined
in its HID Descriptor and touch_max is not pre-defined.

Tested-by: Jason Gerecke <killertofu@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 8a90da1..3d71b60 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -304,7 +304,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	char limit = 0;
 	/* result has to be defined as int for some devices */
-	int result = 0;
+	int result = 0, touch_max = 0;
 	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
 	unsigned char *report;
 
@@ -351,7 +351,8 @@ static int wacom_parse_hid(struct usb_interface *intf,
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
 						features->device_type = BTN_TOOL_FINGER;
-
+						/* touch device at least supports one touch point */
+						touch_max = 1;
 						switch (features->type) {
 						case TABLETPC2FG:
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
@@ -504,6 +505,8 @@ static int wacom_parse_hid(struct usb_interface *intf,
 	}
 
  out:
+	if (!features->touch_max && touch_max)
+		features->touch_max = touch_max;
 	result = 0;
 	kfree(report);
 	return result;
-- 
1.8.3.2

