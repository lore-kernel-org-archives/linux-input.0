From: jsgood.yang@samsung.com
Subject: [PATCH 2/4] [ARM][S3C] Add definition for keypad platform data
Date: Wed,  9 Sep 2009 20:11:27 +0900
Message-ID: <1252494687-17829-1-git-send-email-jsgood.yang@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:40175 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZIILRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:17:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jinsung Yang <jsgood.yang@samsung.com>, Kyeongil Kim <ki0351.kim@samsung.com>

From: Jinsung Yang <jsgood.yang@samsung.com>

This patch supports platform data definition which including
platform specific keymap.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/keypad.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/keypad.h

diff --git a/arch/arm/plat-s3c/include/plat/keypad.h b/arch/arm/plat-s3c/include/plat/keypad.h
new file mode 100644
index 0000000..51c7396
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/keypad.h
@@ -0,0 +1,27 @@
+/*
+ * linux/arch/arm/plat-s3c/include/plat/keypad.h
+ *
+ * Copyright (C) 2009 Samsung Electronics
+ *
+ * Header file for keypad platform data
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_PLAT_S3C_KEYPAD_H
+#define __ASM_PLAT_S3C_KEYPAD_H
+
+struct s3c_platform_keypad {
+	int nr_rows;
+	int nr_cols;
+	int max_keys;
+	int max_masks;
+	int delay;
+	unsigned short *keymap;
+};
+
+extern void s3c_keypad_set_platdata(struct s3c_platform_keypad *pd);
+
+#endif /* __ASM_PLAT_S3C_KEYPAD_H */
-- 
1.6.2.5

