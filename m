From: Jimmy Berry <jimmy@boombatower.com>
Subject: [PATCH] HID: usbhid: add Logitech G710+ keyboard quirk NOGET
Date: Fri, 20 Nov 2015 01:10:28 -0600
Message-ID: <1448003428-7720-1-git-send-email-jimmy@boombatower.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1-01.gzo.com ([216.172.104.48]:38517 "EHLO mx1-01.gzo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759354AbbKTH0t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 02:26:49 -0500
Received: from mx1.gzo.com (localhost [127.0.0.1])
	by mx1.gzo.com (Postfix) with ESMTP id BFAF9C1B473
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 01:11:48 -0600 (CST)
Received: from mx1.gzo.com (localhost [127.0.0.1])
	by mx1.gzo.com (Postfix) with ESMTP id 70FBCC1B478
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 01:11:44 -0600 (CST)
Received: from cpanel78.gzo.com (cpanel78.gzo.com [216.172.104.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.gzo.com (Postfix) with ESMTPS id 70005C1B473
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 01:11:44 -0600 (CST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Jimmy Berry <jimmy@boombatower.com>

Without quirk keyboard repeats '6' until volume control is used since it
indicates the key is pressed without ever releasing.

Signed-off-by: Jimmy Berry <jimmy@boombatower.com>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ac1feea..9024a3d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -609,6 +609,7 @@
 #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
 #define USB_DEVICE_ID_LOGITECH_HARMONY_LAST 0xc14f
 #define USB_DEVICE_ID_LOGITECH_HARMONY_PS3 0x0306
+#define USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS 0xc24d
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C01A	0xc01a
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C05A	0xc05a
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C06A	0xc06a
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 94bb137..2324520 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -84,6 +84,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C01A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
-- 
2.6.3

