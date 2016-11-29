From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 2/5] ASoC: arizona: Use component pin control functions
Date: Tue, 29 Nov 2016 15:44:39 +0000
Message-ID: <1480434282-26389-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35381 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757467AbcK2Poy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 10:44:54 -0500
In-Reply-To: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

We need to modify the state of some of our own pins and are currently
not taking account that the pin name may have a name_prefix applied
to it.

Replace the snd_soc_dapm_x_pin functions with the equivalent
snd_soc_component_x_pin functions so that any name_prefix will be
handled automatically.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 12 ++++++++----
 sound/soc/codecs/cs47l24.c |  3 ++-
 sound/soc/codecs/wm5102.c  |  3 ++-
 sound/soc/codecs/wm5110.c  |  3 ++-
 sound/soc/codecs/wm8997.c  |  3 ++-
 sound/soc/codecs/wm8998.c  |  3 ++-
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ca5ca9e..0a734d9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -257,6 +257,7 @@ int arizona_init_mono(struct snd_soc_codec *codec)
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
index 1ed1329..73559ae 100644
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
index 72ff291..e7ab37d 100644
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
index a9a8bc9..585fc70 100644
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
index ea8b1bf..ee0c863 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1060,12 +1060,13 @@ static int wm8997_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
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
index 1e1d9c1..3694f59 100644
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
1.9.1

