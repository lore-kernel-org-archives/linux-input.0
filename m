From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v3] Input: keyboard - add device tree bindings for simple key matrixes
Date: Sun,  1 Jan 2012 22:09:17 -0800
Message-ID: <1325484557-27695-1-git-send-email-olof@lixom.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325184146-3527-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This adds a simple device tree binding for simple key matrix data and
a helper to fill in the platform data.

The implementation is in a shared file outside if drivers/input/keyboard
since some drivers in drivers/input/misc might be making use of it
as well.

Changes since v2:
 * Removed reference to "legacy" format with a subnode per key
 * Changed to a packed format with one cell per key instead of 3.
 * Moved new OF helper to separate file
 * Misc fixups based on comments

Changes since v1:
 * Removed samsung-style binding support
 * Added linux,fn-keymap and linux,fn-key optional properties

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 .../devicetree/bindings/input/matrix-keymap.txt    |   27 ++++++
 drivers/input/Kconfig                              |    4 +
 drivers/input/Makefile                             |    1 +
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/of_keymap.c                          |   87 ++++++++++++++++++++
 include/linux/input/matrix_keypad.h                |   19 ++++
 6 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
 create mode 100644 drivers/input/of_keymap.c

diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
new file mode 100644
index 0000000..1db8e12
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
@@ -0,0 +1,27 @@
+A simple common binding for matrix-connected key boards. Currently targeted at
+defining the keys in the scope of linux key codes since that is a stable and
+standardized interface at this time.
+
+Required properties:
+- compatible: "matrix-keyboard-controller"
+- linux,keymap: an array of packed 1-cell entries containing the equivalent
+  of row, column and linux key-code. The 32-bit big endian cell is packed
+  as:
+	row << 24 | column << 16 | key-code
+
+Optional properties:
+- linux,fn-keymap: A separate array of packed 1-cell entries similar to
+  linux,keymap but only to be used when the function key modifier is
+  active. This is used for keyboards that have a software-based modifier
+  key for 'Fn' but that need to describe the custom layout that should
+  be used when said modifier key is active.
+
+- linux,fn-key: a 2-cell entry containing the < row column > of the
+  function modifier key used to switch to the above linux,fn-keymap
+  layout.
+
+Example:
+	linux,keymap = < 0x00030012
+			 0x0102003a >;
+	linux,fn-key = < 2 1 >;
+	linux,fn-keymap = < 0x0002004a >;
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
index 0000000..b33627d
--- /dev/null
+++ b/drivers/input/of_keymap.c
@@ -0,0 +1,87 @@
+/*
+ * Helpers for open firmware matrix keyboard bindings
+ *
+ * Copyright (C) 2012 Google, Inc
+ *
+ * Author:
+ * 	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
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
+matrix_keyboard_of_fill_keymap(struct device_node *np)
+{
+	struct matrix_keymap_data *kd;
+	int proplen = 0, i;
+	u32 *keymap;
+	const __be32 *prop;
+
+	if (!np)
+		return NULL;
+
+	prop = of_get_property(np, "linux,keymap", &proplen);
+
+	if (!of_device_is_compatible(np, "matrix-keyboard-controller"))
+		return NULL;
+
+	if (proplen % 4) {
+		pr_warn("Malformed linux,keymap property in %s\n",
+			np->full_name);
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
+	/* FIXME: Need to add handling of the linux,fn-keymap property here */
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
index fe7c4b9..fcf45ec 100644
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
+matrix_keyboard_of_fill_keymap(struct device_node *np);
+
+void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
+#else
+static inline struct matrix_keymap_data *
+matrix_keyboard_of_fill_keymap(struct device_node *np)
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
