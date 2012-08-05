From: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/2] input: usb: hid: Add quirk for Freescale i.MX28 ROM recovery
Date: Sun,  5 Aug 2012 23:57:15 +0200
Message-ID: <1344203835-8308-2-git-send-email-marex@denx.de>
References: <1344203835-8308-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54699 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab2HEV5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Aug 2012 17:57:25 -0400
In-Reply-To: <1344203835-8308-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Marek Vasut <marex@denx.de>, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>, Jiri Kosina <jkosina@suse.cz>

The USB recovery mode present in i.MX28 ROM emulates USB HID.
It needs this quirk to behave properly.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter <B29397@freescale.com>
Cc: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1dcb76f..ab8ce9f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -296,6 +296,9 @@
 #define USB_VENDOR_ID_EZKEY		0x0518
 #define USB_DEVICE_ID_BTC_8193		0x0002
 
+#define USB_VENDOR_ID_FREESCALE		0x15A2
+#define USB_DEVICE_ID_FREESCALE_MX28	0x004F
+
 #define USB_VENDOR_ID_FRUCTEL	0x25B6
 #define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 903eef3..6a09570 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -101,6 +101,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
 	{ 0, 0 }
 };
 
-- 
1.7.10.4

