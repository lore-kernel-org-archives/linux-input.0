From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 11/12] ASoC: pxa: switch to new ac97 bus
	support
Date: Mon, 19 Jun 2017 09:27:08 +0200
Message-ID: <1497857229-12049-12-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Switch to the new ac97 bus support in sound/ac97 instead of the legacy
snd_ac97 one.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: split into 2 patches, the former being XXX ac97 codec agnostic
---
 sound/arm/Kconfig           |  1 -
 sound/soc/pxa/Kconfig       |  5 ++---
 sound/soc/pxa/pxa2xx-ac97.c | 43 ++++++++++++++++++++-----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 65171f6657a2..f1f25704fe52 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -36,7 +36,6 @@ endif	# SND_ARM
 
 config SND_PXA2XX_LIB
 	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
 	select SND_DMAENGINE_PCM
 
 config SND_PXA2XX_LIB_AC97
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 823b5a236d8d..72d652572269 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -19,13 +19,12 @@ config SND_MMP_SOC
 
 config SND_PXA2XX_AC97
 	tristate
-	select SND_AC97_CODEC
 
 config SND_PXA2XX_SOC_AC97
 	tristate
-	select AC97_BUS
+	select AC97_BUS_NEW
 	select SND_PXA2XX_LIB_AC97
-	select SND_SOC_AC97_BUS
+	select SND_SOC_AC97_BUS_NEW
 
 config SND_PXA2XX_SOC_I2S
 	tristate
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index b07d64ef49ba..c2be9dbe1789 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -17,6 +17,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma/pxa-dma.h>
 
+#include <sound/ac97/controller.h>
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
@@ -27,43 +28,35 @@
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_warm_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_cold_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_cold_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
-					      unsigned short reg)
+static int pxa2xx_ac97_read_actrl(struct ac97_controller *adrv, int slot,
+				  unsigned short reg)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_read(ac97->num, reg);
-	if (ret < 0)
-		return 0;
-	else
-		return (unsigned short)(ret & 0xffff);
+	return pxa2xx_ac97_read(slot, reg);
 }
 
-static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
-				     unsigned short reg, unsigned short val)
+static int pxa2xx_ac97_write_actrl(struct ac97_controller *adrv, int slot,
+				   unsigned short reg, unsigned short val)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_write(ac97->num, reg, val);
+	return pxa2xx_ac97_write(slot, reg, val);
 }
 
-static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_legacy_read,
-	.write	= pxa2xx_ac97_legacy_write,
+static struct ac97_controller_ops pxa2xx_ac97_ops = {
+	.read	= pxa2xx_ac97_read_actrl,
+	.write	= pxa2xx_ac97_write_actrl,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
@@ -242,6 +235,8 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct ac97_controller *ctrl;
+	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
 
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
@@ -254,9 +249,11 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
-	if (ret != 0)
-		return ret;
+	ctrl = snd_ac97_controller_register(&pxa2xx_ac97_ops, &pdev->dev,
+					    AC97_SLOTS_AVAILABLE_ALL,
+					    pdata->codec_pdata);
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
@@ -269,7 +266,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
-	snd_soc_set_ac97_ops(NULL);
+	snd_ac97_controller_unregister(&pdev->dev);
 	pxa2xx_ac97_hw_remove(pdev);
 	return 0;
 }
-- 
2.1.4
