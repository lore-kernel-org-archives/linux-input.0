From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 07/12] input: keypad-matrix: introduce polling support
Date: Fri, 21 Jun 2013 20:09:53 +0200
Message-ID: <1371838198-7327-8-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40482 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423566Ab3FUSK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:27 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

detecting changes in the key press status may not work reliably in
interrupt driven mode (see the documentation part of the change for
details)

add support to poll the matrix in software for reliable operation in the
presence of multi key press events, leave a comment on how sleep and
wakeup could be made to work appropriately in the polling case

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |   17 ++++
 drivers/input/keyboard/matrix_keypad.c             |   92 ++++++++++++++++++--
 include/linux/input/matrix_keypad.h                |    4 +-
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index e6a01eb..196935b 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -17,6 +17,20 @@ selected (active) at the same time.  Which in turn assumes that all
 column lines can get activated at the same time, and no harm is done to
 the hardware when multiple keys are pressed simultaneously.
 
+The approach to enable all columns at the same time and to determine
+that a key press status change has occured from row pin level changes
+only works reliably for single key presses.  Multi key presses where the
+keys share their position on a row line may get deferred or even could
+go unnoticed, pressing and holding one key will shadow events which
+another key on the same row would have generated.  When reliable
+detection of key press events is required even in the presence of multi
+key presses, interrupt mode isn't sufficient any longer, and polling
+needs to be used.  The polling approach to detecting changes in the key
+press status will periodically activate a single column line and check
+the signals of the row lines.  Polling may also be applicable to setups
+where the hardware doesn't support the activation of several columns at
+the same time.
+
 Simple keypad matrix layouts just connect GPIO lines to mechanical
 switches, with no other active components involved.  Although due to the
 driver's operation of activating all columns at the same time for most
@@ -60,6 +74,9 @@ Optional Properties:
 			such that pin levels can settle after
 			propagating through the matrix and its
 			associated hardware components
+- col-switch-delay-ms:	columns switch interval in milliseconds instead
+			of using interrupts to detect key press changes,
+			enables polling mode when specified
 - row-gpios-activelow:	row GPIO pins are active low
 - col-gpios-activelow:	column GPIO pins are active low
 - gpio-activelow:	row pins as well as column pins are active low
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 0b2599d..c2221d1 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -36,10 +36,12 @@ struct matrix_keypad {
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work_scan_matrix;
+	struct delayed_work work_switch_column;
 	spinlock_t lock;
 	bool scan_pending;
 	bool stopped;
 	bool gpio_all_disabled;
+	unsigned int col_to_poll;
 };
 
 /*
@@ -152,17 +154,26 @@ static uint32_t sample_rows_for_col(struct matrix_keypad *keypad, int col)
  * to have any subsequent change in the key press status trigger the ISR
  *
  * a single IRQ line can be used if all involved GPIOs share that IRQ
+ *
+ * in contrast to interrupt driven detection of key press changes, for
+ * polling detection a delayed work routine periodically will switch
+ * columns and upon changes will arrange for the same postprocessing as
+ * an ISR would have done
  */
 static void enable_row_irqs(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
+	unsigned long jiffies;
 
-	if (pdata->clustered_irq > 0)
+	if (pdata->clustered_irq > 0) {
 		enable_irq(pdata->clustered_irq);
-	else {
+	} else if (!pdata->col_switch_delay_ms) {
 		for (i = 0; i < pdata->num_row_gpios; i++)
 			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+	} else {
+		jiffies = msecs_to_jiffies(pdata->col_switch_delay_ms);
+		schedule_delayed_work(&keypad->work_switch_column, jiffies);
 	}
 }
 
@@ -178,11 +189,13 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0)
+	if (pdata->clustered_irq > 0) {
 		disable_irq_nosync(pdata->clustered_irq);
-	else {
+	} else if (!pdata->col_switch_delay_ms) {
 		for (i = 0; i < pdata->num_row_gpios; i++)
 			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+	} else {
+		cancel_delayed_work(&keypad->work_switch_column);
 	}
 }
 
@@ -291,6 +304,58 @@ out:
 	return IRQ_HANDLED;
 }
 
+/*
+ * delayed work routine, periodically switching columns and checking the
+ * key press status, to detect changes without interrupt support
+ *
+ * this routine is the polling mode counterpart to the above interrupt handler
+ */
+static void matrix_keypad_switch(struct work_struct *work)
+{
+	struct matrix_keypad *keypad = container_of(work, struct matrix_keypad,
+						    work_switch_column.work);
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int col;
+	uint32_t curr_state, prev_state;
+	unsigned long jiffies;
+
+	/* avoid multiple injection, and cope with shutdowns */
+	if (unlikely(keypad->scan_pending || keypad->stopped))
+		return;
+
+	/*
+	 * advance to the next column (avoids modulo calculation
+	 * since that might be too expensive in the absence of
+	 * compile time constants)
+	 */
+	keypad->col_to_poll++;
+	if (keypad->col_to_poll >= pdata->num_col_gpios)
+		keypad->col_to_poll = 0;
+	col = keypad->col_to_poll;
+
+	/*
+	 * sample the row status for this specific column, schedule
+	 * for the next column switch in the absence of changes
+	 */
+	curr_state = sample_rows_for_col(keypad, col);
+	prev_state = keypad->last_key_state[col];
+	if (curr_state == prev_state) {
+		jiffies = msecs_to_jiffies(pdata->col_switch_delay_ms);
+		schedule_delayed_work(&keypad->work_switch_column, jiffies);
+		return;
+	}
+
+	/*
+	 * start the debounce interval when a change was detected,
+	 * cease further polling until the matrix scan has completed
+	 * (polling automatically gets re-started after the scan)
+	 */
+	disable_row_irqs(keypad);
+	keypad->scan_pending = true;
+	jiffies = msecs_to_jiffies(keypad->pdata->debounce_ms);
+	schedule_delayed_work(&keypad->work_scan_matrix, jiffies);
+}
+
 static int matrix_keypad_start(struct input_dev *dev)
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
@@ -313,6 +378,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 
 	keypad->stopped = true;
 	mb();
+	flush_work(&keypad->work_switch_column.work);
 	flush_work(&keypad->work_scan_matrix.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
@@ -322,6 +388,16 @@ static void matrix_keypad_stop(struct input_dev *dev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * note that software polling may not mix well with interrupt driven
+ * wakeup from power management, since there is no concept of "enabling
+ * all columns at the same time", and any random column may be active
+ * when we get here
+ *
+ * an appropriate approach might be to have the user specify a column
+ * that shall get activated before sleep, such that a specific and
+ * well-known subset of the keypad matrix can wake up the device
+ */
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
@@ -342,6 +418,8 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 			}
 		}
 	}
+
+	/* TODO activate a potentially user specified column */
 }
 
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
@@ -542,7 +620,9 @@ matrix_keypad_parse_dt(struct device *dev)
 	/* get delay and interval timing specs */
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
-						&pdata->col_scan_delay_us);
+			     &pdata->col_scan_delay_us);
+	of_property_read_u32(np, "col-switch-delay-ms",
+			     &pdata->col_switch_delay_ms);
 
 	/* get the individual row and column GPIO pins */
 	gpios = devm_kzalloc(dev,
@@ -609,6 +689,8 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	/* start in stopped state, open(2) will activate the scan */
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work_scan_matrix, matrix_keypad_scan);
+	INIT_DELAYED_WORK(&keypad->work_switch_column, matrix_keypad_switch);
+	keypad->col_to_poll = pdata->num_col_gpios;
 	spin_lock_init(&keypad->lock);
 
 	input_dev->name		= pdev->name;
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 4bbe6b3..3c8dc39 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -41,6 +41,8 @@ struct matrix_keymap_data {
  * @num_col_gpios: actual number of col gpios used by device
  * @col_scan_delay_us: delay in microseconds, the interval between
  *	activating a column and reading back row information
+ * @col_switch_delay_ms: delay in milliseconds, the interval with which
+ *	colums periodically get checked for changes in key press status
  * @debounce_ms: debounce interval in milliseconds, the interval between
  *	detecting a change in the key press status and determining the new
  *	overall keypad matrix status
@@ -70,7 +72,7 @@ struct matrix_keypad_platform_data {
 
 	/* delays and intervals specs */
 	unsigned int	col_scan_delay_us;
-
+	unsigned int	col_switch_delay_ms;
 	unsigned int	debounce_ms;
 
 	/* optionally reduce interrupt mgmt overhead */
-- 
1.7.10.4

