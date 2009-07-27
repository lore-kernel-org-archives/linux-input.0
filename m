From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 27 Jul 2009 16:54:01 +0800
Message-ID: <4A6D6B29.8090708@gmail.com>
References: <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com> <20090629162619.GB24533@dtor-d630.eng.vmware.com> <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt> <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com> <4A60425D.9@teltonika.lt> <5d5443650907200012o4c84b0fm4a03cfb18f7fd738@mail.gmail.com> <4A6448D0.6050002@gmail.com> <20090721080036.GA10168@dtor-d630.eng.vmware.com> <4A657BC7.8090904@gmail.com> <20090721155814.GC4352@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:48503 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbZG0IyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2009 04:54:18 -0400
Received: by rv-out-0506.google.com with SMTP id f6so831111rvb.1
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2009 01:54:18 -0700 (PDT)
In-Reply-To: <20090721155814.GC4352@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Tue, Jul 21, 2009 at 04:26:47PM +0800, Eric Miao wrote:
>> Dmitry Torokhov wrote:
>>> Hi Eric,
>>>
>>> On Mon, Jul 20, 2009 at 06:37:04PM +0800, Eric Miao wrote:
>>>>>>> Did you tried assigning max_keypmap_size in platform data to
>>>>>>> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
>>>>>>>
>>>>>> Yes, this fixes crashes. But this is just workaround for bug in driver.
>>>>>>
>>>>> As you have access to h/w, care to submit a patch which fixes this?
>>>>>
>>>> Dmitry & Trilok,
>>>>
>>>> How about this?  Due to the fact that we are not able to sort out the
>>>> proper solution for a dynamic maximum of columns/rows, let's simplify
>>>> the fix to the patch below:
>>>>
>>>>
>>>> From 61ea1bd16a3636f526fb12619e84a75fa16b7f38 Mon Sep 17 00:00:00 2001
>>>> From: Eric Miao <eric.y.miao@gmail.com>
>>>> Date: Mon, 20 Jul 2009 11:31:08 +0800
>>>> Subject: [PATCH] input: matrix keymap size fixed to maximum
>>>>
>>>> Introduced KEY_IDX(), merged keymap_data into 'matrix_keypad_platform_data'.
>>>>
>>> I would like to keep definitions in matrix_keymap.h useable to other
>>> drivers so we either make KEY_IDX() work with different number of
>>> columns or drop it.
>> What about:
>>
>> #define KEY_IDX(row, col)	(((row) * keypad->num_columns) + (col))
>>
>> if we want to make it dynamic.
>>
> 
> I'd rather not have any references to particular data structures there,
> so something like KEY_IDX(row, col, shift) or KEY_IDX(row, col, maxcol).
> Would that work for you?
> 
> 
>>> I would also like to keep keymap data separate so
>>> drivers that don't use matrix encoding could still use it.
>>>
>> Do you mean there are possibilities that some drivers are not going to
>> define any matrix keycodes, and depend on EV_MSC to know the position
>> happened? That way, we may want to omit the ->keycodes[] accesses.
>>
> 
> Poorly spoken on my part. I should have said "not use entire structure
> from the matrix_keymap.h" but only the keymap part.
> 
>>> Overall, I don't quite understand what the problem with the current
>>> drive is since it works fine as long as we set up max_keymap_size
>>> properly.
>> I think the root of this problem lies in the code below:
>>
>>                         code = (row << 4) + col;
>>                         input_event(input_dev, EV_MSC, MSC_SCAN, code);
>>                         input_report_key(input_dev,
>>                                          keypad->keycodes[code],
>>                                          new_state[col] & (1 << row));
>>
>> that 'code = (row << 4) + col;' is hardcoded to shift left by '4', and
>> is then used to index into keypad->keycodes[] array, the size of which
>> in turn is specified by 'max_keymap_size'. This is a bit inconsistent.
> 
> Right, I agree.
> 
>> If written as (row << 4) + col, it means the max_keymap_size should be
>> setup as 'max_rows * 16', instead of expected 'max_rows * max_cols'.
>>
> 
> Yes, at the moment... I guess we need to put the true dimensions instead
> of max size into the keymap data, right? Then we'd be able to calculate
> proper shift value.
> 
>> And there seems to be a typo in the allocation:
>>
>>         keycodes = kzalloc(keymap_data->max_keymap_size *
>>                                 sizeof(keypad->keycodes),
>>                            GFP_KERNEL);
>>
>> that, 'sizeof(keypad->keycodes)' should be written as
>> 'sizeof(keypad->keycodes[0])' if I guess it correct.
> 
> It should not hurt anything (since sizeof(keypad->keycodes) is 4 bytes)
> but indeed I need to fix that.
> 
>>> We could improve diagnostic by checking row and cols values
>>> and warning users when they supply suspicious data and maybe adjust the
>>> documentation, right?
>>>
> 

OK, then how about this one?

>From be59051b471dc87a0cd846630dd9964602b310f6 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.y.miao@gmail.com>
Date: Mon, 20 Jul 2009 11:31:08 +0800
Subject: [PATCH] input: make matrix keymap size dynamic

The number of rows and columns should really belong to 'struct keymap_data',
and assumption on the shift and size of rows/columns removed.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
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

