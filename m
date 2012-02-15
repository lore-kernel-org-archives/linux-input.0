From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Input: tegra-kbc - revise device tree support
Date: Wed, 15 Feb 2012 14:40:26 -0800
Message-ID: <1329345626-30789-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is an incremental patch updating to the revised bindings for matrix keyboards.

This includes an optional "linux,fn-keymap" binding that is not yet implemented,
that will be used to specify the Fn-key modifier layout if needed.

New for v2:
* Removed references to "matrix-keyboard-controller" compatible values
* Rebased to be incremental on top of previous patch.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

Dmitry,

This is a resend of the incremental patch you requested right around
the 3.3 merge window cutoff. The patch you did pick up implemented an
early version of the binding that was later changed. Please apply this
for the 3.4 merge window to sync it up again.

Thanks!


-Olof

 .../devicetree/bindings/input/tegra-kbc.txt        |   17 ++++++++++-----
 drivers/input/keyboard/tegra-kbc.c                 |   21 +++++++++++++++----
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/tegra-kbc.txt
index 5ecfa99..72683be 100644
--- a/Documentation/devicetree/bindings/input/tegra-kbc.txt
+++ b/Documentation/devicetree/bindings/input/tegra-kbc.txt
@@ -3,16 +3,21 @@
 Required properties:
 - compatible: "nvidia,tegra20-kbc"
 
-Optional properties:
-- debounce-delay: delay in milliseconds per row scan for debouncing
-- repeat-delay: delay in milliseconds before repeat starts
-- ghost-filter: enable ghost filtering for this device
-- wakeup-source: configure keyboard as a wakeup source for suspend/resume
+Optional properties, in addition to those specified by the shared
+matrix-keyboard bindings:
+
+- linux,fn-keymap: a second keymap, same specification as the
+  matrix-keyboard-controller spec but to be used when the KEY_FN modifier
+  key is pressed.
+- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debouncing
+- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
+- nvidia,ghost-filter: enable ghost filtering for this device
+- nvidia,wakeup-source: configure keyboard as a wakeup source for suspend/resume
 
 Example:
 
 keyboard: keyboard {
 	compatible = "nvidia,tegra20-kbc";
 	reg = <0x7000e200 0x100>;
-	ghost-filter;
+	nvidia,ghost-filter;
 };
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index dc19432..21c42f8 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -624,6 +624,8 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 {
 	struct tegra_kbc_platform_data *pdata;
 	struct device_node *np = pdev->dev.of_node;
+	u32 prop;
+	int i;
 
 	if (!np)
 		return NULL;
@@ -631,16 +633,16 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 	if (!pdata)
 		return NULL;
 
-	if (!of_property_read_u32(np, "debounce-delay", &prop))
+	if (!of_property_read_u32(np, "nvidia,debounce-delay-ms", &prop))
 		pdata->debounce_cnt = prop;
 
-	if (!of_property_read_u32(np, "repeat-delay", &prop))
+	if (!of_property_read_u32(np, "nvidia,repeat-delay-ms", &prop))
 		pdata->repeat_cnt = prop;
 
-	if (of_find_property(np, "needs-ghost-filter", NULL))
+	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
 		pdata->use_ghost_filter = true;
 
-	if (of_find_property(np, "wakeup-source", NULL))
+	if (of_find_property(np, "nvidia,wakeup-source", NULL))
 		pdata->wakeup = true;
 
 	/*
@@ -657,6 +659,10 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 		pdata->pin_cfg[KBC_MAX_ROW + i].type = PIN_CFG_COL;
 	}
 
+	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
+
+	/* FIXME: Add handling of linux,fn-keymap here */
+
 	return pdata;
 }
 #else
@@ -792,6 +798,9 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
+	if (!pdev->dev.platform_data)
+		matrix_keyboard_of_free_keymap(pdata->keymap_data);
+
 	return 0;
 
 err_free_irq:
@@ -806,8 +815,10 @@ err_free_mem:
 	input_free_device(input_dev);
 	kfree(kbc);
 err_free_pdata:
-	if (!pdev->dev.platform_data)
+	if (!pdev->dev.platform_data) {
+		matrix_keyboard_of_free_keymap(pdata->keymap_data);
 		kfree(pdata);
+	}
 
 	return err;
 }
-- 
1.7.9.209.gb6b3b
