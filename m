From: Olof Johansson <olof@lixom.net>
Subject: [PATCH v4] Input: keyboard - add device tree bindings for simple key matrixes
Date: Tue,  3 Jan 2012 13:37:28 -0800
Message-ID: <1325626648-9425-1-git-send-email-olof@lixom.net>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42647 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2ACVhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2012 16:37:53 -0500
In-Reply-To: <1325484557-27695-1-git-send-email-olof@lixom.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, riyer@nvidia.com, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, thomas.abraham@linaro.org, sjg@chromium.org, swarren@nvidia.com, grant.likely@secretlab.ca, Olof Johansson <olof@lixom.net>

This adds a simple device tree binding for simple key matrix data and
a helper to fill in the platform data.

The implementation is in a shared file outside if drivers/input/keyboard
since some drivers in drivers/input/misc might be making use of it
as well.

Changes since v3:
 * Dropped compatible field in matrix-keymap.txt
 * Dropped linux,fn-key
 * Dropped linux,fn-keymap optional property but included guideline on
   naming convention
 * Now passing property name in to the helper function (or will assume
   "linux,keymap" if passed NULL)

Changes since v2:
 * Removed reference to "legacy" format with a subnode per key
 * Changed to a packed format with one cell per key instead of 3.
 * Moved new OF helper to separate file
 * Misc fixups based on comments

Changes since v1:
 * Removed samsung-style binding support
 * Added linux,fn-keymap and linux,fn-key optional properties

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 .../devicetree/bindings/input/matrix-keymap.txt    |   19 +++++
 drivers/input/Kconfig                              |    4 +
 drivers/input/Makefile                             |    1 +
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/of_keymap.c                          |   85 ++++++++++++++++++++
 include/linux/input/matrix_keypad.h                |   19 +++++
 6 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
 create mode 100644 drivers/input/of_keymap.c

diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
new file mode 100644
index 0000000..3cd8b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
@@ -0,0 +1,19 @@
+A simple common binding for matrix-connected key boards. Currently targeted at
+defining the keys in the scope of linux key codes since that is a stable and
+standardized interface at this time.
+
+Required properties:
+- linux,keymap: an array of packed 1-cell entries containing the equivalent
+  of row, column and linux key-code. The 32-bit big endian cell is packed
+  as:
+	row << 24 | column << 16 | key-code
+
+Optional properties:
+Some users of this binding might choose to specify secondary keymaps for
+cases where there is a modifier key such as a Fn key. Proposed names
+for said properties are "linux,fn-keymap" or with another descriptive
+word for the modifier other from "Fn".
+
+Example:
+	linux,keymap = < 0x00030012
+			 0x0102003a >;
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 001b147..3325979 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -25,6 +25,10 @@ config INPUT
 
 if INPUT
 
+config INPUT_OF_MATRIX_KEYMAP
+	depends on USE_OF
+	bool
+
 config INPUT_FF_MEMLESS
 	tristate "Support for memoryless force-feedback devices"
 	help
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 0c78949..b173a13a 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+= misc/
 
 obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power.o
+obj-$(CONFIG_INPUT_OF_MATRIX_KEYMAP) += of_keymap.o
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index cdc385b..3371954c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -394,6 +394,7 @@ config KEYBOARD_NOMADIK
 config KEYBOARD_TEGRA
 	tristate "NVIDIA Tegra internal matrix keyboard controller support"
 	depends on ARCH_TEGRA
+	select INPUT_OF_MATRIX_KEYMAP if USE_OF
 	help
 	  Say Y here if you want to use a matrix keyboard connected directly
 	  to the internal keyboard controller on Tegra SoCs.
diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
new file mode 100644
index 0000000..7f11f6d
--- /dev/null
+++ b/drivers/input/of_keymap.c
@@ -0,0 +1,85 @@
+/*
+ * Helpers for open firmware matrix keyboard bindings
+ *
+ * Copyright (C) 2012 Google, Inc
+ *
+ * Author:
+ * 	Olof Johansson <olof@lixom.net>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/of.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+
+struct matrix_keymap_data *
+matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname)
+{
+	struct matrix_keymap_data *kd;
+	int proplen = 0, i;
+	u32 *keymap;
+	const __be32 *prop;
+
+	if (!np)
+		return NULL;
+
+	if (!propname)
+		propname = "linux,keymap";
+
+	prop = of_get_property(np, propname, &proplen);
+
+	if (proplen % 4) {
+		pr_warn("Malformed keymap property %s in %s\n",
+			propname, np->full_name);
+		return NULL;
+	}
+
+	kd = kmalloc(sizeof(*kd), GFP_KERNEL);
+	if (!kd)
+		return NULL;
+	kd->keymap_size = proplen / sizeof(u32);
+
+	keymap = kzalloc(kd->keymap_size * sizeof(u32), GFP_KERNEL);
+	if (!keymap) {
+		kfree(kd);
+		return NULL;
+	}
+
+	kd->keymap = keymap;
+
+	for (i = 0; i < kd->keymap_size; i++) {
+		u32 tmp = be32_to_cpup(prop+i);
+		int key_code, row, col;
+
+		row = (tmp >> 24) & 0xff;
+		col = (tmp >> 16) & 0xff;
+		key_code = tmp & 0xffff;
+		*keymap++ = KEY(row, col, key_code);
+	}
+
+	return kd;
+}
+EXPORT_SYMBOL_GPL(matrix_keyboard_of_fill_keymap);
+
+void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
+{
+	if (!kd)
+		return;
+	kfree(kd->keymap);
+	kfree(kd);
+}
+EXPORT_SYMBOL_GPL(matrix_keyboard_of_free_keymap);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index fe7c4b9..b54fd87 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/of.h>
 
 #define MATRIX_MAX_ROWS		32
 #define MATRIX_MAX_COLS		32
@@ -106,4 +107,22 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 	__clear_bit(KEY_RESERVED, keybit);
 }
 
+#ifdef CONFIG_INPUT_OF_MATRIX_KEYMAP
+struct matrix_keymap_data *
+matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname);
+
+void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
+#else
+static inline struct matrix_keymap_data *
+matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname)
+{
+	return NULL;
+}
+
+static inline void
+matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
+{
+}
+#endif
+
 #endif /* _MATRIX_KEYPAD_H */
-- 
1.7.8.GIT

