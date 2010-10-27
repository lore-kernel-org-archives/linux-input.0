From: Anton Chikin <kverlin@gmail.com>
Subject: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite Panaboard T-780 and T-880
Date: Wed, 27 Oct 2010 01:57:05 -0700
Message-ID: <1288169825-15422-1-git-send-email-Anton.Chikin@dataart.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35046 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0J0I5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 04:57:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: chatty@enac.fr, spbnick@gmail.com, anisse@astier.eu, cascardo@holoscopio.com, don@syst.com.br, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, grig@dataart.com, Anton Chikin <Anton.Chikin@dataart.com>, Anton Chikin <anton.chikin@dataart.com>

Added Panasonic vendor ID, two device IDs for Panasonic Whiteboard devices and new quirk to ignore
these devices in hid-core driver.

Signed-off-by: Anton Chikin <anton.chikin@dataart.com>
---
 drivers/hid/hid-ids.h           |    4 ++++
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3341baa..b5542d3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -446,6 +446,10 @@
 #define USB_VENDOR_ID_ORTEK		0x05a4
 #define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
 
+#define USB_VENDOR_ID_PANASONIC 	0x04da
+#define USB_DEVICE_ID_PANASONIC_PANABOARD_T780 	0x1044
+#define USB_DEVICE_ID_PANASONIC_PANABOARD_T880	0x104d 
+
 #define USB_VENDOR_ID_PANJIT		0x134c
 
 #define USB_VENDOR_ID_PANTHERLORD	0x0810
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 2c18547..b5788b0 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -65,6 +65,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID_PANASONIC_PANABOARD_T780, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID_PANASONIC_PANABOARD_T880, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
-- 
1.7.0.4

