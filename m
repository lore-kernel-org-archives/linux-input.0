From: Florian Mueller <contact@petrockblock.com>
Subject: [PATCH] HID: add multi-input quirk for GamepadBlock
Date: Mon, 16 Oct 2017 09:29:11 +0200
Message-ID: <1508138951-5018-1-git-send-email-contact@petrockblock.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:55060 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdJPIDR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 04:03:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: contact@petrockblock.com

The GamepadBlock game controller adapter needs HID_QUIRK_MULTI_INPUT
to split it up into two input devices. Without this quirk the
adapter is falsely recognized as only one device and mixes up the
inputs of the two connected controllers.

Signed-off-by: Florian Mueller <contact@petrockblock.com>
---
 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a989191..1b1c86d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -727,6 +727,9 @@
 #define USB_DEVICE_ID_MCC_PMD1024LS	0x0076
 #define USB_DEVICE_ID_MCC_PMD1208LS	0x007a
 
+#define USB_VENDOR_ID_MCS		0x16d0
+#define USB_DEVICE_ID_MCS_GAMEPADBLOCK	0x0bcc
+
 #define USB_VENDOR_ID_MGE		0x0463
 #define USB_DEVICE_ID_MGE_UPS		0xffff
 #define USB_DEVICE_ID_MGE_UPS1		0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index f489a5c..331f7f3 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -170,6 +170,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_GAMEPADBLOCK, HID_QUIRK_MULTI_INPUT },
 
 	{ 0, 0 }
 };
-- 
2.7.4

