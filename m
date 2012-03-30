From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V4 Resend 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Fri, 30 Mar 2012 09:10:36 +0530
Message-ID: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com>
References: <cover.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:36894 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715Ab2C3EAh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 00:00:37 -0400
In-Reply-To: <cover.1333009670.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: swarren@nvidia.com, spear-devel@list.st.com, viresh.linux@gmail.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

We don't need to allocate memory for keymap in matrix_keyboard_of_fill_keymap(),
as this would only be used by matrix_keyboard_of_free_keymap(). Instead create
another routine matrix_keypad_of_build_keymap() which reads directly the
property from struct device_node and builds keymap.

With this eariler routines matrix_keyboard_of_fill_keymap() and
matrix_keyboard_of_free_keymap() go away.

This patch also fixes tegra driver according to these changes.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V4:
- check return value of MATRIX_SCAN_CODE() to guarantee that it doesn't overflow
  keycodemax sized buffer.
- moved __devinit with the first line in function prototype

 drivers/input/keyboard/tegra-kbc.c  |   46 +++++++++-------
 drivers/input/of_keymap.c           |   98 ++++++++++++++++++++--------------
 include/linux/input/matrix_keypad.h |   16 ++----
 3 files changed, 88 insertions(+), 72 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 21c42f8..fd8a291 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -620,10 +620,9 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 
 #ifdef CONFIG_OF
 static struct tegra_kbc_platform_data * __devinit
-tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
+tegra_kbc_dt_parse_pdata(struct device_node *np)
 {
 	struct tegra_kbc_platform_data *pdata;
-	struct device_node *np = pdev->dev.of_node;
 	u32 prop;
 	int i;
 
@@ -659,15 +658,11 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 		pdata->pin_cfg[KBC_MAX_ROW + i].type = PIN_CFG_COL;
 	}
 
-	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
-
-	/* FIXME: Add handling of linux,fn-keymap here */
-
 	return pdata;
 }
 #else
-static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
-	struct platform_device *pdev)
+static struct tegra_kbc_platform_data * __devinit
+tegra_kbc_dt_parse_pdata(struct device_node *np)
 {
 	return NULL;
 }
@@ -676,7 +671,7 @@ static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 {
 	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap_data;
+	struct device_node *np = NULL;
 	struct tegra_kbc *kbc;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -686,8 +681,10 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int debounce_cnt;
 	unsigned int scan_time_rows;
 
-	if (!pdata)
-		pdata = tegra_kbc_dt_parse_pdata(pdev);
+	if (!pdata) {
+		np = pdev->dev.of_node;
+		pdata = tegra_kbc_dt_parse_pdata(np);
+	}
 
 	if (!pdata)
 		return -EINVAL;
@@ -775,9 +772,23 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 
 	kbc->use_fn_map = pdata->use_fn_map;
 	kbc->use_ghost_filter = pdata->use_ghost_filter;
-	keymap_data = pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
-	matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
-				   input_dev->keycode, input_dev->keybit);
+
+	if (np) {
+		/* FIXME: Add handling of linux,fn-keymap here */
+		err = matrix_keypad_of_build_keymap(input_dev, KBC_ROW_SHIFT,
+				"linux,keymap");
+		if (err) {
+			dev_err(&pdev->dev, "OF: failed to build keymap\n");
+			goto err_put_clk;
+		}
+	} else {
+		const struct matrix_keymap_data *keymap_data =
+			pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
+
+		matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
+				input_dev->keycode, input_dev->keybit);
+	}
+
 	kbc->wakeup_key = pdata->wakeup_key;
 
 	err = request_irq(kbc->irq, tegra_kbc_isr,
@@ -798,9 +809,6 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
-	if (!pdev->dev.platform_data)
-		matrix_keyboard_of_free_keymap(pdata->keymap_data);
-
 	return 0;
 
 err_free_irq:
@@ -815,10 +823,8 @@ err_free_mem:
 	input_free_device(input_dev);
 	kfree(kbc);
 err_free_pdata:
-	if (!pdev->dev.platform_data) {
-		matrix_keyboard_of_free_keymap(pdata->keymap_data);
+	if (!pdev->dev.platform_data)
 		kfree(pdata);
-	}
 
 	return err;
 }
diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
index 061493d..631054f 100644
--- a/drivers/input/of_keymap.c
+++ b/drivers/input/of_keymap.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/input.h>
@@ -26,62 +27,79 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 
-struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np,
-			       const char *propname)
+/**
+ * matrix_keypad_of_build_keymap - convert platform DT keymap into matrix keymap
+ * @idev: pointer to struct input_dev; used for getting keycode, keybit and
+ * keycodemax.
+ * @row_shift: number of bits to shift row value by to advance to the next
+ * line in the keymap
+ * @propname: Device Tree property name to be used for reading keymap. If passed
+ * as NULL, "linux,keymap" is used.
+ *
+ * This function creates an array of keycodes, by reading propname property from
+ * device tree passed, that is suitable for using in a standard matrix keyboard
+ * driver that uses row and col as indices.
+ *
+ * Expectation from user driver: idev must be initialized with following fields:
+ * dev.parent, keycode, keybit and keycodemax.
+ */
+int matrix_keypad_of_build_keymap(struct input_dev *idev,
+		unsigned int row_shift, const char *propname)
 {
-	struct matrix_keymap_data *kd;
-	u32 *keymap;
-	int proplen, i;
+	struct device *dev = idev->dev.parent;
+	struct device_node *np = dev->of_node;
+	unsigned short *keycode;
 	const __be32 *prop;
+	unsigned int proplen, i, size, col_range = 1 << row_shift, index;
 
-	if (!np)
-		return NULL;
+	if (!np || !idev)
+		return -ENODEV;
 
 	if (!propname)
 		propname = "linux,keymap";
 
 	prop = of_get_property(np, propname, &proplen);
-	if (!prop)
-		return NULL;
+	if (!prop) {
+		dev_err(dev, "OF: %s property not defined in %s\n", propname,
+				np->full_name);
+		return -ENODEV;
+	}
 
 	if (proplen % sizeof(u32)) {
-		pr_warn("Malformed keymap property %s in %s\n",
-			propname, np->full_name);
-		return NULL;
+		dev_warn(dev, "Malformed keycode property %s in %s\n", propname,
+				np->full_name);
+		return -EINVAL;
 	}
 
-	kd = kzalloc(sizeof(*kd), GFP_KERNEL);
-	if (!kd)
-		return NULL;
-
-	kd->keymap = keymap = kzalloc(proplen, GFP_KERNEL);
-	if (!kd->keymap) {
-		kfree(kd);
-		return NULL;
+	size = proplen / sizeof(u32);
+	if (size > idev->keycodemax) {
+		dev_err(dev, "OF: %s size overflow\n", propname);
+		return -EINVAL;
 	}
 
-	kd->keymap_size = proplen / sizeof(u32);
+	keycode = idev->keycode;
+	for (i = 0; i < size; i++) {
+		unsigned int key = be32_to_cpup(prop + i);
+		unsigned int row = KEY_ROW(key);
+		unsigned int col = KEY_COL(key);
+		unsigned short code = KEY_VAL(key);
 
-	for (i = 0; i < kd->keymap_size; i++) {
-		u32 tmp = be32_to_cpup(prop + i);
-		int key_code, row, col;
+		if (col >= col_range) {
+			dev_err(dev, "OF: %s: column %x overflowed its range %d\n",
+					propname, col, col_range);
+			return -EINVAL;
+		}
 
-		row = (tmp >> 24) & 0xff;
-		col = (tmp >> 16) & 0xff;
-		key_code = tmp & 0xffff;
-		keymap[i] = KEY(row, col, key_code);
+		index = MATRIX_SCAN_CODE(row, col, row_shift);
+		if (index > idev->keycodemax) {
+			dev_err(dev, "OF: %s index overflow\n", propname);
+			return -EINVAL;
+		}
+		keycode[index] = code;
+		__set_bit(code, idev->keybit);
 	}
+	__clear_bit(KEY_RESERVED, idev->keybit);
 
-	return kd;
-}
-EXPORT_SYMBOL_GPL(matrix_keyboard_of_fill_keymap);
-
-void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
-{
-	if (kd) {
-		kfree(kd->keymap);
-		kfree(kd);
-	}
+	return 0;
 }
-EXPORT_SYMBOL_GPL(matrix_keyboard_of_free_keymap);
+EXPORT_SYMBOL_GPL(matrix_keypad_of_build_keymap);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 6c07ced..341aca1 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -108,21 +108,13 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 }
 
 #ifdef CONFIG_INPUT_OF_MATRIX_KEYMAP
-struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname);
-
-void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
+int matrix_keypad_of_build_keymap(struct input_dev *idev,
+		unsigned int row_shift, const char *propname);
 #else
-static inline struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname)
+int matrix_keypad_of_build_keymap(struct input_dev *idev,
+		unsigned int row_shift, const char *propname)
 {
 	return NULL;
 }
-
-static inline void
-matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
-{
-}
 #endif
-
 #endif /* _MATRIX_KEYPAD_H */
-- 
1.7.9

