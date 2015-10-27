From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 3/3] input: misc: keychord: move header to uapi
Date: Tue, 27 Oct 2015 09:48:35 +0100
Message-ID: <1445935715-5861-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38703 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbbJ0Isq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 04:48:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Colin Cross <ccross@android.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Colin Cross <ccross@android.com>

Move the entire contents of linux/keychord.h header to uapi, it only
contains a userspace interface.

Change-Id: If94f83328b19efb58c66391dce3bd8e927788d8d
Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 include/linux/keychord.h      |   31 +-----------------------
 include/uapi/linux/keychord.h |   52 +++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 53 insertions(+), 30 deletions(-)
 create mode 100644 include/uapi/linux/keychord.h

diff --git a/include/linux/keychord.h b/include/linux/keychord.h
index 856a585..08cf540 100644
--- a/include/linux/keychord.h
+++ b/include/linux/keychord.h
@@ -18,35 +18,6 @@
 #ifndef __LINUX_KEYCHORD_H_
 #define __LINUX_KEYCHORD_H_
=20
-#include <linux/input.h>
-
-#define KEYCHORD_VERSION		1
-
-/*
- * One or more input_keychord structs are written to /dev/keychord
- * at once to specify the list of keychords to monitor.
- * Reading /dev/keychord returns the id of a keychord when the
- * keychord combination is pressed.  A keychord is signalled when
- * all of the keys in the keycode list are in the pressed state.
- * The order in which the keys are pressed does not matter.
- * The keychord will not be signalled if keys not in the keycode
- * list are pressed.
- * Keychords will not be signalled on key release events.
- */
-struct input_keychord {
-	/* should be KEYCHORD_VERSION */
-	__u16 version;
-	/*
-	 * client specified ID, returned from read()
-	 * when this keychord is pressed.
-	 */
-	__u16 id;
-
-	/* number of keycodes in this keychord */
-	__u16 count;
-
-	/* variable length array of keycodes */
-	__u16 keycodes[];
-};
+#include <uapi/linux/keychord.h>
=20
 #endif	/* __LINUX_KEYCHORD_H_ */
diff --git a/include/uapi/linux/keychord.h b/include/uapi/linux/keychor=
d.h
new file mode 100644
index 0000000..ea7cf4d
--- /dev/null
+++ b/include/uapi/linux/keychord.h
@@ -0,0 +1,52 @@
+/*
+ *  Key chord input driver
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Author: Mike Lockwood <lockwood@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+*/
+
+#ifndef _UAPI_LINUX_KEYCHORD_H_
+#define _UAPI_LINUX_KEYCHORD_H_
+
+#include <linux/input.h>
+
+#define KEYCHORD_VERSION		1
+
+/*
+ * One or more input_keychord structs are written to /dev/keychord
+ * at once to specify the list of keychords to monitor.
+ * Reading /dev/keychord returns the id of a keychord when the
+ * keychord combination is pressed.  A keychord is signalled when
+ * all of the keys in the keycode list are in the pressed state.
+ * The order in which the keys are pressed does not matter.
+ * The keychord will not be signalled if keys not in the keycode
+ * list are pressed.
+ * Keychords will not be signalled on key release events.
+ */
+struct input_keychord {
+	/* should be KEYCHORD_VERSION */
+	__u16 version;
+	/*
+	 * client specified ID, returned from read()
+	 * when this keychord is pressed.
+	 */
+	__u16 id;
+
+	/* number of keycodes in this keychord */
+	__u16 count;
+
+	/* variable length array of keycodes */
+	__u16 keycodes[];
+};
+
+#endif	/* _UAPI_LINUX_KEYCHORD_H_ */
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
