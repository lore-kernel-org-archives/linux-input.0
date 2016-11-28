From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] regulator: arizona-micsupp: Use SoC component pin control functions
Date: Mon, 28 Nov 2016 17:32:28 +0000
Message-ID: <1480354350-24978-4-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1480354350-24978-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52887 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752795AbcK1RdG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 12:33:06 -0500
In-Reply-To: <1480354350-24978-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

The name of a codec pin can have an optional prefix string, which is
defined by the SoC machine driver. The snd_soc_dapm_x_pin functions
take the fully-specified name including the prefix and so the existing
code would fail to find the pin if the audio machine driver had added
a prefix.

Switch to using the snd_soc_component_x_pin equivalent functions that
take a specified SoC component and automatically add the name prefix to
the provided pin name.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-micsupp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index fcb98db..1439462 100644
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
1.9.1

