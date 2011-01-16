From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: [PATCH] i8042 driver for unicore32 architecture
Date: Sun, 16 Jan 2011 23:45:23 +0800
Message-ID: <005b01cbb594$6398d9e0$2aca8da0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:42024 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab1APP5b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Jan 2011 10:57:31 -0500
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch implements i8042 driver for unicore32 architecture.

Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 drivers/input/serio/i8042.h       |    2 +
 drivers/staging/puv3/i8042-ucio.h |   89 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/puv3/i8042-ucio.h

diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index cbc1beb..711b41c 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -26,6 +26,8 @@
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
 #include "i8042-x86ia64io.h"
+#elif defined(CONFIG_UNICORE32)
+#include "../../staging/puv3/i8042-ucio.h"
 #else
 #include "i8042-io.h"
 #endif
diff --git a/drivers/staging/puv3/i8042-ucio.h b/drivers/staging/puv3/i8042-ucio.h
new file mode 100644
index 0000000..c3221df
--- /dev/null
+++ b/drivers/staging/puv3/i8042-ucio.h
@@ -0,0 +1,89 @@
+/*
+ * linux/drivers/staging/puv3/i8042-ucio.h
+ *
+ * Code specific to PKUnity SoC and UniCore ISA
+ *
+ *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
+ *	Copyright (C) 2001-2010 Guan Xuetao
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _I8042_UCIO_H
+#define _I8042_UCIO_H
+
+#include <linux/clk.h>
+#include <mach/hardware.h>
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "isa0060/serio0"
+#define I8042_AUX_PHYS_DESC "isa0060/serio1"
+#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
+
+/*
+ * IRQs.
+ */
+#define I8042_KBD_IRQ           IRQ_PS2_KBD
+#define I8042_AUX_IRQ           IRQ_PS2_AUX
+
+/*
+ * Register numbers.
+ */
+
+#define I8042_COMMAND_REG	((unsigned long)&PS2_COMMAND)
+#define I8042_STATUS_REG	((unsigned long)&PS2_STATUS)
+#define I8042_DATA_REG		((unsigned long)&PS2_DATA)
+
+void puv3_ps2_init(void)
+{
+	struct clk *bclk32;
+
+	bclk32 = clk_get(NULL, "BUS32_CLK");
+	PS2_CNT = clk_get_rate(bclk32) / 200000; /* should > 5us */
+}
+
+static inline int i8042_read_data(void)
+{
+	return inb(I8042_DATA_REG);
+}
+
+static inline int i8042_read_status(void)
+{
+	return inb(I8042_STATUS_REG);
+}
+
+static inline void i8042_write_data(int val)
+{
+	outb(val, I8042_DATA_REG);
+}
+
+static inline void i8042_write_command(int val)
+{
+	outb(val, I8042_COMMAND_REG);
+}
+
+static inline int i8042_platform_init(void)
+{
+/*
+ * On some platforms touching the i8042 data register region can do really
+ * bad things. Because of this the region is always reserved on such boxes.
+ */
+	puv3_ps2_init();
+
+	if (!request_region(I8042_DATA_REG, 16, "i8042"))
+		return -EBUSY;
+
+	i8042_reset = 1;
+	return 0;
+}
+
+static inline void i8042_platform_exit(void)
+{
+	release_region(I8042_DATA_REG, 16);
+}
+
+#endif /* _I8042_UCIO_H */
-- 
1.7.3.5


