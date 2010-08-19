From: David Gow <david@ingeniumdigital.com>
Subject: [PATCH] hid: Add support for chicony multitouch screens.
Date: Thu, 19 Aug 2010 15:43:56 +0800
Message-ID: <1282203836-5895-1-git-send-email-david@ingeniumdigital.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, chatty@enac.fr, dhprince-devel@yahoo.co.uk, dtor@mail.ru, kees.bakker@xs4all.nl, cascardo@holoscopio.com, don@syst.com.br, peter.hutterer@who-t.net, daniel@caiaq.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, David Gow <david@ingeniumdigital.com>
List-Id: linux-input@vger.kernel.org

Adds a hid quirk for the chicony multitouch screen found in the Acer
Aspire 1820pt notebook.

Signed-off-by: David Gow <david@ingeniumdigital.com>
---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 85c6d13..2905142 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -149,6 +149,7 @@
 
 #define USB_VENDOR_ID_CHICONY		0x04f2
 #define USB_DEVICE_ID_CHICONY_TACTICAL_PAD	0x0418
+#define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 
 #define USB_VENDOR_ID_CIDC		0x1677
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 2643d31..51ec481 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -77,6 +77,8 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL, HID_QUIRK_HIDINPUT_FORCE },
 
+	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH, HID_QUIRK_MULTI_INPUT },
+	
 	{ 0, 0 }
 };
 
-- 
1.7.0.4
