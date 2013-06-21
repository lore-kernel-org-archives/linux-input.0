From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from matrix lines
Date: Fri, 21 Jun 2013 20:09:54 +0200
Message-ID: <1371838198-7327-9-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40318 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423568Ab3FUSK3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:29 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

- cleanly tell physical GPIO connections from logical matrix lines
- allow device tree specs to override matrix dimension (reduce
  the size when not all of the available intersections are used)

in the current implementation both aspects of key code mapping
and keypad matrix scanning are handled in separate components,
the logical layout of the matrix need not be identical to what
the physical attachment allows for or would suggest

device tree setups allow to share the hardware controller's GPIO
attachment description with M x N intersections, yet individual
boards may use m x n matrix layouts with m <= M and n <= N

the separation of the physical attachment from the logical
operation further allows for the future introduction of optional
encodings or mappings, and lifts the current limitation (removes
the coded assumption) that there is exactly one pin for each line

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |   16 +++++++
 drivers/input/keyboard/matrix_keypad.c             |   50 ++++++++++++++------
 include/linux/input/matrix_keypad.h                |    6 +++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index 196935b..f72d262 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -49,6 +49,14 @@ software, which makes signals float in the absence of pull up resistors.
 To fully drive output signals in either direction, enable push/pull mode
 for column pins.  This option is off by default for compatibility.
 
+The driver assumes that all interconnections of the matrix can potentially
+contain a button, and will submit scan and key code events to the input
+subsystem.  By default the keypad matrix dimenstions are automatically
+derived from the GPIO pin specifications.  Optionally device tree
+information can override the keypad matrix dimension data, e.g. when not
+all of the potentially available physical connections are used to create
+the logical keypad matrix.
+
 Required Properties:
 - compatible:		Should be "gpio-matrix-keypad"
 - row-gpios:		List of gpios used as row lines. The gpio specifier
@@ -88,6 +96,14 @@ Optional Properties:
 			behaviour is to actively drive low signals and
 			be passive otherwise (emulates an open collector
 			output driver)
+- keypad,num-rows:	number of rows in the keypad matrix, overrides the
+			value which gets derived from the number of row
+			GPIO pins, useful when not all lines are in use for
+			interconnects
+- keypad,num-columns:	number of columns in the keypad matrix, overrides
+			the value which gets derived from the number of
+			column GPIO pins, useful when not all lines are in
+			use for interconnects
 
 Example:
 	matrix-keypad {
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index c2221d1..30b7faf 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -111,7 +111,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 {
 	int col;
 
-	for (col = 0; col < pdata->num_col_gpios; col++)
+	for (col = 0; col < pdata->num_matrix_cols; col++)
 		__activate_col_pin(pdata, col, on);
 }
 
@@ -142,7 +142,7 @@ static uint32_t sample_rows_for_col(struct matrix_keypad *keypad, int col)
 
 	activate_col(pdata, col, true);
 	row_state = 0;
-	for (row = 0; row < pdata->num_row_gpios; row++)
+	for (row = 0; row < pdata->num_matrix_rows; row++)
 		row_state |= row_asserted(pdata, row) ? (1 << row) : 0;
 	activate_col(pdata, col, false);
 
@@ -220,19 +220,19 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	/* assert each column in turn and read back the row status */
 	memset(new_state, 0, sizeof(new_state));
-	for (col = 0; col < pdata->num_col_gpios; col++)
+	for (col = 0; col < pdata->num_matrix_cols; col++)
 		new_state[col] = sample_rows_for_col(keypad, col);
 
 	/* detect changes and derive input events, update the snapshot */
 	has_events = 0;
-	for (col = 0; col < pdata->num_col_gpios; col++) {
+	for (col = 0; col < pdata->num_matrix_cols; col++) {
 		uint32_t bits_changed;
 
 		bits_changed = keypad->last_key_state[col] ^ new_state[col];
 		if (bits_changed == 0)
 			continue;
 
-		for (row = 0; row < pdata->num_row_gpios; row++) {
+		for (row = 0; row < pdata->num_matrix_rows; row++) {
 			if ((bits_changed & (1 << row)) == 0)
 				continue;
 
@@ -329,7 +329,7 @@ static void matrix_keypad_switch(struct work_struct *work)
 	 * compile time constants)
 	 */
 	keypad->col_to_poll++;
-	if (keypad->col_to_poll >= pdata->num_col_gpios)
+	if (keypad->col_to_poll >= pdata->num_matrix_cols)
 		keypad->col_to_poll = 0;
 	col = keypad->col_to_poll;
 
@@ -580,7 +580,8 @@ matrix_keypad_parse_dt(struct device *dev)
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	unsigned int *gpios;
-	int i, nrow, ncol;
+	int i;
+	int err;
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data for the keypad config\n");
@@ -594,12 +595,18 @@ matrix_keypad_parse_dt(struct device *dev)
 	}
 
 	/* get the pin count for rows and columns */
-	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
-	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
-	if (nrow <= 0 || ncol <= 0) {
-		dev_err(dev, "number of keypad rows/columns not specified\n");
+	i = of_gpio_named_count(np, "row-gpios");
+	if (i <= 0) {
+		dev_err(dev, "row GPIO pin specs for keypad missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pdata->num_row_gpios = i;
+	i = of_gpio_named_count(np, "col-gpios");
+	if (i <= 0) {
+		dev_err(dev, "column GPIO pin specs for keypad missing\n");
 		return ERR_PTR(-EINVAL);
 	}
+	pdata->num_col_gpios = i;
 
 	/* get input, power, and GPIO pin properties */
 	if (of_get_property(np, "linux,no-autorepeat", NULL))
@@ -644,6 +651,19 @@ matrix_keypad_parse_dt(struct device *dev)
 	pdata->row_gpios = gpios;
 	pdata->col_gpios = &gpios[pdata->num_row_gpios];
 
+	/*
+	 * auto determine the number of keypad matrix rows and columns
+	 * from the number of GPIO pins, optionally allow device tree
+	 * information to override these values
+	 */
+	pdata->num_matrix_rows = pdata->num_row_gpios;
+	pdata->num_matrix_cols = pdata->num_col_gpios;
+	err = matrix_keypad_parse_of_params(dev,
+					    &pdata->num_matrix_rows,
+					    &pdata->num_matrix_cols);
+	if (err)
+		return ERR_PTR(err);
+
 	return pdata;
 }
 #else
@@ -684,13 +704,13 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
-	keypad->row_shift = get_count_order(pdata->num_col_gpios);
+	keypad->row_shift = get_count_order(pdata->num_matrix_cols);
 
 	/* start in stopped state, open(2) will activate the scan */
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work_scan_matrix, matrix_keypad_scan);
 	INIT_DELAYED_WORK(&keypad->work_switch_column, matrix_keypad_switch);
-	keypad->col_to_poll = pdata->num_col_gpios;
+	keypad->col_to_poll = pdata->num_matrix_cols;
 	spin_lock_init(&keypad->lock);
 
 	input_dev->name		= pdev->name;
@@ -700,8 +720,8 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	input_dev->close	= matrix_keypad_stop;
 
 	err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
-					 pdata->num_row_gpios,
-					 pdata->num_col_gpios,
+					 pdata->num_matrix_rows,
+					 pdata->num_matrix_cols,
 					 NULL, input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 3c8dc39..1398d23 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -39,6 +39,8 @@ struct matrix_keymap_data {
  * @col_gpios: pointer to array of gpio numbers reporesenting colums
  * @num_row_gpios: actual number of row gpios used by device
  * @num_col_gpios: actual number of col gpios used by device
+ * @num_matrix_rows: number of logical row lines in the matrix
+ * @num_matrix_cols: number of logical column lines in the matrix
  * @col_scan_delay_us: delay in microseconds, the interval between
  *	activating a column and reading back row information
  * @col_switch_delay_ms: delay in milliseconds, the interval with which
@@ -70,6 +72,10 @@ struct matrix_keypad_platform_data {
 	unsigned int	num_row_gpios;
 	unsigned int	num_col_gpios;
 
+	/* the logical matrix row/column lines */
+	unsigned int	num_matrix_rows;
+	unsigned int	num_matrix_cols;
+
 	/* delays and intervals specs */
 	unsigned int	col_scan_delay_us;
 	unsigned int	col_switch_delay_ms;
-- 
1.7.10.4

