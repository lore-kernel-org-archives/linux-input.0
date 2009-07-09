From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH v2] input:Add keypad header file for w90p910
Date: Thu, 09 Jul 2009 17:10:30 +0800
Message-ID: <4A55B406.90203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:54729 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685AbZGIJKh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 05:10:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so5197rvb.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 02:10:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Trilok Soni <soni.trilok@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Russell

Dear sirs,

This is a header file for supporting my keypad driver,
a few days ago,I have submitted it, Now, for updating
keypad driver, I submit new patch updated again!

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 .../arm/mach-w90x900/include/mach/w90p910_keypad.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/w90p910_keypad.h

diff --git a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
new file mode 100644
index 0000000..5aaa9a7
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_ARCH_W90P910_KEYPAD_H
+#define __ASM_ARCH_W90P910_KEYPAD_H
+
+#include <linux/input.h>
+
+extern void mfp_set_groupi(struct device *dev);
+
+struct w90p910_keypad_platform_data {
+
+	unsigned int	prescale;
+	unsigned int	debounce;
+	unsigned int	matrix_key_rows;
+	unsigned int	matrix_key_cols;
+	unsigned int	*matrix_key_map;
+	int		matrix_key_map_size;
+};
+
+#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
+
+#endif /* __ASM_ARCH_W90P910_KEYPAD_H */
-- 
1.5.6.3
