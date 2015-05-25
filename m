From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v4 14/18] ASoC: pxa: poodle: make use of new locomo GPIO interface
Date: Mon, 25 May 2015 14:41:49 +0300
Message-ID: <1432554113-26280-15-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33202 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbEYLmt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 07:42:49 -0400
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org, alsa-devel@alsa-project.org

Since LoCoMo driver has been converted to provide proper gpiolib
interface, make poodle ASoC platform driver use gpiolib API.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/pxa/poodle.c | 52 +++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 0fce8c4..c5b7c5e 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -20,15 +20,11 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <asm/mach-types.h>
-#include <asm/hardware/locomo.h>
-#include <mach/poodle.h>
-#include <mach/audio.h>
-
 #include "../codecs/wm8731.h"
 #include "pxa2xx-i2s.h"
 
@@ -42,22 +38,18 @@
 
 static int poodle_jack_func;
 static int poodle_spk_func;
+static struct gpio_desc *poodle_mute_l, *poodle_mute_r, *poodle_amp_on;
 
 static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 {
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
-		/* set = unmute headphone */
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 1);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 1);
+		gpiod_set_value(poodle_mute_l, 0);
+		gpiod_set_value(poodle_mute_r, 0);
 		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	} else {
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 0);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 0);
+		gpiod_set_value(poodle_mute_l, 1);
+		gpiod_set_value(poodle_mute_r, 1);
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
@@ -84,11 +76,8 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 /* we need to unmute the HP at shutdown as the mute burns power on poodle */
 static void poodle_shutdown(struct snd_pcm_substream *substream)
 {
-	/* set = unmute headphone */
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 1);
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 1);
+	gpiod_set_value(poodle_mute_l, 0);
+	gpiod_set_value(poodle_mute_r, 0);
 }
 
 static int poodle_hw_params(struct snd_pcm_substream *substream,
@@ -178,12 +167,7 @@ static int poodle_set_spk(struct snd_kcontrol *kcontrol,
 static int poodle_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 0);
-	else
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 1);
+	gpiod_set_value(poodle_amp_on, (SND_SOC_DAPM_EVENT_ON(event)));
 
 	return 0;
 }
@@ -268,13 +252,17 @@ static int poodle_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &poodle;
 	int ret;
 
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_AMP_ON, 0);
-	/* should we mute HP at startup - burning power ?*/
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 0);
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 0);
+	poodle_mute_l = devm_gpiod_get(&pdev->dev, "mute-l", GPIOD_OUT_HIGH);
+	if (IS_ERR(poodle_mute_l))
+		return PTR_ERR(poodle_mute_l);
+
+	poodle_mute_r = devm_gpiod_get(&pdev->dev, "mute-r", GPIOD_OUT_HIGH);
+	if (IS_ERR(poodle_mute_r))
+		return PTR_ERR(poodle_mute_l);
+
+	poodle_amp_on = devm_gpiod_get(&pdev->dev, "amp-on", GPIOD_OUT_LOW);
+	if (IS_ERR(poodle_amp_on))
+		return PTR_ERR(poodle_amp_on);
 
 	card->dev = &pdev->dev;
 
-- 
2.1.4

