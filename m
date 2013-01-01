From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH v2 1/3] Input: imx_keypad - Add device tree support
Date: Tue, 1 Jan 2013 11:21:13 +0800
Message-ID: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:41798
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab3AAEB2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Dec 2012 23:01:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, liu.y.victor@gmail.com, Liu Ying <Ying.Liu@freescale.com>

This patch adds device tree support for imx keypad driver.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
Changes since v1:
- Parse the array keypad->keycodes[] to get row and column
  mask value instead of parsing DT-supplied data again.
- Remove the pinctrl related code which sets row and column
  key pins.
- Leave matrix_keypad_build_keymap() to determine platform
  data and DT-supplied data precedence.
- Change DT compatible string from 'fsl,imx-kpp' to 'fsl,
  <soc>-kpp'.
---
 .../devicetree/bindings/input/imx-keypad.txt       |   53 ++++++++++++++++++
 drivers/input/keyboard/imx_keypad.c                |   59 ++++++++++++++------
 2 files changed, 94 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/imx-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/imx-keypad.txt b/Documentation/devicetree/bindings/input/imx-keypad.txt
new file mode 100644
index 0000000..2ebaf7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/imx-keypad.txt
@@ -0,0 +1,53 @@
+* Freescale i.MX Keypad Port(KPP) device tree bindings
+
+The KPP is designed to interface with a keypad matrix with 2-point contact
+or 3-point contact keys. The KPP is designed to simplify the software task
+of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
+and decoding one or multiple keys pressed simultaneously on a keypad.
+
+Required SoC Specific Properties:
+- compatible: Should be "fsl,<soc>-kpp".
+
+- reg: Physical base address of the KPP and length of memory mapped
+  region.
+
+- interrupts: The KPP interrupt number to the CPU(s).
+
+- clocks: The clock provided by the SoC to the KPP. Some SoCs use dummy
+clock(The clock for the KPP is provided by the SoCs automatically).
+
+Required Board Specific Properties:
+- pinctrl-names: The definition can be found at
+pinctrl/pinctrl-bindings.txt.
+
+- pinctrl-0: The definition can be found at
+pinctrl/pinctrl-bindings.txt.
+
+- linux,keymap: The definition can be found at
+bindings/input/matrix-keymap.txt.
+
+Example:
+kpp: kpp@73f94000 {
+	compatible = "fsl,imx51-kpp", "fsl,imx21-kpp";
+	reg = <0x73f94000 0x4000>;
+	interrupts = <60>;
+	clocks = <&clks 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp_1>;
+	linux,keymap = <0x00000067	/* KEY_UP */
+			0x0001006c	/* KEY_DOWN */
+			0x00020072	/* KEY_VOLUMEDOWN */
+			0x00030066	/* KEY_HOME */
+			0x0100006a	/* KEY_RIGHT */
+			0x01010069	/* KEY_LEFT */
+			0x0102001c	/* KEY_ENTER */
+			0x01030073	/* KEY_VOLUMEUP */
+			0x02000040	/* KEY_F6 */
+			0x02010042	/* KEY_F8 */
+			0x02020043	/* KEY_F9 */
+			0x02030044	/* KEY_F10 */
+			0x0300003b	/* KEY_F1 */
+			0x0301003c	/* KEY_F2 */
+			0x0302003d	/* KEY_F3 */
+			0x03030074>;	/* KEY_POWER */
+};
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 6d150e3..16eaba8 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -20,6 +20,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
@@ -414,15 +415,38 @@ open_err:
 	return -EIO;
 }
 
+static struct of_device_id imx_keypad_of_match[] = {
+	{ .compatible = "fsl,imx21-kpp", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_keypad_of_match);
+
+#ifdef CONFIG_OF
+static inline int imx_keypad_check_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	return 0;
+}
+#else
+static inline int imx_keypad_check_dt(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 static int imx_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
-	int irq, error, i;
+	int irq, error, i, row, col, row_shift;
 
-	if (keymap_data == NULL) {
+	if (keymap_data == NULL && imx_keypad_check_dt(pdev)) {
 		dev_err(&pdev->dev, "no keymap defined\n");
 		return -EINVAL;
 	}
@@ -480,22 +504,6 @@ static int imx_keypad_probe(struct platform_device *pdev)
 		goto failed_unmap;
 	}
 
-	/* Search for rows and cols enabled */
-	for (i = 0; i < keymap_data->keymap_size; i++) {
-		keypad->rows_en_mask |= 1 << KEY_ROW(keymap_data->keymap[i]);
-		keypad->cols_en_mask |= 1 << KEY_COL(keymap_data->keymap[i]);
-	}
-
-	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
-	    keypad->cols_en_mask > ((1 << MAX_MATRIX_KEY_COLS) - 1)) {
-		dev_err(&pdev->dev,
-			"invalid key data (too many rows or colums)\n");
-		error = -EINVAL;
-		goto failed_clock_put;
-	}
-	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
-	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
-
 	/* Init the Input device */
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
@@ -512,6 +520,20 @@ static int imx_keypad_probe(struct platform_device *pdev)
 		goto failed_clock_put;
 	}
 
+	/* Search for rows and cols enabled */
+	row_shift = get_count_order(MAX_MATRIX_KEY_COLS);
+	for (row = 0; row < MAX_MATRIX_KEY_ROWS; row++) {
+		for (col = 0; col < MAX_MATRIX_KEY_COLS; col++) {
+			i = (row << row_shift) + col;
+			if (keypad->keycodes[i]) {
+				keypad->rows_en_mask |= 1 << row;
+				keypad->cols_en_mask |= 1 << col;
+			}
+		}
+	}
+	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
+	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
+
 	__set_bit(EV_REP, input_dev->evbit);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(input_dev, keypad);
@@ -631,6 +653,7 @@ static struct platform_driver imx_keypad_driver = {
 		.name	= "imx-keypad",
 		.owner	= THIS_MODULE,
 		.pm	= &imx_kbd_pm_ops,
+		.of_match_table = of_match_ptr(imx_keypad_of_match),
 	},
 	.probe		= imx_keypad_probe,
 	.remove		= imx_keypad_remove,
-- 
1.7.1


