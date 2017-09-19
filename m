From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: add ac97 new bus support" to the asoc tree
Date: Tue, 19 Sep 2017 17:11:10 +0100
Message-ID: <E1duL78-0004iD-D7@debutante>
References: <20170913193723.16234-6-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170913193723.16234-6-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

The patch

   ASoC: wm9712: add ac97 new bus support

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

>From 2ed1a8e0ce8db6d36f849526db61ce3c85a9f8d1 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 13 Sep 2017 21:37:20 +0200
Subject: [PATCH] ASoC: wm9712: add ac97 new bus support

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9712.c | 44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 807901cac1b3..655388d456be 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -215,7 +215,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9081 if I2C
 	select SND_SOC_WM9090 if I2C
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
-	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
           Normally ASoC codec drivers are only built if a machine driver which
@@ -1132,6 +1132,7 @@ config SND_SOC_WM9705
 config SND_SOC_WM9712
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1a3e1797994a..1e228bf9f1ae 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -12,6 +12,7 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/mfd/wm97xx.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -19,6 +20,8 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
@@ -30,6 +33,7 @@ struct wm9712_priv {
 	struct snd_ac97 *ac97;
 	unsigned int hp_mixer[2];
 	struct mutex lock;
+	struct wm97xx_platform_data *mfd_pdata;
 };
 
 static const struct reg_default wm9712_reg_defaults[] = {
@@ -636,18 +640,25 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	struct regmap *regmap;
 	int ret;
 
-	wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
-		WM9712_VENDOR_ID_MASK);
-	if (IS_ERR(wm9712->ac97)) {
-		ret = PTR_ERR(wm9712->ac97);
-		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
-		return ret;
-	}
-
-	regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		goto err_free_ac97_codec;
+	if (wm9712->mfd_pdata) {
+		wm9712->ac97 = wm9712->mfd_pdata->ac97;
+		regmap = wm9712->mfd_pdata->regmap;
+	} else {
+#ifdef CONFIG_SND_SOC_AC97_BUS
+		wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
+						      WM9712_VENDOR_ID_MASK);
+		if (IS_ERR(wm9712->ac97)) {
+			ret = PTR_ERR(wm9712->ac97);
+			dev_err(codec->dev,
+				"Failed to register AC97 codec: %d\n", ret);
+			return ret;
+		}
+
+		regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
+		if (IS_ERR(regmap)) {
+			ret = PTR_ERR(regmap);
+			goto err_free_ac97_codec;
+#endif
 	}
 
 	snd_soc_codec_init_regmap(codec, regmap);
@@ -663,10 +674,14 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9712->ac97);
+	if (!wm9712->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
+		snd_soc_free_ac97_codec(wm9712->ac97);
+	}
+#endif
 	return 0;
 }
 
@@ -697,6 +712,7 @@ static int wm9712_probe(struct platform_device *pdev)
 
 	mutex_init(&wm9712->lock);
 
+	wm9712->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9712);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.14.1
