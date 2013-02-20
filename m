From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2] Input: matrix-keypad - support binary column select gpios
Date: Wed, 20 Feb 2013 20:27:55 +0100
Message-ID: <1361388475-23705-1-git-send-email-agust@denx.de>
References: <1359462324-7233-1-git-send-email-agust@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36879 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934345Ab3BTT2L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 14:28:11 -0500
In-Reply-To: <1359462324-7233-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

On hardware with limited gpios one column select gpio can select
two different rows when using some additional hardware logic:
high value selects one row, low value selects another row. Add
support for such matrix keyboards and document device tree
bindings used to describe them.

Since half of the columns is always not selected, interrupts won't be
generated for press events on these columns. To generate interrupts
for not selected columns we need to periodicaly switch to these columns
in order to catch the potential press events. This is done by additional
work function.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - do not use inline attribute for matrix_keyboard_row_events(),
   it causes reporting wrong events for some keys if the kernel
   was built using gcc 4.7.2.

 .../bindings/input/gpio-matrix-keypad.txt          |    7 ++
 drivers/input/keyboard/matrix_keypad.c             |  112 ++++++++++++++++----
 include/linux/input/matrix_keypad.h                |    6 +
 3 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index ead641c..57f4be3 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -23,6 +23,13 @@ Optional Properties:
 - debounce-delay-ms:	debounce interval in milliseconds
 - col-scan-delay-us:	delay, measured in microseconds, that is needed
 			before we can scan keypad after activating column gpio
+- col-gpios-binary:	specify that high and low states of a column gpio
+			select two different rows (boards with limited gpios
+			could support this by additional hardware logic)
+- col-switch-delay-ms:	column gpio switch interval for selecting alternative
+			rows when using 'col-gpios-binary'. This is needed for
+			periodical selecting of the alternative rows to be able
+			to generate keypad interrupts for them
 
 Example:
 	matrix-keypad {
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index f4ff0dd..80ddd4c 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -36,10 +36,12 @@ struct matrix_keypad {
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work;
+	struct delayed_work select_cols;
 	spinlock_t lock;
 	bool scan_pending;
 	bool stopped;
 	bool gpio_all_disabled;
+	bool last_col_val;
 };
 
 /*
@@ -56,7 +58,8 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 		gpio_direction_output(pdata->col_gpios[col], level_on);
 	} else {
 		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
-		gpio_direction_input(pdata->col_gpios[col]);
+		if (!pdata->col_gpios_binary)
+			gpio_direction_input(pdata->col_gpios[col]);
 	}
 }
 
@@ -111,6 +114,24 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 	}
 }
 
+static void matrix_keyboard_row_events(struct matrix_keypad *keypad,
+		int col, uint32_t row_bits_changed, uint32_t new_state)
+{
+	struct input_dev *input_dev = keypad->input_dev;
+	const unsigned short *keycodes = input_dev->keycode;
+	int code, row;
+
+	for (row = 0; row < keypad->pdata->num_row_gpios; row++) {
+		if ((row_bits_changed & (1 << row)) == 0)
+			continue;
+
+		code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
+		input_event(input_dev, EV_MSC, MSC_SCAN, code);
+		input_report_key(input_dev, keycodes[code],
+				 new_state & (1 << row));
+	}
+}
+
 /*
  * This gets the keys from keyboard and reports it to input subsystem
  */
@@ -119,10 +140,9 @@ static void matrix_keypad_scan(struct work_struct *work)
 	struct matrix_keypad *keypad =
 		container_of(work, struct matrix_keypad, work.work);
 	struct input_dev *input_dev = keypad->input_dev;
-	const unsigned short *keycodes = input_dev->keycode;
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	uint32_t new_state[MATRIX_MAX_COLS];
-	int row, col, code;
+	int row, col, col_idx;
 
 	/* de-activate all columns for scanning */
 	activate_all_cols(pdata, false);
@@ -133,30 +153,47 @@ static void matrix_keypad_scan(struct work_struct *work)
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 
 		activate_col(pdata, col, true);
+		col_idx = col;
+		if (pdata->col_gpios_binary)
+			col_idx <<= 1;
 
 		for (row = 0; row < pdata->num_row_gpios; row++)
-			new_state[col] |=
+			new_state[col_idx] |=
 				row_asserted(pdata, row) ? (1 << row) : 0;
 
 		activate_col(pdata, col, false);
+
+		/*
+		 * if a column gpio selects two columns, read out the
+		 * row status for another column (we switched to the
+		 * other column by previous statement).
+		 */
+		if (pdata->col_gpios_binary) {
+			for (row = 0; row < pdata->num_row_gpios; row++)
+				new_state[col_idx + 1] |=
+				row_asserted(pdata, row) ? (1 << row) : 0;
+		}
 	}
 
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 		uint32_t bits_changed;
 
-		bits_changed = keypad->last_key_state[col] ^ new_state[col];
-		if (bits_changed == 0)
-			continue;
-
-		for (row = 0; row < pdata->num_row_gpios; row++) {
-			if ((bits_changed & (1 << row)) == 0)
-				continue;
-
-			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
-			input_event(input_dev, EV_MSC, MSC_SCAN, code);
-			input_report_key(input_dev,
-					 keycodes[code],
-					 new_state[col] & (1 << row));
+		col_idx = col;
+		if (pdata->col_gpios_binary)
+			col_idx <<= 1;
+
+		bits_changed = keypad->last_key_state[col_idx] ^
+				new_state[col_idx];
+		if (bits_changed)
+			matrix_keyboard_row_events(keypad, col, bits_changed,
+							new_state[col_idx]);
+
+		if (pdata->col_gpios_binary) {
+			bits_changed = keypad->last_key_state[col_idx + 1] ^
+					new_state[col_idx + 1];
+			if (bits_changed)
+				matrix_keyboard_row_events(keypad, col + 1,
+					bits_changed, new_state[col_idx + 1]);
 		}
 	}
 	input_sync(input_dev);
@@ -172,6 +209,21 @@ static void matrix_keypad_scan(struct work_struct *work)
 	spin_unlock_irq(&keypad->lock);
 }
 
+static void select_cols_work(struct work_struct *work)
+{
+	struct matrix_keypad *keypad =
+		container_of(work, struct matrix_keypad, select_cols.work);
+
+	if (keypad->stopped)
+		return;
+
+	keypad->last_col_val = !keypad->last_col_val;
+	activate_all_cols(keypad->pdata, keypad->last_col_val);
+
+	schedule_delayed_work(&keypad->select_cols,
+	      msecs_to_jiffies(keypad->pdata->col_switch_delay_ms));
+}
+
 static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
 {
 	struct matrix_keypad *keypad = id;
@@ -210,6 +262,10 @@ static int matrix_keypad_start(struct input_dev *dev)
 	 */
 	schedule_delayed_work(&keypad->work, 0);
 
+	if (keypad->pdata->col_gpios_binary)
+		schedule_delayed_work(&keypad->select_cols,
+		      msecs_to_jiffies(keypad->pdata->col_switch_delay_ms));
+
 	return 0;
 }
 
@@ -225,6 +281,9 @@ static void matrix_keypad_stop(struct input_dev *dev)
 	 * we should disable them now.
 	 */
 	disable_row_irqs(keypad);
+
+	if (keypad->pdata->col_gpios_binary)
+		cancel_delayed_work_sync(&keypad->select_cols);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -429,11 +488,20 @@ matrix_keypad_parse_dt(struct device *dev)
 		pdata->wakeup = true;
 	if (of_get_property(np, "gpio-activelow", NULL))
 		pdata->active_low = true;
+	if (of_get_property(np, "col-gpios-binary", NULL))
+		pdata->col_gpios_binary = true;
 
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
 						&pdata->col_scan_delay_us);
 
+	if (pdata->col_gpios_binary) {
+		of_property_read_u32(np, "col-switch-delay-ms",
+					&pdata->col_switch_delay_ms);
+		if (!pdata->col_switch_delay_ms)
+			pdata->col_switch_delay_ms = 100;
+	}
+
 	gpios = devm_kzalloc(dev,
 			     sizeof(unsigned int) *
 				(pdata->num_row_gpios + pdata->num_col_gpios),
@@ -470,6 +538,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	const struct matrix_keypad_platform_data *pdata;
 	struct matrix_keypad *keypad;
 	struct input_dev *input_dev;
+	int num_cols;
 	int err;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -491,11 +560,16 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	num_cols = pdata->num_col_gpios;
+	if (pdata->col_gpios_binary)
+		num_cols *= 2;
+
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
-	keypad->row_shift = get_count_order(pdata->num_col_gpios);
+	keypad->row_shift = get_count_order(num_cols);
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+	INIT_DELAYED_WORK(&keypad->select_cols, select_cols_work);
 	spin_lock_init(&keypad->lock);
 
 	input_dev->name		= pdev->name;
@@ -506,7 +580,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
 					 pdata->num_row_gpios,
-					 pdata->num_col_gpios,
+					 num_cols,
 					 NULL, input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 5f3aa6b..ad4707a 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -49,6 +49,10 @@ struct matrix_keymap_data {
  * @wakeup: controls whether the device should be set up as wakeup
  *	source
  * @no_autorepeat: disable key autorepeat
+ * @col_gpios_binary: indicate that one column gpio selects two rows,
+ *	i.e. high selects one row, low selects another row
+ * @col_switch_delay_ms: switching interval for periodical selecting
+ *	of the alternative rows to generate interrupts for them
  *
  * This structure represents platform-specific data that use used by
  * matrix_keypad driver to perform proper initialization.
@@ -63,6 +67,7 @@ struct matrix_keypad_platform_data {
 	unsigned int	num_col_gpios;
 
 	unsigned int	col_scan_delay_us;
+	unsigned int	col_switch_delay_ms;
 
 	/* key debounce interval in milli-second */
 	unsigned int	debounce_ms;
@@ -73,6 +78,7 @@ struct matrix_keypad_platform_data {
 	bool		active_low;
 	bool		wakeup;
 	bool		no_autorepeat;
+	bool		col_gpios_binary;
 };
 
 int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
-- 
1.7.5.4

