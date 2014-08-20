From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [RESEND PATCH 7/7] Input: cros_ec_keyb: Optimize ghosting algorithm.
Date: Wed, 20 Aug 2014 14:13:32 +0200
Message-ID: <1408536812-7836-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408536812-7836-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

=46rom: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Previous algorithm was a bit conservative and complicating with
respect to identifying key ghosting.  This CL uses the bitops hamming
weight function (hweight8) to count the number of matching rows for
colM & colN.  If that number is > 1 ghosting is present.

Additionally it removes NULL keys and our one virtual keypress
KEY_BATTERY from consideration as these inputs are never physical
keypresses.

Signed-off-by: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8oXa1LcwEujcA@public.gmane.org=
k>
---
 drivers/input/keyboard/cros_ec_keyb.c | 92 +++++++++++++++++++--------=
--------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyb=
oard/cros_ec_keyb.c
index 93111d1..5d773d2 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -22,6 +22,7 @@
  */
=20
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
=20
 	struct device *dev;
@@ -57,39 +60,15 @@ struct cros_ec_keyb {
 };
=20
=20
-static bool cros_ec_keyb_row_has_ghosting(struct cros_ec_keyb *ckdev,
-					  uint8_t *buf, int row)
-{
-	int pressed_in_row =3D 0;
-	int row_has_teeth =3D 0;
-	int col, mask;
-
-	mask =3D 1 << row;
-	for (col =3D 0; col < ckdev->cols; col++) {
-		if (buf[col] & mask) {
-			pressed_in_row++;
-			row_has_teeth |=3D buf[col] & ~mask;
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
  * Returns true when there is at least one combination of pressed keys=
 that
  * results in ghosting.
  */
 static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint=
8_t *buf)
 {
-	int row;
+	int col1, col2, buf1, buf2;
+	struct device *dev =3D ckdev->dev;
+	uint8_t *valid_keys =3D ckdev->valid_keys;
=20
 	/*
 	 * Ghosting happens if for any pressed key X there are other keys
@@ -103,27 +82,23 @@ static bool cros_ec_keyb_has_ghosting(struct cros_=
ec_keyb *ckdev, uint8_t *buf)
 	 *
 	 * In this case only X, Y, and Z are pressed, but g appears to be
 	 * pressed too (see Wikipedia).
-	 *
-	 * We can detect ghosting in a single pass (*) over the keyboard stat=
e
-	 * by maintaining two arrays.  pressed_in_row counts how many pressed
-	 * keys we have found in a row.  row_has_teeth is true if any of the
-	 * pressed keys for this row has other pressed keys in its column.  I=
f
-	 * at any point of the scan we find that a row has multiple pressed
-	 * keys, and at least one of them is at the intersection with a colum=
n
-	 * with multiple pressed keys, we're sure there is ghosting.
-	 * Conversely, if there is ghosting, we will detect such situation fo=
r
-	 * at least one key during the pass.
-	 *
-	 * (*) This looks linear in the number of keys, but it's not.  We can
-	 * cheat because the number of rows is small.
 	 */
-	for (row =3D 0; row < ckdev->rows; row++)
-		if (cros_ec_keyb_row_has_ghosting(ckdev, buf, row))
-			return true;
+	for (col1 =3D 0; col1 < ckdev->cols; col1++) {
+		buf1 =3D buf[col1] & valid_keys[col1];
+		for (col2 =3D col1 + 1; col2 < ckdev->cols; col2++) {
+			buf2 =3D buf[col2] & valid_keys[col2];
+			if (hweight8(buf1 & buf2) > 1) {
+				dev_dbg(dev, "ghost found at: B[%02d]:0x%02x & B[%02d]:0x%02x",
+					col1, buf1, col2, buf2);
+				return true;
+			}
+		}
+	}
=20
 	return false;
 }
=20
+
 /*
  * Compares the new keyboard state to the old one and produces key
  * press/release events accordingly.  The keyboard state is 13 bytes (=
one byte
@@ -222,6 +197,30 @@ static void cros_ec_keyb_close(struct input_dev *d=
ev)
 	free_irq(ec->irq, ckdev);
 }
=20
+/*
+ * Walks keycodes flipping bit in buffer COLUMNS deep where bit is ROW=
=2E  Used by
+ * ghosting logic to ignore NULL or virtual keys.
+ */
+static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev=
)
+{
+	int row, col;
+	int row_shift =3D ckdev->row_shift;
+	unsigned short *keymap =3D ckdev->idev->keycode;
+	unsigned short code;
+
+	BUG_ON(ckdev->idev->keycodesize !=3D sizeof(*keymap));
+
+	for (col =3D 0; col < ckdev->cols; col++) {
+		for (row =3D 0; row < ckdev->rows; row++) {
+			code =3D keymap[MATRIX_SCAN_CODE(row, col, row_shift)];
+			if (code && (code !=3D KEY_BATTERY))
+				ckdev->valid_keys[col] |=3D 1 << row;
+		}
+		dev_dbg(ckdev->dev, "valid_keys[%02d] =3D 0x%02x\n",
+			col, ckdev->valid_keys[col]);
+	}
+}
+
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec =3D dev_get_drvdata(pdev->dev.parent);
@@ -242,6 +241,11 @@ static int cros_ec_keyb_probe(struct platform_devi=
ce *pdev)
 					    &ckdev->cols);
 	if (err)
 		return err;
+
+	ckdev->valid_keys =3D devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KERNE=
L);
+	if (!ckdev->valid_keys)
+		return -ENOMEM;
+
 	ckdev->old_kb_state =3D devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KER=
NEL);
 	if (!ckdev->old_kb_state)
 		return -ENOMEM;
@@ -285,6 +289,8 @@ static int cros_ec_keyb_probe(struct platform_devic=
e *pdev)
 	input_set_capability(idev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(idev, ckdev);
 	ckdev->idev =3D idev;
+	cros_ec_keyb_compute_valid_keys(ckdev);
+
 	err =3D input_register_device(ckdev->idev);
 	if (err) {
 		dev_err(dev, "cannot register input device\n");
--=20
2.0.1
