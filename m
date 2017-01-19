From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] Input: matrix-keypad - switch to using generic device
 properties
Date: Thu, 19 Jan 2017 14:48:02 -0800
Message-ID: <20170119224803.10713-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-input@vger.kernel.org

Instead of being OF-specific, let's switch to using generic device
properties, which will make this code usable on ACPI, device tree and
legacy boards that use property sets.

As part of the change let's rename matrix_keypad_parse_of_params() to
matrix_keypad_parse_properties().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/bcm-keypad.c      |   2 +-
 drivers/input/keyboard/cros_ec_keyb.c    |   3 +-
 drivers/input/keyboard/lpc32xx-keys.c    |   2 +-
 drivers/input/keyboard/omap4-keypad.c    |   4 +-
 drivers/input/keyboard/pmic8xxx-keypad.c |   2 +-
 drivers/input/keyboard/pxa27x_keypad.c   |   2 +-
 drivers/input/keyboard/st-keyscan.c      |   4 +-
 drivers/input/keyboard/stmpe-keypad.c    |   2 +-
 drivers/input/keyboard/tca8418_keypad.c  |   2 +-
 drivers/input/keyboard/twl4030_keypad.c  |   4 +-
 drivers/input/matrix-keymap.c            | 109 ++++++++++++++++---------------
 include/linux/input/matrix_keypad.h      |  21 +-----
 12 files changed, 72 insertions(+), 85 deletions(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 2b4e63d81e6d..e1cf63ee148f 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -213,7 +213,7 @@ static int bcm_kp_matrix_key_parse_dt(struct bcm_kp *kp)
 	/* Initialize the KPCR Keypad Configuration Register */
 	kp->kpcr = KPCR_STATUSFILTERENABLE | KPCR_COLFILTERENABLE;
 
-	error = matrix_keypad_parse_of_params(dev, &kp->n_rows, &kp->n_cols);
+	error = matrix_keypad_parse_properties(dev, &kp->n_rows, &kp->n_cols);
 	if (error) {
 		dev_err(dev, "failed to parse kp params\n");
 		return error;
diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 87d071ae21da..780977dcf92d 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -229,7 +229,8 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	ckdev = devm_kzalloc(dev, sizeof(*ckdev), GFP_KERNEL);
 	if (!ckdev)
 		return -ENOMEM;
-	err = matrix_keypad_parse_of_params(dev, &ckdev->rows, &ckdev->cols);
+
+	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
 		return err;
 
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 632523d4f5dc..1dd57ac0e7a2 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -145,7 +145,7 @@ static int lpc32xx_parse_dt(struct device *dev,
 	u32 rows = 0, columns = 0;
 	int err;
 
-	err = matrix_keypad_parse_of_params(dev, &rows, &columns);
+	err = matrix_keypad_parse_properties(dev, &rows, &columns);
 	if (err)
 		return err;
 	if (rows != columns) {
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 6639b2b8528a..9f87796169e3 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -223,8 +223,8 @@ static int omap4_keypad_parse_dt(struct device *dev,
 	struct device_node *np = dev->of_node;
 	int err;
 
-	err = matrix_keypad_parse_of_params(dev, &keypad_data->rows,
-					    &keypad_data->cols);
+	err = matrix_keypad_parse_properties(dev, &keypad_data->rows,
+					     &keypad_data->cols);
 	if (err)
 		return err;
 
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 5c68e3f096bc..97c5424f49b9 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -515,7 +515,7 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 	int rc;
 	unsigned int ctrl_val;
 
-	rc = matrix_keypad_parse_of_params(&pdev->dev, &rows, &cols);
+	rc = matrix_keypad_parse_properties(&pdev->dev, &rows, &cols);
 	if (rc)
 		return rc;
 
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index e24443376e75..3841fa30db33 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -126,7 +126,7 @@ static int pxa27x_keypad_matrix_key_parse_dt(struct pxa27x_keypad *keypad,
 	u32 rows, cols;
 	int error;
 
-	error = matrix_keypad_parse_of_params(dev, &rows, &cols);
+	error = matrix_keypad_parse_properties(dev, &rows, &cols);
 	if (error)
 		return error;
 
diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index de7be4f03d91..babcfb165e4f 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -106,8 +106,8 @@ static int keypad_matrix_key_parse_dt(struct st_keyscan *keypad_data)
 	struct device_node *np = dev->of_node;
 	int error;
 
-	error = matrix_keypad_parse_of_params(dev, &keypad_data->n_rows,
-					      &keypad_data->n_cols);
+	error = matrix_keypad_parse_properties(dev, &keypad_data->n_rows,
+					       &keypad_data->n_cols);
 	if (error) {
 		dev_err(dev, "failed to parse keypad params\n");
 		return error;
diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index fe6e3f22eed7..8c6c0b9109c7 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -354,7 +354,7 @@ static int stmpe_keypad_probe(struct platform_device *pdev)
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &pdev->dev;
 
-	error = matrix_keypad_parse_of_params(&pdev->dev, &rows, &cols);
+	error = matrix_keypad_parse_properties(&pdev->dev, &rows, &cols);
 	if (error)
 		return error;
 
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 11d5c76d9fb4..7e49b14c8b02 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -295,7 +295,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		struct device_node *np = dev->of_node;
 		int err;
 
-		err = matrix_keypad_parse_of_params(dev, &rows, &cols);
+		err = matrix_keypad_parse_properties(dev, &rows, &cols);
 		if (err)
 			return err;
 		rep = of_property_read_bool(np, "keypad,autorepeat");
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 29396ca69416..39e72b3219d8 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -374,8 +374,8 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 		kp->autorepeat = pdata->rep;
 		keymap_data = pdata->keymap_data;
 	} else {
-		error = matrix_keypad_parse_of_params(&pdev->dev, &kp->n_rows,
-						      &kp->n_cols);
+		error = matrix_keypad_parse_properties(&pdev->dev, &kp->n_rows,
+						       &kp->n_cols);
 		if (error)
 			return error;
 
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 08b61f506db6..8ccefc15c7a4 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -14,18 +14,18 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
  */
 
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/input.h>
-#include <linux/of.h>
-#include <linux/export.h>
-#include <linux/module.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 
 static bool matrix_keypad_map_key(struct input_dev *input_dev,
 				  unsigned int rows, unsigned int cols,
@@ -49,18 +49,22 @@ static bool matrix_keypad_map_key(struct input_dev *input_dev,
 	return true;
 }
 
-#ifdef CONFIG_OF
-int matrix_keypad_parse_of_params(struct device *dev,
-				  unsigned int *rows, unsigned int *cols)
+/**
+ * matrix_keypad_parse_properties() - Read properties of matrix keypad
+ *
+ * @dev: Device containing properties
+ * @rows: Returns number of matrix rows
+ * @cols: Returns number of matrix columns
+ * @return 0 if OK, <0 on error
+ */
+int matrix_keypad_parse_properties(struct device *dev,
+				   unsigned int *rows, unsigned int *cols)
 {
-	struct device_node *np = dev->of_node;
+	*rows = *cols = 0;
+
+	device_property_read_u32(dev, "keypad,num-rows", rows);
+	device_property_read_u32(dev, "keypad,num-columns", cols);
 
-	if (!np) {
-		dev_err(dev, "missing DT data");
-		return -EINVAL;
-	}
-	of_property_read_u32(np, "keypad,num-rows", rows);
-	of_property_read_u32(np, "keypad,num-columns", cols);
 	if (!*rows || !*cols) {
 		dev_err(dev, "number of keypad rows/columns not specified\n");
 		return -EINVAL;
@@ -68,62 +72,61 @@ int matrix_keypad_parse_of_params(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(matrix_keypad_parse_of_params);
+EXPORT_SYMBOL_GPL(matrix_keypad_parse_properties);
 
-static int matrix_keypad_parse_of_keymap(const char *propname,
-					 unsigned int rows, unsigned int cols,
-					 struct input_dev *input_dev)
+static int matrix_keypad_parse_keymap(const char *propname,
+				      unsigned int rows, unsigned int cols,
+				      struct input_dev *input_dev)
 {
 	struct device *dev = input_dev->dev.parent;
-	struct device_node *np = dev->of_node;
 	unsigned int row_shift = get_count_order(cols);
 	unsigned int max_keys = rows << row_shift;
-	unsigned int proplen, i, size;
-	const __be32 *prop;
-
-	if (!np)
-		return -ENOENT;
+	u32 *keys;
+	int i;
+	int size;
+	int retval;
 
 	if (!propname)
 		propname = "linux,keymap";
 
-	prop = of_get_property(np, propname, &proplen);
-	if (!prop) {
-		dev_err(dev, "OF: %s property not defined in %s\n",
-			propname, np->full_name);
-		return -ENOENT;
+	size = device_property_read_u32_array(dev, propname, NULL, 0);
+	if (size <= 0) {
+		dev_err(dev, "missing or malformed property %s: %d\n",
+			propname, size);
+		return size < 0 ? size : -EINVAL;
 	}
 
-	if (proplen % sizeof(u32)) {
-		dev_err(dev, "OF: Malformed keycode property %s in %s\n",
-			propname, np->full_name);
+	if (size > max_keys) {
+		dev_err(dev, "%s size overflow (%d vs max %u)\n",
+			propname, size, max_keys);
 		return -EINVAL;
 	}
 
-	size = proplen / sizeof(u32);
-	if (size > max_keys) {
-		dev_err(dev, "OF: %s size overflow\n", propname);
-		return -EINVAL;
+	keys = kmalloc_array(size, sizeof(u32), GFP_KERNEL);
+	if (!keys)
+		return -ENOMEM;
+
+	retval = device_property_read_u32_array(dev, propname, keys, size);
+	if (retval) {
+		dev_err(dev, "failed to read %s property: %d\n",
+			propname, retval);
+		goto out;
 	}
 
 	for (i = 0; i < size; i++) {
-		unsigned int key = be32_to_cpup(prop + i);
-
 		if (!matrix_keypad_map_key(input_dev, rows, cols,
-					   row_shift, key))
-			return -EINVAL;
+					   row_shift, keys[i])) {
+			retval = -EINVAL;
+			goto out;
+		}
 	}
 
-	return 0;
-}
-#else
-static int matrix_keypad_parse_of_keymap(const char *propname,
-					 unsigned int rows, unsigned int cols,
-					 struct input_dev *input_dev)
-{
-	return -ENOSYS;
+	retval = 0;
+
+out:
+	kfree(keys);
+	return retval;
 }
-#endif
 
 /**
  * matrix_keypad_build_keymap - convert platform keymap into matrix keymap
@@ -192,8 +195,8 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 				return -EINVAL;
 		}
 	} else {
-		error = matrix_keypad_parse_of_keymap(keymap_name, rows, cols,
-						      input_dev);
+		error = matrix_keypad_parse_keymap(keymap_name, rows, cols,
+						   input_dev);
 		if (error)
 			return error;
 	}
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 27e06acc509a..d855cb0d92aa 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -80,24 +80,7 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 			       unsigned int rows, unsigned int cols,
 			       unsigned short *keymap,
 			       struct input_dev *input_dev);
-
-#ifdef CONFIG_OF
-/**
- * matrix_keypad_parse_of_params() - Read parameters from matrix-keypad node
- *
- * @dev: Device containing of_node
- * @rows: Returns number of matrix rows
- * @cols: Returns number of matrix columns
- * @return 0 if OK, <0 on error
- */
-int matrix_keypad_parse_of_params(struct device *dev,
-				  unsigned int *rows, unsigned int *cols);
-#else
-static inline int matrix_keypad_parse_of_params(struct device *dev,
-				  unsigned int *rows, unsigned int *cols)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF */
+int matrix_keypad_parse_properties(struct device *dev,
+				   unsigned int *rows, unsigned int *cols);
 
 #endif /* _MATRIX_KEYPAD_H */
-- 
2.11.0.483.g087da7b7c-goog
