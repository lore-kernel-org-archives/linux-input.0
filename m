From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Use component pin control functions" to the asoc tree
Date: Wed, 30 Nov 2016 18:07:37 +0000
Message-ID: <E1cC9I9-0008Fj-G3@debutante>
References: <1480434282-26389-3-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480434282-26389-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, myungjoo.ham@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The patch

   ASoC: arizona: Use component pin control functions

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

>From 35f4403edb21d8b162beb3ab82b2087f4063f19d Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 15:44:39 +0000
Subject: [PATCH] ASoC: arizona: Use component pin control functions

We need to modify the state of some of our own pins and are currently
not taking account that the pin name may have a name_prefix applied
to it.

Replace the snd_soc_dapm_x_pin functions with the equivalent
snd_soc_component_x_pin functions so that any name_prefix will be
handled automatically.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 12 ++++++++----
 sound/soc/codecs/cs47l24.c |  3 ++-
 sound/soc/codecs/wm5102.c  |  3 ++-
 sound/soc/codecs/wm5110.c  |  3 ++-
 sound/soc/codecs/wm8997.c  |  3 ++-
 sound/soc/codecs/wm8998.c  |  3 ++-
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ca5ca9eac272..0a734d910850 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -257,6 +257,7 @@ EXPORT_SYMBOL_GPL(arizona_init_mono);
 int arizona_init_gpio(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	int i;
@@ -264,21 +265,24 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 	switch (arizona->type) {
 	case WM5110:
 	case WM8280:
-		snd_soc_dapm_disable_pin(dapm, "DRC2 Signal Activity");
+		snd_soc_component_disable_pin(component,
+					      "DRC2 Signal Activity");
 		break;
 	default:
 		break;
 	}
 
-	snd_soc_dapm_disable_pin(dapm, "DRC1 Signal Activity");
+	snd_soc_component_disable_pin(component, "DRC1 Signal Activity");
 
 	for (i = 0; i < ARRAY_SIZE(arizona->pdata.gpio_defaults); i++) {
 		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
 		case ARIZONA_GP_FN_DRC1_SIGNAL_DETECT:
-			snd_soc_dapm_enable_pin(dapm, "DRC1 Signal Activity");
+			snd_soc_component_enable_pin(component,
+						     "DRC1 Signal Activity");
 			break;
 		case ARIZONA_GP_FN_DRC2_SIGNAL_DETECT:
-			snd_soc_dapm_enable_pin(dapm, "DRC2 Signal Activity");
+			snd_soc_component_enable_pin(component,
+						     "DRC2 Signal Activity");
 			break;
 		default:
 			break;
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 1ed1329c31cc..73559ae864b6 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1115,6 +1115,7 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -1138,7 +1139,7 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err_adsp2_codec_probe;
 
-	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
+	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	return 0;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 72ff291a85be..e7ab37d0dd32 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1931,6 +1931,7 @@ static irqreturn_t wm5102_adsp2_irq(int irq, void *data)
 static int wm5102_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -1947,7 +1948,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
-	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
+	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	priv->core.arizona->dapm = dapm;
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index a9a8bc98fb29..585fc706c1b0 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2273,6 +2273,7 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 
@@ -2295,7 +2296,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err_adsp2_codec_probe;
 
-	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
+	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	return 0;
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index ea8b1bfdf5a0..ee0c8639c743 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1060,12 +1060,13 @@ static struct snd_soc_dai_driver wm8997_dai[] = {
 static int wm8997_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
 
 	arizona_init_spk(codec);
 	arizona_init_notifiers(codec);
 
-	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
+	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	priv->core.arizona->dapm = dapm;
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 1e1d9c1f0371..3694f5958d86 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1320,6 +1320,7 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8998_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 
 	priv->core.arizona->dapm = dapm;
 
@@ -1327,7 +1328,7 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
-	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
+	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	return 0;
 }
-- 
2.10.2
