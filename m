From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH 5/5] i8042: Add i8042_dt.h glue for DT support
Date: Tue,  3 Feb 2015 00:48:50 +0300
Message-ID: <1422913730-12663-5-git-send-email-v1ron@v1ros.org>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@mail.ru>, Roman Volkov <v1ron@v1ros.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

This header file designed to be similar to other glue layers found
for i8042. The difference is that interrupt numbers, device address,
and other information should be retrieved from the device tree.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 drivers/input/serio/i8042-dt.h | 112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 drivers/input/serio/i8042-dt.h

diff --git a/drivers/input/serio/i8042-dt.h b/drivers/input/serio/i8042-dt.h
new file mode 100644
index 0000000..0d1a344
--- /dev/null
+++ b/drivers/input/serio/i8042-dt.h
@@ -0,0 +1,112 @@
+#ifndef _I8042_DT_H
+#define _I8042_DT_H
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+static void __iomem *i8042_base;
+static unsigned int i8042_command_reg;
+static unsigned int i8042_status_reg;
+static unsigned int i8042_data_reg;
+#define I8042_COMMAND_REG i8042_command_reg
+#define I8042_STATUS_REG i8042_status_reg
+#define I8042_DATA_REG i8042_data_reg
+
+/*
+ * Names.
+ */
+
+static const char *i8042_kbd_phys_desc;
+static const char *i8042_aux_phys_desc;
+static const char *i8042_mux_phys_desc;
+#define I8042_KBD_PHYS_DESC i8042_kbd_phys_desc
+#define I8042_AUX_PHYS_DESC i8042_aux_phys_desc
+#define I8042_MUX_PHYS_DESC i8042_mux_phys_desc
+
+/*
+ * IRQs.
+ */
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
+#define I8042_KBD_IRQ i8042_kbd_irq
+#define I8042_AUX_IRQ i8042_aux_irq
+
+static inline int i8042_read_data(void)
+{
+	return readb(i8042_base + i8042_data_reg);
+}
+
+static inline int i8042_read_status(void)
+{
+	return readb(i8042_base + i8042_status_reg);
+}
+
+static inline void i8042_write_data(int val)
+{
+	writeb(val, i8042_base + i8042_data_reg);
+}
+
+static inline void i8042_write_command(int val)
+{
+	writeb(val, i8042_base + i8042_command_reg);
+}
+
+static inline int i8042_platform_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int status;
+
+	i8042_base = of_iomap(np, 0);
+	if (!i8042_base)
+		return -ENOMEM;
+
+	status = of_property_read_u32(np, "command-reg", &i8042_command_reg);
+	if (status)
+		return status;
+
+	status = of_property_read_u32(np, "status-reg", &i8042_status_reg);
+	if (status)
+		return status;
+
+	status = of_property_read_u32(np, "data-reg", &i8042_data_reg);
+	if (status)
+		return status;
+
+	i8042_kbd_irq = irq_of_parse_and_map(np, 0);
+	i8042_aux_irq = irq_of_parse_and_map(np, 1);
+
+	status = of_property_read_string(np, "linux,kbd_phys_desc",
+						&i8042_kbd_phys_desc);
+	if (status)
+		i8042_kbd_phys_desc = "i8042/serio0";
+
+	status = of_property_read_string(np, "linux,aux_phys_desc",
+						&i8042_aux_phys_desc);
+	if (status)
+		i8042_aux_phys_desc = "i8042/serio1";
+
+	status = of_property_read_string(np, "linux,mux_phys_desc",
+						&i8042_mux_phys_desc);
+	if (status)
+		i8042_mux_phys_desc = "i8042/serio%d";
+
+	if (of_get_property(np, "init-reset", NULL))
+		i8042_reset = true;
+
+	return 0;
+}
+
+static inline void i8042_platform_exit(void)
+{
+	if (i8042_base)
+		iounmap(i8042_base);
+}
+
+#endif
-- 
2.2.2
