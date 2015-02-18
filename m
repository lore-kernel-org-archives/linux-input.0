From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 5/6] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Wed, 18 Feb 2015 21:53:52 +0100
Message-ID: <1424292832.32581.49.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 include/uapi/linux/input.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index b0a8130..affe40e 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -740,6 +740,16 @@ struct input_keymap_entry {
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
 
+#define KEY_CLIPPING_TOOL		0x252	/* Screenshot clipping tool */
+#define KEY_CLOUD			0x253	/* Cloud Settings */
+#define KEY_CAMERA_GESTURES		0x254	/* Toggle Camera gestures */
+#define KEY_NEW_TAB			0x255	/* Open a new tab */
+#define KEY_MICUP			0x256	/* Microphone Up */
+#define KEY_MICDOWN			0x257	/* Microphone Down */
+#define KEY_MICCANCEL_MODE		0x258	/* Toggle Microphone cancellation mode */
+#define KEY_CAMERA_ZOOM_MODE		0x259	/* Toggle camera zoom mode */
+#define KEY_ROTATE_DISPLAY		0x25a	/* Rotate screen by 90 degrees */
+
 #define KEY_KBDINPUTASSIST_PREV		0x260
 #define KEY_KBDINPUTASSIST_NEXT		0x261
 #define KEY_KBDINPUTASSIST_PREVGROUP		0x262
-- 
2.1.0
