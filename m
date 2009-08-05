From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: make matrix keymap size dynamic
Date: Wed, 5 Aug 2009 01:26:30 -0700
Message-ID: <20090805082631.96C1A526EA5@mailhub.coreip.homeip.net>
References: <4A77FE31.3010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:25945 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933730AbZHEI0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2009 04:26:34 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1415612rvb.1
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2009 01:26:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A77FE31.3010209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Eric,

On Tue, Aug 04, 2009 at 05:24:01PM +0800, Eric Miao wrote:
> 
> The number of rows and columns should really belong to 'struct keymap_data',
> and assumption on the shift and size of rows/columns removed.
> 

I aplayed with your patch for a while and moving rows and columns into
struct keymap_data did not feel right; the changes to activate_cols and
others where we have to access 2 different structures to get gpios and
upper limit made the code awkward. In the end I decided the sizes should
be kept where they were, together with the gpio arrays.

What do you think about the modified version of your patch below? The
definitions seem to be working for other matrix drivers I have i my
queue as well...

-- 
Dmitry


Input: matrix_keypad - make matrix keymap size dynamic

From: Eric Miao <eric.y.miao@gmail.com>

Remove assumption on the shift and size of rows/columns form
matrix_keypad driver.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/matrix_keypad.c |   18 +++++++++---------
 include/linux/input/matrix_keypad.h    |   13 +++++++------
 2 files changed, 16 insertions(+), 15 deletions(-)


diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index e9b2e7c..541b981 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -27,6 +27,7 @@ struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	unsigned short *keycodes;
+	unsigned int row_shift;
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work;
@@ -136,7 +137,7 @@ static void matrix_keypad_scan(struct work_struct *work)
 			if ((bits_changed & (1 << row)) == 0)
 				continue;
 
-			code = (row << 4) + col;
+			code = MATRIX_SCAN_CODE(row, col, keypad->row_shift);
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev,
 					 keypad->keycodes[code],
@@ -317,6 +318,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	struct matrix_keypad *keypad;
 	struct input_dev *input_dev;
 	unsigned short *keycodes;
+	unsigned int row_shift;
 	int i;
 	int err;
 
@@ -332,14 +334,11 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!keymap_data->max_keymap_size) {
-		dev_err(&pdev->dev, "invalid keymap data supplied\n");
-		return -EINVAL;
-	}
+	row_shift = get_count_order(pdata->num_col_gpios);
 
 	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
-	keycodes = kzalloc(keymap_data->max_keymap_size *
-				sizeof(keypad->keycodes),
+	keycodes = kzalloc((pdata->num_row_gpios << row_shift) *
+				sizeof(*keycodes),
 			   GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!keypad || !keycodes || !input_dev) {
@@ -350,6 +349,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
 	keypad->keycodes = keycodes;
+	keypad->row_shift = row_shift;
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
 	spin_lock_init(&keypad->lock);
@@ -363,7 +363,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 
 	input_dev->keycode	= keycodes;
 	input_dev->keycodesize	= sizeof(*keycodes);
-	input_dev->keycodemax	= keymap_data->max_keymap_size;
+	input_dev->keycodemax	= pdata->num_row_gpios << keypad->row_shift;
 
 	for (i = 0; i < keymap_data->keymap_size; i++) {
 		unsigned int key = keymap_data->keymap[i];
@@ -371,7 +371,7 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
 		unsigned int col = KEY_COL(key);
 		unsigned short code = KEY_VAL(key);
 
-		keycodes[(row << 4) + col] = code;
+		keycodes[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
 		__set_bit(code, input_dev->keybit);
 	}
 	__clear_bit(KEY_RESERVED, input_dev->keybit);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 7964516..15d5903 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -15,12 +15,13 @@
 #define KEY_COL(k)		(((k) >> 16) & 0xff)
 #define KEY_VAL(k)		((k) & 0xffff)
 
+#define MATRIX_SCAN_CODE(row, col, row_shift)	(((row) << (row_shift)) + (col))
+
 /**
  * struct matrix_keymap_data - keymap for matrix keyboards
  * @keymap: pointer to array of uint32 values encoded with KEY() macro
  *	representing keymap
  * @keymap_size: number of entries (initialized) in this keymap
- * @max_keymap_size: maximum size of keymap supported by the device
  *
  * This structure is supposed to be used by platform code to supply
  * keymaps to drivers that implement matrix-like keypads/keyboards.
@@ -28,14 +29,13 @@
 struct matrix_keymap_data {
 	const uint32_t *keymap;
 	unsigned int	keymap_size;
-	unsigned int	max_keymap_size;
 };
 
 /**
  * struct matrix_keypad_platform_data - platform-dependent keypad data
  * @keymap_data: pointer to &matrix_keymap_data
- * @row_gpios: array of gpio numbers reporesenting rows
- * @col_gpios: array of gpio numbers reporesenting colums
+ * @row_gpios: pointer to array of gpio numbers representing rows
+ * @col_gpios: pointer to array of gpio numbers reporesenting colums
  * @num_row_gpios: actual number of row gpios used by device
  * @num_col_gpios: actual number of col gpios used by device
  * @col_scan_delay_us: delay, measured in microseconds, that is
@@ -48,8 +48,9 @@ struct matrix_keymap_data {
 struct matrix_keypad_platform_data {
 	const struct matrix_keymap_data *keymap_data;
 
-	unsigned int	row_gpios[MATRIX_MAX_ROWS];
-	unsigned int	col_gpios[MATRIX_MAX_COLS];
+	const unsigned int *row_gpios;
+	const unsigned int *col_gpios;
+
 	unsigned int	num_row_gpios;
 	unsigned int	num_col_gpios;
 
