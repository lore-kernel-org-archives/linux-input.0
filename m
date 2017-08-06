From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 09/12] ASoC: wm9712: add ac97 new bus support
Date: Sun,  6 Aug 2017 23:36:10 +0200
Message-ID: <20170806213613.5600-10-robert.jarzmik@free.fr>
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806213613.5600-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v4:
 - added #ifdef spotted by Charles
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9712.c | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index aebf148d7e4d..f17af3592785 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -206,7 +206,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9081 if I2C
 	select SND_SOC_WM9090 if I2C
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
-	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
           Normally ASoC codec drivers are only built if a machine driver which
@@ -1087,6 +1087,7 @@ config SND_SOC_WM9705
 config SND_SOC_WM9712
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1a3e1797994a..7ebbb48b18c5 100644
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
@@ -666,7 +677,8 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 
 	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9712->ac97);
+	if (!wm9712->mfd_pdata)
+		snd_soc_free_ac97_codec(wm9712->ac97);
 	return 0;
 }
 
@@ -697,6 +709,7 @@ static int wm9712_probe(struct platform_device *pdev)
 
 	mutex_init(&wm9712->lock);
 
+	wm9712->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9712);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.11.0
