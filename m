From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/03] input: bitmap update for sh_keysc
Date: Mon, 08 Feb 2010 15:32:34 +0900
Message-ID: <20100208063234.2003.7539.sendpatchset@rxone.opensource.se>
References: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh_keysc driver with proper bitmap support
instead of using a fixed 32-bit integer to keep track
for the key states. This allows the driver to support
key pads with more than 32 keys.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |   83 +++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 25 deletions(-)

--- 0005/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2010-02-05 13:13:24.000000000 +0900
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
@@ -71,69 +76,97 @@ static void sh_keysc_level_mode(struct s
 		udelay(pdata->kycr2_delay);
 }
 
+#define WRAP(fn, m...) bitmap_##fn(m, SH_KEYSC_MAXKEYS)
+#define sh_keysc_map_zero(m) WRAP(zero, (m)->b)
+#define sh_keysc_map_fill(m) WRAP(fill, (m)->b)
+#define sh_keysc_map_and(m, m2) WRAP(and, (m)->b, (m)->b, (m2)->b)
+#define sh_keysc_map_or(m, m2) WRAP(or, (m)->b, (m)->b, (m2)->b)
+#define sh_keysc_map_complement(m) WRAP(complement, (m)->b, (m)->b)
+#define sh_keysc_map_set(m, n) set_bit((n), (m)->b)
+#define sh_keysc_map_clear(m, n) clear_bit((n), (m)->b)
+#define sh_keysc_map_test(m, n) test_bit((n), (m)->b)
+
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
+	sh_keysc_map_fill(&keys1);
+	sh_keysc_map_zero(&keys0);
 
 	do {
-		keys = 0;
+		sh_keysc_map_zero(&keys);
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
+					sh_keysc_map_set(&keys, n + k);
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
+		sh_keysc_map_complement(&keys);
+		sh_keysc_map_and(&keys1, &keys);
+		sh_keysc_map_or(&keys0, &keys);
 
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
+		if (sh_keysc_map_test(&keys0, i) ==
+		    sh_keysc_map_test(&priv->last_keys, i))
 			continue;
 
-		if ((keys1 | keys0) & mask) {
+		if (sh_keysc_map_test(&keys1, i) ||
+		    sh_keysc_map_test(&keys0, i)) {
 			input_event(priv->input, EV_KEY, k, 1);
-			priv->last_keys |= mask;
+			sh_keysc_map_set(&priv->last_keys, i);
 		}
 
-		if (!(keys1 & mask)) {
+		if (!sh_keysc_map_test(&keys1, i)) {
 			input_event(priv->input, EV_KEY, k, 0);
-			priv->last_keys &= ~mask;
+			sh_keysc_map_clear(&priv->last_keys, i);
 		}
 
 	}
