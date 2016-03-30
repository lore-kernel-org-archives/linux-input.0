From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where appropriate
Date: Wed, 30 Mar 2016 22:03:31 +0200
Message-ID: <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbd
List-Id: linux-input@vger.kernel.org

The PWM framework has clarified the concept of reference PWM config
(the platform dependent config retrieved from the DT or the PWM
lookup table) and real PWM state.

Use pwm_get_args() when the PWM user wants to retrieve this reference
config and not the current state.

This is part of the rework allowing the PWM framework to support
hardware readout and expose real PWM state even when the PWM has
just been requested (before the user calls pwm_config/enable/disable()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/hwmon/pwm-fan.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 3e23003..82c5656 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -40,15 +40,18 @@ struct pwm_fan_ctx {
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
+	struct pwm_args pargs = { };
 	unsigned long duty;
 	int ret = 0;
 
+	pwm_get_args(ctx->pwm, &pargs);
+
 	mutex_lock(&ctx->lock);
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	duty = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		goto exit_set_pwm_err;
 
@@ -214,6 +217,7 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
+	struct pwm_args pargs = { };
 	struct pwm_fan_ctx *ctx;
 	struct device *hwmon;
 	int duty_cycle;
@@ -234,10 +238,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	/* Set duty cycle to maximum allowed */
-	duty_cycle = ctx->pwm->period - 1;
+	pwm_get_args(ctx->pwm, &pargs);
+	duty_cycle = pargs.period - 1;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
+	ret = pwm_config(ctx->pwm, duty_cycle, pargs.period);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
@@ -303,14 +308,16 @@ static int pwm_fan_suspend(struct device *dev)
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct pwm_args pargs = { };
 	unsigned long duty;
 	int ret;
 
 	if (ctx->pwm_value == 0)
 		return 0;
 
-	duty = DIV_ROUND_UP(ctx->pwm_value * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	pwm_get_args(ctx->pwm, &pargs);
+	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		return ret;
 	return pwm_enable(ctx->pwm);
-- 
2.5.0
