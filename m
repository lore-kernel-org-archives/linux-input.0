From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] HID: Add MULTI_INPUT quirk for another D-WAV touchscreen
Date: Tue, 21 Dec 2010 11:55:18 +0100
Message-ID: <1292928918-31264-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:44326 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab0LUKzn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Dec 2010 05:55:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3341baa..b76166a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -196,6 +196,7 @@
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1	0x720c
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2	0x72a1
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 2c18547..52ceeda 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -34,6 +34,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-- 
1.7.3.2

