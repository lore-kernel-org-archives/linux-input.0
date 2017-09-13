From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v7 6/8] ASoC: wm9705: add private structure
Date: Wed, 13 Sep 2017 21:37:21 +0200
Message-ID: <20170913193723.16234-7-robert.jarzmik@free.fr>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50231 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbdIMTh7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 15:37:59 -0400
In-Reply-To: <20170913193723.16234-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Add a private data structure. This is a preparation for a codec which
would need an another data on top of snd_ac97, which will be the case
when an MFD wm97xx device will probe wm9705.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
2.11.0

