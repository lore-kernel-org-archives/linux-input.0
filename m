From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: bitmap update for sh_keysc V2
Date: Tue, 09 Feb 2010 18:16:09 +0900
Message-ID: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:62999 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0BIJWu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 04:22:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh_keysc driver with proper bitmap support V2.
This instead of using a fixed 32-bit integer to keep track
for the key states. With this change in place the driver
supports key pads with more than 32 keys.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - ditched the wrapping macros
 - use __set_bit() and __clear_bit()

 drivers/input/keyboard/sh_keysc.c |   71 +++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 25 deletions(-)

--- 0010/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2010-02-09 18:01:32.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -32,10 +33,14 @@ static const struct {
 	[SH_KEYSC_MODE_5] = { 4, 6, 7 },
 };
 
+struct sh_keysc_map {
+	DECLARE_BITMAP(b, SH_KEYSC_MAXKEYS);
+};
+
 struct sh_keysc_priv {
 	void __iomem *iomem_base;
 	struct clk *clk;
-	unsigned long last_keys;
+	struct sh_keysc_map last_keys;
 	struct input_dev *input;
 	struct sh_keysc_info pdata;
 };
@@ -71,69 +76,85 @@ static void sh_keysc_level_mode(struct s
 		udelay(pdata->kycr2_delay);
 }
 
+static void sh_keysc_map_dbg(struct device *dev, struct sh_keysc_map *map,
+			     const char *str)
+{
+	int k;
+
+	for (k = 0; k < BITS_TO_LONGS(SH_KEYSC_MAXKEYS); k++)
+		dev_dbg(dev, "%s[%d] 0x%lx\n", str, k, map->b[k]);
+}
+
 static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 	struct sh_keysc_info *pdata = &priv->pdata;
-	unsigned long keys, keys1, keys0, mask;
+	int keyout_nr = sh_keysc_mode[pdata->mode].keyout;
+	int keyin_nr = sh_keysc_mode[pdata->mode].keyin;
+	struct sh_keysc_map keys, keys1, keys0;
 	unsigned char keyin_set, tmp;
-	int i, k;
+	int i, k, n;
 
 	dev_dbg(&pdev->dev, "isr!\n");
 
-	keys1 = ~0;
-	keys0 = 0;
+	bitmap_fill(keys1.b, SH_KEYSC_MAXKEYS);
+	bitmap_zero(keys0.b, SH_KEYSC_MAXKEYS);
 
 	do {
-		keys = 0;
+		bitmap_zero(keys.b, SH_KEYSC_MAXKEYS);
 		keyin_set = 0;
 
 		sh_keysc_write(priv, KYCR2, KYCR2_IRQ_DISABLED);
 
-		for (i = 0; i < sh_keysc_mode[pdata->mode].keyout; i++) {
+		for (i = 0; i < keyout_nr; i++) {
+			n = keyin_nr * i;
+
+			/* drive one KEYOUT pin low, read KEYIN pins */
 			sh_keysc_write(priv, KYOUTDR, 0xfff ^ (3 << (i * 2)));
 			udelay(pdata->delay);
 			tmp = sh_keysc_read(priv, KYINDR);
 
-			keys |= tmp << (sh_keysc_mode[pdata->mode].keyin * i);
-			tmp ^= (1 << sh_keysc_mode[pdata->mode].keyin) - 1;
-			keyin_set |= tmp;
+			/* set bit if key press has been detected */
+			for (k = 0; k < keyin_nr; k++) {
+				if (tmp & (1 << k))
+					__set_bit(n + k, keys.b);
+			}
+
+			/* keep track of which KEYIN bits that have been set */
+			keyin_set |= tmp ^ ((1 << keyin_nr) - 1);
 		}
 
 		sh_keysc_level_mode(priv, keyin_set);
 
-		keys ^= ~0;
-		keys &= (1 << (sh_keysc_mode[pdata->mode].keyin *
-			       sh_keysc_mode[pdata->mode].keyout)) - 1;
-		keys1 &= keys;
-		keys0 |= keys;
+		bitmap_complement(keys.b, keys.b, SH_KEYSC_MAXKEYS);
+		bitmap_and(keys1.b, keys1.b, keys.b, SH_KEYSC_MAXKEYS);
+		bitmap_or(keys0.b, keys0.b, keys.b, SH_KEYSC_MAXKEYS);
 
-		dev_dbg(&pdev->dev, "keys 0x%08lx\n", keys);
+		sh_keysc_map_dbg(&pdev->dev, &keys, "keys");
 
 	} while (sh_keysc_read(priv, KYCR2) & 0x01);
 
-	dev_dbg(&pdev->dev, "last_keys 0x%08lx keys0 0x%08lx keys1 0x%08lx\n",
-		priv->last_keys, keys0, keys1);
+	sh_keysc_map_dbg(&pdev->dev, &priv->last_keys, "last_keys");
+	sh_keysc_map_dbg(&pdev->dev, &keys0, "keys0");
+	sh_keysc_map_dbg(&pdev->dev, &keys1, "keys1");
 
 	for (i = 0; i < SH_KEYSC_MAXKEYS; i++) {
 		k = pdata->keycodes[i];
 		if (!k)
 			continue;
 
-		mask = 1 << i;
-
-		if (!((priv->last_keys ^ keys0) & mask))
+		if (test_bit(i, keys0.b) == test_bit(i, priv->last_keys.b))
 			continue;
 
-		if ((keys1 | keys0) & mask) {
+		if (test_bit(i, keys1.b) || test_bit(i, keys0.b)) {
 			input_event(priv->input, EV_KEY, k, 1);
-			priv->last_keys |= mask;
+			__set_bit(i, priv->last_keys.b);
 		}
 
-		if (!(keys1 & mask)) {
+		if (!test_bit(i, keys1.b)) {
 			input_event(priv->input, EV_KEY, k, 0);
-			priv->last_keys &= ~mask;
+			__clear_bit(i, priv->last_keys.b);
 		}
 
 	}
