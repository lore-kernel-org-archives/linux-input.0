From: Mark Brown <broonie@kernel.org>
Subject: Applied "extcon: arizona: Use SoC component pin control functions" to the asoc tree
Date: Thu, 01 Dec 2016 21:46:01 +0000
Message-ID: <E1cCZB3-0007bH-2t@debutante>
References: <1480354350-24978-5-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47994 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758519AbcLAVqR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2016 16:46:17 -0500
In-Reply-To: <1480354350-24978-5-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Mark Brown <broonie@kernel.org>broonie@kernel.orgcw00.choi@samsung.com, dmitry.torokhov@gmail.com, myungjoo.ham@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The patch

   extcon: arizona: Use SoC component pin control functions

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

>From efd95c71f4892ad5d0d33099db25085763f4c6c3 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 15:44:41 +0000
Subject: [PATCH] extcon: arizona: Use SoC component pin control functions

The name of a codec pin can have an optional prefix string, which is
defined by the SoC machine driver. The snd_soc_dapm_x_pin functions
take the fully-specified name including the prefix and so the existing
code would fail to find the pin if the audio machine driver had added
a prefix.

Switch to using the snd_soc_component_x_pin equivalent functions that
take a specified SoC component and automatically add the name prefix to
the provided pin name.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/extcon/extcon-arizona.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 56e6c4c7c60d..d836d4ce5ee4 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -274,9 +274,10 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
 	struct arizona *arizona = info->arizona;
 	const char *widget = arizona_extcon_get_micbias(info);
 	struct snd_soc_dapm_context *dapm = arizona->dapm;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	int ret;
 
-	ret = snd_soc_dapm_force_enable_pin(dapm, widget);
+	ret = snd_soc_component_force_enable_pin(component, widget);
 	if (ret != 0)
 		dev_warn(arizona->dev, "Failed to enable %s: %d\n",
 			 widget, ret);
@@ -284,7 +285,7 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
 	snd_soc_dapm_sync(dapm);
 
 	if (!arizona->pdata.micd_force_micbias) {
-		ret = snd_soc_dapm_disable_pin(arizona->dapm, widget);
+		ret = snd_soc_component_disable_pin(component, widget);
 		if (ret != 0)
 			dev_warn(arizona->dev, "Failed to disable %s: %d\n",
 				 widget, ret);
@@ -349,6 +350,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 	struct arizona *arizona = info->arizona;
 	const char *widget = arizona_extcon_get_micbias(info);
 	struct snd_soc_dapm_context *dapm = arizona->dapm;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	bool change;
 	int ret;
 
@@ -356,7 +358,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 				 ARIZONA_MICD_ENA, 0,
 				 &change);
 
-	ret = snd_soc_dapm_disable_pin(dapm, widget);
+	ret = snd_soc_component_disable_pin(component, widget);
 	if (ret != 0)
 		dev_warn(arizona->dev,
 			 "Failed to disable %s: %d\n",
-- 
2.10.2

