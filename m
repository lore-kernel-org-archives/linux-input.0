From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm5110: Implement haptics support
Date: Mon, 26 Nov 2012 21:39:40 +0000
Message-ID: <1353965980-32543-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1353965980-32543-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38369 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757258Ab2KZVjw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 16:39:52 -0500
In-Reply-To: <1353965980-32543-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Provide a haptics widget for use by the haptics driver and expose the DAPM
context for it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 8b81fa5..601d90a 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -371,6 +371,7 @@ SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
 
 SND_SOC_DAPM_SIGGEN("TONE"),
 SND_SOC_DAPM_SIGGEN("NOISE"),
+SND_SOC_DAPM_SIGGEN("HAPTICS"),
 
 SND_SOC_DAPM_INPUT("IN1L"),
 SND_SOC_DAPM_INPUT("IN1R"),
@@ -639,6 +640,7 @@ SND_SOC_DAPM_OUTPUT("SPKDAT2R"),
 	{ name, "Noise Generator", "Noise Generator" }, \
 	{ name, "Tone Generator 1", "Tone Generator 1" }, \
 	{ name, "Tone Generator 2", "Tone Generator 2" }, \
+	{ name, "Haptics", "HAPTICS" }, \
 	{ name, "AEC", "AEC Loopback" }, \
 	{ name, "IN1L", "IN1L PGA" }, \
 	{ name, "IN1R", "IN1R PGA" }, \
@@ -963,9 +965,20 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	int i;
 
 	codec->control_data = priv->core.arizona->regmap;
+	priv->core.arizona->dapm = &codec->dapm;
+
 	return snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
 }
 
+static int wm5110_codec_remove(struct snd_soc_codec *codec)
+{
+	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->core.arizona->dapm = NULL;
+
+	return 0;
+}
+
 #define WM5110_DIG_VU 0x0200
 
 static unsigned int wm5110_digital_vu[] = {
@@ -994,6 +1007,7 @@ static unsigned int wm5110_digital_vu[] = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.probe = wm5110_codec_probe,
+	.remove = wm5110_codec_remove,
 
 	.idle_bias_off = true,
 
-- 
1.7.10.4

