From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 08/12] ASoC: wm9713: add ac97 new bus support
Date: Fri, 30 Jun 2017 21:44:04 +0200
Message-ID: <20170630194408.24978-9-robert.jarzmik@free.fr>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:27670 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdF3Tr7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Jun 2017 15:47:59 -0400
In-Reply-To: <20170630194408.24978-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9713.c | 39 +++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e49e9da7f1f6..aebf148d7e4d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -207,7 +207,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9090 if I2C
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
-	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -1091,6 +1091,7 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 # Amp
 config SND_SOC_LM4857
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7e4822185feb..3df2c01d751d 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -17,12 +17,15 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/mfd/wm97xx.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
@@ -38,6 +41,7 @@ struct wm9713_priv {
 	u32 pll_in; /* PLL input frequency */
 	unsigned int hp_mixer[2];
 	struct mutex lock;
+	struct wm97xx_platform_data *mfd_pdata;
 };
 
 #define HPL_MIXER 0
@@ -1205,17 +1209,23 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	struct regmap *regmap;
+	struct regmap *regmap = NULL;
 
-	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
-		WM9713_VENDOR_ID_MASK);
-	if (IS_ERR(wm9713->ac97))
-		return PTR_ERR(wm9713->ac97);
-
-	regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
-	if (IS_ERR(regmap)) {
-		snd_soc_free_ac97_codec(wm9713->ac97);
-		return PTR_ERR(regmap);
+	if (wm9713->mfd_pdata) {
+		wm9713->ac97 = wm9713->mfd_pdata->ac97;
+		regmap = wm9713->mfd_pdata->regmap;
+	} else {
+#ifdef CONFIG_SND_SOC_AC97_BUS
+		wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
+						      WM9713_VENDOR_ID_MASK);
+		if (IS_ERR(wm9713->ac97))
+			return PTR_ERR(wm9713->ac97);
+		regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+		if (IS_ERR(regmap)) {
+			snd_soc_free_ac97_codec(wm9713->ac97);
+			return PTR_ERR(regmap);
+		}
+#endif
 	}
 
 	snd_soc_codec_init_regmap(codec, regmap);
@@ -1230,8 +1240,12 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9713->ac97);
+	if (!wm9713->mfd_pdata) {
+		snd_soc_codec_exit_regmap(codec);
+#ifdef CONFIG_SND_SOC_AC97_BUS
+		snd_soc_free_ac97_codec(wm9713->ac97);
+#endif
+	}
 	return 0;
 }
 
@@ -1262,6 +1276,7 @@ static int wm9713_probe(struct platform_device *pdev)
 
 	mutex_init(&wm9713->lock);
 
+	wm9713->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9713);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.11.0

