From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9705: add private structure" to the asoc tree
Date: Tue, 19 Sep 2017 17:11:07 +0100
Message-ID: <E1duL75-0004gs-9C@debutante>
References: <1497857229-12049-10-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497857229-12049-10-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

The patch

   ASoC: wm9705: add private structure

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

>From c6e46e52b7b3301dda529830226e578cf773151c Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 13 Sep 2017 21:37:21 +0200
Subject: [PATCH] ASoC: wm9705: add private structure

Add a private data structure. This is a preparation for a codec which
would need an another data on top of snd_ac97, which will be the case
when an MFD wm97xx device will probe wm9705.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
