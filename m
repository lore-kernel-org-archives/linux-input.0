From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 11/12] ASoC: wm9705: add ac97 new bus support
Date: Fri, 30 Jun 2017 21:44:07 +0200
Message-ID: <20170630194408.24978-12-robert.jarzmik@free.fr>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170630194408.24978-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/Kconfig  |  3 ++-
 sound/soc/codecs/wm9705.c | 35 +++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f17af3592785..1d69a1c1f896 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -205,7 +205,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8998 if MFD_WM8998
 	select SND_SOC_WM9081 if I2C
 	select SND_SOC_WM9090 if I2C
-	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
         help
@@ -1083,6 +1083,7 @@ config SND_SOC_WM9090
 config SND_SOC_WM9705
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 08477d040028..f3378da80eee 100644
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
@@ -319,17 +323,22 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
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
 	}
 
 	snd_soc_codec_set_drvdata(codec, wm9705->ac97);
@@ -346,7 +355,8 @@ static int wm9705_soc_remove(struct snd_soc_codec *codec)
 	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 
 	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9705->ac97);
+	if (!wm9705->mfd_pdata)
+		snd_soc_free_ac97_codec(wm9705->ac97);
 	return 0;
 }
 
@@ -374,6 +384,7 @@ static int wm9705_probe(struct platform_device *pdev)
 	if (wm9705 == NULL)
 		return -ENOMEM;
 
+	wm9705->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9705);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
2.11.0
