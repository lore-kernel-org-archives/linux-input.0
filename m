From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V3 2/2] Input: spear-keyboard: add device tree bindings
Date: Wed, 28 Mar 2012 15:24:55 +0530
Message-ID: <782f3bf6de204785b6d1bc389b58ec6cf3d722e4.1332826100.git.viresh.kumar@st.com>
References: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sr-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds simple DT bindings for spear-keyboard controller.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/input/spear-keyboard.txt   |   21 +++++
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/spear-keyboard.c            |   87 +++++++++++++++++---
 3 files changed, 96 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/spear-keyboard.txt

diff --git a/Documentation/devicetree/bindings/input/spear-keyboard.txt b/Documentation/devicetree/bindings/input/spear-keyboard.txt
new file mode 100644
index 0000000..e1bcf13
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/spear-keyboard.txt
@@ -0,0 +1,21 @@
+* SPEAr keyboard controller
+
+Required properties:
+- compatible: "st,spear300-kbd"
+
+Optional properties, in addition to those specified by the shared
+matrix-keyboard bindings:
+- autorepeat: bool: enables key autorepeat
+- st,mode: keyboard mode: 0 - 9x9, 1 - 6x6, 2 - 2x2
+
+Example:
+
+kbd@fc400000 {
+	compatible = "st,spear300-kbd";
+	reg = <0xfc400000 0x100>;
+	linux,keymap = < 0x00030012
+			 0x0102003a >;
+	autorepeat;
+	st,mode = <0>;
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
index 3b6b528..d72e4cb 100644
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
@@ -136,25 +137,66 @@ static void spear_kbd_close(struct input_dev *dev)
 	kbd->last_key = KEY_RESERVED;
 }
 
+#ifdef CONFIG_OF
+static int __devinit spear_kbd_probe_dt(struct platform_device *pdev)
+{
+	struct kbd_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+
+	if (of_property_read_bool(np, "autorepeat"))
+		pdata->rep = true;
+
+	if (!of_property_read_u32(np, "st,mode", &val)) {
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
-	const struct matrix_keymap_data *keymap;
+	struct kbd_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = NULL;
 	struct spear_kbd *kbd;
 	struct input_dev *input_dev;
 	struct resource *res;
 	int irq;
 	int error;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "Invalid platform data\n");
-		return -EINVAL;
-	}
-
-	keymap = pdata->keymap;
-	if (!keymap) {
-		dev_err(&pdev->dev, "no keymap defined\n");
-		return -EINVAL;
+	if (pdata) {
+		if (!pdata->keymap) {
+			dev_err(&pdev->dev, "Invalid platform data\n");
+			return -EINVAL;
+		}
+	} else {
+		np = pdev->dev.of_node;
+		if (!np) {
+			dev_err(&pdev->dev, "Failed: Neither DT nor Pdata is passed\n");
+			return -EINVAL;
+		}
+
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
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -221,8 +263,18 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 	input_dev->keycodesize = sizeof(kbd->keycodes[0]);
 	input_dev->keycodemax = ARRAY_SIZE(kbd->keycodes);
 
-	matrix_keypad_build_keymap(keymap, ROW_SHIFT,
-			input_dev->keycode, input_dev->keybit);
+	if (np) {
+		error = matrix_keypad_of_build_keymap(&pdev->dev, ROW_SHIFT,
+				input_dev->keycode, input_dev->keybit,
+				"linux,keymap");
+		if (error) {
+			dev_err(&pdev->dev, "OF: failed to build keymap\n");
+			goto err_put_clk;
+		}
+	} else {
+		matrix_keypad_build_keymap(pdata->keymap, ROW_SHIFT,
+				input_dev->keycode, input_dev->keybit);
+	}
 
 	input_set_drvdata(input_dev, kbd);
 
@@ -317,6 +369,14 @@ static int spear_kbd_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id spear_kbd_id_table[] = {
+	{ .compatible = "st,spear300-kbd" },
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
