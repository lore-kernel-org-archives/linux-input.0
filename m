From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 35/46] hwmon: pwm-fan: switch to the atomic API
Date: Wed, 30 Mar 2016 22:03:58 +0200
Message-ID: <1459368249-13241-36-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBGPD6C3QKGQELMW2J6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>linu
List-Id: linux-input@vger.kernel.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/hwmon/pwm-fan.c | 81 ++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 82c5656..da4e4ab 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -40,8 +40,8 @@ struct pwm_fan_ctx {
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
+	struct pwm_state pstate;
 	struct pwm_args pargs = { };
-	unsigned long duty;
 	int ret = 0;
 
 	pwm_get_args(ctx->pwm, &pargs);
@@ -50,19 +50,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
-	if (ret)
-		goto exit_set_pwm_err;
-
+	pwm_get_state(ctx->pwm, &pstate);
+	pstate.period = pargs.period;
+	pstate.duty_cycle = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
 	if (pwm == 0)
-		pwm_disable(ctx->pwm);
+		pstate.enabled = false;
+	else
+		pstate.enabled = true;
 
-	if (ctx->pwm_value == 0) {
-		ret = pwm_enable(ctx->pwm);
-		if (ret)
-			goto exit_set_pwm_err;
-	}
+	ret = pwm_apply_state(ctx->pwm, &pstate);
+	if (ret)
+		goto exit_set_pwm_err;
 
 	ctx->pwm_value = pwm;
 exit_set_pwm_err:
@@ -217,10 +215,10 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
+	struct pwm_state pstate;
 	struct pwm_args pargs = { };
 	struct pwm_fan_ctx *ctx;
 	struct device *hwmon;
-	int duty_cycle;
 	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -239,27 +237,25 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	/* Set duty cycle to maximum allowed */
 	pwm_get_args(ctx->pwm, &pargs);
-	duty_cycle = pargs.period - 1;
+	pwm_get_state(ctx->pwm, &pstate);
+
+	pstate.period = pargs.period;
+	pstate.duty_cycle = pargs.period - 1;
+	pstate.enabled = true;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, pargs.period);
+	ret = pwm_apply_state(ctx->pwm, &pstate);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
 	}
 
-	/* Enbale PWM output */
-	ret = pwm_enable(ctx->pwm);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable PWM\n");
-		return ret;
-	}
-
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
 		dev_err(&pdev->dev, "Failed to register hwmon device\n");
-		pwm_disable(ctx->pwm);
+		pstate.enabled = false;
+		pwm_apply_state(ctx->pwm, &pstate);
 		return PTR_ERR(hwmon);
 	}
 
@@ -275,7 +271,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		if (IS_ERR(cdev)) {
 			dev_err(&pdev->dev,
 				"Failed to register pwm-fan as cooling device");
-			pwm_disable(ctx->pwm);
+			pstate.enabled = false;
+			pwm_apply_state(ctx->pwm, &pstate);
 			return PTR_ERR(cdev);
 		}
 		ctx->cdev = cdev;
@@ -290,8 +287,14 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(ctx->cdev);
-	if (ctx->pwm_value)
-		pwm_disable(ctx->pwm);
+	if (ctx->pwm_value) {
+		struct pwm_state pstate;
+
+		pwm_get_state(ctx->pwm, &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(ctx->pwm, &pstate);
+	}
+
 	return 0;
 }
 
@@ -300,27 +303,35 @@ static int pwm_fan_suspend(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 
-	if (ctx->pwm_value)
-		pwm_disable(ctx->pwm);
+	if (ctx->pwm_value) {
+		struct pwm_state pstate;
+
+		pwm_get_state(ctx->pwm, &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(ctx->pwm, &pstate);
+	}
+
 	return 0;
 }
 
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct pwm_state pstate;
 	struct pwm_args pargs = { };
-	unsigned long duty;
-	int ret;
 
 	if (ctx->pwm_value == 0)
 		return 0;
 
 	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
-	if (ret)
-		return ret;
-	return pwm_enable(ctx->pwm);
+	pwm_get_state(ctx->pwm, &pstate);
+
+	pstate.period = pargs.period;
+	pstate.duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1),
+					 MAX_PWM);
+	pstate.enabled = true;
+
+	return pwm_apply_state(ctx->pwm, &pstate);
 }
 #endif
 
-- 
2.5.0
