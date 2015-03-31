From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V2 1/3] Input: Add event types to DT bidnings header
Date: Mon, 30 Mar 2015 17:28:07 -0700
Message-ID: <1427761689-5238-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add #defines for the event types (EV_KEY, EV_SW, etc.) to the input DT
bindings header so that they can be used in device-tree source files.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
New for v2.
---
 include/dt-bindings/input/input.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
index 042e7b3..b9ca218 100644
--- a/include/dt-bindings/input/input.h
+++ b/include/dt-bindings/input/input.h
@@ -522,4 +522,18 @@
 #define MATRIX_KEY(row, col, code)	\
 	((((row) & 0xFF) << 24) | (((col) & 0xFF) << 16) | ((code) & 0xFFFF))
 
+/* Event types */
+#define EV_SYN			0x00
+#define EV_KEY			0x01
+#define EV_REL			0x02
+#define EV_ABS			0x03
+#define EV_MSC			0x04
+#define EV_SW			0x05
+#define EV_LED			0x11
+#define EV_SND			0x12
+#define EV_REP			0x14
+#define EV_FF			0x15
+#define EV_PWR			0x16
+#define EV_FF_STATUS		0x17
+
 #endif /* _DT_BINDINGS_INPUT_INPUT_H */
-- 
2.2.0.rc0.207.ga3a616c
