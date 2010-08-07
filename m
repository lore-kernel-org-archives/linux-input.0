From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input: add ABS definitions for 16 pressure sensitve pads
Date: Sat,  7 Aug 2010 17:38:17 +0200
Message-ID: <1281195497-6957-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:41844 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0HGPig (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Aug 2010 11:38:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/input.h           |   19 ++++++++++++++++++-
 include/linux/mod_devicetable.h |    2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 896a922..b88d965 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -709,13 +709,30 @@ struct input_absinfo {
 #define ABS_MT_TRACKING_ID	0x39	/* Unique ID of initiated contact */
 #define ABS_MT_PRESSURE		0x3a	/* Pressure on contact area */
 
+#define ABS_PAD0		0x40	/* pressure sensitive pads */
+#define ABS_PAD1		0x41
+#define ABS_PAD2		0x42
+#define ABS_PAD3		0x43
+#define ABS_PAD4		0x44
+#define ABS_PAD5		0x45
+#define ABS_PAD6		0x46
+#define ABS_PAD7		0x47
+#define ABS_PAD8		0x48
+#define ABS_PAD9		0x49
+#define ABS_PAD10		0x4a
+#define ABS_PAD11		0x4b
+#define ABS_PAD12		0x4c
+#define ABS_PAD13		0x4d
+#define ABS_PAD14		0x4e
+#define ABS_PAD15		0x4f
+
 #ifdef __KERNEL__
 /* Implementation details, userspace should not care about these */
 #define ABS_MT_FIRST		ABS_MT_TOUCH_MAJOR
 #define ABS_MT_LAST		ABS_MT_PRESSURE
 #endif
 
-#define ABS_MAX			0x3f
+#define ABS_MAX			0x4f
 #define ABS_CNT			(ABS_MAX+1)
 
 /*
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 48c007d..f9711de 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -287,7 +287,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
 #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
-#define INPUT_DEVICE_ID_ABS_MAX		0x3f
+#define INPUT_DEVICE_ID_ABS_MAX		0x4f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
-- 
1.7.1

