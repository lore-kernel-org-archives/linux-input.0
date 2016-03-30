From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 27/46] regulator: pwm: adjust PWM config at
 probe time
Date: Wed, 30 Mar 2016 22:03:50 +0200
Message-ID: <1459368249-13241-28-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBDHD6C3QKGQEKRS3PCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The PWM attached to a PWM regulator device might have been previously
configured by the bootloader.
Make sure the bootloader and linux config are in sync, and adjust the PWM
config if that's not the case.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/regulator/pwm-regulator.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 9154c47..9590fb0 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -240,6 +240,52 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	return 0;
 }
 
+static int pwm_regulator_adjust_pwm_config(struct pwm_regulator_data *drvdata)
+{
+	struct pwm_state pstate = { };
+	struct pwm_args pargs = { };
+
+	pwm_get_args(drvdata->pwm, &pargs);
+	pwm_get_state(drvdata->pwm, &pstate);
+
+	/*
+	 * if the current period is zero this either means the PWM driver
+	 * does not support initial state retrieval or the PWM was not
+	 * configured.
+	 * In any case, we setup the new period and poloarity, and assign a
+	 * duty_cycle of 0.
+	 */
+	if (!pstate.period) {
+		pstate.duty_cycle = 0;
+		pstate.period = pargs.period;
+		pstate.polarity = pargs.polarity;
+
+		return pwm_apply_state(drvdata->pwm, &pstate);
+	}
+
+	/*
+	 * Adjust the PWM dutycycle/period based on the period value provided
+	 * in PWM args.
+	 */
+	if (pargs.period != pstate.period) {
+		u64 dutycycle = (u64)pstate.duty_cycle * pargs.period;
+
+		do_div(dutycycle, pstate.period);
+		pstate.duty_cycle = dutycycle;
+		pstate.period = pargs.period;
+	}
+
+	/*
+	 * If the polarity changed, we should also change the dutycycle value.
+	 */
+	if (pargs.polarity != pstate.polarity) {
+		pstate.polarity = pargs.polarity;
+		pstate.duty_cycle = pstate.period - pstate.duty_cycle;
+	}
+
+	return pwm_apply_state(drvdata->pwm, &pstate);
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	const struct regulator_init_data *init_data;
@@ -283,6 +329,10 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 		return PTR_ERR(drvdata->pwm);
 	}
 
+	ret = pwm_regulator_adjust_pwm_config(drvdata);
+	if (ret)
+		return ret;
+
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {
-- 
2.5.0
