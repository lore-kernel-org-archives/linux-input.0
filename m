From: Paulo Costa <me@paulo.costa.nom.br>
Subject: [PATCH] Input: add LED_0..LED_15 define
Date: Tue,  7 Feb 2017 22:41:41 -0200
Message-ID: <20170208004141.30540-1-me@paulo.costa.nom.br>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33474 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932122AbdBHAus (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 19:50:48 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so15687624qkl.0
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2017 16:50:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Paulo Costa <me@paulo.costa.nom.br>

Some input devices have many controllable leds that don't fit any standard function (e.g., the Wiimote has 4 controllable LEDs)

Just as we have BTN_0..BTN_9 for generic buttons, LED_0...LED_15 can now be used to control generic leds.

Signed-off-by: Paulo Costa <me@paulo.costa.nom.br>
---
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..d54cec1 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -288,7 +288,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
 #define INPUT_DEVICE_ID_ABS_MAX		0x3f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07
-#define INPUT_DEVICE_ID_LED_MAX		0x0f
+#define INPUT_DEVICE_ID_LED_MAX		0x1f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
 #define INPUT_DEVICE_ID_SW_MAX		0x0f
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3af60ee..4322682 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -812,7 +812,25 @@
 #define LED_MISC		0x08
 #define LED_MAIL		0x09
 #define LED_CHARGING		0x0a
-#define LED_MAX			0x0f
+
+#define LED_0			0x10
+#define LED_1			0x11
+#define LED_2			0x12
+#define LED_3			0x13
+#define LED_4			0x14
+#define LED_5			0x15
+#define LED_6			0x16
+#define LED_7			0x17
+#define LED_8			0x18
+#define LED_9			0x19
+#define LED_10			0x1a
+#define LED_11			0x1b
+#define LED_12			0x1c
+#define LED_13			0x1d
+#define LED_14			0x1e
+#define LED_15			0x1f
+
+#define LED_MAX			0x1f
 #define LED_CNT			(LED_MAX+1)
 
 /*
-- 
2.9.3

