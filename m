From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 5/12] pxa: enable both rotary encoders and direct keys for keypad
Date: Wed, 23 Jan 2008 15:27:30 +0800
Message-ID: <f17812d70801222327g25ab8246wa5e35b03b4e65ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:57527 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAWH1b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:27:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4885356wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:27:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From 75d4d094be869bd130eab2e8cf9c782a9060285b Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 11:00:41 +0800
Subject: [PATCH] pxa: enable both rotary encoders and direct keys for keypad

1. rotary encoder events can be configured either as relative events
   as the legacy code does or as any specified key code, this is
   useful on some platform which uses the rotary keys as
   KEY_{UP/DOWN/LEFT/RIGHT}

2. add support for direct keys, the corresponding keycodes for each
   direct key can now be specified within the platform data

3. remove the direct/rotary key detection code from the IRQ handler
   to dedicated functions to improve readability

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c   |  163 ++++++++++++++++++++++++------
 include/asm-arm/arch-pxa/pxa27x_keypad.h |   30 ++++++
 2 files changed, 164 insertions(+), 29 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
index e9d4e22..cd25b34 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -41,6 +41,9 @@
 #define KPC_MKCN(n)	((((n) & 0x7) - 1) << 23) /* matrix key column number */
 #define KPC_DKN(n)	((((n) & 0x7) - 1) << 6)  /* direct key number */

+#define KPDK_DKP        (0x1 << 31)
+#define KPDK_DK(n)	((n) & 0xff)
+
 #define KPAS_MUKP(n)		(((n) >> 26) & 0x1f)
 #define KPAS_RP(n)		(((n) >> 4) & 0xf)
 #define KPAS_CP(n)		((n) & 0xf)
@@ -60,6 +63,13 @@ struct pxa27x_keypad {

 	/* state row bits of each column scan */
 	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
+	uint32_t direct_key_state;
+
+	unsigned int direct_key_mask;
+
+	int rotary_rel_code[2];
+	int rotary_up_key[2];
+	int rotary_down_key[2];
 };

 static void pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
@@ -78,6 +88,25 @@ static void pxa27x_keypad_build_keycode(struct
pxa27x_keypad *keypad)
 		keypad->matrix_keycodes[(row << 3) + col] = code;
 		set_bit(code, input_dev->keybit);
 	}
+
+	keypad->rotary_up_key[0] = pdata->rotary0_up_key;
+	keypad->rotary_up_key[1] = pdata->rotary1_up_key;
+	keypad->rotary_down_key[0] = pdata->rotary0_down_key;
+	keypad->rotary_down_key[1] = pdata->rotary1_down_key;
+	keypad->rotary_rel_code[0] = pdata->rotary0_rel_code;
+	keypad->rotary_rel_code[1] = pdata->rotary1_rel_code;
+
+	if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
+		set_bit(pdata->rotary0_up_key, input_dev->keybit);
+		set_bit(pdata->rotary0_down_key, input_dev->keybit);
+	} else
+		set_bit(pdata->rotary0_rel_code, input_dev->relbit);
+
+	if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
+		set_bit(pdata->rotary1_up_key, input_dev->keybit);
+		set_bit(pdata->rotary1_down_key, input_dev->keybit);
+	} else
+		set_bit(pdata->rotary1_rel_code, input_dev->relbit);
 }

 static inline unsigned int lookup_matrix_keycode(
@@ -151,35 +180,92 @@ scan:

 #define DEFAULT_KPREC	(0x007f007f)

+static inline int rotary_delta(uint32_t kprec)
+{
+	if (kprec & KPREC_OF0)
+		return (kprec & 0xff) + 0x7f;
+	else if (kprec & KPREC_UF0)
+		return (kprec & 0xff) - 0x7f - 0xff;
+	else
+		return (kprec & 0xff) - 0x7f;
+}
+
+static void report_rotary_event(struct pxa27x_keypad *keypad, int r, int delta)
+{
+	struct input_dev *dev = keypad->input_dev;
+
+	if (delta == 0)
+		return;
+
+	if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
+		int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
+					    keypad->rotary_down_key[r];
+
+		/* simulate a press-n-release */
+		input_report_key(dev, keycode, 1);
+		input_sync(dev);
+		input_report_key(dev, keycode, 0);
+		input_sync(dev);
+	} else {
+		input_report_rel(dev, keypad->rotary_rel_code[r], delta);
+		input_sync(dev);
+	}
+}
+
+static void pxa27x_keypad_scan_rotary(struct pxa27x_keypad *keypad)
+{
+	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	uint32_t kprec;
+
+	/* read and reset to default count value */
+	kprec = KPREC;
+	KPREC = DEFAULT_KPREC;
+
+	if (pdata->enable_rotary0)
+		report_rotary_event(keypad, 0, rotary_delta(kprec));
+
+	if (pdata->enable_rotary1)
+		report_rotary_event(keypad, 1, rotary_delta(kprec >> 16));
+}
+
+static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
+{
+	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int new_state;
+	uint32_t kpdk, bits_changed;
+	int i;
+
+	kpdk = KPDK;
+
+	if (pdata->enable_rotary0 || pdata->enable_rotary1)
+		pxa27x_keypad_scan_rotary(keypad);
+
+	if (pdata->direct_key_map == NULL)
+		return;
+
+	new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
+	bits_changed = keypad->direct_key_state ^ new_state;
+
+	if (bits_changed == 0)
+		return;
+
+	for (i = 0; i < pdata->direct_key_num; i++) {
+		if (bits_changed & (1 << i))
+			input_report_key(keypad->input_dev,
+					pdata->direct_key_map[i],
+					(new_state & (1 << i)));
+	}
+	input_sync(keypad->input_dev);
+	keypad->direct_key_state = new_state;
+}
+
 static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct pxa27x_keypad *keypad = dev_id;
-	struct input_dev *input_dev = keypad->input_dev;
 	unsigned long kpc = KPC;
-	int rel;
-
-	if (kpc & KPC_DI) {
-		unsigned long kpdk = KPDK;
-
-		if (!(kpdk & KPDK_DKP)) {
-			/* better luck next time */
-		} else if (kpc & KPC_REE0) {
-			unsigned long kprec = KPREC;
-			KPREC = 0x7f;
-
-			if (kprec & KPREC_OF0)
-				rel = (kprec & 0xff) + 0x7f;
-			else if (kprec & KPREC_UF0)
-				rel = (kprec & 0xff) - 0x7f - 0xff;
-			else
-				rel = (kprec & 0xff) - 0x7f;
-
-			if (rel) {
-				input_report_rel(input_dev, REL_WHEEL, rel);
-				input_sync(input_dev);
-			}
-		}
-	}
+
+	if (kpc & KPC_DI)
+		pxa27x_keypad_scan_direct(keypad);

 	if (kpc & KPC_MI)
 		pxa27x_keypad_scan_matrix(keypad);
@@ -190,6 +276,7 @@ static irqreturn_t pxa27x_keypad_irq_handler(int
irq, void *dev_id)
 static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 {
 	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int mask = 0, direct_key_num = 0;
 	unsigned long kpc = 0;

 	/* enable matrix keys with automatic scan */
@@ -199,10 +286,29 @@ static void pxa27x_keypad_config(struct
pxa27x_keypad *keypad)
 		       KPC_MKCN(pdata->matrix_key_cols);
 	}

-	/* FIXME: hardcoded to enable rotary 0 _only_ */
-	kpc |= KPC_DKN(2) | KPC_REE0 | KPC_DI | KPC_DIE;
+	/* enable rotary key, debounce interval same as direct keys */
+	if (pdata->enable_rotary0) {
+		mask |= 0x03;
+		direct_key_num = 2;
+		kpc |= KPC_REE0;
+	}
+
+	if (pdata->enable_rotary1) {
+		mask |= 0x0c;
+		direct_key_num = 4;
+		kpc |= KPC_REE1;
+	}
+
+	if (pdata->direct_key_num > direct_key_num)
+		direct_key_num = pdata->direct_key_num;
+
+	keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
+
+	/* enable direct key */
+	if (direct_key_num)
+		kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);

-	KPC = kpc;
+	KPC = kpc | KPC_RE_ZERO_DEB;
 	KPREC = DEFAULT_KPREC;
 }

@@ -301,7 +407,6 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)

 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
 		BIT_MASK(EV_REL);
-	input_dev->relbit[BIT_WORD(REL_WHEEL)] = BIT_MASK(REL_WHEEL);

 	pxa27x_keypad_build_keycode(keypad);

diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
index 23f4ebc..6b83232 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -6,6 +6,20 @@
 #define MAX_MATRIX_KEY_ROWS	(8)
 #define MAX_MATRIX_KEY_COLS	(8)

+/* pxa3xx keypad platform specific parameters
+ *
+ * NOTE:
+ * 1. direct_key_num indicates the number of keys in the direct keypad
+ *    _plus_ the number of rotary-encoder sensor inputs,  this can be
+ *    left as 0 if only rotary encoders are enabled,  the driver will
+ *    automatically calculate this
+ *
+ * 2. direct_key_map is the key code map for the direct keys, if rotary
+ *    encoder(s) are enabled, direct key 0/1(2/3) will be ignored
+ *
+ * 3. rotary can be either interpreted as a relative input event (e.g.
+ *    REL_WHEEL/REL_HWHEEL) or specific keys (e.g. UP/DOWN/LEFT/RIGHT)
+ */
 struct pxa27x_keypad_platform_data {

 	/* code map for the matrix keys */
@@ -13,6 +27,22 @@ struct pxa27x_keypad_platform_data {
 	unsigned int	matrix_key_cols;
 	unsigned int	*matrix_key_map;
 	int		matrix_key_map_size;
+
+	/* direct keys */
+	int		direct_key_num;
+	unsigned int	direct_key_map[8];
+
+	/* rotary encoders 0 */
+	int		enable_rotary0;
+	int		rotary0_rel_code;
+	int		rotary0_up_key;
+	int		rotary0_down_key;
+
+	/* rotary encoders 1 */
+	int		enable_rotary1;
+	int		rotary1_rel_code;
+	int		rotary1_up_key;
+	int		rotary1_down_key;
 };

 #define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
