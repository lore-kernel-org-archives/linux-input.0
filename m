From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] Input: tegra-kbc - assume CONFIG_OF, remove platform data
Date: Fri, 15 Feb 2013 14:58:26 -0700
Message-ID: <1360965506-19641-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58880 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3BOV6c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 16:58:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

Tegra only supports, and always enables, device tree. Remove all ifdefs
and runtime checks for DT support from the driver. Platform data is
therefore no longer required. Delete the header that defines it, and
rework the driver to parse the device tree directly into struct
tegra_kbc.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/input/keyboard/tegra-kbc.c |  193 +++++++++++++++++-------------------
 include/linux/input/tegra_kbc.h    |   62 ------------
 2 files changed, 91 insertions(+), 164 deletions(-)
 delete mode 100644 include/linux/input/tegra_kbc.h

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 46e8ad2..e59eebe 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -29,9 +29,16 @@
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
-#include <linux/input/tegra_kbc.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/clk/tegra.h>
 
+#define KBC_MAX_GPIO	24
+#define KBC_MAX_KPENT	8
+
+#define KBC_MAX_ROW	16
+#define KBC_MAX_COL	8
+#define KBC_MAX_KEY	(KBC_MAX_ROW * KBC_MAX_COL)
+
 #define KBC_MAX_DEBOUNCE_CNT	0x3ffu
 
 /* KBC row scan time and delay for beginning the row scan. */
@@ -67,7 +74,24 @@
 
 #define KBC_ROW_SHIFT	3
 
+enum tegra_pin_type {
+	PIN_CFG_IGNORE,
+	PIN_CFG_COL,
+	PIN_CFG_ROW,
+};
+
+struct tegra_kbc_pin_cfg {
+	enum tegra_pin_type type;
+	unsigned char num;
+};
+
 struct tegra_kbc {
+	struct device *dev;
+	unsigned int debounce_cnt;
+	unsigned int repeat_cnt;
+	struct tegra_kbc_pin_cfg pin_cfg[KBC_MAX_GPIO];
+	const struct matrix_keymap_data *keymap_data;
+	bool wakeup;
 	void __iomem *mmio;
 	struct input_dev *idev;
 	unsigned int irq;
@@ -78,7 +102,6 @@ struct tegra_kbc {
 	bool use_fn_map;
 	bool use_ghost_filter;
 	bool keypress_caused_wake;
-	const struct tegra_kbc_platform_data *pdata;
 	unsigned short keycode[KBC_MAX_KEY * 2];
 	unsigned short current_keys[KBC_MAX_KPENT];
 	unsigned int num_pressed_keys;
@@ -286,12 +309,11 @@ static irqreturn_t tegra_kbc_isr(int irq, void *args)
 
 static void tegra_kbc_setup_wakekeys(struct tegra_kbc *kbc, bool filter)
 {
-	const struct tegra_kbc_platform_data *pdata = kbc->pdata;
 	int i;
 	unsigned int rst_val;
 
 	/* Either mask all keys or none. */
-	rst_val = (filter && !pdata->wakeup) ? ~0 : 0;
+	rst_val = (filter && !kbc->wakeup) ? ~0 : 0;
 
 	for (i = 0; i < KBC_MAX_ROW; i++)
 		writel(rst_val, kbc->mmio + KBC_ROW0_MASK_0 + i * 4);
@@ -299,7 +321,6 @@ static void tegra_kbc_setup_wakekeys(struct tegra_kbc *kbc, bool filter)
 
 static void tegra_kbc_config_pins(struct tegra_kbc *kbc)
 {
-	const struct tegra_kbc_platform_data *pdata = kbc->pdata;
 	int i;
 
 	for (i = 0; i < KBC_MAX_GPIO; i++) {
@@ -315,13 +336,13 @@ static void tegra_kbc_config_pins(struct tegra_kbc *kbc)
 		row_cfg &= ~r_mask;
 		col_cfg &= ~c_mask;
 
-		switch (pdata->pin_cfg[i].type) {
+		switch (kbc->pin_cfg[i].type) {
 		case PIN_CFG_ROW:
-			row_cfg |= ((pdata->pin_cfg[i].num << 1) | 1) << r_shft;
+			row_cfg |= ((kbc->pin_cfg[i].num << 1) | 1) << r_shft;
 			break;
 
 		case PIN_CFG_COL:
-			col_cfg |= ((pdata->pin_cfg[i].num << 1) | 1) << c_shft;
+			col_cfg |= ((kbc->pin_cfg[i].num << 1) | 1) << c_shft;
 			break;
 
 		case PIN_CFG_IGNORE:
@@ -335,7 +356,6 @@ static void tegra_kbc_config_pins(struct tegra_kbc *kbc)
 
 static int tegra_kbc_start(struct tegra_kbc *kbc)
 {
-	const struct tegra_kbc_platform_data *pdata = kbc->pdata;
 	unsigned int debounce_cnt;
 	u32 val = 0;
 
@@ -350,10 +370,10 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
 	tegra_kbc_config_pins(kbc);
 	tegra_kbc_setup_wakekeys(kbc, false);
 
-	writel(pdata->repeat_cnt, kbc->mmio + KBC_RPT_DLY_0);
+	writel(kbc->repeat_cnt, kbc->mmio + KBC_RPT_DLY_0);
 
 	/* Keyboard debounce count is maximum of 12 bits. */
-	debounce_cnt = min(pdata->debounce_cnt, KBC_MAX_DEBOUNCE_CNT);
+	debounce_cnt = min(kbc->debounce_cnt, KBC_MAX_DEBOUNCE_CNT);
 	val = KBC_DEBOUNCE_CNT_SHIFT(debounce_cnt);
 	val |= KBC_FIFO_TH_CNT_SHIFT(1); /* set fifo interrupt threshold to 1 */
 	val |= KBC_CONTROL_FIFO_CNT_INT_EN;  /* interrupt on FIFO threshold */
@@ -420,21 +440,20 @@ static void tegra_kbc_close(struct input_dev *dev)
 	return tegra_kbc_stop(kbc);
 }
 
-static bool
-tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
-			struct device *dev, unsigned int *num_rows)
+static bool tegra_kbc_check_pin_cfg(const struct tegra_kbc *kbc,
+					unsigned int *num_rows)
 {
 	int i;
 
 	*num_rows = 0;
 
 	for (i = 0; i < KBC_MAX_GPIO; i++) {
-		const struct tegra_kbc_pin_cfg *pin_cfg = &pdata->pin_cfg[i];
+		const struct tegra_kbc_pin_cfg *pin_cfg = &kbc->pin_cfg[i];
 
 		switch (pin_cfg->type) {
 		case PIN_CFG_ROW:
 			if (pin_cfg->num >= KBC_MAX_ROW) {
-				dev_err(dev,
+				dev_err(kbc->dev,
 					"pin_cfg[%d]: invalid row number %d\n",
 					i, pin_cfg->num);
 				return false;
@@ -444,7 +463,7 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 
 		case PIN_CFG_COL:
 			if (pin_cfg->num >= KBC_MAX_COL) {
-				dev_err(dev,
+				dev_err(kbc->dev,
 					"pin_cfg[%d]: invalid column number %d\n",
 					i, pin_cfg->num);
 				return false;
@@ -455,7 +474,7 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 			break;
 
 		default:
-			dev_err(dev,
+			dev_err(kbc->dev,
 				"pin_cfg[%d]: invalid entry type %d\n",
 				pin_cfg->type, pin_cfg->num);
 			return false;
@@ -465,12 +484,9 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 	return true;
 }
 
-#ifdef CONFIG_OF
-static struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
-	struct platform_device *pdev)
+static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 {
-	struct tegra_kbc_platform_data *pdata;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = kbc->dev->of_node;
 	u32 prop;
 	int i;
 	u32 num_rows = 0;
@@ -480,109 +496,96 @@ static struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 	int proplen;
 	int ret;
 
-	if (!np) {
-		dev_err(&pdev->dev, "device tree data is missing\n");
-		return ERR_PTR(-ENOENT);
-	}
-
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
 	if (!of_property_read_u32(np, "nvidia,debounce-delay-ms", &prop))
-		pdata->debounce_cnt = prop;
+		kbc->debounce_cnt = prop;
 
 	if (!of_property_read_u32(np, "nvidia,repeat-delay-ms", &prop))
-		pdata->repeat_cnt = prop;
+		kbc->repeat_cnt = prop;
 
 	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
-		pdata->use_ghost_filter = true;
+		kbc->use_ghost_filter = true;
 
 	if (of_find_property(np, "nvidia,wakeup-source", NULL))
-		pdata->wakeup = true;
+		kbc->wakeup = true;
 
 	if (!of_get_property(np, "nvidia,kbc-row-pins", &proplen)) {
-		dev_err(&pdev->dev, "property nvidia,kbc-row-pins not found\n");
-		return ERR_PTR(-ENOENT);
+		dev_err(kbc->dev, "property nvidia,kbc-row-pins not found\n");
+		return -ENOENT;
 	}
 	num_rows = proplen / sizeof(u32);
 
 	if (!of_get_property(np, "nvidia,kbc-col-pins", &proplen)) {
-		dev_err(&pdev->dev, "property nvidia,kbc-col-pins not found\n");
-		return ERR_PTR(-ENOENT);
+		dev_err(kbc->dev, "property nvidia,kbc-col-pins not found\n");
+		return -ENOENT;
 	}
 	num_cols = proplen / sizeof(u32);
 
 	if (!of_get_property(np, "linux,keymap", &proplen)) {
-		dev_err(&pdev->dev, "property linux,keymap not found\n");
-		return ERR_PTR(-ENOENT);
+		dev_err(kbc->dev, "property linux,keymap not found\n");
+		return -ENOENT;
 	}
 
 	if (!num_rows || !num_cols || ((num_rows + num_cols) > KBC_MAX_GPIO)) {
-		dev_err(&pdev->dev,
+		dev_err(kbc->dev,
 			"keypad rows/columns not porperly specified\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	/* Set all pins as non-configured */
 	for (i = 0; i < KBC_MAX_GPIO; i++)
-		pdata->pin_cfg[i].type = PIN_CFG_IGNORE;
+		kbc->pin_cfg[i].type = PIN_CFG_IGNORE;
 
 	ret = of_property_read_u32_array(np, "nvidia,kbc-row-pins",
 				rows_cfg, num_rows);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Rows configurations are not proper\n");
-		return ERR_PTR(-EINVAL);
+		dev_err(kbc->dev, "Rows configurations are not proper\n");
+		return -EINVAL;
 	}
 
 	ret = of_property_read_u32_array(np, "nvidia,kbc-col-pins",
 				cols_cfg, num_cols);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Cols configurations are not proper\n");
-		return ERR_PTR(-EINVAL);
+		dev_err(kbc->dev, "Cols configurations are not proper\n");
+		return -EINVAL;
 	}
 
 	for (i = 0; i < num_rows; i++) {
-		pdata->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
-		pdata->pin_cfg[rows_cfg[i]].num = i;
+		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
+		kbc->pin_cfg[rows_cfg[i]].num = i;
 	}
 
 	for (i = 0; i < num_cols; i++) {
-		pdata->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
-		pdata->pin_cfg[cols_cfg[i]].num = i;
+		kbc->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
+		kbc->pin_cfg[cols_cfg[i]].num = i;
 	}
 
-	return pdata;
-}
-#else
-static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
-	struct platform_device *pdev)
-{
-	dev_err(&pdev->dev, "platform data is missing\n");
-	return ERR_PTR(-EINVAL);
+	return 0;
 }
-#endif
 
 static int tegra_kbc_probe(struct platform_device *pdev)
 {
-	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
 	struct tegra_kbc *kbc;
-	struct input_dev *input_dev;
 	struct resource *res;
-	int irq;
 	int err;
 	int num_rows = 0;
 	unsigned int debounce_cnt;
 	unsigned int scan_time_rows;
 	unsigned int keymap_rows = KBC_MAX_KEY;
 
-	if (!pdata)
-		pdata = tegra_kbc_dt_parse_pdata(pdev);
+	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
+	if (!kbc) {
+		dev_err(&pdev->dev, "failed to alloc memory for kbc\n");
+		return -ENOMEM;
+	}
+
+	kbc->dev = &pdev->dev;
+	spin_lock_init(&kbc->lock);
 
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
+	err = tegra_kbc_parse_dt(kbc);
+	if (err)
+		return err;
 
-	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows))
+	if (!tegra_kbc_check_pin_cfg(kbc, &num_rows))
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -591,28 +594,18 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	kbc->irq = platform_get_irq(pdev, 0);
+	if (kbc->irq < 0) {
 		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
 		return -ENXIO;
 	}
 
-	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
-	if (!kbc) {
-		dev_err(&pdev->dev, "failed to alloc memory for kbc\n");
-		return -ENOMEM;
-	}
-
-	input_dev = devm_input_allocate_device(&pdev->dev);
-	if (!input_dev) {
+	kbc->idev = devm_input_allocate_device(&pdev->dev);
+	if (!kbc->idev) {
 		dev_err(&pdev->dev, "failed to allocate input device\n");
 		return -ENOMEM;
 	}
 
-	kbc->pdata = pdata;
-	kbc->idev = input_dev;
-	kbc->irq = irq;
-	spin_lock_init(&kbc->lock);
 	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc);
 
 	kbc->mmio = devm_request_and_ioremap(&pdev->dev, res);
@@ -633,36 +626,32 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	 * the rows. There is an additional delay before the row scanning
 	 * starts. The repoll delay is computed in milliseconds.
 	 */
-	debounce_cnt = min(pdata->debounce_cnt, KBC_MAX_DEBOUNCE_CNT);
+	debounce_cnt = min(kbc->debounce_cnt, KBC_MAX_DEBOUNCE_CNT);
 	scan_time_rows = (KBC_ROW_SCAN_TIME + debounce_cnt) * num_rows;
-	kbc->repoll_dly = KBC_ROW_SCAN_DLY + scan_time_rows + pdata->repeat_cnt;
+	kbc->repoll_dly = KBC_ROW_SCAN_DLY + scan_time_rows + kbc->repeat_cnt;
 	kbc->repoll_dly = DIV_ROUND_UP(kbc->repoll_dly, KBC_CYCLE_MS);
 
-	kbc->wakeup_key = pdata->wakeup_key;
-	kbc->use_fn_map = pdata->use_fn_map;
-	kbc->use_ghost_filter = pdata->use_ghost_filter;
-
-	input_dev->name = pdev->name;
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->dev.parent = &pdev->dev;
-	input_dev->open = tegra_kbc_open;
-	input_dev->close = tegra_kbc_close;
+	kbc->idev->name = pdev->name;
+	kbc->idev->id.bustype = BUS_HOST;
+	kbc->idev->dev.parent = &pdev->dev;
+	kbc->idev->open = tegra_kbc_open;
+	kbc->idev->close = tegra_kbc_close;
 
-	if (pdata->keymap_data && pdata->use_fn_map)
+	if (kbc->keymap_data && kbc->use_fn_map)
 		keymap_rows *= 2;
 
-	err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
+	err = matrix_keypad_build_keymap(kbc->keymap_data, NULL,
 					 keymap_rows, KBC_MAX_COL,
-					 kbc->keycode, input_dev);
+					 kbc->keycode, kbc->idev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to setup keymap\n");
 		return err;
 	}
 
-	__set_bit(EV_REP, input_dev->evbit);
-	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	__set_bit(EV_REP, kbc->idev->evbit);
+	input_set_capability(kbc->idev, EV_MSC, MSC_SCAN);
 
-	input_set_drvdata(input_dev, kbc);
+	input_set_drvdata(kbc->idev, kbc);
 
 	err = devm_request_irq(&pdev->dev, kbc->irq, tegra_kbc_isr,
 			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
@@ -680,7 +669,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, kbc);
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	device_init_wakeup(&pdev->dev, kbc->wakeup);
 
 	return 0;
 }
diff --git a/include/linux/input/tegra_kbc.h b/include/linux/input/tegra_kbc.h
deleted file mode 100644
index a130256..0000000
--- a/include/linux/input/tegra_kbc.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Platform definitions for tegra-kbc keyboard input driver
- *
- * Copyright (c) 2010-2011, NVIDIA Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- */
-
-#ifndef ASMARM_ARCH_TEGRA_KBC_H
-#define ASMARM_ARCH_TEGRA_KBC_H
-
-#include <linux/types.h>
-#include <linux/input/matrix_keypad.h>
-
-#define KBC_MAX_GPIO	24
-#define KBC_MAX_KPENT	8
-
-#define KBC_MAX_ROW	16
-#define KBC_MAX_COL	8
-#define KBC_MAX_KEY	(KBC_MAX_ROW * KBC_MAX_COL)
-
-enum tegra_pin_type {
-	PIN_CFG_IGNORE,
-	PIN_CFG_COL,
-	PIN_CFG_ROW,
-};
-
-struct tegra_kbc_pin_cfg {
-	enum tegra_pin_type type;
-	unsigned char num;
-};
-
-struct tegra_kbc_wake_key {
-	u8 row:4;
-	u8 col:4;
-};
-
-struct tegra_kbc_platform_data {
-	unsigned int debounce_cnt;
-	unsigned int repeat_cnt;
-
-	struct tegra_kbc_pin_cfg pin_cfg[KBC_MAX_GPIO];
-	const struct matrix_keymap_data *keymap_data;
-
-	u32 wakeup_key;
-	bool wakeup;
-	bool use_fn_map;
-	bool use_ghost_filter;
-};
-#endif
-- 
1.7.10.4

