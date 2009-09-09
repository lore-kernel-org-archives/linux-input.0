From: jsgood.yang@samsung.com
Subject: [PATCH 3/4] [ARM][S3C] Add definition for keypad register
Date: Wed,  9 Sep 2009 20:11:38 +0900
Message-ID: <1252494698-17862-1-git-send-email-jsgood.yang@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:40176 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZIILRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:17:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jinsung Yang <jsgood.yang@samsung.com>, Kyeongil Kim <ki0351.kim@samsung.com>

From: Jinsung Yang <jsgood.yang@samsung.com>

This patch introduce keypad registers and fields for Samsung keypad
interface driver.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-keypad.h |   50 ++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/regs-keypad.h

diff --git a/arch/arm/plat-s3c/include/plat/regs-keypad.h b/arch/arm/plat-s3c/include/plat/regs-keypad.h
new file mode 100644
index 0000000..24bd66e
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/regs-keypad.h
@@ -0,0 +1,50 @@
+/* linux/arch/arm/plat-s3c/include/plat/regs-keypad.h
+ *
+ * S3C Key Interface register definitions
+ *
+ * Kim Kyoungil, Copyright (c) 2006-2009 Samsung Electronics
+ *      http://www.samsungsemi.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#ifndef __ASM_ARCH_REGS_KEYPAD_H
+#define __ASM_ARCH_REGS_KEYPAD_H
+
+/*
+ * Keypad Interface
+ */
+#define S3C_KEYPADREG(x)	(x)
+
+/* KEYIF registers */
+#define S3C_KEYIFCON		S3C_KEYPADREG(0x00)
+#define S3C_KEYIFSTSCLR		S3C_KEYPADREG(0x04)
+#define S3C_KEYIFCOL		S3C_KEYPADREG(0x08)
+#define S3C_KEYIFROW		S3C_KEYPADREG(0x0C)
+#define S3C_KEYIFFC		S3C_KEYPADREG(0x10)
+
+/* KEYIFCON fields */
+#define S3C_KEYIF_INT_F_EN	(1 << 0) /*falling edge(key-pressed) interuppt enable*/
+#define S3C_KEYIF_INT_R_EN	(1 << 1) /*rising edge(key-released) interuppt enable*/
+#define S3C_KEYIF_DF_EN		(1 << 2) /*debouncing filter enable*/
+#define S3C_KEYIF_FC_EN		(1 << 3) /*filter clock enable*/
+#define S3C_KEYIF_CON_MASK_ALL	(0x1f)
+
+/* KEYIFSTSCLR fields */
+#define S3C_KEYIF_STSCLR_CLEAR	(0xffff)
+
+/* KEYIFCOL fields */
+#define S3C_KEYIF_COL_DMASK	(0xff)
+#define S3C_KEYIF_COL_MASK_ALL	(0xffff)
+
+/* KEYIFROW fields */
+#define S3C_KEYIF_ROW_DMASK	(0xff)
+
+/* KEYIFFC fields */
+#define S3C_KEYIF_FILTER_VAL	(1)
+
+#endif /* __ASM_ARCH_REGS_KEYPAD_H */
+
-- 
1.6.2.5

