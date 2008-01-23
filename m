From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 4/12] pxa: introduce pxa27x_keypad_config() for keypad registers configuration
Date: Wed, 23 Jan 2008 15:25:21 +0800
Message-ID: <f17812d70801222325l4a93ed69g102165c89faafeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:51210 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAWHZW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:25:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4884191wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:25:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From cd5025c1ae9158ef876bb1e8b8d2afa9824ca9dd Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 09:41:27 +0800
Subject: [PATCH] pxa: introduce pxa27x_keypad_config() for keypad
registers configuration

and remove the reg_kpc, reg_kprec from platform data structure

1. so that configurations to keypad registers can be centralized to
   a single function

2. this can be re-used when resuming

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c   |   60 ++++++++++++++----------------
 include/asm-arm/arch-pxa/pxa27x_keypad.h |    5 --
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
index 8de35b0..e9d4e22 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -37,6 +37,10 @@

 #define DRIVER_NAME		"pxa27x-keypad"

+#define KPC_MKRN(n)	((((n) & 0x7) - 1) << 26) /* matrix key row number */
+#define KPC_MKCN(n)	((((n) & 0x7) - 1) << 23) /* matrix key column number */
+#define KPC_DKN(n)	((((n) & 0x7) - 1) << 6)  /* direct key number */
+
 #define KPAS_MUKP(n)		(((n) >> 26) & 0x1f)
 #define KPAS_RP(n)		(((n) >> 4) & 0xf)
 #define KPAS_CP(n)		((n) & 0xf)
@@ -145,6 +149,8 @@ scan:
 	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
 }

+#define DEFAULT_KPREC	(0x007f007f)
+
 static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct pxa27x_keypad *keypad = dev_id;
@@ -181,24 +187,32 @@ static irqreturn_t pxa27x_keypad_irq_handler(int
irq, void *dev_id)
 	return IRQ_HANDLED;
 }

-static int pxa27x_keypad_open(struct input_dev *dev)
+static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 {
-	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
+	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	unsigned long kpc = 0;

-	/* Set keypad control register */
-	KPC |= (KPC_ASACT |
-		KPC_MS_ALL |
-		(2 << 6) | KPC_REE0 | KPC_DK_DEB_SEL |
-		KPC_ME | KPC_MIE | KPC_DE | KPC_DIE);
+	/* enable matrix keys with automatic scan */
+	if (pdata->matrix_key_rows && pdata->matrix_key_cols) {
+		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
+		kpc |= KPC_MKRN(pdata->matrix_key_rows) |
+		       KPC_MKCN(pdata->matrix_key_cols);
+	}

-	KPC &= ~KPC_AS;         /* disable automatic scan */
-	KPC &= ~KPC_IMKP;       /* do not ignore multiple keypresses */
+	/* FIXME: hardcoded to enable rotary 0 _only_ */
+	kpc |= KPC_DKN(2) | KPC_REE0 | KPC_DI | KPC_DIE;

-	/* Set rotary count to mid-point value */
-	KPREC = 0x7F;
+	KPC = kpc;
+	KPREC = DEFAULT_KPREC;
+}
+
+static int pxa27x_keypad_open(struct input_dev *dev)
+{
+	struct pxa27x_keypad *keypad = input_get_drvdata(dev);

 	/* Enable unit clock */
 	clk_enable(keypad->clk);
+	pxa27x_keypad_config(keypad);

 	return 0;
 }
@@ -215,30 +229,22 @@ static void pxa27x_keypad_close(struct input_dev *dev)
 static int pxa27x_keypad_suspend(struct platform_device *pdev,
pm_message_t state)
 {
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
-	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
-
-	/* Save controller status */
-	pdata->reg_kpc = KPC;
-	pdata->reg_kprec = KPREC;

+	clk_disable(keypad->clk);
 	return 0;
 }

 static int pxa27x_keypad_resume(struct platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
-	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
 	struct input_dev *input_dev = keypad->input_dev;

 	mutex_lock(&input_dev->mutex);

 	if (input_dev->users) {
-		/* Restore controller status */
-		KPC = pdata->reg_kpc;
-		KPREC = pdata->reg_kprec;
-
 		/* Enable unit clock */
 		clk_enable(keypad->clk);
+		pxa27x_keypad_config(keypad);
 	}

 	mutex_unlock(&input_dev->mutex);
@@ -254,7 +260,7 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad;
 	struct input_dev *input_dev;
-	int col, error;
+	int error;

 	keypad = kzalloc(sizeof(struct pxa27x_keypad), GFP_KERNEL);
 	if (keypad == NULL) {
@@ -313,16 +319,6 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 	if (error)
 		goto err_free_irq;

-	/*
-	 * Store rows/cols info into keyboard registers.
-	 */
-
-	KPC |= (keypad->pdata->matrix_key_rows - 1) << 26;
-	KPC |= (keypad->pdata->matrix_key_cols - 1) << 23;
-
-	for (col = 0; col < keypad->pdata->matrix_key_cols; col++)
-		KPC |= KPC_MS0 << col;
-
 	return 0;

  err_free_irq:
diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
index 1b1bf9f..23f4ebc 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -13,11 +13,6 @@ struct pxa27x_keypad_platform_data {
 	unsigned int	matrix_key_cols;
 	unsigned int	*matrix_key_map;
 	int		matrix_key_map_size;
-
-#ifdef CONFIG_PM
-	u32 reg_kpc;
-	u32 reg_kprec;
-#endif
 };

 #define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
