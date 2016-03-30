From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 28/46] regulator: pwm: swith to the atomic
 PWM API
Date: Wed, 30 Mar 2016 22:03:51 +0200
Message-ID: <1459368249-13241-29-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBD7D6C3QKGQEKYL2IMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

pwm_config/enable/disable() have been deprecated in favor of
pwm_apply_state().
Replace all those calls with the equivalent pwm_get/apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/regulator/pwm-regulator.c | 54 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 9590fb0..42cc312 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -59,16 +59,18 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					 unsigned selector)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
-	struct pwm_args pargs = { };
-	int dutycycle;
+	struct pwm_state pstate = { };
+	u64 dutycycle;
 	int ret;
 
-	pwm_get_args(drvdata->pwm, &pargs);
+	pwm_get_state(drvdata->pwm, &pstate);
 
-	dutycycle = (pargs.period *
-		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
+	dutycycle = drvdata->duty_cycle_table[selector].dutycycle;
+	dutycycle *= pstate.period;
+	do_div(dutycycle, 100);
+	pstate.duty_cycle = dutycycle;
 
-	ret = pwm_config(drvdata->pwm, dutycycle, pargs.period);
+	ret = pwm_apply_state(drvdata->pwm, &pstate);
 	if (ret) {
 		dev_err(&rdev->dev, "Failed to configure PWM\n");
 		return ret;
@@ -93,24 +95,39 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 static int pwm_regulator_enable(struct regulator_dev *dev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_state pstate = { };
+
+	pwm_get_state(drvdata->pwm, &pstate);
+	if (pstate.enabled)
+		return 0;
+
+	pstate.enabled = true;
 
-	return pwm_enable(drvdata->pwm);
+	return pwm_apply_state(drvdata->pwm, &pstate);
 }
 
 static int pwm_regulator_disable(struct regulator_dev *dev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_state pstate = { };
 
-	pwm_disable(drvdata->pwm);
+	pwm_get_state(drvdata->pwm, &pstate);
+	if (!pstate.enabled)
+		return 0;
 
-	return 0;
+	pstate.enabled = false;
+
+	return pwm_apply_state(drvdata->pwm, &pstate);
 }
 
 static int pwm_regulator_is_enabled(struct regulator_dev *dev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_state pstate = { };
 
-	return pwm_is_enabled(drvdata->pwm);
+	pwm_get_state(drvdata->pwm, &pstate);
+
+	return pstate.enabled;
 }
 
 /**
@@ -138,25 +155,22 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 	unsigned int ramp_delay = rdev->constraints->ramp_delay;
-	struct pwm_args pargs = { };
-	int duty_cycle;
+	struct pwm_state pstate = { };
+	u64 duty_cycle;
 	int ret;
 
-	pwm_get_args(drvdata->pwm, &pargs);
+	pwm_get_state(drvdata->pwm, &pstate);
 	duty_cycle = pwm_voltage_to_duty_cycle_percentage(rdev, min_uV);
+	duty_cycle *= pstate.period;
+	do_div(duty_cycle, 100);
+	pstate.duty_cycle = duty_cycle;
 
-	ret = pwm_config(drvdata->pwm, (pargs.period / 100) * duty_cycle,
-			 pargs.period);
+	ret = pwm_apply_state(drvdata->pwm, &pstate);
 	if (ret) {
 		dev_err(&rdev->dev, "Failed to configure PWM\n");
 		return ret;
 	}
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM\n");
-		return ret;
-	}
 	drvdata->volt_uV = min_uV;
 
 	/* Delay required by PWM regulator to settle to the new voltage */
-- 
2.5.0
