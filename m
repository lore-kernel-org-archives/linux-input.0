From: Mark Brown <broonie@kernel.org>
Subject: Applied "Input: arizona-haptics - Use SoC component pin control functions" to the asoc tree
Date: Thu, 01 Dec 2016 21:48:19 +0000
Message-ID: <E1cCZDH-00083Z-My@debutante>
References: <1480354350-24978-6-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48116 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbcLAVsd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2016 16:48:33 -0500
In-Reply-To: <1480354350-24978-6-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, cw00.choi@samsung.comdmitry.torokhov@gmail.com, myungjoo.ham@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The patch

   Input: arizona-haptics - Use SoC component pin control functions

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

>From 931afc4114c59b8fe8386db9fcdfe69a1322cae6 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 15:44:42 +0000
Subject: [PATCH] Input: arizona-haptics - Use SoC component pin control
 functions

The name of a codec pin can have an optional prefix string, which is
defined by the SoC machine driver. The snd_soc_dapm_x_pin functions
take the fully-specified name including the prefix and so the existing
code would fail to find the pin if the audio machine driver had added
a prefix.

Switch to using the snd_soc_component_x_pin equivalent functions that
take a specified SoC component and automatically add the name prefix to
the provided pin name.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/misc/arizona-haptics.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 982936334537..07ec465f1095 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -37,6 +37,8 @@ static void arizona_haptics_work(struct work_struct *work)
 						       struct arizona_haptics,
 						       work);
 	struct arizona *arizona = haptics->arizona;
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(arizona->dapm);
 	int ret;
 
 	if (!haptics->arizona->dapm) {
@@ -66,7 +68,7 @@ static void arizona_haptics_work(struct work_struct *work)
 			return;
 		}
 
-		ret = snd_soc_dapm_enable_pin(arizona->dapm, "HAPTICS");
+		ret = snd_soc_component_enable_pin(component, "HAPTICS");
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to start HAPTICS: %d\n",
 				ret);
@@ -81,7 +83,7 @@ static void arizona_haptics_work(struct work_struct *work)
 		}
 	} else {
 		/* This disable sequence will be a noop if already enabled */
-		ret = snd_soc_dapm_disable_pin(arizona->dapm, "HAPTICS");
+		ret = snd_soc_component_disable_pin(component, "HAPTICS");
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to disable HAPTICS: %d\n",
 				ret);
@@ -140,11 +142,14 @@ static int arizona_haptics_play(struct input_dev *input, void *data,
 static void arizona_haptics_close(struct input_dev *input)
 {
 	struct arizona_haptics *haptics = input_get_drvdata(input);
+	struct snd_soc_component *component;
 
 	cancel_work_sync(&haptics->work);
 
-	if (haptics->arizona->dapm)
-		snd_soc_dapm_disable_pin(haptics->arizona->dapm, "HAPTICS");
+	if (haptics->arizona->dapm) {
+		component = snd_soc_dapm_to_component(haptics->arizona->dapm);
+		snd_soc_component_disable_pin(component, "HAPTICS");
+	}
 }
 
 static int arizona_haptics_probe(struct platform_device *pdev)
-- 
2.10.2

