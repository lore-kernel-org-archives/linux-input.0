From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH v2] HID: usbhid: quirk for N-Trig DuoSense Touch Screen
Date: Fri, 30 Aug 2013 18:25:04 -0400
Message-ID: <CABSveYikpdAy9rUDfVrL=jAj7OCqFXyPd7GsvjTnhH3K=u--Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49381 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3H3WZ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 18:25:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

The DuoSense touchscreen device causes a 10 second timeout. This fix
removes the delay.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2168885..376170e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -646,6 +646,7 @@
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_16   0x0012
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_17   0x0013
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18   0x0014
+#define USB_DEVICE_ID_NTRIG_DUOSENSE 0x1500

 #define USB_VENDOR_ID_ONTRAK 0x0a07
 #define USB_DEVICE_ID_ONTRAK_ADU100 0x0064
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 19b8360..1671b47 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -109,6 +109,7 @@ static const struct hid_blacklist {
  { USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD,
HID_QUIRK_NO_INIT_REPORTS },
  { USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X,
HID_QUIRK_MULTI_INPUT },
  { USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
+ { USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE,
HID_QUIRK_NO_INIT_REPORTS },
  { 0, 0 }
 };

-- 
1.7.10.4
