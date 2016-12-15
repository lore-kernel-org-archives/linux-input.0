From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: arizona-micsupp: Use SoC component pin control functions" to the regulator tree
Date: Thu, 15 Dec 2016 18:28:43 +0000
Message-ID: <E1cHaln-00009z-Gf@debutante>
References: <1480354350-24978-4-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33526 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbcLOWGs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 17:06:48 -0500
In-Reply-To: <1480354350-24978-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

The patch

   regulator: arizona-micsupp: Use SoC component pin control functions

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 98cf9965c09fc3fe6d8bd9760dba1dec53e387cc Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Thu, 15 Dec 2016 14:43:49 +0000
Subject: [PATCH] regulator: arizona-micsupp: Use SoC component pin control
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-micsupp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index fcb98dbda837..143946215e23 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -45,6 +45,7 @@ static void arizona_micsupp_check_cp(struct work_struct *work)
 	struct arizona_micsupp *micsupp =
 		container_of(work, struct arizona_micsupp, check_cp_work);
 	struct snd_soc_dapm_context *dapm = micsupp->arizona->dapm;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct arizona *arizona = micsupp->arizona;
 	struct regmap *regmap = arizona->regmap;
 	unsigned int reg;
@@ -59,9 +60,10 @@ static void arizona_micsupp_check_cp(struct work_struct *work)
 	if (dapm) {
 		if ((reg & (ARIZONA_CPMIC_ENA | ARIZONA_CPMIC_BYPASS)) ==
 		    ARIZONA_CPMIC_ENA)
-			snd_soc_dapm_force_enable_pin(dapm, "MICSUPP");
+			snd_soc_component_force_enable_pin(component,
+							   "MICSUPP");
 		else
-			snd_soc_dapm_disable_pin(dapm, "MICSUPP");
+			snd_soc_component_disable_pin(component, "MICSUPP");
 
 		snd_soc_dapm_sync(dapm);
 	}
-- 
2.11.0

