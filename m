From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 3/6] hid-multitouch: add support for GoodTouch panels
Date: Thu, 19 May 2011 14:18:15 +0200
Message-ID: <1305807498-8785-4-git-send-email-benjamin.tissoires__567.348188678984$1305807624$gmane$org@enac.fr>
References: <1305807498-8785-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:57172 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756931Ab1ESMSs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 08:18:48 -0400
In-Reply-To: <1305807498-8785-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <ch>

This patch introduce support for GoodTouch panels.
This device has not been optimized in term of kernel processing
operations (default class), but it will work.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/Kconfig          |    1 +
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-multitouch.c |    5 +++++
 4 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 69a2cc9..10b8f90 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -308,6 +308,7 @@ config HID_MULTITOUCH
 	  - CVTouch panels
 	  - Cypress TrueTouch panels
 	  - Elo TouchSystems IntelliTouch Plus panels
+	  - GoodTouch panels
 	  - Hanvon dual touch panels
 	  - Ilitek dual touch panel
 	  - IrTouch Infrared USB panels
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index dbe949a..02c6c93 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1377,6 +1377,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH, USB_DEVICE_ID_GOODTOUCH_000f) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f617acb..7db188f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -262,6 +262,9 @@
 #define USB_DEVICE_ID_0_8_8_IF_KIT	0x0053
 #define USB_DEVICE_ID_PHIDGET_MOTORCONTROL	0x0058
 
+#define USB_VENDOR_ID_GOODTOUCH		0x1aad
+#define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
+
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
 #define USB_DEVICE_ID_GOGOPEN		0x00ce
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index af8789a..76ef60d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -609,6 +609,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
 			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
 
+	/* GoodTouch panels */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,
+			USB_DEVICE_ID_GOODTOUCH_000f) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_DEFAULT,
 		HID_USB_DEVICE(USB_VENDOR_ID_ILITEK,
-- 
1.7.4.4

