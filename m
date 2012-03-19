From: Andreas Nielsen <eas@svep.se>
Subject: [PATCH] HID: multitouch: add PID for Fructel product
Date: Mon, 19 Mar 2012 15:41:03 +0100
Message-ID: <1332168063-24812-1-git-send-email-eas@svep.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchange.svep.se ([213.80.127.210]:32819 "EHLO
	Exchange-1.svep.se" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752766Ab2CSOsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 10:48:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@enac.fr, chatty@enac.fr, dmitry.torokhov@gmail.com, jkosina@suse.cz, Andreas Nielsen <eas@svep.se>

Adds multitouch support for the Gametel Android game controller

Signed-off-by: Andreas Nielsen <eas@svep.se>
---
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-multitouch.c |    5 +++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6f3289a..dbb7a7b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1378,6 +1378,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2515) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_FRUCTEL, USB_DEVICE_ID_GAMETEL_MT_MODE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c946d90..452d845 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -248,6 +248,9 @@
 #define USB_VENDOR_ID_EZKEY		0x0518
 #define USB_DEVICE_ID_BTC_8193		0x0002
 
+#define USB_VENDOR_ID_FRUCTEL	0x25B6
+#define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
+
 #define USB_VENDOR_ID_GAMERON		0x0810
 #define USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR	0x0001
 #define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR	0x0002
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5de25ff..3eea20c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -667,6 +667,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
 			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
 
+	/* Gametel game controller */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_FRUCTEL,
+			USB_DEVICE_ID_GAMETEL_MT_MODE) },
+
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_DEFAULT,
 		HID_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,
-- 
1.7.1

