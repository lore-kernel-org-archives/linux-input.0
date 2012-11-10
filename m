From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v5] Input: matrix-keypad - Add device tree support
Date: Sun, 11 Nov 2012 03:10:32 +0530
Message-ID: <1352583632-30550-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58404 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab2KJVkz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Nov 2012 16:40:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca
Cc: rob.herring@calxeda.com, dgdunix@gmail.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add device tree support to matrix keypad driver and usage details
are added to device tree documentation. Driver was tested on AM335x
EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
This patch was tested on AM335x-EVM and based on linux-next, cleanly
applies on top of "input/next"

Changes from v4:
	- Removed clustered-irq support through DT. This should be
	  added if any platform requires in the future.

Changes from v3:
	- Incorporated Stephen Warren's review comments on v3
	  * Added description to clustered-irq-flags binding

Changes from v2:
	- Incorporated Stephen Warren's review comments on v2
	  * Renamed the bindings file to gpio-matrix-keypad.txt
	  * Added description to clustered-irq binding

Changes from v1:
	- Incorporated Rob's review comments on v1
	  * Changed matix-keypad compatible to gpio-matrix-keypad
	  * Removed unnecessary props (num of gpios)
	  * Used of_match_ptr()
	- Removed first patch based on Dmitry's comments on v1

 .../bindings/input/gpio-matrix-keypad.txt          |   46 +++++++++
 drivers/input/keyboard/matrix_keypad.c             |  104 +++++++++++++++++++-
 2 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
new file mode 100644
index 0000000..ead641c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -0,0 +1,46 @@
+* GPIO driven matrix keypad device tree bindings
+
+GPIO driven matrix keypad is used to interface a SoC with a matrix keypad.
+The matrix keypad supports multiple row and column lines, a key can be
+placed at each intersection of a unique row and a unique column. The matrix
+keypad can sense a key-press and key-release by means of GPIO lines and
+report the event using GPIO interrupts to the cpu.
+
+Required Properties:
+- compatible:		Should be "gpio-matrix-keypad"
+- row-gpios:		List of gpios used as row lines. The gpio specifier
+			for this property depends on the gpio controller to
+			which these row lines are connected.
+- col-gpios:		List of gpios used as column lines. The gpio specifier
+			for this property depends on the gpio controller to
+			which these column lines are connected.
+- linux,keymap:		The definition can be found at
+			bindings/input/matrix-keymap.txt
+
+Optional Properties:
+- linux,no-autorepeat:	do no enable autorepeat feature.
+- linux,wakeup:		use any event on keypad as wakeup event.
+- debounce-delay-ms:	debounce interval in milliseconds
+- col-scan-delay-us:	delay, measured in microseconds, that is needed
+			before we can scan keypad after activating column gpio
+
+Example:
+	matrix-keypad {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <2>;
+
+		row-gpios = <&gpio2 25 0
+			     &gpio2 26 0
+			     &gpio2 27 0>;
+
+		col-gpios = <&gpio2 21 0
+			     &gpio2 22 0>;
+
+		linux,keymap = <0x0000008B
+				0x0100009E
+				0x02000069
+				0x0001006A
+				0x0101001C
+				0x0201006C>;
+	};
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 18b7237..3ba8cfb 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -23,6 +23,9 @@
 #include <linux/gpio.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
 
 struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
@@ -394,6 +397,93 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		gpio_free(pdata->col_gpios[i]);
 }
 
+#ifdef CONFIG_OF
+static
+struct matrix_keypad_platform_data *matrix_keypad_parse_dt(struct device *dev)
+{
+	struct matrix_keypad_platform_data *pdata;
+	struct matrix_keymap_data *keymap_data;
+	struct device_node *np = dev->of_node;
+	unsigned int *row_gpios;
+	unsigned int *col_gpios;
+	struct property *prop;
+	int key_count = 0, length, row, col;
+	uint32_t *keymap;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "could not allocate memory for platform data\n");
+		return NULL;
+	}
+
+	pdata->num_row_gpios = of_gpio_named_count(np, "row-gpios");
+	pdata->num_col_gpios = of_gpio_named_count(np, "col-gpios");
+	if (!pdata->num_row_gpios || !pdata->num_col_gpios) {
+		dev_err(dev, "number of keypad rows/columns not specified\n");
+		return NULL;
+	}
+
+	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
+	if (!keymap_data) {
+		dev_err(dev, "could not allocate memory for keymap data\n");
+		return NULL;
+	}
+	pdata->keymap_data = keymap_data;
+
+	prop = of_find_property(np, "linux,keymap", &length);
+	if (!prop)
+		return NULL;
+
+	key_count = length / sizeof(u32);
+	keymap_data->keymap_size = key_count;
+	keymap = devm_kzalloc(dev, sizeof(uint32_t) * key_count, GFP_KERNEL);
+	if (!keymap) {
+		dev_err(dev, "could not allocate memory for keymap\n");
+		return NULL;
+	}
+	keymap_data->keymap = keymap;
+
+	of_property_read_u32_array(np, "linux,keymap", keymap, key_count);
+
+	if (of_get_property(np, "linux,no-autorepeat", NULL))
+		pdata->no_autorepeat = true;
+	if (of_get_property(np, "linux,wakeup", NULL))
+		pdata->wakeup = true;
+	if (of_get_property(np, "gpio-activelow", NULL))
+		pdata->active_low = true;
+
+	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
+	of_property_read_u32(np, "col-scan-delay-us",
+						&pdata->col_scan_delay_us);
+
+	row_gpios = devm_kzalloc(dev, sizeof(unsigned int) *
+					pdata->num_row_gpios, GFP_KERNEL);
+	col_gpios = devm_kzalloc(dev, sizeof(unsigned int) *
+					pdata->num_col_gpios, GFP_KERNEL);
+	if (!row_gpios || !col_gpios) {
+		dev_err(dev, "could not allocate memory for gpios\n");
+		return NULL;
+	}
+
+	for (row = 0; row < pdata->num_row_gpios; row++)
+		row_gpios[row] = of_get_named_gpio(np, "row-gpios", row);
+
+	for (col = 0; col < pdata->num_col_gpios; col++)
+		col_gpios[col] = of_get_named_gpio(np, "col-gpios", col);
+
+	pdata->row_gpios = row_gpios;
+	pdata->col_gpios = col_gpios;
+
+	return pdata;
+}
+#else
+static
+struct matrix_keypad_platform_data *matrix_keypad_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keypad_platform_data *pdata;
@@ -404,7 +494,10 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	size_t keymap_size;
 	int err;
 
-	pdata = pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		pdata = matrix_keypad_parse_dt(&pdev->dev);
+	else
+		pdata = pdev->dev.platform_data;
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -EINVAL;
@@ -488,6 +581,14 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id matrix_keypad_dt_match[] = {
+	{ .compatible = "gpio-matrix-keypad" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
+#endif
+
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
 	.remove		= __devexit_p(matrix_keypad_remove),
@@ -495,6 +596,7 @@ static struct platform_driver matrix_keypad_driver = {
 		.name	= "matrix-keypad",
 		.owner	= THIS_MODULE,
 		.pm	= &matrix_keypad_pm_ops,
+		.of_match_table = of_match_ptr(matrix_keypad_dt_match),
 	},
 };
 module_platform_driver(matrix_keypad_driver);
-- 
1.7.9.5

