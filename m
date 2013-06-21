From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 03/12] input: matrix-keypad: rename variables and funcs
Date: Fri, 21 Jun 2013 20:09:49 +0200
Message-ID: <1371838198-7327-4-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47790 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423567Ab3FUSK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:27 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

mechanical edits before code changes, to reduce diffs later on
- rename the 'work' member of the driver's private data to better
  reflect that it's the work routine which scans the matrix after a
  change of status was detected
- rename the __activate_col() routine to better reflect that it takes
  care of GPIO pins while its caller handles logical matrix lines

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/input/keyboard/matrix_keypad.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 71d7719..5b5f86d 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -35,7 +35,7 @@ struct matrix_keypad {
 	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
-	struct delayed_work work;
+	struct delayed_work work_scan_matrix;
 	spinlock_t lock;
 	bool scan_pending;
 	bool stopped;
@@ -47,8 +47,8 @@ struct matrix_keypad {
  * minmal side effect when scanning other columns, here it is configured to
  * be input, and it should work on most platforms.
  */
-static void __activate_col(const struct matrix_keypad_platform_data *pdata,
-			   int col, bool on)
+static void __activate_col_pin(const struct matrix_keypad_platform_data *pdata,
+			       int col, bool on)
 {
 	bool level_on = !pdata->active_low;
 
@@ -63,7 +63,7 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 static void activate_col(const struct matrix_keypad_platform_data *pdata,
 			 int col, bool on)
 {
-	__activate_col(pdata, col, on);
+	__activate_col_pin(pdata, col, on);
 
 	if (on && pdata->col_scan_delay_us)
 		udelay(pdata->col_scan_delay_us);
@@ -75,7 +75,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 	int col;
 
 	for (col = 0; col < pdata->num_col_gpios; col++)
-		__activate_col(pdata, col, on);
+		__activate_col_pin(pdata, col, on);
 }
 
 static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
@@ -116,8 +116,8 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
  */
 static void matrix_keypad_scan(struct work_struct *work)
 {
-	struct matrix_keypad *keypad =
-		container_of(work, struct matrix_keypad, work.work);
+	struct matrix_keypad *keypad = container_of(work, struct matrix_keypad,
+						    work_scan_matrix.work);
 	struct input_dev *input_dev = keypad->input_dev;
 	const unsigned short *keycodes = input_dev->keycode;
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
@@ -189,8 +189,8 @@ static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
 
 	disable_row_irqs(keypad);
 	keypad->scan_pending = true;
-	schedule_delayed_work(&keypad->work,
-		msecs_to_jiffies(keypad->pdata->debounce_ms));
+	schedule_delayed_work(&keypad->work_scan_matrix,
+			      msecs_to_jiffies(keypad->pdata->debounce_ms));
 
 out:
 	spin_unlock_irqrestore(&keypad->lock, flags);
@@ -208,7 +208,7 @@ static int matrix_keypad_start(struct input_dev *dev)
 	 * Schedule an immediate key scan to capture current key state;
 	 * columns will be activated and IRQs be enabled after the scan.
 	 */
-	schedule_delayed_work(&keypad->work, 0);
+	schedule_delayed_work(&keypad->work_scan_matrix, 0);
 
 	return 0;
 }
@@ -219,7 +219,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 
 	keypad->stopped = true;
 	mb();
-	flush_work(&keypad->work.work);
+	flush_work(&keypad->work_scan_matrix.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
@@ -495,7 +495,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	keypad->pdata = pdata;
 	keypad->row_shift = get_count_order(pdata->num_col_gpios);
 	keypad->stopped = true;
-	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+	INIT_DELAYED_WORK(&keypad->work_scan_matrix, matrix_keypad_scan);
 	spin_lock_init(&keypad->lock);
 
 	input_dev->name		= pdev->name;
-- 
1.7.10.4

