From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 08/12] ASoC: wm9712: add ac97 new bus support
Date: Mon, 19 Jun 2017 09:27:05 +0200
Message-ID: <1497857229-12049-9-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9712.c | 37 ++++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 14 deletions(-)

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
index 1a3e1797994a..9031c58d9bb2 100644
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
@@ -636,18 +640,23 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
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
 	}
 
 	snd_soc_codec_init_regmap(codec, regmap);
@@ -666,7 +675,8 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 
 	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9712->ac97);
+	if (!wm9712->mfd_pdata)
+		snd_soc_free_ac97_codec(wm9712->ac97);
 	return 0;
 }
 
@@ -697,6 +707,7 @@ static int wm9712_probe(struct platform_device *pdev)
 
 	mutex_init(&wm9712->lock);
 
+	wm9712->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9712);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.1.4
