From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH 3/3] Input: pwm-beeper: add optional enable gpio
Date: Thu,  5 Jan 2017 20:43:54 -0600
Message-ID: <1483670635-25060-4-git-send-email-david@lechnology.com>
References: <1483670635-25060-1-git-send-email-david@lechnology.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483670635-25060-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds an optional enable gpio to the pwm-beeper device. This gpio is
used in cases where the beeper needs to be switched on before using it. For
example, there may be an amplifier that is not always powered on.

Tested on LEGO MINDSTORMS EV3, which has a speaker connected to PWM through
an amplifier. The amplifier has an enable pin that is connected to a gpio.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---
 drivers/input/misc/pwm-beeper.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index e76b710..4379ceb 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -25,6 +26,7 @@
 struct pwm_beeper {
 	struct input_dev *input;
 	struct pwm_device *pwm;
+	struct gpio_desc *enable_gpio;
 	struct work_struct work;
 	unsigned long period;
 };
@@ -38,8 +40,13 @@ static void __pwm_beeper_set(struct pwm_beeper *beeper)
 	if (period) {
 		pwm_config(beeper->pwm, period / 2, period);
 		pwm_enable(beeper->pwm);
-	} else
+		if (beeper->enable_gpio)
+			gpiod_direction_output(beeper->enable_gpio, 1);
+	} else {
+		if (beeper->enable_gpio)
+			gpiod_direction_output(beeper->enable_gpio, 0);
 		pwm_disable(beeper->pwm);
+	}
 }
 
 static void pwm_beeper_work(struct work_struct *work)
@@ -82,6 +89,8 @@ static void pwm_beeper_stop(struct pwm_beeper *beeper)
 {
 	cancel_work_sync(&beeper->work);
 
+	if (beeper->enable_gpio)
+		gpiod_direction_output(beeper->enable_gpio, 0);
 	if (beeper->period)
 		pwm_disable(beeper->pwm);
 }
@@ -116,6 +125,15 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	beeper->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						      GPIOD_OUT_LOW);
+	error = PTR_ERR_OR_ZERO(beeper->enable_gpio);
+	if (error) {
+		if (error != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get enable gpio\n");
+		goto err_pwm_free;
+	}
+
 	/*
 	 * FIXME: pwm_apply_args() should be removed when switching to
 	 * the atomic PWM API.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
