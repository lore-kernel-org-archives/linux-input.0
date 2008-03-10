From: Guryanov Dmitry <dmitry.torokhov@gmail.com>
Subject: [PATCH 27/37] Input: aiptek - add support for Genius G-PEN 560 tablet
Date: Mon, 10 Mar 2008 03:08:58 -0700
Message-ID: <a32bcc45b9e9d8021b5936c45dc3f8db7a044466.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9129 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759917AbYDUNTB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:01 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106316waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:01 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

USBHID driver only supports relative mode with this tablet so let aiptek
module handle it.

Signed-off-by: Dmitry Guryanov <guryanov@dgap.mipt.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/hid/usbhid/hid-quirks.c |    4 ++++
 drivers/input/tablet/Kconfig    |   10 +++++-----
 drivers/input/tablet/aiptek.c   |    2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e29a057..17b2f49 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -405,6 +405,9 @@
 #define USB_VENDOR_ID_YEALINK		0x6993
 #define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
 
+#define USB_VENDOR_ID_KYE		0x0458
+#define USB_DEVICE_ID_KYE_GPEN_560	0x5003
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -703,6 +706,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_63, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_64, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR, USB_DEVICE_ID_N_S_HARMONY, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_GPEN_560, HID_QUIRK_IGNORE },
 
 	{ 0, 0 }
 };
diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index d371c0b..effb49e 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -25,14 +25,14 @@ config TABLET_USB_ACECAD
 	  module will be called acecad.
 
 config TABLET_USB_AIPTEK
-	tristate "Aiptek 6000U/8000U tablet support (USB)"
+	tristate "Aiptek 6000U/8000U and Genius G_PEN tablet support (USB)"
 	depends on USB_ARCH_HAS_HCD
 	select USB
 	help
-	  Say Y here if you want to use the USB version of the Aiptek 6000U
-	  or Aiptek 8000U tablet.  Make sure to say Y to "Mouse support"
-	  (CONFIG_INPUT_MOUSEDEV) and/or "Event interface support"
-	  (CONFIG_INPUT_EVDEV) as well.
+	  Say Y here if you want to use the USB version of the Aiptek 6000U,
+	  Aiptek 8000U or Genius G-PEN 560 tablet.  Make sure to say Y to
+	  "Mouse support" (CONFIG_INPUT_MOUSEDEV) and/or "Event interface
+	  support" (CONFIG_INPUT_EVDEV) as well.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called aiptek.
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 94683f5..1d759f6 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -184,6 +184,7 @@
  */
 
 #define USB_VENDOR_ID_AIPTEK				0x08ca
+#define USB_VENDOR_ID_KYE				0x0458
 #define USB_REQ_GET_REPORT				0x01
 #define USB_REQ_SET_REPORT				0x09
 
@@ -832,6 +833,7 @@ static const struct usb_device_id aiptek_ids[] = {
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x22)},
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x23)},
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x24)},
+	{USB_DEVICE(USB_VENDOR_ID_KYE, 0x5003)},
 	{}
 };
 
-- 
1.5.5.rc2.6.gf58d


