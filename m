From: Jonathan Rockway <jon@jrock.us>
Subject: [PATCH] add support for my CH Eclipse yoke
Date: Sat,  3 Jul 2010 02:59:01 -0500
Message-ID: <1278143941-10817-1-git-send-email-jon@jrock.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dsl253-036-036.chi1.dsl.speakeasy.net ([66.253.36.36]:51030
	"EHLO snowball2.jrock.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0GCIeA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Jul 2010 04:34:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Rockway <jon@jrock.us>

This USB flight yoke needs the NOGET quirk, like most of CH's other
products.  This patch adds that :)

---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index adbef5d..b2c5bd5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -117,6 +117,7 @@
 #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
 #define USB_DEVICE_ID_CH_COMBATSTICK	0x00f4
 #define USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE	0x00ff
+#define USB_DEVICE_ID_CH_FLIGHT_SIM_ECLIPSE_YOKE	0x0051

 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 0d9045a..f5bd7e8 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -52,6 +52,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_ECLIPSE_YOKE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
--
1.7.1

