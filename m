Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DB3EC81B
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417867; cv=none; b=bha8gu/VQ90VqX+P3K9tj13E0l6RJvwVgTP0L9Fa/vBj9BPoX/lWL6p7K6POpiOs4FiylJlc2p4TzlSB7LFORjh9z0GpiuLRnBOHn6K3s5BJ3Kd1Ncxp9/XF7+Z15+hyuW2t+qx9RCtOSTOIfiLSKOlmg4qhBZbzWU9TEDhSQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417867; c=relaxed/simple;
	bh=rt0uf5ENDUFezdgnDnZTZzJtTUD/9Ca8kwTZGSnZtmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abB2hV0GVnZQIW8q2pXVBr8NDHeh5uPSIMCrS9b5bZgKqYhWqifiMx+PxiPV1kwMwoN4u34kw0nuyRVRxQO4xuPeBjt/fZA4GSGIHSyN6pDG1ctiWNIFPfb4Z3fMr2RXthE2pokbi5Jt21Ogz15bCgIXYmXSXH90W/NOlbJ1sFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w9rOz+Q0; arc=none smtp.client-ip=95.215.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w9rOz+Q0"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rt0uf5ENDUFezdgnDnZTZzJtTUD/9Ca8kwTZGSnZtmU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788417857; v=1; x=1789022657;
 b=w9rOz+Q0Ceb36XjiKUW0oT0cQBlYWCgfZ5t6eog7/wK5Ymzsd7K+PET8Igsm8Jpw0gKP0lDG
 UgQ2/MLbt2dqYFAYJvb3naEzDuSp2PcOkwVAO+sXaJLgdOfoPHurRKD+za+QrvlSU9jwG4K017R
 egktj/LrTX1fG74KK7xRJsAU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb1b68e32c3346e3;
	Thu, 03 Sep 2026 06:44:17 +0000
X-Mizu-Trace-ID: bb1b68e32c3346e3
X-Migadu-Flow: FLOW_OUT
From: Aditya Garg <aditya.garg@linux.dev>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: apple: ignore the trackpad on T2 Macs
Date: Thu,  3 Sep 2026 12:14:07 +0530
Message-ID: <20260903064407.27755-1-aditya.garg@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trackpad on T2 Macs is incorrectly bound by the hid-apple driver.
This is due to both trackpad and keyboard sharing the same VID/PID.
Use the existing APPLE_IGNORE_MOUSE quirk for the same.

Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
---
 drivers/hid/hid-apple.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 4505e5839..cdc008c66 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -30,7 +30,7 @@
 #include "hid-ids.h"
 
 #define APPLE_RDESC_JIS		BIT(0)
-/* BIT(1) reserved, was: APPLE_IGNORE_MOUSE */
+#define APPLE_IGNORE_MOUSE	BIT(1)
 #define APPLE_HAS_FN		BIT(2)
 /* BIT(3) reserved, was: APPLE_HIDDEV */
 #define APPLE_ISO_TILDE_QUIRK	BIT(4)
@@ -951,6 +951,9 @@ static int apple_probe(struct hid_device *hdev,
 	    hdev->type != HID_TYPE_SPI_KEYBOARD)
 		return -ENODEV;
 
+	if (quirks & APPLE_IGNORE_MOUSE && hdev->type == HID_TYPE_USBMOUSE)
+		return -ENODEV;
+
 	asc = devm_kzalloc(&hdev->dev, sizeof(*asc), GFP_KERNEL);
 	if (asc == NULL) {
 		hid_err(hdev, "can't alloc apple descriptor\n");
@@ -1173,27 +1176,31 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K),
-		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK |
+				APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132),
 		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK |
-			APPLE_DISABLE_FKEYS },
+			APPLE_DISABLE_FKEYS | APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680),
 		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK |
-			APPLE_DISABLE_FKEYS },
+			APPLE_DISABLE_FKEYS | APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680_ALT),
 		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK |
-			APPLE_DISABLE_FKEYS },
+			APPLE_DISABLE_FKEYS | APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213),
 		.driver_data = APPLE_HAS_FN | APPLE_BACKLIGHT_CTL | APPLE_ISO_TILDE_QUIRK |
-			APPLE_DISABLE_FKEYS },
+			APPLE_DISABLE_FKEYS | APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS |
+				APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS |
+				APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_IGNORE_MOUSE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_DISABLE_FKEYS |
+				APPLE_IGNORE_MOUSE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
-- 
2.50.1

