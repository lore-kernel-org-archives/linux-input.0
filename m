From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] ep93xx_keypad: remove macros and update clkdev support
Date: Mon, 22 Jun 2009 19:35:10 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909019BDB3A@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9F392.15F63E8D"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og108.obsmtp.com ([64.18.1.21]:59368 "HELO
	exprod6og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751010AbZFVXfM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2009 19:35:12 -0400
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909019683A6@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9F392.15F63E8D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Update the ep93xx_keypad driver.

Most of these changes are to put this driver inline with my
local version of the source.

1) Add generic macros for matrix keypads (ep93xx_keypad.h).
2) Add missing include.
3) Cleanup and rename the register defines to avoid namespace
   problems.
4) The keypad_{readl|writel} macros are both only used once.
   Remove them and just open code the __raw_{readl|writel}.
5) Reorganize the private ep93xx_keypad data.
6) Update ep93xx_keypad_build_keycode() to use the generic
   matrix keypad macros.
7) Split ep93xx_keypad_irq_handler() into more logical pieces.
8) Update ep93xx_keypad_config() to correctly use the clkdev API.
9) The ep93xx_keypad clock is matched based on the device ID.
   Change the clk_get() call to reflect this.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Patch is attached in case of word wrap problems.

If we can get a consensus on the generic macros for matrix keypads I
will create a patch to move this to linux/input.h and update all the
in tree users.

Note: a patch to add the necessary ep93xx clkdev support was recently
submitted to linux-arm-kernel.  If anyone needs this patch right now
please let me know.


diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h =
b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
index 83f31cd..dc1f4f5 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
@@ -5,9 +5,6 @@
 #ifndef __ASM_ARCH_EP93XX_KEYPAD_H
 #define __ASM_ARCH_EP93XX_KEYPAD_H
=20
-#define MAX_MATRIX_KEY_ROWS		(8)
-#define MAX_MATRIX_KEY_COLS		(8)
-
 /* flags for the ep93xx_keypad driver */
 #define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
 #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
@@ -36,7 +33,22 @@ struct ep93xx_keypad_platform_data {
 	unsigned int	flags;
 };
=20
-/* macro for creating the matrix_key_map table */
-#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
+#define MAX_MATRIX_KEY_ROWS	(8)
+#define MAX_MATRIX_KEY_COLS	(8)
+
+/*
+ * Macro to pack the row/col of a key on a matrix keypad and it's =
associated
+ * KEY_* code into into an array.  4 bits are used for both the row and =
column
+ * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) are
+ * interchangable depending on a keypad drivers usage.
+ */
+#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
+
+#define MATRIX_ROWCOL_MASK	MATRIX_KEY(0x0f, 0x0f, 0)
+#define MATRIX_KEYCODE_MASK	(~MATRIX_ROWCOL_MASK)
+
+#define MATRIX_ROW(_k)		(((_k) >> 28) & 0x0f)
+#define MATRIX_COL(_k)		(((_k) >> 24) & 0x0f)
+#define MATRIX_KEYCODE(_k)	((_k) & MATRIX_KEYCODE_MASK)
=20
 #endif	/* __ASM_ARCH_EP93XX_KEYPAD_H */
diff --git a/drivers/input/keyboard/ep93xx_keypad.c =
b/drivers/input/keyboard/ep93xx_keypad.c
index 181d30e..acb79d5 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -24,125 +24,144 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/clk.h>
+#include <linux/io.h>
=20
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 #include <mach/ep93xx_keypad.h>
=20
 /*
- * Keypad Interface Register offsets
+ * Keypad Interface register offsets and bit defines
  */
-#define KEY_INIT		0x00	/* Key Scan Initialization register */
-#define KEY_DIAG		0x04	/* Key Scan Diagnostic register */
-#define KEY_REG			0x08	/* Key Value Capture register */
-
-/* Key Scan Initialization Register bit defines */
-#define KEY_INIT_DBNC_MASK	(0x00ff0000)
-#define KEY_INIT_DBNC_SHIFT	(16)
-#define KEY_INIT_DIS3KY		(1<<15)
-#define KEY_INIT_DIAG		(1<<14)
-#define KEY_INIT_BACK		(1<<13)
-#define KEY_INIT_T2		(1<<12)
-#define KEY_INIT_PRSCL_MASK	(0x000003ff)
-#define KEY_INIT_PRSCL_SHIFT	(0)
-
-/* Key Scan Diagnostic Register bit defines */
-#define KEY_DIAG_MASK		(0x0000003f)
-#define KEY_DIAG_SHIFT		(0)
-
-/* Key Value Capture Register bit defines */
-#define KEY_REG_K		(1<<15)
-#define KEY_REG_INT		(1<<14)
-#define KEY_REG_2KEYS		(1<<13)
-#define KEY_REG_1KEY		(1<<12)
-#define KEY_REG_KEY2_MASK	(0x00000fc0)
-#define KEY_REG_KEY2_SHIFT	(6)
-#define KEY_REG_KEY1_MASK	(0x0000003f)
-#define KEY_REG_KEY1_SHIFT	(0)
-
-#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
-#define keypad_writel(v, off)	__raw_writel((v), keypad->mmio_base + =
(off))
-
-#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
+#define EP93XX_KEY_INIT			0x00
+#define   EP93XX_KEY_INIT_DBNC_MASK	  0x00ff0000
+#define   EP93XX_KEY_INIT_DBNC_SHIFT	  16
+#define   EP93XX_KEY_INIT_DIS3KY	  (1<<15)
+#define   EP93XX_KEY_INIT_DIAG		  (1<<14)
+#define   EP93XX_KEY_INIT_BACK		  (1<<13)
+#define   EP93XX_KEY_INIT_T2		  (1<<12)
+#define   EP93XX_KEY_INIT_PRSCL_MASK	  0x000003ff
+#define   EP93XX_KEY_INIT_PRSCL_SHIFT	  0
+#define EP93XX_KEY_DIAG			0x04
+#define   EP93XX_KEY_DIAG_MASK		  0x0000003f
+#define   EP93XX_KEY_DIAG_SHIFT		  0
+#define EP93XX_KEY_REG			0x08
+#define   EP93XX_KEY_REG_K		  (1<<15)
+#define   EP93XX_KEY_REG_INT		  (1<<14)
+#define   EP93XX_KEY_REG_2KEYS		  (1<<13)
+#define   EP93XX_KEY_REG_1KEY		  (1<<12)
+#define   EP93XX_KEY_REG_KEY2_MASK	  0x00000fc0
+#define   EP93XX_KEY_REG_KEY2_SHIFT	  6
+#define   EP93XX_KEY_REG_KEY1_MASK	  0x0000003f
+#define   EP93XX_KEY_REG_KEY1_SHIFT	  0
+
+#define EP93XX_KEYTCHCLKDIV_4		(EP93XX_EXT_CLK_RATE / 4)
+#define EP93XX_KEYTCHCLKDIV_16		(EP93XX_EXT_CLK_RATE / 16)
+
+#define MAX_MATRIX_KEY_NUM		(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
=20
 struct ep93xx_keypad {
 	struct ep93xx_keypad_platform_data *pdata;
-
-	struct clk *clk;
 	struct input_dev *input_dev;
+	struct clk *clk;
+
 	void __iomem *mmio_base;
=20
-	int irq;
-	int enabled;
+	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
=20
 	int key1;
 	int key2;
=20
-	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+	int irq;
+	int enabled;
 };
=20
 static void ep93xx_keypad_build_keycode(struct ep93xx_keypad *keypad)
 {
 	struct ep93xx_keypad_platform_data *pdata =3D keypad->pdata;
 	struct input_dev *input_dev =3D keypad->input_dev;
+	unsigned int *key;
 	int i;
=20
-	for (i =3D 0; i < pdata->matrix_key_map_size; i++) {
-		unsigned int key =3D pdata->matrix_key_map[i];
-		int row =3D (key >> 28) & 0xf;
-		int col =3D (key >> 24) & 0xf;
-		int code =3D key & 0xffffff;
+	key =3D &pdata->matrix_key_map[0];
+	for (i =3D 0; i < pdata->matrix_key_map_size; i++, key++) {
+		int row =3D MATRIX_ROW(*key);
+		int col =3D MATRIX_COL(*key);
+		int code =3D MATRIX_KEYCODE(*key);
=20
 		keypad->matrix_keycodes[(row << 3) + col] =3D code;
 		__set_bit(code, input_dev->keybit);
 	}
 }
=20
-static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+static void ep93xx_keypad_report(struct ep93xx_keypad *keypad, int key, =
int press)
 {
-	struct ep93xx_keypad *keypad =3D dev_id;
 	struct input_dev *input_dev =3D keypad->input_dev;
-	unsigned int status =3D keypad_readl(KEY_REG);
-	int keycode, key1, key2;
=20
-	keycode =3D (status & KEY_REG_KEY1_MASK) >> KEY_REG_KEY1_SHIFT;
-	key1 =3D keypad->matrix_keycodes[keycode];
+	if (key) {
+		input_report_key(input_dev, key, press);
+		input_sync(input_dev);
+	}
+}
=20
-	keycode =3D (status & KEY_REG_KEY2_MASK) >> KEY_REG_KEY2_SHIFT;
-	key2 =3D keypad->matrix_keycodes[keycode];
+static void ep93xx_keypad_release(struct ep93xx_keypad *keypad, int =
*key)
+{
+	ep93xx_keypad_report(keypad, *key, 0);
+	*key =3D 0;
+}
+
+static void ep93xx_keypad_press(struct ep93xx_keypad *keypad, int *key, =
int code)
+{
+	*key =3D code;
+	ep93xx_keypad_report(keypad, *key, 1);
+}
=20
-	if (status & KEY_REG_2KEYS) {
-		if (keypad->key1 && key1 !=3D keypad->key1 && key2 !=3D keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+static void ep93xx_keypad_process(struct ep93xx_keypad *keypad,
+				int key1, int key2)
+{
+	int old_key1 =3D keypad->key1;
+	int old_key2 =3D keypad->key2;
=20
-		if (keypad->key2 && key1 !=3D keypad->key2 && key2 !=3D keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+	if (old_key1 !=3D key1 && old_key1 !=3D key2)
+		ep93xx_keypad_release(keypad, &keypad->key1);
=20
-		input_report_key(input_dev, key1, 1);
-		input_report_key(input_dev, key2, 1);
+	if (old_key2 !=3D key1 && old_key2 !=3D key2)
+		ep93xx_keypad_release(keypad, &keypad->key2);
=20
+	if (old_key1 !=3D key1 && old_key2 !=3D key1)
+		ep93xx_keypad_press(keypad, &keypad->key1, key1);
+	else
 		keypad->key1 =3D key1;
+
+	if (old_key1 !=3D key2 && old_key2 !=3D key2)
+		ep93xx_keypad_press(keypad, &keypad->key2, key2);
+	else
 		keypad->key2 =3D key2;
+}
=20
-	} else if (status & KEY_REG_1KEY) {
-		if (keypad->key1 && key1 !=3D keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct ep93xx_keypad *keypad =3D dev_id;
+	unsigned int status;
+	int keycode, key1, key2;
=20
-		if (keypad->key2 && key1 !=3D keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+	status =3D __raw_readl(keypad->mmio_base + EP93XX_KEY_REG);
=20
-		input_report_key(input_dev, key1, 1);
+	keycode =3D (status & EP93XX_KEY_REG_KEY1_MASK) >>
+				EP93XX_KEY_REG_KEY1_SHIFT;
+	key1 =3D keypad->matrix_keycodes[keycode];
=20
-		keypad->key1 =3D key1;
-		keypad->key2 =3D 0;
+	keycode =3D (status & EP93XX_KEY_REG_KEY2_MASK) >>
+				EP93XX_KEY_REG_KEY2_SHIFT;
+	key2 =3D keypad->matrix_keycodes[keycode];
=20
+	if (status & EP93XX_KEY_REG_2KEYS) {
+		ep93xx_keypad_process(keypad, key1, key2);
+	} else if (status & EP93XX_KEY_REG_1KEY) {
+		ep93xx_keypad_process(keypad, key1, 0);
 	} else {
-		input_report_key(input_dev, keypad->key1, 0);
-		input_report_key(input_dev, keypad->key2, 0);
-
-		keypad->key1 =3D keypad->key2 =3D 0;
+		ep93xx_keypad_process(keypad, 0, 0);
 	}
-	input_sync(input_dev);
=20
 	return IRQ_HANDLED;
 }
@@ -152,22 +171,27 @@ static void ep93xx_keypad_config(struct =
ep93xx_keypad *keypad)
 	struct ep93xx_keypad_platform_data *pdata =3D keypad->pdata;
 	unsigned int val =3D 0;
=20
-	clk_set_rate(keypad->clk, pdata->flags & EP93XX_KEYPAD_KDIV);
+	if (pdata->flags & EP93XX_KEYPAD_KDIV)
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLKDIV_4);
+	else
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLKDIV_16);
=20
 	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
-		val |=3D KEY_INIT_DIS3KY;
+		val |=3D EP93XX_KEY_INIT_DIS3KY;
 	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
-		val |=3D KEY_INIT_DIAG;
+		val |=3D EP93XX_KEY_INIT_DIAG;
 	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
-		val |=3D KEY_INIT_BACK;
+		val |=3D EP93XX_KEY_INIT_BACK;
 	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
-		val |=3D KEY_INIT_T2;
+		val |=3D EP93XX_KEY_INIT_T2;
=20
-	val |=3D ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & =
KEY_INIT_DBNC_MASK);
+	val |=3D ((pdata->debounce << EP93XX_KEY_INIT_DBNC_SHIFT) &
+		EP93XX_KEY_INIT_DBNC_MASK);
=20
-	val |=3D ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & =
KEY_INIT_PRSCL_MASK);
+	val |=3D ((pdata->prescale << EP93XX_KEY_INIT_PRSCL_SHIFT) &
+		EP93XX_KEY_INIT_PRSCL_MASK);
=20
-	keypad_writel(val, KEY_INIT);
+	__raw_writel(val, keypad->mmio_base + EP93XX_KEY_INIT);
 }
=20
 static int ep93xx_keypad_open(struct input_dev *pdev)
@@ -323,7 +347,7 @@ static int __devinit ep93xx_keypad_probe(struct =
platform_device *pdev)
 		}
 	}
=20
-	keypad->clk =3D clk_get(&pdev->dev, "key_clk");
+	keypad->clk =3D clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		err =3D PTR_ERR(keypad->clk);=20

------_=_NextPart_001_01C9F392.15F63E8D
Content-Type: application/octet-stream;
	name="ep93xx_keypad.patch"
Content-Transfer-Encoding: base64
Content-Description: ep93xx_keypad.patch
Content-Disposition: attachment;
	filename="ep93xx_keypad.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtZXA5M3h4L2luY2x1ZGUvbWFjaC9lcDkzeHhfa2V5
cGFkLmggYi9hcmNoL2FybS9tYWNoLWVwOTN4eC9pbmNsdWRlL21hY2gvZXA5M3h4X2tleXBhZC5o
CmluZGV4IDgzZjMxY2QuLmRjMWY0ZjUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtZXA5M3h4
L2luY2x1ZGUvbWFjaC9lcDkzeHhfa2V5cGFkLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1lcDkzeHgv
aW5jbHVkZS9tYWNoL2VwOTN4eF9rZXlwYWQuaApAQCAtNSw5ICs1LDYgQEAKICNpZm5kZWYgX19B
U01fQVJDSF9FUDkzWFhfS0VZUEFEX0gKICNkZWZpbmUgX19BU01fQVJDSF9FUDkzWFhfS0VZUEFE
X0gKIAotI2RlZmluZSBNQVhfTUFUUklYX0tFWV9ST1dTCQkoOCkKLSNkZWZpbmUgTUFYX01BVFJJ
WF9LRVlfQ09MUwkJKDgpCi0KIC8qIGZsYWdzIGZvciB0aGUgZXA5M3h4X2tleXBhZCBkcml2ZXIg
Ki8KICNkZWZpbmUgRVA5M1hYX0tFWVBBRF9ESVNBQkxFXzNfS0VZCSgxPDwwKQkvKiBkaXNhYmxl
IDMta2V5IHJlc2V0ICovCiAjZGVmaW5lIEVQOTNYWF9LRVlQQURfRElBR19NT0RFCQkoMTw8MSkJ
LyogZGlhZ25vc3RpYyBtb2RlICovCkBAIC0zNiw3ICszMywyMiBAQCBzdHJ1Y3QgZXA5M3h4X2tl
eXBhZF9wbGF0Zm9ybV9kYXRhIHsKIAl1bnNpZ25lZCBpbnQJZmxhZ3M7CiB9OwogCi0vKiBtYWNy
byBmb3IgY3JlYXRpbmcgdGhlIG1hdHJpeF9rZXlfbWFwIHRhYmxlICovCi0jZGVmaW5lIEtFWShy
b3csIGNvbCwgdmFsKQkoKChyb3cpIDw8IDI4KSB8ICgoY29sKSA8PCAyNCkgfCAodmFsKSkKKyNk
ZWZpbmUgTUFYX01BVFJJWF9LRVlfUk9XUwkoOCkKKyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfQ09M
UwkoOCkKKworLyoKKyAqIE1hY3JvIHRvIHBhY2sgdGhlIHJvdy9jb2wgb2YgYSBrZXkgb24gYSBt
YXRyaXgga2V5cGFkIGFuZCBpdCdzIGFzc29jaWF0ZWQKKyAqIEtFWV8qIGNvZGUgaW50byBpbnRv
IGFuIGFycmF5LiAgNCBiaXRzIGFyZSB1c2VkIGZvciBib3RoIHRoZSByb3cgYW5kIGNvbHVtbgor
ICogYWxsb3dpbmcgZm9yIHVwIHRvIGEgMTZ4MTYga2V5cGFkLiAgVGhlIHJvdyAoX3IpIGFuZCBj
b2x1bW4gKF9jKSBhcmUKKyAqIGludGVyY2hhbmdhYmxlIGRlcGVuZGluZyBvbiBhIGtleXBhZCBk
cml2ZXJzIHVzYWdlLgorICovCisjZGVmaW5lIE1BVFJJWF9LRVkoX3IsIF9jLCBfdikJKCgoX3Ip
IDw8IDI4KSB8ICgoX2MpIDw8IDI0KSB8IChfdikpCisKKyNkZWZpbmUgTUFUUklYX1JPV0NPTF9N
QVNLCU1BVFJJWF9LRVkoMHgwZiwgMHgwZiwgMCkKKyNkZWZpbmUgTUFUUklYX0tFWUNPREVfTUFT
Swkofk1BVFJJWF9ST1dDT0xfTUFTSykKKworI2RlZmluZSBNQVRSSVhfUk9XKF9rKQkJKCgoX2sp
ID4+IDI4KSAmIDB4MGYpCisjZGVmaW5lIE1BVFJJWF9DT0woX2spCQkoKChfaykgPj4gMjQpICYg
MHgwZikKKyNkZWZpbmUgTUFUUklYX0tFWUNPREUoX2spCSgoX2spICYgTUFUUklYX0tFWUNPREVf
TUFTSykKIAogI2VuZGlmCS8qIF9fQVNNX0FSQ0hfRVA5M1hYX0tFWVBBRF9IICovCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2VwOTN4eF9rZXlwYWQuYyBiL2RyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvZXA5M3h4X2tleXBhZC5jCmluZGV4IDE4MWQzMGUuLmFjYjc5ZDUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvZXA5M3h4X2tleXBhZC5jCisrKyBiL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvZXA5M3h4X2tleXBhZC5jCkBAIC0yNCwxMjUgKzI0LDE0NCBAQAog
I2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAj
aW5jbHVkZSA8bGludXgvY2xrLmg+CisjaW5jbHVkZSA8bGludXgvaW8uaD4KIAogI2luY2x1ZGUg
PG1hY2gvaGFyZHdhcmUuaD4KICNpbmNsdWRlIDxtYWNoL2dwaW8uaD4KICNpbmNsdWRlIDxtYWNo
L2VwOTN4eF9rZXlwYWQuaD4KIAogLyoKLSAqIEtleXBhZCBJbnRlcmZhY2UgUmVnaXN0ZXIgb2Zm
c2V0cworICogS2V5cGFkIEludGVyZmFjZSByZWdpc3RlciBvZmZzZXRzIGFuZCBiaXQgZGVmaW5l
cwogICovCi0jZGVmaW5lIEtFWV9JTklUCQkweDAwCS8qIEtleSBTY2FuIEluaXRpYWxpemF0aW9u
IHJlZ2lzdGVyICovCi0jZGVmaW5lIEtFWV9ESUFHCQkweDA0CS8qIEtleSBTY2FuIERpYWdub3N0
aWMgcmVnaXN0ZXIgKi8KLSNkZWZpbmUgS0VZX1JFRwkJCTB4MDgJLyogS2V5IFZhbHVlIENhcHR1
cmUgcmVnaXN0ZXIgKi8KLQotLyogS2V5IFNjYW4gSW5pdGlhbGl6YXRpb24gUmVnaXN0ZXIgYml0
IGRlZmluZXMgKi8KLSNkZWZpbmUgS0VZX0lOSVRfREJOQ19NQVNLCSgweDAwZmYwMDAwKQotI2Rl
ZmluZSBLRVlfSU5JVF9EQk5DX1NISUZUCSgxNikKLSNkZWZpbmUgS0VZX0lOSVRfRElTM0tZCQko
MTw8MTUpCi0jZGVmaW5lIEtFWV9JTklUX0RJQUcJCSgxPDwxNCkKLSNkZWZpbmUgS0VZX0lOSVRf
QkFDSwkJKDE8PDEzKQotI2RlZmluZSBLRVlfSU5JVF9UMgkJKDE8PDEyKQotI2RlZmluZSBLRVlf
SU5JVF9QUlNDTF9NQVNLCSgweDAwMDAwM2ZmKQotI2RlZmluZSBLRVlfSU5JVF9QUlNDTF9TSElG
VAkoMCkKLQotLyogS2V5IFNjYW4gRGlhZ25vc3RpYyBSZWdpc3RlciBiaXQgZGVmaW5lcyAqLwot
I2RlZmluZSBLRVlfRElBR19NQVNLCQkoMHgwMDAwMDAzZikKLSNkZWZpbmUgS0VZX0RJQUdfU0hJ
RlQJCSgwKQotCi0vKiBLZXkgVmFsdWUgQ2FwdHVyZSBSZWdpc3RlciBiaXQgZGVmaW5lcyAqLwot
I2RlZmluZSBLRVlfUkVHX0sJCSgxPDwxNSkKLSNkZWZpbmUgS0VZX1JFR19JTlQJCSgxPDwxNCkK
LSNkZWZpbmUgS0VZX1JFR18yS0VZUwkJKDE8PDEzKQotI2RlZmluZSBLRVlfUkVHXzFLRVkJCSgx
PDwxMikKLSNkZWZpbmUgS0VZX1JFR19LRVkyX01BU0sJKDB4MDAwMDBmYzApCi0jZGVmaW5lIEtF
WV9SRUdfS0VZMl9TSElGVAkoNikKLSNkZWZpbmUgS0VZX1JFR19LRVkxX01BU0sJKDB4MDAwMDAw
M2YpCi0jZGVmaW5lIEtFWV9SRUdfS0VZMV9TSElGVAkoMCkKLQotI2RlZmluZSBrZXlwYWRfcmVh
ZGwob2ZmKQlfX3Jhd19yZWFkbChrZXlwYWQtPm1taW9fYmFzZSArIChvZmYpKQotI2RlZmluZSBr
ZXlwYWRfd3JpdGVsKHYsIG9mZikJX19yYXdfd3JpdGVsKCh2KSwga2V5cGFkLT5tbWlvX2Jhc2Ug
KyAob2ZmKSkKLQotI2RlZmluZSBNQVhfTUFUUklYX0tFWV9OVU0JKE1BWF9NQVRSSVhfS0VZX1JP
V1MgKiBNQVhfTUFUUklYX0tFWV9DT0xTKQorI2RlZmluZSBFUDkzWFhfS0VZX0lOSVQJCQkweDAw
CisjZGVmaW5lICAgRVA5M1hYX0tFWV9JTklUX0RCTkNfTUFTSwkgIDB4MDBmZjAwMDAKKyNkZWZp
bmUgICBFUDkzWFhfS0VZX0lOSVRfREJOQ19TSElGVAkgIDE2CisjZGVmaW5lICAgRVA5M1hYX0tF
WV9JTklUX0RJUzNLWQkgICgxPDwxNSkKKyNkZWZpbmUgICBFUDkzWFhfS0VZX0lOSVRfRElBRwkJ
ICAoMTw8MTQpCisjZGVmaW5lICAgRVA5M1hYX0tFWV9JTklUX0JBQ0sJCSAgKDE8PDEzKQorI2Rl
ZmluZSAgIEVQOTNYWF9LRVlfSU5JVF9UMgkJICAoMTw8MTIpCisjZGVmaW5lICAgRVA5M1hYX0tF
WV9JTklUX1BSU0NMX01BU0sJICAweDAwMDAwM2ZmCisjZGVmaW5lICAgRVA5M1hYX0tFWV9JTklU
X1BSU0NMX1NISUZUCSAgMAorI2RlZmluZSBFUDkzWFhfS0VZX0RJQUcJCQkweDA0CisjZGVmaW5l
ICAgRVA5M1hYX0tFWV9ESUFHX01BU0sJCSAgMHgwMDAwMDAzZgorI2RlZmluZSAgIEVQOTNYWF9L
RVlfRElBR19TSElGVAkJICAwCisjZGVmaW5lIEVQOTNYWF9LRVlfUkVHCQkJMHgwOAorI2RlZmlu
ZSAgIEVQOTNYWF9LRVlfUkVHX0sJCSAgKDE8PDE1KQorI2RlZmluZSAgIEVQOTNYWF9LRVlfUkVH
X0lOVAkJICAoMTw8MTQpCisjZGVmaW5lICAgRVA5M1hYX0tFWV9SRUdfMktFWVMJCSAgKDE8PDEz
KQorI2RlZmluZSAgIEVQOTNYWF9LRVlfUkVHXzFLRVkJCSAgKDE8PDEyKQorI2RlZmluZSAgIEVQ
OTNYWF9LRVlfUkVHX0tFWTJfTUFTSwkgIDB4MDAwMDBmYzAKKyNkZWZpbmUgICBFUDkzWFhfS0VZ
X1JFR19LRVkyX1NISUZUCSAgNgorI2RlZmluZSAgIEVQOTNYWF9LRVlfUkVHX0tFWTFfTUFTSwkg
IDB4MDAwMDAwM2YKKyNkZWZpbmUgICBFUDkzWFhfS0VZX1JFR19LRVkxX1NISUZUCSAgMAorCisj
ZGVmaW5lIEVQOTNYWF9LRVlUQ0hDTEtESVZfNAkJKEVQOTNYWF9FWFRfQ0xLX1JBVEUgLyA0KQor
I2RlZmluZSBFUDkzWFhfS0VZVENIQ0xLRElWXzE2CQkoRVA5M1hYX0VYVF9DTEtfUkFURSAvIDE2
KQorCisjZGVmaW5lIE1BWF9NQVRSSVhfS0VZX05VTQkJKE1BWF9NQVRSSVhfS0VZX1JPV1MgKiBN
QVhfTUFUUklYX0tFWV9DT0xTKQogCiBzdHJ1Y3QgZXA5M3h4X2tleXBhZCB7CiAJc3RydWN0IGVw
OTN4eF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGE7Ci0KLQlzdHJ1Y3QgY2xrICpjbGs7CiAJ
c3RydWN0IGlucHV0X2RldiAqaW5wdXRfZGV2OworCXN0cnVjdCBjbGsgKmNsazsKKwogCXZvaWQg
X19pb21lbSAqbW1pb19iYXNlOwogCi0JaW50IGlycTsKLQlpbnQgZW5hYmxlZDsKKwl1bnNpZ25l
ZCBpbnQgbWF0cml4X2tleWNvZGVzW01BWF9NQVRSSVhfS0VZX05VTV07CiAKIAlpbnQga2V5MTsK
IAlpbnQga2V5MjsKIAotCXVuc2lnbmVkIGludCBtYXRyaXhfa2V5Y29kZXNbTUFYX01BVFJJWF9L
RVlfTlVNXTsKKwlpbnQgaXJxOworCWludCBlbmFibGVkOwogfTsKIAogc3RhdGljIHZvaWQgZXA5
M3h4X2tleXBhZF9idWlsZF9rZXljb2RlKHN0cnVjdCBlcDkzeHhfa2V5cGFkICprZXlwYWQpCiB7
CiAJc3RydWN0IGVwOTN4eF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBrZXlwYWQtPnBk
YXRhOwogCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldiA9IGtleXBhZC0+aW5wdXRfZGV2Owor
CXVuc2lnbmVkIGludCAqa2V5OwogCWludCBpOwogCi0JZm9yIChpID0gMDsgaSA8IHBkYXRhLT5t
YXRyaXhfa2V5X21hcF9zaXplOyBpKyspIHsKLQkJdW5zaWduZWQgaW50IGtleSA9IHBkYXRhLT5t
YXRyaXhfa2V5X21hcFtpXTsKLQkJaW50IHJvdyA9IChrZXkgPj4gMjgpICYgMHhmOwotCQlpbnQg
Y29sID0gKGtleSA+PiAyNCkgJiAweGY7Ci0JCWludCBjb2RlID0ga2V5ICYgMHhmZmZmZmY7CisJ
a2V5ID0gJnBkYXRhLT5tYXRyaXhfa2V5X21hcFswXTsKKwlmb3IgKGkgPSAwOyBpIDwgcGRhdGEt
Pm1hdHJpeF9rZXlfbWFwX3NpemU7IGkrKywga2V5KyspIHsKKwkJaW50IHJvdyA9IE1BVFJJWF9S
T1coKmtleSk7CisJCWludCBjb2wgPSBNQVRSSVhfQ09MKCprZXkpOworCQlpbnQgY29kZSA9IE1B
VFJJWF9LRVlDT0RFKCprZXkpOwogCiAJCWtleXBhZC0+bWF0cml4X2tleWNvZGVzWyhyb3cgPDwg
MykgKyBjb2xdID0gY29kZTsKIAkJX19zZXRfYml0KGNvZGUsIGlucHV0X2Rldi0+a2V5Yml0KTsK
IAl9CiB9CiAKLXN0YXRpYyBpcnFyZXR1cm5fdCBlcDkzeHhfa2V5cGFkX2lycV9oYW5kbGVyKGlu
dCBpcnEsIHZvaWQgKmRldl9pZCkKK3N0YXRpYyB2b2lkIGVwOTN4eF9rZXlwYWRfcmVwb3J0KHN0
cnVjdCBlcDkzeHhfa2V5cGFkICprZXlwYWQsIGludCBrZXksIGludCBwcmVzcykKIHsKLQlzdHJ1
Y3QgZXA5M3h4X2tleXBhZCAqa2V5cGFkID0gZGV2X2lkOwogCXN0cnVjdCBpbnB1dF9kZXYgKmlu
cHV0X2RldiA9IGtleXBhZC0+aW5wdXRfZGV2OwotCXVuc2lnbmVkIGludCBzdGF0dXMgPSBrZXlw
YWRfcmVhZGwoS0VZX1JFRyk7Ci0JaW50IGtleWNvZGUsIGtleTEsIGtleTI7CiAKLQlrZXljb2Rl
ID0gKHN0YXR1cyAmIEtFWV9SRUdfS0VZMV9NQVNLKSA+PiBLRVlfUkVHX0tFWTFfU0hJRlQ7Ci0J
a2V5MSA9IGtleXBhZC0+bWF0cml4X2tleWNvZGVzW2tleWNvZGVdOworCWlmIChrZXkpIHsKKwkJ
aW5wdXRfcmVwb3J0X2tleShpbnB1dF9kZXYsIGtleSwgcHJlc3MpOworCQlpbnB1dF9zeW5jKGlu
cHV0X2Rldik7CisJfQorfQogCi0Ja2V5Y29kZSA9IChzdGF0dXMgJiBLRVlfUkVHX0tFWTJfTUFT
SykgPj4gS0VZX1JFR19LRVkyX1NISUZUOwotCWtleTIgPSBrZXlwYWQtPm1hdHJpeF9rZXljb2Rl
c1trZXljb2RlXTsKK3N0YXRpYyB2b2lkIGVwOTN4eF9rZXlwYWRfcmVsZWFzZShzdHJ1Y3QgZXA5
M3h4X2tleXBhZCAqa2V5cGFkLCBpbnQgKmtleSkKK3sKKwllcDkzeHhfa2V5cGFkX3JlcG9ydChr
ZXlwYWQsICprZXksIDApOworCSprZXkgPSAwOworfQorCitzdGF0aWMgdm9pZCBlcDkzeHhfa2V5
cGFkX3ByZXNzKHN0cnVjdCBlcDkzeHhfa2V5cGFkICprZXlwYWQsIGludCAqa2V5LCBpbnQgY29k
ZSkKK3sKKwkqa2V5ID0gY29kZTsKKwllcDkzeHhfa2V5cGFkX3JlcG9ydChrZXlwYWQsICprZXks
IDEpOworfQogCi0JaWYgKHN0YXR1cyAmIEtFWV9SRUdfMktFWVMpIHsKLQkJaWYgKGtleXBhZC0+
a2V5MSAmJiBrZXkxICE9IGtleXBhZC0+a2V5MSAmJiBrZXkyICE9IGtleXBhZC0+a2V5MSkKLQkJ
CWlucHV0X3JlcG9ydF9rZXkoaW5wdXRfZGV2LCBrZXlwYWQtPmtleTEsIDApOworc3RhdGljIHZv
aWQgZXA5M3h4X2tleXBhZF9wcm9jZXNzKHN0cnVjdCBlcDkzeHhfa2V5cGFkICprZXlwYWQsCisJ
CQkJaW50IGtleTEsIGludCBrZXkyKQoreworCWludCBvbGRfa2V5MSA9IGtleXBhZC0+a2V5MTsK
KwlpbnQgb2xkX2tleTIgPSBrZXlwYWQtPmtleTI7CiAKLQkJaWYgKGtleXBhZC0+a2V5MiAmJiBr
ZXkxICE9IGtleXBhZC0+a2V5MiAmJiBrZXkyICE9IGtleXBhZC0+a2V5MikKLQkJCWlucHV0X3Jl
cG9ydF9rZXkoaW5wdXRfZGV2LCBrZXlwYWQtPmtleTIsIDApOworCWlmIChvbGRfa2V5MSAhPSBr
ZXkxICYmIG9sZF9rZXkxICE9IGtleTIpCisJCWVwOTN4eF9rZXlwYWRfcmVsZWFzZShrZXlwYWQs
ICZrZXlwYWQtPmtleTEpOwogCi0JCWlucHV0X3JlcG9ydF9rZXkoaW5wdXRfZGV2LCBrZXkxLCAx
KTsKLQkJaW5wdXRfcmVwb3J0X2tleShpbnB1dF9kZXYsIGtleTIsIDEpOworCWlmIChvbGRfa2V5
MiAhPSBrZXkxICYmIG9sZF9rZXkyICE9IGtleTIpCisJCWVwOTN4eF9rZXlwYWRfcmVsZWFzZShr
ZXlwYWQsICZrZXlwYWQtPmtleTIpOwogCisJaWYgKG9sZF9rZXkxICE9IGtleTEgJiYgb2xkX2tl
eTIgIT0ga2V5MSkKKwkJZXA5M3h4X2tleXBhZF9wcmVzcyhrZXlwYWQsICZrZXlwYWQtPmtleTEs
IGtleTEpOworCWVsc2UKIAkJa2V5cGFkLT5rZXkxID0ga2V5MTsKKworCWlmIChvbGRfa2V5MSAh
PSBrZXkyICYmIG9sZF9rZXkyICE9IGtleTIpCisJCWVwOTN4eF9rZXlwYWRfcHJlc3Moa2V5cGFk
LCAma2V5cGFkLT5rZXkyLCBrZXkyKTsKKwllbHNlCiAJCWtleXBhZC0+a2V5MiA9IGtleTI7Cit9
CiAKLQl9IGVsc2UgaWYgKHN0YXR1cyAmIEtFWV9SRUdfMUtFWSkgewotCQlpZiAoa2V5cGFkLT5r
ZXkxICYmIGtleTEgIT0ga2V5cGFkLT5rZXkxKQotCQkJaW5wdXRfcmVwb3J0X2tleShpbnB1dF9k
ZXYsIGtleXBhZC0+a2V5MSwgMCk7CitzdGF0aWMgaXJxcmV0dXJuX3QgZXA5M3h4X2tleXBhZF9p
cnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpCit7CisJc3RydWN0IGVwOTN4eF9rZXlw
YWQgKmtleXBhZCA9IGRldl9pZDsKKwl1bnNpZ25lZCBpbnQgc3RhdHVzOworCWludCBrZXljb2Rl
LCBrZXkxLCBrZXkyOwogCi0JCWlmIChrZXlwYWQtPmtleTIgJiYga2V5MSAhPSBrZXlwYWQtPmtl
eTIpCi0JCQlpbnB1dF9yZXBvcnRfa2V5KGlucHV0X2Rldiwga2V5cGFkLT5rZXkyLCAwKTsKKwlz
dGF0dXMgPSBfX3Jhd19yZWFkbChrZXlwYWQtPm1taW9fYmFzZSArIEVQOTNYWF9LRVlfUkVHKTsK
IAotCQlpbnB1dF9yZXBvcnRfa2V5KGlucHV0X2Rldiwga2V5MSwgMSk7CisJa2V5Y29kZSA9IChz
dGF0dXMgJiBFUDkzWFhfS0VZX1JFR19LRVkxX01BU0spID4+CisJCQkJRVA5M1hYX0tFWV9SRUdf
S0VZMV9TSElGVDsKKwlrZXkxID0ga2V5cGFkLT5tYXRyaXhfa2V5Y29kZXNba2V5Y29kZV07CiAK
LQkJa2V5cGFkLT5rZXkxID0ga2V5MTsKLQkJa2V5cGFkLT5rZXkyID0gMDsKKwlrZXljb2RlID0g
KHN0YXR1cyAmIEVQOTNYWF9LRVlfUkVHX0tFWTJfTUFTSykgPj4KKwkJCQlFUDkzWFhfS0VZX1JF
R19LRVkyX1NISUZUOworCWtleTIgPSBrZXlwYWQtPm1hdHJpeF9rZXljb2Rlc1trZXljb2RlXTsK
IAorCWlmIChzdGF0dXMgJiBFUDkzWFhfS0VZX1JFR18yS0VZUykgeworCQllcDkzeHhfa2V5cGFk
X3Byb2Nlc3Moa2V5cGFkLCBrZXkxLCBrZXkyKTsKKwl9IGVsc2UgaWYgKHN0YXR1cyAmIEVQOTNY
WF9LRVlfUkVHXzFLRVkpIHsKKwkJZXA5M3h4X2tleXBhZF9wcm9jZXNzKGtleXBhZCwga2V5MSwg
MCk7CiAJfSBlbHNlIHsKLQkJaW5wdXRfcmVwb3J0X2tleShpbnB1dF9kZXYsIGtleXBhZC0+a2V5
MSwgMCk7Ci0JCWlucHV0X3JlcG9ydF9rZXkoaW5wdXRfZGV2LCBrZXlwYWQtPmtleTIsIDApOwot
Ci0JCWtleXBhZC0+a2V5MSA9IGtleXBhZC0+a2V5MiA9IDA7CisJCWVwOTN4eF9rZXlwYWRfcHJv
Y2VzcyhrZXlwYWQsIDAsIDApOwogCX0KLQlpbnB1dF9zeW5jKGlucHV0X2Rldik7CiAKIAlyZXR1
cm4gSVJRX0hBTkRMRUQ7CiB9CkBAIC0xNTIsMjIgKzE3MSwyNyBAQCBzdGF0aWMgdm9pZCBlcDkz
eHhfa2V5cGFkX2NvbmZpZyhzdHJ1Y3QgZXA5M3h4X2tleXBhZCAqa2V5cGFkKQogCXN0cnVjdCBl
cDkzeHhfa2V5cGFkX3BsYXRmb3JtX2RhdGEgKnBkYXRhID0ga2V5cGFkLT5wZGF0YTsKIAl1bnNp
Z25lZCBpbnQgdmFsID0gMDsKIAotCWNsa19zZXRfcmF0ZShrZXlwYWQtPmNsaywgcGRhdGEtPmZs
YWdzICYgRVA5M1hYX0tFWVBBRF9LRElWKTsKKwlpZiAocGRhdGEtPmZsYWdzICYgRVA5M1hYX0tF
WVBBRF9LRElWKQorCQljbGtfc2V0X3JhdGUoa2V5cGFkLT5jbGssIEVQOTNYWF9LRVlUQ0hDTEtE
SVZfNCk7CisJZWxzZQorCQljbGtfc2V0X3JhdGUoa2V5cGFkLT5jbGssIEVQOTNYWF9LRVlUQ0hD
TEtESVZfMTYpOwogCiAJaWYgKHBkYXRhLT5mbGFncyAmIEVQOTNYWF9LRVlQQURfRElTQUJMRV8z
X0tFWSkKLQkJdmFsIHw9IEtFWV9JTklUX0RJUzNLWTsKKwkJdmFsIHw9IEVQOTNYWF9LRVlfSU5J
VF9ESVMzS1k7CiAJaWYgKHBkYXRhLT5mbGFncyAmIEVQOTNYWF9LRVlQQURfRElBR19NT0RFKQot
CQl2YWwgfD0gS0VZX0lOSVRfRElBRzsKKwkJdmFsIHw9IEVQOTNYWF9LRVlfSU5JVF9ESUFHOwog
CWlmIChwZGF0YS0+ZmxhZ3MgJiBFUDkzWFhfS0VZUEFEX0JBQ0tfRFJJVkUpCi0JCXZhbCB8PSBL
RVlfSU5JVF9CQUNLOworCQl2YWwgfD0gRVA5M1hYX0tFWV9JTklUX0JBQ0s7CiAJaWYgKHBkYXRh
LT5mbGFncyAmIEVQOTNYWF9LRVlQQURfVEVTVF9NT0RFKQotCQl2YWwgfD0gS0VZX0lOSVRfVDI7
CisJCXZhbCB8PSBFUDkzWFhfS0VZX0lOSVRfVDI7CiAKLQl2YWwgfD0gKChwZGF0YS0+ZGVib3Vu
Y2UgPDwgS0VZX0lOSVRfREJOQ19TSElGVCkgJiBLRVlfSU5JVF9EQk5DX01BU0spOworCXZhbCB8
PSAoKHBkYXRhLT5kZWJvdW5jZSA8PCBFUDkzWFhfS0VZX0lOSVRfREJOQ19TSElGVCkgJgorCQlF
UDkzWFhfS0VZX0lOSVRfREJOQ19NQVNLKTsKIAotCXZhbCB8PSAoKHBkYXRhLT5wcmVzY2FsZSA8
PCBLRVlfSU5JVF9QUlNDTF9TSElGVCkgJiBLRVlfSU5JVF9QUlNDTF9NQVNLKTsKKwl2YWwgfD0g
KChwZGF0YS0+cHJlc2NhbGUgPDwgRVA5M1hYX0tFWV9JTklUX1BSU0NMX1NISUZUKSAmCisJCUVQ
OTNYWF9LRVlfSU5JVF9QUlNDTF9NQVNLKTsKIAotCWtleXBhZF93cml0ZWwodmFsLCBLRVlfSU5J
VCk7CisJX19yYXdfd3JpdGVsKHZhbCwga2V5cGFkLT5tbWlvX2Jhc2UgKyBFUDkzWFhfS0VZX0lO
SVQpOwogfQogCiBzdGF0aWMgaW50IGVwOTN4eF9rZXlwYWRfb3BlbihzdHJ1Y3QgaW5wdXRfZGV2
ICpwZGV2KQpAQCAtMzIzLDcgKzM0Nyw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGVwOTN4eF9r
ZXlwYWRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJfQogCX0KIAotCWtl
eXBhZC0+Y2xrID0gY2xrX2dldCgmcGRldi0+ZGV2LCAia2V5X2NsayIpOworCWtleXBhZC0+Y2xr
ID0gY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsKIAlpZiAoSVNfRVJSKGtleXBhZC0+Y2xrKSkg
ewogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IGtleXBhZCBjbG9ja1xuIik7
CiAJCWVyciA9IFBUUl9FUlIoa2V5cGFkLT5jbGspOwo=

------_=_NextPart_001_01C9F392.15F63E8D--
