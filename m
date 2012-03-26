From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 2/2] Input: spear-keyboard: add device tree bindings
Date: Mon, 26 Mar 2012 15:15:13 +0530
Message-ID: <a2d16bc563cf5c7e8eebf817de0a1eb08d7b96ba.1332754641.git.viresh.kumar@st.com>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:56694 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757040Ab2CZJqh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 05:46:37 -0400
In-Reply-To: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, swarren@nvidia.com, rajeev-dlh.kumar@st.com, olof@lixom.net, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

This adds simple DT bindings for spear-keyboard controller.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 .../devicetree/bindings/input/spear-keyboard.txt   |   21 +++++++
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/spear-keyboard.c            |   63 +++++++++++++++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/spear-keyboard.txt

diff --git a/Documentation/devicetree/bindings/input/spear-keyboard.txt b/Documentation/devicetree/bindings/input/spear-keyboard.txt
new file mode 100644
index 0000000..3dc0103
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/spear-keyboard.txt
@@ -0,0 +1,21 @@
+* SPEAr keyboard controller
+
+Required properties:
+- compatible: "st,spear-kbd"
+
+Optional properties, in addition to those specified by the shared
+matrix-keyboard bindings:
+- autorepeat: bool: enables key autorepeat
+- mode: keyboard mode: 0 - 9x9, 1 - 6x6, 2 - 2x2
+
+Example:
+
+kbd@fc400000 {
+	compatible = "st,spear-kbd";
+	reg = <0xfc400000 0x100>;
+	linux,keymap = < 0x00030012
+			 0x0102003a >;
+	autorepeat;
+	mode = <0>;
+};
+
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index f354813..6da2b02 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -522,6 +522,7 @@ config KEYBOARD_OMAP4
 config KEYBOARD_SPEAR
 	tristate "ST SPEAR keyboard support"
 	depends on PLAT_SPEAR
+	select INPUT_OF_MATRIX_KEYMAP if USE_OF
 	help
 	  Say Y here if you want to use the SPEAR keyboard.
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 3b6b528..2a16519 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeup.h>
 #include <linux/slab.h>
@@ -136,9 +137,43 @@ static void spear_kbd_close(struct input_dev *dev)
 	kbd->last_key = KEY_RESERVED;
 }
 
+#ifdef CONFIG_OF
+static int __devinit spear_kbd_probe_dt(struct platform_device *pdev)
+{
+	struct kbd_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+
+	pdata->keymap = matrix_keyboard_of_fill_keymap(&pdev->dev, np,
+			"linux,keymap");
+	if (!pdata->keymap) {
+		dev_err(&pdev->dev, "DT: Invalid keymap array\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_bool(np, "autorepeat"))
+		pdata->rep = true;
+
+	if (!of_property_read_u32(np, "mode", &val)) {
+		pdata->mode = val;
+	} else {
+		dev_err(&pdev->dev, "DT: Invalid mode\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+#else
+static int __devinit spear_kbd_probe_dt(struct platform_device *pdev)
+{
+	return -ENOSYS;
+}
+#endif
+
 static int __devinit spear_kbd_probe(struct platform_device *pdev)
 {
-	const struct kbd_platform_data *pdata = pdev->dev.platform_data;
+	struct kbd_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
 	const struct matrix_keymap_data *keymap;
 	struct spear_kbd *kbd;
 	struct input_dev *input_dev;
@@ -146,6 +181,23 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 	int irq;
 	int error;
 
+	if (np) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "DT: kzalloc failed\n");
+			return -ENOMEM;
+		}
+
+		pdev->dev.platform_data = pdata;
+		error = spear_kbd_probe_dt(pdev);
+		if (error) {
+			dev_err(&pdev->dev, "DT: no platform data\n");
+			return error;
+		}
+	} else {
+		pdata = dev_get_platdata(&pdev->dev);
+	}
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "Invalid platform data\n");
 		return -EINVAL;
@@ -317,6 +369,14 @@ static int spear_kbd_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id spear_kbd_id_table[] = {
+	{ .compatible = "st,spear-kbd" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spear_kbd_id_table);
+#endif
+
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
 	.remove		= __devexit_p(spear_kbd_remove),
@@ -324,6 +384,7 @@ static struct platform_driver spear_kbd_driver = {
 		.name	= "keyboard",
 		.owner	= THIS_MODULE,
 		.pm	= &spear_kbd_pm_ops,
+		.of_match_table = of_match_ptr(spear_kbd_id_table),
 	},
 };
 module_platform_driver(spear_kbd_driver);
-- 
1.7.10.rc2.10.gb47606

