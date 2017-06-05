From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/2] HID: asus: Add support for Zen AiO MD-5110 keyboard
Date: Mon,  5 Jun 2017 14:58:57 -0600
Message-ID: <20170605205857.17789-2-drake@endlessm.com>
References: <20170605205857.17789-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36040 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU7G (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2017 16:59:06 -0400
Received: by mail-vk0-f50.google.com with SMTP id p85so72692266vkd.3
        for <linux-input@vger.kernel.org>; Mon, 05 Jun 2017 13:59:05 -0700 (PDT)
In-Reply-To: <20170605205857.17789-1-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com

Add support for media keys on the MD-5110 wireless keyboard that comes
with the Asus V221ID and ZN241IC All In One computers.

The keys to support here are WLAN, BRIGHTNESSDOWN and BRIGHTNESSUP.

The USB Vendor ID suggests that it is a TURBOX device, but
the physical branding only mentions ASUS MD-5110.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/hid/hid-asus.c | 1 +
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16a88da545b1..a4a3c38bc145 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -600,6 +600,7 @@ static const struct hid_device_id asus_devices[] = {
 		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
 	{ }
 };
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 391dcc94d2c2..006cece0f6aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2090,6 +2090,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID_TOPSEED2_RF_COMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 10ad3899c079..20371ab0cac8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1022,6 +1022,7 @@
 
 #define USB_VENDOR_ID_TURBOX		0x062a
 #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
+#define USB_DEVICE_ID_ASUS_MD_5110	0x5110
 #define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART	0x7100
 
 #define USB_VENDOR_ID_TWINHAN		0x6253
-- 
2.11.0

