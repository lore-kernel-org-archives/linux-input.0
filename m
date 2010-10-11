From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] HID: Add MULTI_INPUT quirk for MozArt touchscreen
Date: Mon, 11 Oct 2010 16:54:55 +0200
Message-ID: <20101011165455.1e13789c@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43233 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab0JKOzI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 10:55:08 -0400
Received: by wye20 with SMTP id 20so525176wye.19
        for <linux-input@vger.kernel.org>; Mon, 11 Oct 2010 07:55:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Pierre BAILLY <pierre@substantiel.fr>

From: Pierre BAILLY <pierre@substantiel.fr>

This device generates ABS_Z and ABS_RX events, while it should be
generating ABS_X and ABS_Y instead. Using the MULTI_INPUT quirk solves
this issue.

Reference: https://bugs.launchpad.net/ubuntu/+bug/620609/

Signed-off-by: Pierre BAILLY <pierre@substantiel.fr>
Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 31601ee..4df6036 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -483,6 +483,7 @@
 
 #define USB_VENDOR_ID_TURBOX		0x062a
 #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
+#define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART	0x7100
 
 #define USB_VENDOR_ID_TWINHAN           0x6253
 #define USB_DEVICE_ID_TWINHAN_IR_REMOTE 0x0100
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 5f5aa39..a22e38c 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -34,6 +34,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
-- 
1.7.1

