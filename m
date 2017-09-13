From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v7 0/8] AC97 device/driver model revamp
Date: Wed, 13 Sep 2017 21:37:15 +0200
Message-ID: <20170913193723.16234-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:28827 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdIMThw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 15:37:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Hi Lars, Mark, Charles, Lee,

This is a revision for Lee and Charles, only targetted at wm97xx-core changes
(second round) suggested by Lee and codecs remove path for Charles.

I removed the leading 4 patches as Mark has already scheduled them.

For easier spotting, I included in [1] the diff from the last serie.

As before Charles, I think your ack is not granted anymore for codecs, could you have a look please ?

Cheers.

--
Robert

Robert Jarzmik (8):
  Input: wm97xx: split out touchscreen registering
  mfd: wm97xx-core: core support for wm97xx Codec
  Input: wm97xx: add new AC97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: wm9712: add ac97 new bus support
  ASoC: wm9705: add private structure
  ASoC: wm9705: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 252 +++++++++++++++-------
 drivers/mfd/Kconfig                     |  14 ++
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 366 ++++++++++++++++++++++++++++++++
 include/linux/mfd/wm97xx.h              |  25 +++
 sound/arm/Kconfig                       |   1 -
 sound/soc/codecs/Kconfig                |   9 +-
 sound/soc/codecs/wm9705.c               |  66 ++++--
 sound/soc/codecs/wm9712.c               |  44 ++--
 sound/soc/codecs/wm9713.c               |  39 ++--
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  46 ++--
 13 files changed, 712 insertions(+), 158 deletions(-)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h

-- 
2.11.0

[1] Diff from the previous serie
---8>---
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index 66e477fffd43..4141ee52a70b 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -109,12 +109,8 @@ static const struct regmap_config wm9705_regmap_config = {
 };
 
 static struct mfd_cell wm9705_cells[] = {
-	{
-		.name = "wm9705-codec",
-	},
-	{
-		.name = "wm97xx-ts",
-	},
+	{ .name = "wm9705-codec", },
+	{ .name = "wm97xx-ts", },
 };
 
 static bool wm9712_volatile_reg(struct device *dev, unsigned int reg)
@@ -181,12 +177,8 @@ static const struct regmap_config wm9712_regmap_config = {
 };
 
 static struct mfd_cell wm9712_cells[] = {
-	{
-		.name = "wm9712-codec",
-	},
-	{
-		.name = "wm97xx-ts",
-	},
+	{ .name = "wm9712-codec", },
+	{ .name = "wm97xx-ts", },
 };
 
 static const struct reg_default wm9713_reg_defaults[] = {
@@ -256,12 +248,8 @@ static const struct regmap_config wm9713_regmap_config = {
 };
 
 static struct mfd_cell wm9713_cells[] = {
-	{
-		.name = "wm9713-codec",
-	},
-	{
-		.name = "wm97xx-ts",
-	},
+	{ .name = "wm9713-codec", },
+	{ .name = "wm97xx-ts", },
 };
 
 static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
@@ -270,7 +258,7 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 	const struct regmap_config *config;
 	struct wm97xx_platform_data *codec_pdata;
 	struct mfd_cell *cells;
-	int ret = 0, nb_cells, i;
+	int ret = -ENODEV, nb_cells, i;
 	struct wm97xx_pdata *pdata = snd_ac97_codec_get_platdata(adev);
 
 	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
@@ -309,7 +297,7 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 		nb_cells = ARRAY_SIZE(wm9713_cells);
 		break;
 	default:
-		config = NULL;
+		goto err_free_compat;
 	}
 
 	for (i = 0; i < nb_cells; i++) {
@@ -317,23 +305,22 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 		cells[i].pdata_size = sizeof(*codec_pdata);
 	}
 
-	if (config) {
-		codec_pdata->regmap =
-			devm_regmap_init_ac97(wm97xx->ac97, config);
-		if (IS_ERR(codec_pdata->regmap))
-			ret = PTR_ERR(codec_pdata->regmap);
-	} else {
-		ret = -ENODEV;
+	codec_pdata->regmap = devm_regmap_init_ac97(wm97xx->ac97, config);
+	if (IS_ERR(codec_pdata->regmap)) {
+		ret = PTR_ERR(codec_pdata->regmap);
+		goto err_free_compat;
 	}
 
-	if (!ret)
-		ret = devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE,
-					   cells, nb_cells, NULL, 0, NULL);
-
+	ret = devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE,
+				   cells, nb_cells, NULL, 0, NULL);
 	if (ret)
-		snd_ac97_compat_release(wm97xx->ac97);
+		goto err_free_compat;
 
 	return ret;
+
+err_free_compat:
+	snd_ac97_compat_release(wm97xx->ac97);
+	return ret;
 }
 
 static int wm97xx_ac97_remove(struct ac97_codec_device *adev)
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 46b5a77c53e4..68c204e3599f 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -354,11 +354,14 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	if (!wm9705->mfd_pdata)
+	if (!wm9705->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
 		snd_soc_free_ac97_codec(wm9705->ac97);
+	}
+#endif
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 7ebbb48b18c5..1e228bf9f1ae 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -674,11 +674,14 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	if (!wm9712->mfd_pdata)
+	if (!wm9712->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
 		snd_soc_free_ac97_codec(wm9712->ac97);
+	}
+#endif
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 3df2c01d751d..df7220656d98 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1238,14 +1238,14 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 
 static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
+#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
 	if (!wm9713->mfd_pdata) {
 		snd_soc_codec_exit_regmap(codec);
-#ifdef CONFIG_SND_SOC_AC97_BUS
 		snd_soc_free_ac97_codec(wm9713->ac97);
-#endif
 	}
+#endif
 	return 0;
 }
 
