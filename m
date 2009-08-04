From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: make matrix keymap size dynamic
Date: Tue, 04 Aug 2009 17:24:01 +0800
Message-ID: <4A77FE31.3010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:50155 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbZHDJYG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2009 05:24:06 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1093582eyd.37
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2009 02:24:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


The number of rows and columns should really belong to 'struct keymap_data',
and assumption on the shift and size of rows/columns removed.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---

Dmitry,

How about this patch to fix the .max_keymap_size issue? The numbers of rows and
columns are really a part of keymap data, and by moving the num_{rows, cols}
into 'struct matrix_keypad', some of the functions are changed a bit accordingly.

 drivers/input/keyboard/matrix_keypad.c |   85 +++++++++++++++++---------------
 include/linux/input/matrix_keypad.h    |    9 ++--
 2 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index e9b2e7c..aa9442a 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -26,6 +26,8 @@
 struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
+	int num_rows;
+	int num_cols;
 	unsigned short *keycodes;
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
@@ -35,14 +37,16 @@ struct matrix_keypad {
 	spinlock_t lock;
 };
 
+#define KEY_IDX(kp, row, col)	(((row) * (kp)->num_cols) + col)
+
 /*
  * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
  * minmal side effect when scanning other columns, here it is configured to
  * be input, and it should work on most platforms.
  */
-static void __activate_col(const struct matrix_keypad_platform_data *pdata,
-			   int col, bool on)
+static void __activate_col(struct matrix_keypad *keypad, int col, bool on)
 {
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	bool level_on = !pdata->active_low;
 
 	if (on) {
@@ -53,22 +57,20 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 	}
 }
 
-static void activate_col(const struct matrix_keypad_platform_data *pdata,
-			 int col, bool on)
+static void activate_col(struct matrix_keypad *keypad, int col, bool on)
 {
-	__activate_col(pdata, col, on);
+	__activate_col(keypad, col, on);
 
-	if (on && pdata->col_scan_delay_us)
-		udelay(pdata->col_scan_delay_us);
+	if (on && keypad->pdata->col_scan_delay_us)
+		udelay(keypad->pdata->col_scan_delay_us);
 }
 
-static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
-			      bool on)
+static void activate_all_cols(struct matrix_keypad *keypad, bool on)
 {
 	int col;
 
-	for (col = 0; col < pdata->num_col_gpios; col++)
-		__activate_col(pdata, col, on);
+	for (col = 0; col < keypad->num_cols; col++)
+		__activate_col(keypad, col, on);
 }
 
 static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
@@ -83,7 +85,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
+	for (i = 0; i < keypad->num_rows; i++)
 		enable_irq(gpio_to_irq(pdata->row_gpios[i]));
 }
 
@@ -92,7 +94,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
+	for (i = 0; i < keypad->num_rows; i++)
 		disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
 }
 
@@ -109,34 +111,34 @@ static void matrix_keypad_scan(struct work_struct *work)
 	int row, col, code;
 
 	/* de-activate all columns for scanning */
-	activate_all_cols(pdata, false);
+	activate_all_cols(keypad, false);
 
 	memset(new_state, 0, sizeof(new_state));
 
 	/* assert each column and read the row status out */
-	for (col = 0; col < pdata->num_col_gpios; col++) {
+	for (col = 0; col < keypad->num_cols; col++) {
 
-		activate_col(pdata, col, true);
+		activate_col(keypad, col, true);
 
-		for (row = 0; row < pdata->num_row_gpios; row++)
+		for (row = 0; row < keypad->num_rows; row++)
 			new_state[col] |=
 				row_asserted(pdata, row) ? (1 << row) : 0;
 
-		activate_col(pdata, col, false);
+		activate_col(keypad, col, false);
 	}
 
-	for (col = 0; col < pdata->num_col_gpios; col++) {
+	for (col = 0; col < keypad->num_cols; col++) {
 		uint32_t bits_changed;
 
 		bits_changed = keypad->last_key_state[col] ^ new_state[col];
 		if (bits_changed == 0)
 			continue;
 
-		for (row = 0; row < pdata->num_row_gpios; row++) {
+		for (row = 0; row < keypad->num_rows; row++) {
 			if ((bits_changed & (1 << row)) == 0)
 				continue;
 
-			code = (row << 4) + col;
+			code = KEY_IDX(keypad, row, col);
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev,
 					 keypad->keycodes[code],
@@ -147,7 +149,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memcpy(keypad->last_key_state, new_state, sizeof(new_state));
 
-	activate_all_cols(pdata, true);
+	activate_all_cols(keypad, true);
 
 	/* Enable IRQs again */
 	spin_lock_irq(&keypad->lock);
@@ -221,7 +223,7 @@ static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t stat
 	matrix_keypad_stop(keypad->input_dev);
 
 	if (device_may_wakeup(&pdev->dev))
-		for (i = 0; i < pdata->num_row_gpios; i++)
+		for (i = 0; i < keypad->num_rows; i++)
 			enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
 
 	return 0;
@@ -234,7 +236,7 @@ static int matrix_keypad_resume(struct platform_device *pdev)
 	int i;
 
 	if (device_may_wakeup(&pdev->dev))
-		for (i = 0; i < pdata->num_row_gpios; i++)
+		for (i = 0; i < keypad->num_rows; i++)
 			disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
 
 	matrix_keypad_start(keypad->input_dev);
@@ -253,7 +255,7 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
 	int i, err = -EINVAL;
 
 	/* initialized strobe lines as outputs, activated */
-	for (i = 0; i < pdata->num_col_gpios; i++) {
+	for (i = 0; i < keypad->num_cols; i++) {
 		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
 		if (err) {
 			dev_err(&pdev->dev,
@@ -265,7 +267,7 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
 		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
 	}
 
-	for (i = 0; i < pdata->num_row_gpios; i++) {
+	for (i = 0; i < keypad->num_rows; i++) {
 		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
 		if (err) {
 			dev_err(&pdev->dev,
@@ -277,7 +279,7 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
-	for (i = 0; i < pdata->num_row_gpios; i++) {
+	for (i = 0; i < keypad->num_rows; i++) {
 		err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
 				matrix_keypad_interrupt,
 				IRQF_DISABLED |
@@ -298,11 +300,11 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
 err_free_irqs:
 	while (--i >= 0)
 		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
-	i = pdata->num_row_gpios;
+	i = keypad->num_rows;
 err_free_rows:
 	while (--i >= 0)
 		gpio_free(pdata->row_gpios[i]);
-	i = pdata->num_col_gpios;
+	i = keypad->num_cols;
 err_free_cols:
 	while (--i >= 0)
 		gpio_free(pdata->col_gpios[i]);
@@ -317,7 +319,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	struct matrix_keypad *keypad;
 	struct input_dev *input_dev;
 	unsigned short *keycodes;
-	int i;
+	int i, num_rows, num_cols;
 	int err;
 
 	pdata = pdev->dev.platform_data;
@@ -332,14 +334,17 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!keymap_data->max_keymap_size) {
+	if (!keymap_data->keymap_rows || !keymap_data->keymap_cols) {
 		dev_err(&pdev->dev, "invalid keymap data supplied\n");
 		return -EINVAL;
 	}
 
 	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
-	keycodes = kzalloc(keymap_data->max_keymap_size *
-				sizeof(keypad->keycodes),
+
+	num_rows = pdata->keymap_data->keymap_rows;
+	num_cols = pdata->keymap_data->keymap_cols;
+	keycodes = kzalloc(num_rows * num_cols *
+				sizeof(keypad->keycodes[0]),
 			   GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!keypad || !keycodes || !input_dev) {
@@ -349,6 +354,8 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
+	keypad->num_rows = num_rows;
+	keypad->num_cols = num_cols;
 	keypad->keycodes = keycodes;
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
@@ -362,16 +369,14 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	input_dev->close	= matrix_keypad_stop;
 
 	input_dev->keycode	= keycodes;
-	input_dev->keycodesize	= sizeof(*keycodes);
-	input_dev->keycodemax	= keymap_data->max_keymap_size;
 
-	for (i = 0; i < keymap_data->keymap_size; i++) {
-		unsigned int key = keymap_data->keymap[i];
+	for (i = 0; i < pdata->keymap_data->keymap_size; i++) {
+		unsigned int key = pdata->keymap_data->keymap[i];
 		unsigned int row = KEY_ROW(key);
 		unsigned int col = KEY_COL(key);
 		unsigned short code = KEY_VAL(key);
 
-		keycodes[(row << 4) + col] = code;
+		keypad->keycodes[KEY_IDX(keypad, row, col)] = code;
 		__set_bit(code, input_dev->keybit);
 	}
 	__clear_bit(KEY_RESERVED, input_dev->keybit);
@@ -407,12 +412,12 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	for (i = 0; i < pdata->num_row_gpios; i++) {
+	for (i = 0; i < keypad->num_rows; i++) {
 		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
 		gpio_free(pdata->row_gpios[i]);
 	}
 
-	for (i = 0; i < pdata->num_col_gpios; i++)
+	for (i = 0; i < keypad->num_cols; i++)
 		gpio_free(pdata->col_gpios[i]);
 
 	input_unregister_device(keypad->input_dev);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 7964516..46cb3db 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -27,8 +27,9 @@
  */
 struct matrix_keymap_data {
 	const uint32_t *keymap;
+	unsigned int	keymap_rows;
+	unsigned int	keymap_cols;
 	unsigned int	keymap_size;
-	unsigned int	max_keymap_size;
 };
 
 /**
@@ -48,10 +49,8 @@ struct matrix_keymap_data {
 struct matrix_keypad_platform_data {
 	const struct matrix_keymap_data *keymap_data;
 
-	unsigned int	row_gpios[MATRIX_MAX_ROWS];
-	unsigned int	col_gpios[MATRIX_MAX_COLS];
-	unsigned int	num_row_gpios;
-	unsigned int	num_col_gpios;
+	const int	*row_gpios;
+	const int	*col_gpios;
 
 	unsigned int	col_scan_delay_us;
 
-- 
1.6.0.4
