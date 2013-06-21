From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 05/12] input: matrix-keypad: update comments, diagnostics
Date: Fri, 21 Jun 2013 20:09:51 +0200
Message-ID: <1371838198-7327-6-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:55745 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423562Ab3FUSK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:27 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

- add comments about individual routines' purpose and their interaction,
  pre-conditions and consequences
- mark a few spots which may need some more attention or clarification
- rephrase some diagnostics messages

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/input/keyboard/matrix_keypad.c |   81 +++++++++++++++++++++++++++++---
 drivers/input/matrix-keymap.c          |    4 +-
 include/linux/input/matrix_keypad.h    |   17 ++++---
 3 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 4f22149..85e16a2 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -43,6 +43,10 @@ struct matrix_keypad {
 };
 
 /*
+ * this routine controls a physical column pin which the keypad matrix
+ * is connected to, and takes care of the pin's polarity as well as its
+ * mode of operation (fully driven push/pull, or emulated open drain)
+ *
  * former comment before introduction of optional push/pull behaviour:
  * <cite>
  * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
@@ -77,6 +81,14 @@ static void __activate_col_pin(const struct matrix_keypad_platform_data *pdata,
 	}
 }
 
+/*
+ * this routine addresses logical columns of the keypad matrix, and
+ * makes sure that the "scan delay" is applied upon activation of the
+ * column (the delay between activating the column and reading rows)
+ *
+ * the caller ensures that this routine need not de-activate other
+ * columns when dealing with the column specified for the invocation
+ */
 static void activate_col(const struct matrix_keypad_platform_data *pdata,
 			 int col, bool on)
 {
@@ -86,6 +98,12 @@ static void activate_col(const struct matrix_keypad_platform_data *pdata,
 		udelay(pdata->col_scan_delay_us);
 }
 
+/*
+ * this routine either de-activates all columns before scanning the
+ * matrix, or re-activates all columns at the same time after the scan
+ * is complete, to make changes in the key press state trigger the
+ * condition to re-scan the matrix
+ */
 static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 			      bool on)
 {
@@ -95,6 +113,10 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 		__activate_col_pin(pdata, col, on);
 }
 
+/*
+ * this routine checks a single row while a specific column is active,
+ * it takes care of the pin's polarity, the pin level had time to settle
+ */
 static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			 int row)
 {
@@ -103,6 +125,12 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			pdata->row_gpios_active_low;
 }
 
+/*
+ * this routine enables IRQs after a keypad matrix scan has completed,
+ * to have any subsequent change in the key press status trigger the ISR
+ *
+ * a single IRQ line can be used if all involved GPIOs share that IRQ
+ */
 static void enable_row_irqs(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
@@ -116,6 +144,13 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 	}
 }
 
+/*
+ * this routine disables IRQs for changes in the key press status, which
+ * applies to shutdown or suspend modes, to periods where the keypad
+ * matrix is not used (not opened by any application), as well as to the
+ * interval between the first detected change and scanning the complete
+ * matrix (the debounce interval)
+ */
 static void disable_row_irqs(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
@@ -130,7 +165,9 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 }
 
 /*
- * This gets the keys from keyboard and reports it to input subsystem
+ * this routine scans the keypad matrix and detects changes in the keys'
+ * status against a previously sampled status, from which events for the
+ * input subsystem get derived
  */
 static void matrix_keypad_scan(struct work_struct *work)
 {
@@ -142,12 +179,12 @@ static void matrix_keypad_scan(struct work_struct *work)
 	uint32_t new_state[MATRIX_MAX_COLS];
 	int row, col, code;
 
-	/* de-activate all columns for scanning */
+	/* de-activate all columns before scanning the matrix */
 	activate_all_cols(pdata, false);
 
 	memset(new_state, 0, sizeof(new_state));
 
-	/* assert each column and read the row status out */
+	/* assert each column in turn and read back the row status */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 
 		activate_col(pdata, col, true);
@@ -159,6 +196,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 		activate_col(pdata, col, false);
 	}
 
+	/* detect changes and derive input events, update the snapshot */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 		uint32_t bits_changed;
 
@@ -171,6 +209,15 @@ static void matrix_keypad_scan(struct work_struct *work)
 				continue;
 
 			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+			/*
+			 * TODO: the key code matrix may be sparse,
+			 * ignore items in gaps or report changes in all
+			 * positions?  this consideration may especially
+			 * apply where the key code matrix gets setup or
+			 * manipulated from user space, or where the key
+			 * code matrix gets switched (shift or function
+			 * keys, alternate keyboard modes)
+			 */
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev,
 					 keycodes[code],
@@ -178,9 +225,13 @@ static void matrix_keypad_scan(struct work_struct *work)
 		}
 	}
 	input_sync(input_dev);
-
 	memcpy(keypad->last_key_state, new_state, sizeof(new_state));
 
+	/*
+	 * re-enable all columns after the scan has completed, to have
+	 * changes in their key press status issue interrupts and
+	 * trigger another complete scan of the matrix
+	 */
 	activate_all_cols(pdata, true);
 
 	/* Enable IRQs again */
@@ -190,6 +241,14 @@ static void matrix_keypad_scan(struct work_struct *work)
 	spin_unlock_irq(&keypad->lock);
 }
 
+/*
+ * interrupt service routine, invoked upon the first detected change in
+ * the key press status, initiating a debounce delay, and suppressing
+ * subsequent interrupts until scanning all of the matrix has completed
+ *
+ * copes with interrupts which arrive during the debounce interval or
+ * the actual matrix scan or a shutdown or suspend sequence
+ */
 static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
 {
 	struct matrix_keypad *keypad = id;
@@ -310,6 +369,10 @@ static int matrix_keypad_resume(struct device *dev)
 	if (device_may_wakeup(&pdev->dev))
 		matrix_keypad_disable_wakeup(keypad);
 
+	/*
+	 * TODO: consider whether to only (re-)start the keypad matrix
+	 * driver when it was opened by applications?
+	 */
 	matrix_keypad_start(keypad->input_dev);
 
 	return 0;
@@ -425,7 +488,7 @@ matrix_keypad_parse_dt(struct device *dev)
 	int i, nrow, ncol;
 
 	if (!np) {
-		dev_err(dev, "device lacks DT data\n");
+		dev_err(dev, "device lacks DT data for the keypad config\n");
 		return ERR_PTR(-ENODEV);
 	}
 
@@ -435,6 +498,7 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/* get the pin count for rows and columns */
 	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
 	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
 	if (nrow <= 0 || ncol <= 0) {
@@ -442,6 +506,7 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* get input, power, and GPIO pin properties */
 	if (of_get_property(np, "linux,no-autorepeat", NULL))
 		pdata->no_autorepeat = true;
 	if (of_get_property(np, "linux,wakeup", NULL))
@@ -457,10 +522,12 @@ matrix_keypad_parse_dt(struct device *dev)
 	if (of_get_property(np, "col-gpios-pushpull", NULL))
 		pdata->col_gpios_push_pull = true;
 
+	/* get delay and interval timing specs */
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
 						&pdata->col_scan_delay_us);
 
+	/* get the individual row and column GPIO pins */
 	gpios = devm_kzalloc(dev,
 			     sizeof(unsigned int) *
 				(pdata->num_row_gpios + pdata->num_col_gpios),
@@ -486,7 +553,7 @@ matrix_keypad_parse_dt(struct device *dev)
 static inline struct matrix_keypad_platform_data *
 matrix_keypad_parse_dt(struct device *dev)
 {
-	dev_err(dev, "no platform data defined\n");
+	dev_err(dev, "device lacks DT support for the keypad config\n");
 
 	return ERR_PTR(-EINVAL);
 }
@@ -521,6 +588,8 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
 	keypad->row_shift = get_count_order(pdata->num_col_gpios);
+
+	/* start in stopped state, open(2) will activate the scan */
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work_scan_matrix, matrix_keypad_scan);
 	spin_lock_init(&keypad->lock);
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index b7091f2..c427bf9 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -103,7 +103,9 @@ static int matrix_keypad_parse_of_keymap(const char *propname,
 
 	size = proplen / sizeof(u32);
 	if (size > max_keys) {
-		dev_err(dev, "OF: %s size overflow\n", propname);
+		dev_err(dev,
+			"OF: %s size overflow, keymap size %u, max keys %u\n",
+			propname, size, max_keys);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 5496a00..4bbe6b3 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -39,9 +39,11 @@ struct matrix_keymap_data {
  * @col_gpios: pointer to array of gpio numbers reporesenting colums
  * @num_row_gpios: actual number of row gpios used by device
  * @num_col_gpios: actual number of col gpios used by device
- * @col_scan_delay_us: delay, measured in microseconds, that is
- *	needed before we can keypad after activating column gpio
- * @debounce_ms: debounce interval in milliseconds
+ * @col_scan_delay_us: delay in microseconds, the interval between
+ *	activating a column and reading back row information
+ * @debounce_ms: debounce interval in milliseconds, the interval between
+ *	detecting a change in the key press status and determining the new
+ *	overall keypad matrix status
  * @clustered_irq: may be specified if interrupts of all row/column GPIOs
  *	are bundled to one single irq
  * @clustered_irq_flags: flags that are needed for the clustered irq
@@ -53,26 +55,29 @@ struct matrix_keymap_data {
  *	source
  * @no_autorepeat: disable key autorepeat
  *
- * This structure represents platform-specific data that use used by
+ * This structure represents platform-specific data that is used by
  * matrix_keypad driver to perform proper initialization.
  */
 struct matrix_keypad_platform_data {
+	/* map keys to codes */
 	const struct matrix_keymap_data *keymap_data;
 
+	/* the physical GPIO pin connections */
 	const unsigned int *row_gpios;
 	const unsigned int *col_gpios;
-
 	unsigned int	num_row_gpios;
 	unsigned int	num_col_gpios;
 
+	/* delays and intervals specs */
 	unsigned int	col_scan_delay_us;
 
-	/* key debounce interval in milli-second */
 	unsigned int	debounce_ms;
 
+	/* optionally reduce interrupt mgmt overhead */
 	unsigned int	clustered_irq;
 	unsigned int	clustered_irq_flags;
 
+	/* pin and input system properties */
 	bool		row_gpios_active_low;
 	bool		col_gpios_active_low;
 	bool		col_gpios_push_pull;
-- 
1.7.10.4

