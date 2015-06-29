From: Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCHv7 04/15] HID: add HDMI CEC specific keycodes
Date: Mon, 29 Jun 2015 12:14:49 +0200
Message-ID: <1435572900-56998-5-git-send-email-hans.verkuil@cisco.com>
References: <1435572900-56998-1-git-send-email-hans.verkuil@cisco.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1435572900-56998-1-git-send-email-hans.verkuil@cisco.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, thomas@tommie-lie.de, sean@mess.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu, kamil@wypas.org
List-Id: linux-input@vger.kernel.org

From: Kamil Debski <kamil@wypas.org>

Add HDMI CEC specific keycodes to the keycodes definition.

Signed-off-by: Kamil Debski <kamil@wypas.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 include/uapi/linux/input.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 731417c..7430a3f 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -752,6 +752,18 @@ struct input_keymap_entry {
 #define KEY_KBDINPUTASSIST_ACCEPT		0x264
 #define KEY_KBDINPUTASSIST_CANCEL		0x265
 
+#define KEY_RIGHT_UP			0x266
+#define KEY_RIGHT_DOWN			0x267
+#define KEY_LEFT_UP			0x268
+#define KEY_LEFT_DOWN			0x269
+
+#define KEY_NEXT_FAVORITE		0x270
+#define KEY_STOP_RECORD			0x271
+#define KEY_PAUSE_RECORD		0x272
+#define KEY_VOD				0x273
+#define KEY_UNMUTE			0x274
+#define KEY_DVB				0x275
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
2.1.4
