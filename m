From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 23/46] pwm: rockchip: add support for atomic update
Date: Wed, 30 Mar 2016 22:03:46 +0200
Message-ID: <1459368249-13241-24-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBBPD6C3QKGQEPBP42LQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Implement the ->apply() function to add support for atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 63 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 5c7e79c..ed27740 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -50,7 +50,8 @@ struct rockchip_pwm_data {
 	const struct pwm_ops *ops;
 
 	void (*set_enable)(struct pwm_chip *chip,
-			   struct pwm_device *pwm, bool enable);
+			   struct pwm_device *pwm, bool enable,
+			   enum pwm_polarity polarity);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *pstate);
 };
@@ -61,7 +62,8 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
 }
 
 static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable)
+				       struct pwm_device *pwm, bool enable,
+				       enum pwm_polarity polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
@@ -91,14 +93,15 @@ static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
 }
 
 static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable)
+				       struct pwm_device *pwm, bool enable,
+				       enum pwm_polarity polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
 			  PWM_CONTINUOUS;
 	u32 val;
 
-	if (pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED)
+	if (polarity == PWM_POLARITY_INVERSED)
 		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
 	else
 		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
@@ -168,7 +171,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
-	int ret;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -185,15 +187,8 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
 	duty = div;
 
-	ret = clk_enable(pc->clk);
-	if (ret)
-		return ret;
-
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
-	writel(0, pc->base + pc->data->regs.cntr);
-
-	clk_disable(pc->clk);
 
 	return 0;
 }
@@ -211,43 +206,63 @@ static int rockchip_pwm_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
-static int rockchip_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	struct pwm_state curstate;
+	bool enabled;
 	int ret;
 
+	pwm_get_state(pwm, &curstate);
+	enabled = curstate.enabled;
+
 	ret = clk_enable(pc->clk);
 	if (ret)
 		return ret;
 
-	pc->data->set_enable(chip, pwm, true);
+	if (state->polarity != curstate.polarity && enabled) {
+		pc->data->set_enable(chip, pwm, false, state->polarity);
+		enabled = false;
+	}
 
-	return 0;
-}
+	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (ret) {
+		if (enabled != curstate.enabled)
+			pc->data->set_enable(chip, pwm, !enabled,
+					     state->polarity);
 
-static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+		goto out;
+	}
 
-	pc->data->set_enable(chip, pwm, false);
+	if (state->enabled != enabled)
+		pc->data->set_enable(chip, pwm, state->enabled,
+				     state->polarity);
 
+	/*
+	 * Update the state with the real hardware, which can differ a bit
+	 * because of period/duty_cycle approximation.
+	 */
+	rockchip_pwm_get_state(chip, pwm, state);
+
+out:
 	clk_disable(pc->clk);
+
+	return ret;
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
 	.get_state = rockchip_pwm_get_state,
 	.config = rockchip_pwm_config,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
+	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
 	.get_state = rockchip_pwm_get_state,
 	.config = rockchip_pwm_config,
+	.apply = rockchip_pwm_apply,
 	.set_polarity = rockchip_pwm_set_polarity,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
2.5.0
