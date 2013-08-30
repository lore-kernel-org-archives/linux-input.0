From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH] HID: usbhid: quirk for N-Trig DuoSense Touch Screen
Date: Fri, 30 Aug 2013 14:47:26 -0400
Message-ID: <CABSveYg3gAnx=cKTqN-iqZdypzivXDuvVAJCdKdbCS6fz3gYkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:59310 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab3H3Srs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 14:47:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

The DuoSense touchscreen device causes a 10 second timeout. This fix
removes the delay.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 drivers/hid/hid-ids.h           |    2 ++
 drivers/hid/usbhid/hid-quirks.c |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2168885..c3929ea 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -898,4 +898,6 @@
 #define USB_VENDOR_ID_PRIMAX 0x0461
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD 0x4e05

+#define USB_DEVICE_ID_NTRIG_DUOSENSE 0x1500
+
 #endif
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 19b8360..3fd4dfd 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -89,6 +89,9 @@ static const struct hid_blacklist {
  { USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
  { USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK_NOGET },
  { USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
+
+ { USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NOGET },
+
  { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209,
HID_QUIRK_MULTI_INPUT },
  { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U,
HID_QUIRK_MULTI_INPUT },
  { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5,
HID_QUIRK_MULTI_INPUT },
-- 
1.7.10.4
