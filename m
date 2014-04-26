From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH RESEND] input: dts: Add commonly used event types
Date: Sat, 26 Apr 2014 09:37:19 +0400
Message-ID: <1398490639-18411-1-git-send-email-shc_work@mail.ru>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Patch adds commonly used event types (EV_KEY and EV_SW) to
devicetree bindings header for input subsystem.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 include/dt-bindings/input/input.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
index 042e7b3..3a141d92 100644
--- a/include/dt-bindings/input/input.h
+++ b/include/dt-bindings/input/input.h
@@ -9,6 +9,9 @@
 #ifndef _DT_BINDINGS_INPUT_INPUT_H
 #define _DT_BINDINGS_INPUT_INPUT_H
 
+#define EV_KEY			0x01
+#define EV_SW			0x05
+
 #define KEY_RESERVED		0
 #define KEY_ESC			1
 #define KEY_1			2
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
