From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9705: add ac97 new bus support" to the asoc tree
Date: Tue, 19 Sep 2017 17:11:04 +0100
Message-ID: <E1duL72-0004f6-0n@debutante>
References: <20170913193723.16234-8-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170913193723.16234-8-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

The patch

   ASoC: wm9705: add ac97 new bus support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aaafcfed9290349555a326fff1147460a54c34f2 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 13 Sep 2017 21:37:22 +0200
Subject: [PATCH] ASoC: wm9705: add ac97 new bus support

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9705.c | 42 +++++++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 655388d456be..0838ae710941 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -214,7 +214,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8998 if MFD_WM8998
 	select SND_SOC_WM9081 if I2C
 	select SND_SOC_WM9090 if I2C
-	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
@@ -1128,6 +1128,7 @@ config SND_SOC_WM9090
 config SND_SOC_WM9705
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 08477d040028..68c204e3599f 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/mfd/wm97xx.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -18,6 +19,8 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
 
@@ -26,6 +29,7 @@
 
 struct wm9705_priv {
 	struct snd_ac97 *ac97;
+	struct wm97xx_platform_data *mfd_pdata;
 };
 
 static const struct reg_default wm9705_reg_defaults[] = {
@@ -319,17 +323,24 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	struct regmap *regmap;
 	int ret;
 
-	wm9705->ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
-					      WM9705_VENDOR_ID_MASK);
-	if (IS_ERR(wm9705->ac97)) {
-		dev_err(codec->dev, "Failed to register AC97 codec\n");
-		return PTR_ERR(wm9705->ac97);
-	}
-
-	regmap = regmap_init_ac97(wm9705->ac97, &wm9705_regmap_config);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		goto err_free_ac97_codec;
+	if (wm9705->mfd_pdata) {
+		wm9705->ac97 = wm9705->mfd_pdata->ac97;
+		regmap = wm9705->mfd_pdata->regmap;
+	} else {
+#ifdef CONFIG_SND_SOC_AC97_BUS
+		wm9705->ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
+						      WM9705_VENDOR_ID_MASK);
+		if (IS_ERR(wm9705->ac97)) {
+			dev_err(codec->dev, "Failed to register AC97 codec\n");
+			return PTR_ERR(wm9705->ac97);
+		}
+
+		regmap = regmap_init_ac97(wm9705->ac97, &wm9705_regmap_config);
+		if (IS_ERR(regmap)) {
+			ret = PTR_ERR(regmap);
+			goto err_free_ac97_codec;
+		}
+#endif
 	}
 
 	snd_soc_codec_set_drvdata(codec, wm9705->ac97);
@@ -343,10 +354,14 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9705->ac97);
+	if (!wm9705->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
+		snd_soc_free_ac97_codec(wm9705->ac97);
+	}
+#endif
 	return 0;
 }
 
@@ -374,6 +389,7 @@ static int wm9705_probe(struct platform_device *pdev)
 	if (wm9705 == NULL)
 		return -ENOMEM;
 
+	wm9705->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9705);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.14.1
