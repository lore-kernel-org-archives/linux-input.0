From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v4 04/12] ASoC: arm: make pxa2xx-ac97-lib ac97 codec agnostic
Date: Mon, 24 Jul 2017 22:49:20 +0200
Message-ID: <20170724204928.29505-5-robert.jarzmik@free.fr>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:17192 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755846AbdGXUuH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 16:50:07 -0400
In-Reply-To: <20170724204928.29505-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

All pxa library functions don't use the input parameters for nothing but
slot number. This simplifies their prototypes, and makes them usable by
both the legacy ac97 bus and the new ac97 bus.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/sound/pxa2xx-lib.h  | 15 +++++++++------
 sound/arm/pxa2xx-ac97-lib.c | 37 +++++++++++++++++++++----------------
 sound/arm/pxa2xx-ac97.c     | 35 +++++++++++++++++++++++++++--------
 sound/soc/pxa/pxa2xx-ac97.c | 32 ++++++++++++++++++++++++++------
 4 files changed, 83 insertions(+), 36 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 6ef629bde164..85352becec7c 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -1,10 +1,13 @@
 #ifndef PXA2XX_LIB_H
 #define PXA2XX_LIB_H
 
+#include <uapi/sound/asound.h>
 #include <linux/platform_device.h>
-#include <sound/ac97_codec.h>
 
 /* PCM */
+struct snd_pcm_substream;
+struct snd_pcm_hw_params;
+struct snd_pcm;
 
 extern int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params);
@@ -21,12 +24,12 @@ extern void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm);
 
 /* AC97 */
 
-extern unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg);
-extern void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val);
+extern int pxa2xx_ac97_read(int slot, unsigned short reg);
+extern int pxa2xx_ac97_write(int slot, unsigned short reg, unsigned short val);
 
-extern bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97);
-extern bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97);
-extern void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97);
+extern bool pxa2xx_ac97_try_warm_reset(void);
+extern bool pxa2xx_ac97_try_cold_reset(void);
+extern void pxa2xx_ac97_finish_reset(void);
 
 extern int pxa2xx_ac97_hw_suspend(void);
 extern int pxa2xx_ac97_hw_resume(void);
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 39c3969ac1c7..5950a9e218d9 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -20,7 +20,6 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <sound/ac97_codec.h>
 #include <sound/pxa2xx-lib.h>
 
 #include <mach/irqs.h>
@@ -46,38 +45,41 @@ extern void pxa27x_configure_ac97reset(int reset_gpio, bool to_gpio);
  * 1 jiffy timeout if interrupt never comes).
  */
 
-unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+int pxa2xx_ac97_read(int slot, unsigned short reg)
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
 
@@ -86,29 +88,32 @@ out:	mutex_unlock(&car_mutex);
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_read);
 
-void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-			unsigned short val)
+int pxa2xx_ac97_write(int slot, unsigned short reg, unsigned short val)
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
 
@@ -188,7 +193,7 @@ static inline void pxa_ac97_cold_pxa3xx(void)
 }
 #endif
 
-bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_warm_reset(void)
 {
 	unsigned long gsr;
 	unsigned int timeout = 100;
@@ -225,7 +230,7 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 }
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 
-bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
+bool pxa2xx_ac97_try_cold_reset(void)
 {
 	unsigned long gsr;
 	unsigned int timeout = 1000;
@@ -263,7 +268,7 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_cold_reset);
 
 
-void pxa2xx_ac97_finish_reset(struct snd_ac97 *ac97)
+void pxa2xx_ac97_finish_reset(void)
 {
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index fbd5dad0c484..4bc244c40f80 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -29,19 +29,38 @@
 
 #include "pxa2xx-pcm.h"
 
-static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_legacy_reset(struct snd_ac97 *ac97)
 {
-	if (!pxa2xx_ac97_try_cold_reset(ac97)) {
-		pxa2xx_ac97_try_warm_reset(ac97);
-	}
+	if (!pxa2xx_ac97_try_cold_reset())
+		pxa2xx_ac97_try_warm_reset();
+
+	pxa2xx_ac97_finish_reset();
+}
+
+static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
+					      unsigned short reg)
+{
+	int ret;
+
+	ret = pxa2xx_ac97_read(ac97->num, reg);
+	if (ret < 0)
+		return 0;
+	else
+		return (unsigned short)(ret & 0xffff);
+}
+
+static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
+				     unsigned short reg, unsigned short val)
+{
+	int __always_unused ret;
 
-	pxa2xx_ac97_finish_reset(ac97);
+	ret = pxa2xx_ac97_write(ac97->num, reg, val);
 }
 
 static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_read,
-	.write	= pxa2xx_ac97_write,
-	.reset	= pxa2xx_ac97_reset,
+	.read	= pxa2xx_ac97_legacy_read,
+	.write	= pxa2xx_ac97_legacy_write,
+	.reset	= pxa2xx_ac97_legacy_reset,
 };
 
 static struct pxad_param pxa2xx_ac97_pcm_out_req = {
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 2e2fb1838ec2..b07d64ef49ba 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -29,21 +29,41 @@
 
 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	pxa2xx_ac97_try_warm_reset(ac97);
+	pxa2xx_ac97_try_warm_reset();
 
-	pxa2xx_ac97_finish_reset(ac97);
+	pxa2xx_ac97_finish_reset();
 }
 
 static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	pxa2xx_ac97_try_cold_reset(ac97);
+	pxa2xx_ac97_try_cold_reset();
 
-	pxa2xx_ac97_finish_reset(ac97);
+	pxa2xx_ac97_finish_reset();
+}
+
+static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
+					      unsigned short reg)
+{
+	int ret;
+
+	ret = pxa2xx_ac97_read(ac97->num, reg);
+	if (ret < 0)
+		return 0;
+	else
+		return (unsigned short)(ret & 0xffff);
+}
+
+static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
+				     unsigned short reg, unsigned short val)
+{
+	int ret;
+
+	ret = pxa2xx_ac97_write(ac97->num, reg, val);
 }
 
 static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_read,
-	.write	= pxa2xx_ac97_write,
+	.read	= pxa2xx_ac97_legacy_read,
+	.write	= pxa2xx_ac97_legacy_write,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
-- 
2.11.0

