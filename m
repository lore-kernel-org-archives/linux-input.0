From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 4/5] extcon: arizona: Use SoC component pin control functions
Date: Tue, 29 Nov 2016 15:44:41 +0000
Message-ID: <1480434282-26389-5-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
 drivers/extcon/extcon-arizona.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index aeab47d..ed78b7c 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -270,9 +270,10 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
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
@@ -280,7 +281,7 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
 	snd_soc_dapm_sync(dapm);
 
 	if (!arizona->pdata.micd_force_micbias) {
-		ret = snd_soc_dapm_disable_pin(arizona->dapm, widget);
+		ret = snd_soc_component_disable_pin(component, widget);
 		if (ret != 0)
 			dev_warn(arizona->dev, "Failed to disable %s: %d\n",
 				 widget, ret);
@@ -345,6 +346,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 	struct arizona *arizona = info->arizona;
 	const char *widget = arizona_extcon_get_micbias(info);
 	struct snd_soc_dapm_context *dapm = arizona->dapm;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	bool change;
 	int ret;
 
@@ -352,7 +354,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 				 ARIZONA_MICD_ENA, 0,
 				 &change);
 
-	ret = snd_soc_dapm_disable_pin(dapm, widget);
+	ret = snd_soc_component_disable_pin(component, widget);
 	if (ret != 0)
 		dev_warn(arizona->dev,
 			 "Failed to disable %s: %d\n",
-- 
1.9.1
