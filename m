From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Input: tegra-kbc - add device tree support
Date: Tue,  3 Jan 2012 14:28:22 -0800
Message-ID: <1325629702-10307-1-git-send-email-olof@lixom.net>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325484557-27695-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This includes an optional "linux,fn-keymap" binding that is not yet implemented,
that will be used to specify the Fn-key modifier layout if needed.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

This patch depends on "Input: keyboard - add device tree bindings for
simple key matrixes".


-Olof
 .../devicetree/bindings/input/tegra-kbc.txt        |   23 +++++
 drivers/input/keyboard/tegra-kbc.c                 |  103 ++++++++++++++++++--
 2 files changed, 118 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tegra-kbc.txt

diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/tegra-kbc.txt
new file mode 100644
index 0000000..b630eeb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/tegra-kbc.txt
@@ -0,0 +1,23 @@
+* Tegra keyboard controller
+
+Required properties:
+- compatible: "nvidia,tegra20-kbc", "matrix-keyboard-controller"
+
+Optional properties, in addition to those specified by
+"matrix-keyboard-controller" bindings:
+
+- linux,fn-keymap: a second keymap, same specification as the
+matrix-keyboard-controller spec but to be used when the KEY_FN modifier
+key is pressed.
+- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debouncing
+- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
+- nvidia,ghost-filter: enable ghost filtering for this device
+- nvidia,wakeup-source: configure keyboard as a wakeup source for suspend/resume
+
+Example:
+
+keyboard: keyboard {
+	compatible = "nvidia,tegra20-kbc";
+	reg = <0x7000e200 0x100>;
+	nvidia,ghost-filter;
+};
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 08d02f2..0794879 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <mach/clk.h>
@@ -82,7 +83,7 @@ struct tegra_kbc {
 	struct clk *clk;
 };
 
-static const u32 tegra_kbc_default_keymap[] = {
+static const u32 tegra_kbc_default_keymap[] __devinitdata = {
 	KEY(0, 2, KEY_W),
 	KEY(0, 3, KEY_S),
 	KEY(0, 4, KEY_A),
@@ -217,7 +218,8 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(31, 4, KEY_HELP),
 };
 
-static const struct matrix_keymap_data tegra_kbc_default_keymap_data = {
+static const
+struct matrix_keymap_data tegra_kbc_default_keymap_data __devinitdata = {
 	.keymap		= tegra_kbc_default_keymap,
 	.keymap_size	= ARRAY_SIZE(tegra_kbc_default_keymap),
 };
@@ -576,6 +578,62 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 	return true;
 }
 
+#ifdef CONFIG_OF
+static struct tegra_kbc_platform_data * __devinit
+tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
+{
+	struct tegra_kbc_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	u32 prop;
+	int i;
+
+	if (!np)
+		return NULL;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	if (!of_property_read_u32(np, "nvidia,debounce-delay-ms", &prop))
+		pdata->debounce_cnt = prop;
+
+	if (!of_property_read_u32(np, "nvidia,repeat-delay-ms", &prop))
+		pdata->repeat_cnt = prop;
+
+	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
+		pdata->use_ghost_filter = true;
+
+	if (of_find_property(np, "nvidia,wakeup-source", NULL))
+		pdata->wakeup = true;
+
+	/*
+	 * All currently known keymaps with device tree support use the same
+	 * pin_cfg, so set it up here.
+	 */
+	for (i = 0; i < KBC_MAX_ROW; i++) {
+		pdata->pin_cfg[i].num = i;
+		pdata->pin_cfg[i].is_row = true;
+	}
+
+	for (i = 0; i < KBC_MAX_COL; i++) {
+		pdata->pin_cfg[KBC_MAX_ROW + i].num = i;
+		pdata->pin_cfg[KBC_MAX_ROW + i].is_row = false;
+	}
+
+	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
+
+	/* FIXME: Add handling of linux,fn-keymap here */
+
+	return pdata;
+}
+#else
+static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
+	struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 {
 	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
@@ -590,21 +648,28 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int scan_time_rows;
 
 	if (!pdata)
-		return -EINVAL;
+		pdata = tegra_kbc_dt_parse_pdata(pdev);
 
-	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows))
+	if (!pdata)
 		return -EINVAL;
 
+	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows)) {
+		err = -EINVAL;
+		goto err_free_pdata;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
+		err = -ENXIO;
+		goto err_free_pdata;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
-		return -ENXIO;
+		err = -ENXIO;
+		goto err_free_pdata;
 	}
 
 	kbc = kzalloc(sizeof(*kbc), GFP_KERNEL);
@@ -693,6 +758,9 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
+	if (!pdev->dev.platform_data)
+		matrix_keyboard_of_free_keymap(pdata->keymap_data);
+
 	return 0;
 
 err_free_irq:
@@ -706,6 +774,11 @@ err_free_mem_region:
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(kbc);
+err_free_pdata:
+	if (!pdev->dev.platform_data) {
+		matrix_keyboard_of_free_keymap(pdata->keymap_data);
+		kfree(pdata);
+	}
 
 	return err;
 }
@@ -715,6 +788,8 @@ static int __devexit tegra_kbc_remove(struct platform_device *pdev)
 	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
 	struct resource *res;
 
+	platform_set_drvdata(pdev, NULL);
+
 	free_irq(kbc->irq, pdev);
 	clk_put(kbc->clk);
 
@@ -723,9 +798,14 @@ static int __devexit tegra_kbc_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	kfree(kbc);
+	/*
+	 * If we do not have platform data attached to the device we
+	 * allocated it ourselves and thus need to free it.
+	 */
+	if (!pdev->dev.platform_data)
+		kfree(kbc->pdata);
 
-	platform_set_drvdata(pdev, NULL);
+	kfree(kbc);
 
 	return 0;
 }
@@ -793,6 +873,12 @@ static int tegra_kbc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(tegra_kbc_pm_ops, tegra_kbc_suspend, tegra_kbc_resume);
 
+static const struct of_device_id tegra_kbc_of_match[] = {
+	{ .compatible = "nvidia,tegra20-kbc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra_kbc_of_match);
+
 static struct platform_driver tegra_kbc_driver = {
 	.probe		= tegra_kbc_probe,
 	.remove		= __devexit_p(tegra_kbc_remove),
@@ -800,6 +886,7 @@ static struct platform_driver tegra_kbc_driver = {
 		.name	= "tegra-kbc",
 		.owner  = THIS_MODULE,
 		.pm	= &tegra_kbc_pm_ops,
+		.of_match_table = tegra_kbc_of_match,
 	},
 };
 module_platform_driver(tegra_kbc_driver);
-- 
1.7.8.GIT
