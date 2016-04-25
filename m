From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: [PATCH v2] hid: Fix boot delay for Creative SB Omni Surround 5.1 with
 quirk
Date: Mon, 25 Apr 2016 17:01:56 +0300
Message-ID: <7b30aa00-7085-1f6f-7bad-ac19532cc611@mokrynskyi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.3.12.4.46.clients.your-server.de ([46.4.12.3]:51165 "EHLO
	mx.mokrynskyi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583AbcDYOCE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 10:02:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx.mokrynskyi.com (Postfix) with ESMTP id 5779813548
	for <linux-input@vger.kernel.org>; Mon, 25 Apr 2016 14:02:02 +0000 (UTC)
Received: from mx.mokrynskyi.com ([127.0.0.1])
	by localhost (mx.mokrynskyi.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqFiMc5Iz8YT for <linux-input@vger.kernel.org>;
	Mon, 25 Apr 2016 14:02:01 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Needed for v2 of the device firmware, otherwise kernel will stuck for few
seconds and throw "usb_submit_urb(ctrl) failed: -1" early on system boot.

Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
---
No changes, just resubmission to ensure absence of undesired line breaks
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c6eaff5..0238f01 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -259,6 +259,7 @@
 #define USB_DEVICE_ID_CORSAIR_K90    0x1b02

 #define USB_VENDOR_ID_CREATIVELABS    0x041e
+#define USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51    0x322c
 #define USB_DEVICE_ID_PRODIKEYS_PCMIDI    0x2801

 #define USB_VENDOR_ID_CVTOUCH        0x1ff7
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index ed2f68e..53fc856 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -71,6 +71,7 @@ static const struct hid_blacklist {
     { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
     { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
     { USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
+    { USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
     { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
     { USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
     { USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
-- 
2.7.4 
