From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 1/2] input/of_keymap: Convert kzalloc to devm_kzalloc derivative
Date: Mon, 26 Mar 2012 15:15:12 +0530
Message-ID: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:36868 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756942Ab2CZKL7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 06:11:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, swarren@nvidia.com, rajeev-dlh.kumar@st.com, olof@lixom.net, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

matrix_keyboard_of_fill_keymap() routines allocates memory using kzalloc()
routine. It is freed on call to matrix_keyboard_of_free_keymap() routine.

This patch converts these kzalloc() calls to devm_kzalloc() and thus we don't
require matrix_keyboard_of_free_keymap() anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/input/keyboard/tegra-kbc.c  |   10 +++-------
 drivers/input/of_keymap.c           |   18 +++++-------------
 include/linux/input/matrix_keypad.h |   14 ++++----------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 21c42f8..40ee63f 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -659,7 +659,8 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 		pdata->pin_cfg[KBC_MAX_ROW + i].type = PIN_CFG_COL;
 	}
 
-	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
+	pdata->keymap_data = matrix_keyboard_of_fill_keymap(&pdev->dev, np,
+			"linux,keymap");
 
 	/* FIXME: Add handling of linux,fn-keymap here */
 
@@ -798,9 +799,6 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
-	if (!pdev->dev.platform_data)
-		matrix_keyboard_of_free_keymap(pdata->keymap_data);
-
 	return 0;
 
 err_free_irq:
@@ -815,10 +813,8 @@ err_free_mem:
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
index 061493d..17eb27e 100644
--- a/drivers/input/of_keymap.c
+++ b/drivers/input/of_keymap.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/input.h>
@@ -27,7 +28,7 @@
 #include <linux/slab.h>
 
 struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np,
+matrix_keyboard_of_fill_keymap(struct device *dev, struct device_node *np,
 			       const char *propname)
 {
 	struct matrix_keymap_data *kd;
@@ -46,16 +47,16 @@ matrix_keyboard_of_fill_keymap(struct device_node *np,
 		return NULL;
 
 	if (proplen % sizeof(u32)) {
-		pr_warn("Malformed keymap property %s in %s\n",
+		dev_warn(dev, "Malformed keymap property %s in %s\n",
 			propname, np->full_name);
 		return NULL;
 	}
 
-	kd = kzalloc(sizeof(*kd), GFP_KERNEL);
+	kd = devm_kzalloc(dev, sizeof(*kd), GFP_KERNEL);
 	if (!kd)
 		return NULL;
 
-	kd->keymap = keymap = kzalloc(proplen, GFP_KERNEL);
+	kd->keymap = keymap = devm_kzalloc(dev, proplen, GFP_KERNEL);
 	if (!kd->keymap) {
 		kfree(kd);
 		return NULL;
@@ -76,12 +77,3 @@ matrix_keyboard_of_fill_keymap(struct device_node *np,
 	return kd;
 }
 EXPORT_SYMBOL_GPL(matrix_keyboard_of_fill_keymap);
-
-void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
-{
-	if (kd) {
-		kfree(kd->keymap);
-		kfree(kd);
-	}
-}
-EXPORT_SYMBOL_GPL(matrix_keyboard_of_free_keymap);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 6c07ced..fb2e578 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -109,20 +109,14 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 
 #ifdef CONFIG_INPUT_OF_MATRIX_KEYMAP
 struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname);
-
-void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
+matrix_keyboard_of_fill_keymap(struct device *dev, struct device_node *np,
+		const char *propname);
 #else
 static inline struct matrix_keymap_data *
-matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname)
+matrix_keyboard_of_fill_keymap(struct device *dev, struct device_node *np,
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

