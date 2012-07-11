From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom: Add support for EMR on Cintiq 24HD touch
Date: Wed, 11 Jul 2012 10:16:05 -0700
Message-ID: <1342026965-1331-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63109 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab2GKRQW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jul 2012 13:16:22 -0400
Received: by gglu4 with SMTP id u4so1466409ggl.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jul 2012 10:16:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jason Gerecke <killertofu@gmail.com>

Adds support for the EMR digitizer on the Cintiq 24HD touch. The
EMR digitizer should work identically to that found on the Cintiq
24HD. The touch digitizer is a separate USB device similar to how
we split apart some other devices.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
NOTE: If you're wondering where the patches for touch are, I'll be
submitting them once I can get my hands on a unit to test against
(touch uses a new packet format, unlike the EMR interface). Since
the addition of touch isn't the sole reason to buy this model, it
makes sense to support at least the EMR in the mean time.

 drivers/input/tablet/wacom_wac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 6533f44..51c7208 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1835,7 +1835,10 @@ static const struct wacom_features wacom_features_0x2A =
 	{ "Wacom Intuos5 M", WACOM_PKGLEN_INTUOS,  44704, 27940, 2047,
 	  63, INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xF4 =
-	{ "Wacom Cintiq 24HD",    WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
+	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
+	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0xF8 =
+	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
 	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX",    WACOM_PKGLEN_INTUOS,    87200, 65600, 1023,
@@ -2075,6 +2078,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
+	{ USB_DEVICE_WACOM(0xF8) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
 };
-- 
1.7.11.1

