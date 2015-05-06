From: Sean Young <sean@mess.org>
Subject: [PATCH 2/2] HID: core: remove phidgets from ignore list
Date: Wed,  6 May 2015 21:38:43 +0100
Message-ID: <1430944724-3980-2-git-send-email-sean@mess.org>
References: <1430944724-3980-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gofer.mess.org ([80.229.237.210]:45866 "EHLO gofer.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbbEFUqZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2015 16:46:25 -0400
In-Reply-To: <1430944724-3980-1-git-send-email-sean@mess.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Once upon a time there were kernel drivers for some of the phidgets devices,
and for those kernel drivers to work the hid system needed exceptions. Now
the kernel drivers are long since gone in favour of the user-space drivers
which don't need the exceptions.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/hid/hid-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1855b65..0731d96 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2245,14 +2245,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_16_16_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_8_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_7_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_PHIDGET_MOTORCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_SUPER_Q2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_GOGOPEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_PENPOWER) },
@@ -2384,9 +2376,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LCSPEC) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU, USB_DEVICE_ID_RI_KA_WEBMAIL) },
 	{ }
-- 
2.1.0

