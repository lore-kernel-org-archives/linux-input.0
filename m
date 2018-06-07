From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 01/13] input: move MT_TOOL_* to input-event-codes.h
Date: Thu,  7 Jun 2018 09:54:36 +0200
Message-ID: <20180607075448.5706-2-benjamin.tissoires@redhat.com>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This is evdev API and should be in this file.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 include/uapi/linux/input-event-codes.h | 8 ++++++++
 include/uapi/linux/input.h             | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 6cba8a21ea19..e8841cdb1ebd 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -848,4 +848,12 @@
 #define SND_MAX			0x07
 #define SND_CNT			(SND_MAX+1)
 
+/*
+ * MT_TOOL types
+ */
+#define MT_TOOL_FINGER		0
+#define MT_TOOL_PEN		1
+#define MT_TOOL_PALM		2
+#define MT_TOOL_MAX		2
+
 #endif
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 7288a7c573cc..cc55c140dfef 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -267,14 +267,6 @@ struct input_mask {
 #define BUS_CEC			0x1E
 #define BUS_INTEL_ISHTP		0x1F
 
-/*
- * MT_TOOL types
- */
-#define MT_TOOL_FINGER		0
-#define MT_TOOL_PEN		1
-#define MT_TOOL_PALM		2
-#define MT_TOOL_MAX		2
-
 /*
  * Values describing the status of a force-feedback effect
  */
-- 
2.14.3
