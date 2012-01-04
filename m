From: Olof Johansson <olof@lixom.net>
Subject: [PATCH v2] [INCREMENTAL] Input: tegra-kbc - add device tree support
Date: Tue,  3 Jan 2012 17:19:16 -0800
Message-ID: <1325639956-27502-1-git-send-email-olof@lixom.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58069 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2ADBTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2012 20:19:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, riyer@nvidia.com, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, sjg@chromium.org, swarren@nvidia.com, grant.likely@secretlab.ca, Olof Johansson <olof@lixom.net>

This is an incremental patch updating to the revised bindings for matrix keyboards.

This includes an optional "linux,fn-keymap" binding that is not yet implemented,
that will be used to specify the Fn-key modifier layout if needed.

New for v2:
* Removed references to "matrix-keyboard-controller" compatible values
* Rebased to be incremental on top of previous patch.

Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Stephen Warren <swarren@nvidia.com>

---

Dmitry,

Here's an incremental patch to go on top of your next branch.

Regards,

-Olof
---
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
index a136e2e..383fa83 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -590,6 +590,8 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 {
 	struct tegra_kbc_platform_data *pdata;
 	struct device_node *np = pdev->dev.of_node;
+	u32 prop;
+	int i;
 
 	if (!np)
 		return NULL;
@@ -598,16 +600,16 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
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
@@ -624,6 +626,10 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 		pdata->pin_cfg[KBC_MAX_ROW + i].is_row = false;
 	}
 
+	pdata->keymap_data = matrix_keyboard_of_fill_keymap(np, "linux,keymap");
+
+	/* FIXME: Add handling of linux,fn-keymap here */
+
 	return pdata;
 }
 #else
@@ -759,6 +765,9 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, kbc);
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
+	if (!pdev->dev.platform_data)
+		matrix_keyboard_of_free_keymap(pdata->keymap_data);
+
 	return 0;
 
 err_free_irq:
@@ -773,8 +782,10 @@ err_free_mem:
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
1.7.8.GIT

