From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bitmap update for sh_keysc V2
Date: Wed, 10 Feb 2010 01:26:50 -0800
Message-ID: <20100210092650.GA28229@core.coreip.homeip.net>
References: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
 <20100209093954.GC12642@core.coreip.homeip.net>
 <aec7e5c31002092013y615cb624x78a9d5fad126b3ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:50296 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0BJJ05 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 04:26:57 -0500
Content-Disposition: inline
In-Reply-To: <aec7e5c31002092013y615cb624x78a9d5fad126b3ec@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wed, Feb 10, 2010 at 01:13:37PM +0900, Magnus Damm wrote:
> On Tue, Feb 9, 2010 at 6:39 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Feb 09, 2010 at 06:16:09PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Update the sh_keysc driver with proper bitmap support V2.
> >> This instead of using a fixed 32-bit integer to keep track
> >> for the key states. With this change in place the driver
> >> supports key pads with more than 32 keys.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >> =A0Changes since V1:
> >> =A0- ditched the wrapping macros
> >> =A0- use __set_bit() and __clear_bit()
> >
> > Thank you for making the change. It indeed is easier to read than t=
he
> > original since one does not have to go and look up what wrappers ar=
e
> > doing.
>=20
> Yeah, I initially disliked the SH_KEYSC_MAXKEYS that now are sprinkle=
d
> all over the place, but I have to admit that not using wrappers made
> me realize that I should use __set_bit() and __clear_bit() instead of
> the atomic ones. So all good.
>=20

BTW, that sh_keysc_map seems to be a holdover from the V1 of the patch
and is not needed anymore. Does the patch below still work for you?

Thanks!

--=20
Dmitry


Input: sh_keysc - switch to using bitmaps

=46rom: Magnus Damm <damm@opensource.se>

Use bitmaps instead of using 32-bit integers to keep track of the key
states. With this change in place the driver supports key pads with
more than 32 keys.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/sh_keysc.c |   69 ++++++++++++++++++++++++-----=
--------
 1 files changed, 44 insertions(+), 25 deletions(-)


diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard=
/sh_keysc.c
index 6218b2f..c2fc977 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/io.h>
=20
@@ -35,7 +36,7 @@ static const struct {
 struct sh_keysc_priv {
 	void __iomem *iomem_base;
 	struct clk *clk;
-	unsigned long last_keys;
+	DECLARE_BITMAP(last_keys, SH_KEYSC_MAXKEYS);
 	struct input_dev *input;
 	struct sh_keysc_info pdata;
 };
@@ -71,69 +72,87 @@ static void sh_keysc_level_mode(struct sh_keysc_pri=
v *p,
 		udelay(pdata->kycr2_delay);
 }
=20
+static void sh_keysc_map_dbg(struct device *dev, unsigned long *map,
+			     const char *str)
+{
+	int k;
+
+	for (k =3D 0; k < BITS_TO_LONGS(SH_KEYSC_MAXKEYS); k++)
+		dev_dbg(dev, "%s[%d] 0x%lx\n", str, k, map[k]);
+}
+
 static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 {
 	struct platform_device *pdev =3D dev_id;
 	struct sh_keysc_priv *priv =3D platform_get_drvdata(pdev);
 	struct sh_keysc_info *pdata =3D &priv->pdata;
-	unsigned long keys, keys1, keys0, mask;
+	int keyout_nr =3D sh_keysc_mode[pdata->mode].keyout;
+	int keyin_nr =3D sh_keysc_mode[pdata->mode].keyin;
+	DECLARE_BITMAP(keys, SH_KEYSC_MAXKEYS);
+	DECLARE_BITMAP(keys0, SH_KEYSC_MAXKEYS);
+	DECLARE_BITMAP(keys1, SH_KEYSC_MAXKEYS);
 	unsigned char keyin_set, tmp;
-	int i, k;
+	int i, k, n;
=20
 	dev_dbg(&pdev->dev, "isr!\n");
=20
-	keys1 =3D ~0;
-	keys0 =3D 0;
+	bitmap_fill(keys1, SH_KEYSC_MAXKEYS);
+	bitmap_zero(keys0, SH_KEYSC_MAXKEYS);
=20
 	do {
-		keys =3D 0;
+		bitmap_zero(keys, SH_KEYSC_MAXKEYS);
 		keyin_set =3D 0;
=20
 		sh_keysc_write(priv, KYCR2, KYCR2_IRQ_DISABLED);
=20
-		for (i =3D 0; i < sh_keysc_mode[pdata->mode].keyout; i++) {
+		for (i =3D 0; i < keyout_nr; i++) {
+			n =3D keyin_nr * i;
+
+			/* drive one KEYOUT pin low, read KEYIN pins */
 			sh_keysc_write(priv, KYOUTDR, 0xfff ^ (3 << (i * 2)));
 			udelay(pdata->delay);
 			tmp =3D sh_keysc_read(priv, KYINDR);
=20
-			keys |=3D tmp << (sh_keysc_mode[pdata->mode].keyin * i);
-			tmp ^=3D (1 << sh_keysc_mode[pdata->mode].keyin) - 1;
-			keyin_set |=3D tmp;
+			/* set bit if key press has been detected */
+			for (k =3D 0; k < keyin_nr; k++) {
+				if (tmp & (1 << k))
+					__set_bit(n + k, keys);
+			}
+
+			/* keep track of which KEYIN bits that have been set */
+			keyin_set |=3D tmp ^ ((1 << keyin_nr) - 1);
 		}
=20
 		sh_keysc_level_mode(priv, keyin_set);
=20
-		keys ^=3D ~0;
-		keys &=3D (1 << (sh_keysc_mode[pdata->mode].keyin *
-			       sh_keysc_mode[pdata->mode].keyout)) - 1;
-		keys1 &=3D keys;
-		keys0 |=3D keys;
+		bitmap_complement(keys, keys, SH_KEYSC_MAXKEYS);
+		bitmap_and(keys1, keys1, keys, SH_KEYSC_MAXKEYS);
+		bitmap_or(keys0, keys0, keys, SH_KEYSC_MAXKEYS);
=20
-		dev_dbg(&pdev->dev, "keys 0x%08lx\n", keys);
+		sh_keysc_map_dbg(&pdev->dev, keys, "keys");
=20
 	} while (sh_keysc_read(priv, KYCR2) & 0x01);
=20
-	dev_dbg(&pdev->dev, "last_keys 0x%08lx keys0 0x%08lx keys1 0x%08lx\n"=
,
-		priv->last_keys, keys0, keys1);
+	sh_keysc_map_dbg(&pdev->dev, priv->last_keys, "last_keys");
+	sh_keysc_map_dbg(&pdev->dev, keys0, "keys0");
+	sh_keysc_map_dbg(&pdev->dev, keys1, "keys1");
=20
 	for (i =3D 0; i < SH_KEYSC_MAXKEYS; i++) {
 		k =3D pdata->keycodes[i];
 		if (!k)
 			continue;
=20
-		mask =3D 1 << i;
-
-		if (!((priv->last_keys ^ keys0) & mask))
+		if (test_bit(i, keys0) =3D=3D test_bit(i, priv->last_keys))
 			continue;
=20
-		if ((keys1 | keys0) & mask) {
+		if (test_bit(i, keys1) || test_bit(i, keys0)) {
 			input_event(priv->input, EV_KEY, k, 1);
-			priv->last_keys |=3D mask;
+			__set_bit(i, priv->last_keys);
 		}
=20
-		if (!(keys1 & mask)) {
+		if (!test_bit(i, keys1)) {
 			input_event(priv->input, EV_KEY, k, 0);
-			priv->last_keys &=3D ~mask;
+			__clear_bit(i, priv->last_keys);
 		}
=20
 	}
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
