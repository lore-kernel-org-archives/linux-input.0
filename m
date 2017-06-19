From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 09/12] ASoC: wm9705: add private structure
Date: Mon, 19 Jun 2017 09:27:06 +0200
Message-ID: <1497857229-12049-10-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Add a private data structure. This is a preparation for a codec which
would need an another data on top of snd_ac97, which will be the case
when an MFD wm97xx device will probe wm9705.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/wm9705.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index f6d5c0f2aea5..08477d040028 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -24,6 +24,10 @@
 #define WM9705_VENDOR_ID 0x574d4c05
 #define WM9705_VENDOR_ID_MASK 0xffffffff
 
+struct wm9705_priv {
+	struct snd_ac97 *ac97;
+};
+
 static const struct reg_default wm9705_reg_defaults[] = {
 	{ 0x02, 0x8000 },
 	{ 0x04, 0x8000 },
@@ -292,10 +296,10 @@ static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 
 static int wm9705_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_ac97_reset(ac97, true, WM9705_VENDOR_ID,
+	ret = snd_ac97_reset(wm9705->ac97, true, WM9705_VENDOR_ID,
 		WM9705_VENDOR_ID_MASK);
 	if (ret < 0)
 		return ret;
@@ -311,38 +315,38 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 
 static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97;
+	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
 	int ret;
 
-	ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
-		WM9705_VENDOR_ID_MASK);
-	if (IS_ERR(ac97)) {
+	wm9705->ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
+					      WM9705_VENDOR_ID_MASK);
+	if (IS_ERR(wm9705->ac97)) {
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
-		return PTR_ERR(ac97);
+		return PTR_ERR(wm9705->ac97);
 	}
 
-	regmap = regmap_init_ac97(ac97, &wm9705_regmap_config);
+	regmap = regmap_init_ac97(wm9705->ac97, &wm9705_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		goto err_free_ac97_codec;
 	}
 
-	snd_soc_codec_set_drvdata(codec, ac97);
+	snd_soc_codec_set_drvdata(codec, wm9705->ac97);
 	snd_soc_codec_init_regmap(codec, regmap);
 
 	return 0;
 err_free_ac97_codec:
-	snd_soc_free_ac97_codec(ac97);
+	snd_soc_free_ac97_codec(wm9705->ac97);
 	return ret;
 }
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 
 	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(ac97);
+	snd_soc_free_ac97_codec(wm9705->ac97);
 	return 0;
 }
 
@@ -364,6 +368,14 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 
 static int wm9705_probe(struct platform_device *pdev)
 {
+	struct wm9705_priv *wm9705;
+
+	wm9705 = devm_kzalloc(&pdev->dev, sizeof(*wm9705), GFP_KERNEL);
+	if (wm9705 == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wm9705);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
 }
-- 
2.1.4
