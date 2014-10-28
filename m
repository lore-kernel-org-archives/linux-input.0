From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO interface
Date: Tue, 28 Oct 2014 03:02:04 +0300
Message-ID: <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

Since LoCoMo driver has been converted to provide proper gpiolib
interface, make poodle ASoC platform driver use gpiolib API.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/poodle.c | 51 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 21f3400..a593bff 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -20,12 +20,12 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
-#include <asm/hardware/locomo.h>
 #include <mach/poodle.h>
 #include <mach/audio.h>
 
@@ -48,16 +48,12 @@ static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 1);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 1);
+		gpio_set_value(POODLE_GPIO_MUTE_L, 1);
+		gpio_set_value(POODLE_GPIO_MUTE_R, 1);
 		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	} else {
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 0);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 0);
+		gpio_set_value(POODLE_GPIO_MUTE_L, 0);
+		gpio_set_value(POODLE_GPIO_MUTE_R, 0);
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
@@ -85,10 +81,8 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 static void poodle_shutdown(struct snd_pcm_substream *substream)
 {
 	/* set = unmute headphone */
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 1);
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 1);
+	gpio_set_value(POODLE_GPIO_MUTE_L, 1);
+	gpio_set_value(POODLE_GPIO_MUTE_R, 1);
 }
 
 static int poodle_hw_params(struct snd_pcm_substream *substream,
@@ -178,12 +172,7 @@ static int poodle_set_spk(struct snd_kcontrol *kcontrol,
 static int poodle_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 0);
-	else
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 1);
+	gpio_set_value(POODLE_GPIO_AMP_ON, !(SND_SOC_DAPM_EVENT_ON(event)));
 
 	return 0;
 }
@@ -263,25 +252,32 @@ static struct snd_soc_card poodle = {
 	.num_dapm_routes = ARRAY_SIZE(poodle_audio_map),
 };
 
+struct gpio poodle_gpios[] = {
+	{ POODLE_GPIO_AMP_ON, GPIOF_OUT_INIT_HIGH, "Amplifier" },
+	{ POODLE_GPIO_MUTE_L, GPIOF_OUT_INIT_LOW, "Mute left" },
+	{ POODLE_GPIO_MUTE_R, GPIOF_OUT_INIT_LOW, "Mute right" },
+};
+
 static int poodle_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &poodle;
 	int ret;
 
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_AMP_ON, 0);
-	/* should we mute HP at startup - burning power ?*/
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 0);
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 0);
+	ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
+	if (ret) {
+		dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
+				ret);
+		return ret;
+	}
 
 	card->dev = &pdev->dev;
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
+		gpio_free_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
+	}
 	return ret;
 }
 
@@ -290,6 +286,7 @@ static int poodle_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	snd_soc_unregister_card(card);
+	gpio_free_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
 	return 0;
 }
 
-- 
2.1.1

