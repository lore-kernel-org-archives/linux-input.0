From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] HID: wacom - Add support for DTU-1031X
Date: Thu,  4 Dec 2014 18:23:04 -0800
Message-ID: <1417746184-12192-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50610 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaLECXJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2014 21:23:09 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so18939016pde.33
        for <linux-input@vger.kernel.org>; Thu, 04 Dec 2014 18:23:08 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a8a19a5..b65e0d7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1847,6 +1847,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case DTUS:
+	case DTUSX:
 		sync = wacom_dtus_irq(wacom_wac);
 		break;
 
@@ -2211,6 +2212,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case DTUS:
+	case DTUSX:
 	case PL:
 	case DTU:
 		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
@@ -2722,6 +2724,10 @@ static const struct wacom_features wacom_features_0xFB =
 	{ "Wacom DTU1031", 22096, 13960, 511, 0,
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
+static const struct wacom_features wacom_features_0x32F =
+	{ "Wacom DTU1031X", 22472, 12728, 511, 0,
+	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
@@ -3057,6 +3063,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x315) },
 	{ USB_DEVICE_WACOM(0x317) },
 	{ USB_DEVICE_WACOM(0x323) },
+	{ USB_DEVICE_WACOM(0x32F) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 128cbb3..5384043 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -80,6 +80,7 @@ enum {
 	PL,
 	DTU,
 	DTUS,
+	DTUSX,
 	INTUOS,
 	INTUOS3S,
 	INTUOS3,
-- 
1.9.1

