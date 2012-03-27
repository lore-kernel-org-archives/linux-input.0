From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Tue, 27 Mar 2012 11:08:11 +0530
Message-ID: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:50694 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755133Ab2C0Frl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 01:47:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: swarren@nvidia.com, olof@lixom.net, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, spear-devel@list.st.com, viresh.linux@gmail.com, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

We don't need to allocate memory for keymap in matrix_keyboard_of_fill_keymap(),
as this would only be used by matrix_keyboard_of_free_keymap(). Instead create
another routine matrix_keypad_of_build_keymap() which reads directly the
property from struct device_node and builds keymap.

With this eariler routines matrix_keyboard_of_fill_keymap() and
matrix_keyboard_of_free_keymap() go away.

This patch also fixes tegra driver according to these changes.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V2:
- Introduced matrix_keypad_of_build_keymap() and removed fill and free keymap
  routines.
- Updated tegra-kbc.

 drivers/input/keyboard/tegra-kbc.c  |   33 ++++++++------
 drivers/input/of_keymap.c           |   82 +++++++++++++++++------------------
 include/linux/input/matrix_keypad.h |   18 +++-----
 3 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 21c42f8..96ee31e 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -659,10 +659,6 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 		pdata->pin_cfg[KBC_MAX_ROW + i].type = PIN_CFG_COL;
 	}
 
-	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
-
-	/* FIXME: Add handling of linux,fn-keymap here */
-
 	return pdata;
 }
 #else
@@ -676,7 +672,6 @@ static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 {
 	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap_data;
 	struct tegra_kbc *kbc;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -775,9 +770,24 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 
 	kbc->use_fn_map = pdata->use_fn_map;
 	kbc->use_ghost_filter = pdata->use_ghost_filter;
-	keymap_data = pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
-	matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
-				   input_dev->keycode, input_dev->keybit);
+
+	if (pdev->dev.of_node) {
+		/* FIXME: Add handling of linux,fn-keymap here */
+		err = matrix_keypad_of_build_keymap(&pdev->dev, KBC_ROW_SHIFT,
+				input_dev->keycode, input_dev->keybit,
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
@@ -798,9 +808,6 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
-	if (!pdev->dev.platform_data)
-		matrix_keyboard_of_free_keymap(pdata->keymap_data);
-
 	return 0;
 
 err_free_irq:
@@ -815,10 +822,8 @@ err_free_mem:
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
index 061493d..2837566 100644
--- a/drivers/input/of_keymap.c
+++ b/drivers/input/of_keymap.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/input.h>
@@ -26,62 +27,61 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 
-struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np,
-			       const char *propname)
+/**
+ * matrix_keypad_of_build_keymap - convert platform DT keymap into matrix keymap
+ * @dev: Pointer to struct device, will be used for getting struct device_node
+ * @row_shift: number of bits to shift row value by to advance to the next
+ * line in the keymap
+ * @keymap: expanded version of keymap that is suitable for use by
+ * matrix keyboad driver
+ * @keybit: pointer to bitmap of keys supported by input device
+ * @propname: Device Tree property name to be used for reading keymap. If passed
+ * as NULL, "linux,keymap" is used.
+ *
+ * This function creates an array of keycodes, by reading propname property from
+ * device tree passed, that is suitable for using in a standard matrix keyboard
+ * driver that uses row and col as indices.
+ */
+int matrix_keypad_of_build_keymap(struct device *dev, unsigned int row_shift,
+		unsigned short *keymap, unsigned long *keybit,
+		const char *propname)
 {
-	struct matrix_keymap_data *kd;
-	u32 *keymap;
-	int proplen, i;
+	struct device_node *np = dev->of_node;
 	const __be32 *prop;
+	int proplen, i, size;
 
 	if (!np)
-		return NULL;
+		return -ENODEV;
 
 	if (!propname)
 		propname = "linux,keymap";
 
 	prop = of_get_property(np, propname, &proplen);
-	if (!prop)
-		return NULL;
-
-	if (proplen % sizeof(u32)) {
-		pr_warn("Malformed keymap property %s in %s\n",
-			propname, np->full_name);
-		return NULL;
+	if (!prop) {
+		dev_err(dev, "OF: %s property not defined in %s\n", propname,
+				np->full_name);
+		return -ENODEV;
 	}
 
-	kd = kzalloc(sizeof(*kd), GFP_KERNEL);
-	if (!kd)
-		return NULL;
-
-	kd->keymap = keymap = kzalloc(proplen, GFP_KERNEL);
-	if (!kd->keymap) {
-		kfree(kd);
-		return NULL;
+	if (proplen % sizeof(u32)) {
+		dev_warn(dev, "Malformed keymap property %s in %s\n", propname,
+				np->full_name);
+		return -EINVAL;
 	}
 
-	kd->keymap_size = proplen / sizeof(u32);
+	size = proplen / sizeof(u32);
 
-	for (i = 0; i < kd->keymap_size; i++) {
-		u32 tmp = be32_to_cpup(prop + i);
-		int key_code, row, col;
+	for (i = 0; i < size; i++) {
+		unsigned int key = be32_to_cpup(prop + i);
+		unsigned int row = KEY_ROW(key);
+		unsigned int col = KEY_COL(key);
+		unsigned short code = KEY_VAL(key);
 
-		row = (tmp >> 24) & 0xff;
-		col = (tmp >> 16) & 0xff;
-		key_code = tmp & 0xffff;
-		keymap[i] = KEY(row, col, key_code);
+		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
+		__set_bit(code, keybit);
 	}
+	__clear_bit(KEY_RESERVED, keybit);
 
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
index 6c07ced..aef352f 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -108,21 +108,15 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 }
 
 #ifdef CONFIG_INPUT_OF_MATRIX_KEYMAP
-struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname);
-
-void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
+int matrix_keypad_of_build_keymap(struct device *dev, unsigned int row_shift,
+		unsigned short *keymap, unsigned long *keybit,
+		const char *propname);
 #else
-static inline struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname)
+int matrix_keypad_of_build_keymap(struct device *dev, unsigned int row_shift,
+		unsigned short *keymap, unsigned long *keybit,
+		const char *propname)
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
1.7.10.rc2.10.gb47606

