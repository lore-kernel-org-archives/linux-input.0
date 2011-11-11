From: chris@cnpbagwell.com
Subject: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Fri, 11 Nov 2011 14:21:08 -0600
Message-ID: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43327 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab1KKUV2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Nov 2011 15:21:28 -0500
Received: by gyc15 with SMTP id 15so3265178gyc.19
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2011 12:21:28 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

This allows ASUS Eee Slate touchscreens to work.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---

I do not have one of these to test the patch but I helped a user
debug why his new touchscreen was being treated as a touchpad.
He reported success after adding this ID.

I'm sending this since I'm unsure status of patch to auto-assign
multitouch devices to hid-multitouch. That would probably have
solved issue as well.

 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |    3 +++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 848a56c..f973d33 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1409,6 +1409,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2515) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 06ce996..7bb5227 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -235,6 +235,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2	0x72a1
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3	0x480e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4	0x726b
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5	0xa001
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f1c909f..a59d939 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -662,6 +662,9 @@ static const struct hid_device_id mt_devices[] = {
 	{  .driver_data = MT_CLS_EGALAX,
 		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
+	{  .driver_data = MT_CLS_EGALAX,
+		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
 
 	/* Elo TouchSystems IntelliTouch Plus panel */
 	{ .driver_data = MT_CLS_DUAL_NSMU_CONTACTID,
-- 
1.7.7

