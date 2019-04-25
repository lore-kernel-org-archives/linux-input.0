From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] Input: add KEY_KBD_LAYOUT_NEXT
Date: Thu, 25 Apr 2019 09:38:45 -0700
Message-ID: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gwink@chromium.org
List-Id: linux-input@vger.kernel.org

The HID usage tables define a key to cycle through a set of keyboard
layouts, let's add corresponding keycode.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 64cee116928e..85387c76c24f 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -606,6 +606,7 @@
 #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
 #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
 #define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
+#define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
-- 
2.21.0.593.g511ec345e18-goog
