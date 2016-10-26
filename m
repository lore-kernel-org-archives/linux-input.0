From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 5/9] ASoC: pxa: switch to new ac97 bus support
Date: Wed, 26 Oct 2016 21:41:43 +0200
Message-ID: <1477510907-23495-6-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:32546 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755378AbcJZTtj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 15:49:39 -0400
In-Reply-To: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Switch to the new ac97 bus support in sound/ac97 instead of the legacy
snd_ac97 one.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/sound/pxa2xx-lib.h  | 15 +++++++++------
 sound/arm/Kconfig           |  1 -
 sound/arm/pxa2xx-ac97-lib.c | 39 +++++++++++++++++++++++----------------
 sound/soc/pxa/Kconfig       |  5 ++---
 sound/soc/pxa/pxa2xx-ac97.c | 22 +++++++++++++---------
 5 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 6ef629bde164..0e2b8ae3e00e 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -2,7 +2,8 @@
 #define PXA2XX_LIB_H
 
 #include <linux/platform_device.h>
-#include <sound/ac97_codec.h>
+#include <sound/ac97/controller.h>
+#include <sound/ac97/compat.h>
 
 /* PCM */
 
@@ -21,12 +22,14 @@ extern void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm);
 
 /* AC97 */
 
-extern unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg);
-extern void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val);
+extern int pxa2xx_ac97_read(struct ac97_controller *adrv, int slot,
+			    unsigned short reg);
+extern int pxa2xx_ac97_write(struct ac97_controller *adrv, int slot,
+			     unsigned short reg, unsigned short val);
 
-extern bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97);
-extern bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97);
-extern void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97);
+extern bool pxa2xx_ac97_try_warm_reset(struct ac97_controller *adrv);
+extern bool pxa2xx_ac97_try_cold_reset(struct ac97_controller *adrv);
+extern void pxa2xx_ac97_finish_reset(struct ac97_controller *adrv);
 
 extern int pxa2xx_ac97_hw_suspend(void);
 extern int pxa2xx_ac97_hw_resume(void);
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
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 39c3969ac1c7..62b31e909d31 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <sound/ac97_codec.h>
+#include <sound/ac97/controller.h>
 #include <sound/pxa2xx-lib.h>
 
 #include <mach/irqs.h>
@@ -46,38 +46,41 @@ extern void pxa27x_configure_ac97reset(int reset_gpio, bool to_gpio);
  * 1 jiffy timeout if interrupt never comes).
  */
 
-unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+int pxa2xx_ac97_read(struct ac97_controller *ac97, int slot, unsigned short reg)
 {
-	unsigned short val = -1;
+	int val = -ENODEV;
 	volatile u32 *reg_addr;
 
+	if (slot > 0)
+		return -ENODEV;
+
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
 	if (cpu_is_pxa25x() && reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+		reg_addr = slot ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+		reg_addr = slot ? &SAC_REG_BASE : &PAC_REG_BASE;
 	reg_addr += (reg >> 1);
 
 	/* start read access across the ac97 link */
 	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
-	val = *reg_addr;
+	val = (*reg_addr & 0xffff);
 	if (reg == AC97_GPIO_STATUS)
 		goto out;
 	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1) <= 0 &&
 	    !((GSR | gsr_bits) & GSR_SDONE)) {
 		printk(KERN_ERR "%s: read error (ac97_reg=%d GSR=%#lx)\n",
 				__func__, reg, GSR | gsr_bits);
-		val = -1;
+		val = -ETIMEDOUT;
 		goto out;
 	}
 
 	/* valid data now */
 	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
-	val = *reg_addr;
+	val = (*reg_addr & 0xffff);
 	/* but we've just started another cycle... */
 	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
 
@@ -86,29 +89,33 @@ out:	mutex_unlock(&car_mutex);
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_read);
 
-void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-			unsigned short val)
+int pxa2xx_ac97_write(struct ac97_controller *ac97, int slot,
+		      unsigned short reg, unsigned short val)
 {
 	volatile u32 *reg_addr;
+	int ret = 0;
 
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
 	if (cpu_is_pxa25x() && reg == AC97_GPIO_STATUS)
-		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
+		reg_addr = slot ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
-		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
+		reg_addr = slot ? &SAC_REG_BASE : &PAC_REG_BASE;
 	reg_addr += (reg >> 1);
 
 	GSR = GSR_CDONE | GSR_SDONE;
 	gsr_bits = 0;
 	*reg_addr = val;
 	if (wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1) <= 0 &&
-	    !((GSR | gsr_bits) & GSR_CDONE))
+	    !((GSR | gsr_bits) & GSR_CDONE)) {
 		printk(KERN_ERR "%s: write error (ac97_reg=%d GSR=%#lx)\n",
 				__func__, reg, GSR | gsr_bits);
+		ret = -EIO;
+	}
 
 	mutex_unlock(&car_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_write);
 
@@ -188,7 +195,7 @@ static inline void pxa_ac97_cold_pxa3xx(void)
 }
 #endif
 
-bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_warm_reset(struct ac97_controller *adrv)
 {
 	unsigned long gsr;
 	unsigned int timeout = 100;
@@ -225,7 +232,7 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 
-bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_cold_reset(struct ac97_controller *adrv)
 {
 	unsigned long gsr;
 	unsigned int timeout = 1000;
@@ -263,7 +270,7 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_cold_reset);
 
 
-void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97)
+void pxa2xx_ac97_finish_reset(struct ac97_controller *adrv)
 {
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f2bf8661dd21..d390a789f3ab 100644
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
index 9615e6de1306..aba1bd5eb817 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -17,6 +17,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma/pxa-dma.h>
 
+#include <sound/ac97/controller.h>
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
@@ -29,21 +30,21 @@
 
 #include "pxa2xx-ac97.h"
 
-static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
-	pxa2xx_ac97_try_warm_reset(ac97);
+	pxa2xx_ac97_try_warm_reset(adrv);
 
-	pxa2xx_ac97_finish_reset(ac97);
+	pxa2xx_ac97_finish_reset(adrv);
 }
 
-static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_cold_reset(struct ac97_controller *adrv)
 {
-	pxa2xx_ac97_try_cold_reset(ac97);
+	pxa2xx_ac97_try_cold_reset(adrv);
 
-	pxa2xx_ac97_finish_reset(ac97);
+	pxa2xx_ac97_finish_reset(adrv);
 }
 
-static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
+static struct ac97_controller_ops pxa2xx_ac97_ops = {
 	.read	= pxa2xx_ac97_read,
 	.write	= pxa2xx_ac97_write,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
@@ -224,6 +225,7 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
+	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
 
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
@@ -236,7 +238,9 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
+	ret = snd_ac97_controller_register(&pxa2xx_ac97_ops, &pdev->dev,
+					   AC97_SLOTS_AVAILABLE_ALL,
+					   pdata->codec_pdata);
 	if (ret != 0)
 		return ret;
 
@@ -251,7 +255,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
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

