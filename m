From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 7/7] Input: cros_ec_keyb: Optimize ghosting algorithm.
Date: Mon, 28 Jul 2014 14:19:27 +0200
Message-ID: <1406549967-21291-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:57570 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaG1MTw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jul 2014 08:19:52 -0400
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

From: Todd Broch <tbroch@chromium.org>

Previous algorithm was a bit conservative and complicating with
respect to identifying key ghosting.  This CL uses the bitops hamming
weight function (hweight8) to count the number of matching rows for
colM & colN.  If that number is > 1 ghosting is present.

Additionally it removes NULL keys and our one virtual keypress
KEY_BATTERY from consideration as these inputs are never physical
keypresses.

Signed-off-by: Todd Broch <tbroch@chromium.org>
Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
Reviewed-by: Luigi Semenzato <semenzato@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 92 +++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 93111d1..5d773d2 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -38,6 +39,7 @@
  * @row_shift: log2 or number of rows, rounded up
  * @keymap_data: Matrix keymap data used to convert to keyscan values
  * @ghost_filter: true to enable the matrix key-ghosting filter
+ * @valid_keys: bitmap of existing keys for each matrix column
  * @old_kb_state: bitmap of keys pressed last scan
  * @dev: Device pointer
  * @idev: Input device
@@ -49,6 +51,7 @@ struct cros_ec_keyb {
 	int row_shift;
 	const struct matrix_keymap_data *keymap_data;
 	bool ghost_filter;
+	uint8_t *valid_keys;
 	uint8_t *old_kb_state;
 
 	struct device *dev;
@@ -57,39 +60,15 @@ struct cros_ec_keyb {
 };
 
 
-static bool cros_ec_keyb_row_has_ghosting(struct cros_ec_keyb *ckdev,
-					  uint8_t *buf, int row)
-{
-	int pressed_in_row = 0;
-	int row_has_teeth = 0;
-	int col, mask;
-
-	mask = 1 << row;
-	for (col = 0; col < ckdev->cols; col++) {
-		if (buf[col] & mask) {
-			pressed_in_row++;
-			row_has_teeth |= buf[col] & ~mask;
-			if (pressed_in_row > 1 && row_has_teeth) {
-				/* ghosting */
-				dev_dbg(ckdev->dev,
-					"ghost found at: r%d c%d, pressed %d, teeth 0x%x\n",
-					row, col, pressed_in_row,
-					row_has_teeth);
-				return true;
-			}
-		}
-	}
-
-	return false;
-}
-
 /*
  * Returns true when there is at least one combination of pressed keys that
  * results in ghosting.
  */
 static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
 {
-	int row;
+	int col1, col2, buf1, buf2;
+	struct device *dev = ckdev->dev;
+	uint8_t *valid_keys = ckdev->valid_keys;
 
 	/*
 	 * Ghosting happens if for any pressed key X there are other keys
@@ -103,27 +82,23 @@ static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
 	 *
 	 * In this case only X, Y, and Z are pressed, but g appears to be
 	 * pressed too (see Wikipedia).
-	 *
-	 * We can detect ghosting in a single pass (*) over the keyboard state
-	 * by maintaining two arrays.  pressed_in_row counts how many pressed
-	 * keys we have found in a row.  row_has_teeth is true if any of the
-	 * pressed keys for this row has other pressed keys in its column.  If
-	 * at any point of the scan we find that a row has multiple pressed
-	 * keys, and at least one of them is at the intersection with a column
-	 * with multiple pressed keys, we're sure there is ghosting.
-	 * Conversely, if there is ghosting, we will detect such situation for
-	 * at least one key during the pass.
-	 *
-	 * (*) This looks linear in the number of keys, but it's not.  We can
-	 * cheat because the number of rows is small.
 	 */
-	for (row = 0; row < ckdev->rows; row++)
-		if (cros_ec_keyb_row_has_ghosting(ckdev, buf, row))
-			return true;
+	for (col1 = 0; col1 < ckdev->cols; col1++) {
+		buf1 = buf[col1] & valid_keys[col1];
+		for (col2 = col1 + 1; col2 < ckdev->cols; col2++) {
+			buf2 = buf[col2] & valid_keys[col2];
+			if (hweight8(buf1 & buf2) > 1) {
+				dev_dbg(dev, "ghost found at: B[%02d]:0x%02x & B[%02d]:0x%02x",
+					col1, buf1, col2, buf2);
+				return true;
+			}
+		}
+	}
 
 	return false;
 }
 
+
 /*
  * Compares the new keyboard state to the old one and produces key
  * press/release events accordingly.  The keyboard state is 13 bytes (one byte
@@ -222,6 +197,30 @@ static void cros_ec_keyb_close(struct input_dev *dev)
 	free_irq(ec->irq, ckdev);
 }
 
+/*
+ * Walks keycodes flipping bit in buffer COLUMNS deep where bit is ROW.  Used by
+ * ghosting logic to ignore NULL or virtual keys.
+ */
+static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev)
+{
+	int row, col;
+	int row_shift = ckdev->row_shift;
+	unsigned short *keymap = ckdev->idev->keycode;
+	unsigned short code;
+
+	BUG_ON(ckdev->idev->keycodesize != sizeof(*keymap));
+
+	for (col = 0; col < ckdev->cols; col++) {
+		for (row = 0; row < ckdev->rows; row++) {
+			code = keymap[MATRIX_SCAN_CODE(row, col, row_shift)];
+			if (code && (code != KEY_BATTERY))
+				ckdev->valid_keys[col] |= 1 << row;
+		}
+		dev_dbg(ckdev->dev, "valid_keys[%02d] = 0x%02x\n",
+			col, ckdev->valid_keys[col]);
+	}
+}
+
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
@@ -242,6 +241,11 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 					    &ckdev->cols);
 	if (err)
 		return err;
+
+	ckdev->valid_keys = devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KERNEL);
+	if (!ckdev->valid_keys)
+		return -ENOMEM;
+
 	ckdev->old_kb_state = devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KERNEL);
 	if (!ckdev->old_kb_state)
 		return -ENOMEM;
@@ -285,6 +289,8 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	input_set_capability(idev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(idev, ckdev);
 	ckdev->idev = idev;
+	cros_ec_keyb_compute_valid_keys(ckdev);
+
 	err = input_register_device(ckdev->idev);
 	if (err) {
 		dev_err(dev, "cannot register input device\n");
-- 
2.0.0.rc2

