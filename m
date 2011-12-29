From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2] Input: keyboard - add device tree bindings for simple key matrixes
Date: Thu, 29 Dec 2011 10:42:26 -0800
Message-ID: <1325184146-3527-1-git-send-email-olof@lixom.net>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325112771-31941-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This adds a simple device tree binding for simple key matrix data.

Changes since v1:
 * Removed samsung-style binding support
 * Added linux,fn-keymap and linux,fn-key optional properties

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 .../devicetree/bindings/input/matrix-keymap.txt    |   25 ++++++
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/keymap.c                    |   78 ++++++++++++++++++++
 include/linux/input/matrix_keypad.h                |   34 +++++----
 4 files changed, 123 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
 create mode 100644 drivers/input/keyboard/keymap.c

diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
new file mode 100644
index 0000000..480ca46
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
@@ -0,0 +1,25 @@
+For matrix keyboards there are two kinds of layout bindings using
+linux key codes.
+
+Required properties:
+- compatible: "matrix-keyboard-controller"
+- linux,keymap: an array of 3-cell entries containing the equivalent
+  of the three separate properties above: row, column and linux
+  key-code.
+
+Optional properties:
+- linux,fn-keymap: A separate array of 3-cell entries similar to
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
+	linux,keymap = < 0 3 2
+			 0 4 5 >;
+	linux,fn-key = < 2 1 >;
+	linux,fn-keymap = < 0 3 1 >;
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index df7061f..83e6eed 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_INPUT_KEYBOARD)		+= keymap.o
 obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
diff --git a/drivers/input/keyboard/keymap.c b/drivers/input/keyboard/keymap.c
new file mode 100644
index 0000000..80d1074
--- /dev/null
+++ b/drivers/input/keyboard/keymap.c
@@ -0,0 +1,78 @@
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/of.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+
+void matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
+				unsigned int row_shift,
+				unsigned short *keymap, unsigned long *keybit)
+{
+	int i;
+
+	for (i = 0; i < keymap_data->keymap_size; i++) {
+		unsigned int key = keymap_data->keymap[i];
+		unsigned int row = KEY_ROW(key);
+		unsigned int col = KEY_COL(key);
+		unsigned short code = KEY_VAL(key);
+
+		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
+		__set_bit(code, keybit);
+	}
+	__clear_bit(KEY_RESERVED, keybit);
+}
+EXPORT_SYMBOL_GPL(matrix_keypad_build_keymap);
+
+#ifdef CONFIG_OF
+struct matrix_keymap_data *
+matrix_keyboard_of_fill_keymap(struct device_node *np)
+{
+	struct matrix_keymap_data *kd;
+	struct device_node *knp;
+	int proplen = 0, i;
+	u32 *keymap, row, col, key_code;
+	const __be32 *prop = of_get_property(np, "linux,keymap", &proplen);
+
+	if (!of_device_is_compatible(np, "matrix-keyboard-controller"))
+		return NULL;
+
+	kd = kmalloc(sizeof(*kd), GFP_KERNEL);
+	if (!kd)
+		return NULL;
+	kd->keymap_size = proplen / 3;
+
+	keymap = kzalloc(kd->keymap_size * sizeof(u32), GFP_KERNEL);
+	if (!keymap) {
+		kfree(kd);
+		return NULL;
+	}
+
+	kd->keymap = keymap;
+
+	for (i = 0; i < kd->keymap_size; i++){
+		/* property format is < row column keycode > */
+		row = be32_to_cpup(prop++);
+		col = be32_to_cpup(prop++);
+		key_code = be32_to_cpup(prop++);
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
+	if (kd->keymap)
+		kfree(kd->keymap);
+	kfree(kd);
+}
+EXPORT_SYMBOL_GPL(matrix_keyboard_of_free_keymap);
+#endif
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index fe7c4b9..ac999c6 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/of.h>
 
 #define MATRIX_MAX_ROWS		32
 #define MATRIX_MAX_COLS		32
@@ -87,23 +88,26 @@ struct matrix_keypad_platform_data {
  * an array of keycodes that is suitable for using in a standard matrix
  * keyboard driver that uses row and col as indices.
  */
+void matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
+				unsigned int row_shift,
+				unsigned short *keymap, unsigned long *keybit);
+
+#ifdef CONFIG_OF
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
 static inline void
-matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
-			   unsigned int row_shift,
-			   unsigned short *keymap, unsigned long *keybit)
+matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
 {
-	int i;
-
-	for (i = 0; i < keymap_data->keymap_size; i++) {
-		unsigned int key = keymap_data->keymap[i];
-		unsigned int row = KEY_ROW(key);
-		unsigned int col = KEY_COL(key);
-		unsigned short code = KEY_VAL(key);
-
-		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
-		__set_bit(code, keybit);
-	}
-	__clear_bit(KEY_RESERVED, keybit);
 }
+#endif
 
 #endif /* _MATRIX_KEYPAD_H */
-- 
1.7.8.GIT
