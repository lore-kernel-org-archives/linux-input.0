From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm5110: Implement haptics support
Date: Tue, 27 Nov 2012 07:08:08 +0000
Message-ID: <1354000088-30517-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56273 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758130Ab2K0HIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 02:08:20 -0500
In-Reply-To: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Provide a haptics widget for use by the haptics driver and expose the DAPM
context for it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 3485b83..2a075ad 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -352,6 +352,7 @@ SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
 
 SND_SOC_DAPM_SIGGEN("TONE"),
 SND_SOC_DAPM_SIGGEN("NOISE"),
+SND_SOC_DAPM_SIGGEN("HAPTICS"),
 
 SND_SOC_DAPM_INPUT("IN1L"),
 SND_SOC_DAPM_INPUT("IN1R"),
@@ -610,6 +611,7 @@ SND_SOC_DAPM_OUTPUT("SPKDAT2R"),
 	{ name, "Noise Generator", "Noise Generator" }, \
 	{ name, "Tone Generator 1", "Tone Generator 1" }, \
 	{ name, "Tone Generator 2", "Tone Generator 2" }, \
+	{ name, "Haptics", "HAPTICS" }, \
 	{ name, "AEC", "AEC Loopback" }, \
 	{ name, "IN1L", "IN1L PGA" }, \
 	{ name, "IN1R", "IN1R PGA" }, \
@@ -902,9 +904,29 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	codec->control_data = priv->core.arizona->regmap;
-	return snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
+	priv->core.arizona->dapm = &codec->dapm;
+
+	ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
+	if (ret != 0)
+		return ret;
+
+	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
+
+	priv->core.arizona->dapm = &codec->dapm;
+
+	return 0;
+}
+
+static int wm5110_codec_remove(struct snd_soc_codec *codec)
+{
+	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->core.arizona->dapm = NULL;
+
+	return 0;
 }
 
 #define WM5110_DIG_VU 0x0200
@@ -935,6 +957,7 @@ static unsigned int wm5110_digital_vu[] = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.probe = wm5110_codec_probe,
+	.remove = wm5110_codec_remove,
 
 	.idle_bias_off = true,
 
-- 
1.7.10.4

