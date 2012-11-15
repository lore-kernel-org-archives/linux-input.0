From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v6] Input: matrix-keypad - Add device tree support
Date: Thu, 15 Nov 2012 19:43:08 +0530
Message-ID: <1352988788-5336-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767828Ab2KOOOV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 09:14:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca
Cc: rob.herring@calxeda.com, dgdunix@gmail.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add device tree support to matrix keypad driver and usage details
are added to device tree documentation. Also modified the driver
according to recent update of matrix_keypad_build_keymap(), which
automatically allocate memory for keymap. Driver was tested on AM335x
EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
This patch was tested on AM335x-EVM and based on linux-next, cleanly
applies on top of "input/next"

Changes from v6:
	- Added missed DT binding document.

Changes from v5:
	- Updated based on Dmitry's patch.
	  * Modified the driver acc. to matrix_keypad_build_keymap()
	    recent update.
	  * Combined row_gpios & col_gpios devm_kzalloc's to single
	    devm_kzalloc.
	  * Added proper return values for different failures in
	    matrix_keypad_parse_dt().

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

 .../bindings/input/gpio-matrix-keypad.txt          |   46 ++++++++
 drivers/input/keyboard/matrix_keypad.c             |  119 ++++++++++++++++----
 2 files changed, 143 insertions(+), 22 deletions(-)
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
index 18b7237..05d3a96 100644
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
@@ -37,8 +40,6 @@ struct matrix_keypad {
 	bool scan_pending;
 	bool stopped;
 	bool gpio_all_disabled;
-
-	unsigned short keycodes[];
 };
 
 /*
@@ -118,6 +119,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 	struct matrix_keypad *keypad =
 		container_of(work, struct matrix_keypad, work.work);
 	struct input_dev *input_dev = keypad->input_dev;
+	const unsigned short *keycodes = input_dev->keycode;
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	uint32_t new_state[MATRIX_MAX_COLS];
 	int row, col, code;
@@ -153,7 +155,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev,
-					 keypad->keycodes[code],
+					 keycodes[code],
 					 new_state[col] & (1 << row));
 		}
 	}
@@ -394,33 +396,95 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		gpio_free(pdata->col_gpios[i]);
 }
 
+#ifdef CONFIG_OF
+static struct matrix_keypad_platform_data * __devinit
+matrix_keypad_parse_dt(struct device *dev)
+{
+	struct matrix_keypad_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	unsigned int *gpios;
+	int i;
+
+	if (!np) {
+		dev_err(dev, "device lacks DT data\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "could not allocate memory for platform data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->num_row_gpios = of_gpio_named_count(np, "row-gpios");
+	pdata->num_col_gpios = of_gpio_named_count(np, "col-gpios");
+	if (!pdata->num_row_gpios || !pdata->num_col_gpios) {
+		dev_err(dev, "number of keypad rows/columns not specified\n");
+		return ERR_PTR(-EINVAL);
+	}
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
+	gpios = devm_kzalloc(dev,
+			     sizeof(unsigned int) *
+				(pdata->num_row_gpios + pdata->num_col_gpios),
+			     GFP_KERNEL);
+	if (!gpios) {
+		dev_err(dev, "could not allocate memory for gpios\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++)
+		gpios[i] = of_get_named_gpio(np, "row-gpios", i);
+
+	for (i = 0; i < pdata->num_col_gpios; i++)
+		gpios[pdata->num_row_gpios + i] =
+			of_get_named_gpio(np, "col-gpios", i);
+
+	pdata->row_gpios = gpios;
+	pdata->col_gpios = &gpios[pdata->num_row_gpios];
+
+	return pdata;
+}
+#else
+static inline struct matrix_keypad_platform_data *
+matrix_keypad_parse_dt(struct device *dev)
+{
+	dev_err(dev, "no platform data defined\n");
+
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
 static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keypad_platform_data *pdata;
-	const struct matrix_keymap_data *keymap_data;
 	struct matrix_keypad *keypad;
 	struct input_dev *input_dev;
-	unsigned int row_shift;
-	size_t keymap_size;
 	int err;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
-
-	keymap_data = pdata->keymap_data;
-	if (!keymap_data) {
+		pdata = matrix_keypad_parse_dt(&pdev->dev);
+		if (IS_ERR(pdata)) {
+			dev_err(&pdev->dev, "no platform data defined\n");
+			return PTR_ERR(pdata);
+		}
+	} else if (!pdata->keymap_data) {
 		dev_err(&pdev->dev, "no keymap data defined\n");
 		return -EINVAL;
 	}
 
-	row_shift = get_count_order(pdata->num_col_gpios);
-	keymap_size = (pdata->num_row_gpios << row_shift) *
-			sizeof(keypad->keycodes[0]);
-	keypad = kzalloc(sizeof(struct matrix_keypad) + keymap_size,
-			 GFP_KERNEL);
+	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!keypad || !input_dev) {
 		err = -ENOMEM;
@@ -429,7 +493,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
-	keypad->row_shift = row_shift;
+	keypad->row_shift = get_count_order(pdata->num_col_gpios);
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
 	spin_lock_init(&keypad->lock);
@@ -440,12 +504,14 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	input_dev->open		= matrix_keypad_start;
 	input_dev->close	= matrix_keypad_stop;
 
-	err = matrix_keypad_build_keymap(keymap_data, NULL,
+	err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
 					 pdata->num_row_gpios,
 					 pdata->num_col_gpios,
-					 keypad->keycodes, input_dev);
-	if (err)
+					 NULL, input_dev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to build keymap\n");
 		goto err_free_mem;
+	}
 
 	if (!pdata->no_autorepeat)
 		__set_bit(EV_REP, input_dev->evbit);
@@ -488,6 +554,14 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id matrix_keypad_dt_match[] = {
+	{ .compatible = "gpio-matrix-keypad" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
+#endif
+
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
 	.remove		= __devexit_p(matrix_keypad_remove),
@@ -495,6 +569,7 @@ static struct platform_driver matrix_keypad_driver = {
 		.name	= "matrix-keypad",
 		.owner	= THIS_MODULE,
 		.pm	= &matrix_keypad_pm_ops,
+		.of_match_table = of_match_ptr(matrix_keypad_dt_match),
 	},
 };
 module_platform_driver(matrix_keypad_driver);
-- 
1.7.9.5

