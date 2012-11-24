From: Marek Vasut <marex@denx.de>
Subject: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Sat, 24 Nov 2012 06:15:57 +0100
Message-ID: <1353734157-9119-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37367 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab2KXFQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Nov 2012 00:16:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>, Jiri Kosina <jkosina@suse.cz>

The USB recovery mode present in i.MX23 ROM emulates USB HID.
It needs this quirk to behave properly.

Even if the official branding of the chip is Freescale i.MX23,
I named it Sigmatel STMP3780 since that's what the chip really
is and it even reports itself as STMP3780.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter <B29397@freescale.com>
Cc: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 4 insertions(+)

NOTE: it'd be nice to include this in -stable eventually.

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9d7a428..1ef9a9e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -696,6 +696,9 @@
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
 
+#define USB_VENDOR_ID_SIGMATEL		0x066F
+#define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
+
 #define USB_VENDOR_ID_SKYCABLE			0x1223
 #define	USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER	0x3F07
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 11c7932..0a1429f 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -79,6 +79,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
-- 
1.7.10.4

