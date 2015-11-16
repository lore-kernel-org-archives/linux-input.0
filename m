From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 23/24] pwm: rockchip: add support for atomic update
Date: Mon, 16 Nov 2015 09:56:46 +0100
Message-ID: <1447664207-24370-24-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbd
List-Id: linux-input@vger.kernel.org

Implement the ->apply() function to add support for atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/pwm-rockchip.c | 53 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 6eab25c..48b814d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -50,7 +50,8 @@ struct rockchip_pwm_data {
 	const struct pwm_ops *ops;
 
 	void (*set_enable)(struct pwm_chip *chip,
-			   struct pwm_device *pwm, bool enable);
+			   struct pwm_device *pwm, bool enable,
+			   enum pwm_polarity polarity);
 	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
@@ -60,7 +61,8 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
 }
 
 static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
-				       struct pwm_device *pwm, bool enable)
+				       struct pwm_device *pwm, bool enable,
+				       enum pwm_polarity polarity)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
@@ -89,14 +91,15 @@ static void rockchip_pwm_reset_state_v1(struct pwm_chip *chip,
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
@@ -165,7 +168,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
 	u64 clk_rate, div;
-	int ret;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -182,15 +184,8 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -208,43 +203,53 @@ static int rockchip_pwm_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
-static int rockchip_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	bool enabled = pwm_is_enabled(pwm);
 	int ret;
 
 	ret = clk_enable(pc->clk);
 	if (ret)
 		return ret;
 
-	pc->data->set_enable(chip, pwm, true);
+	if (state->polarity != pwm_get_polarity(pwm) && enabled) {
+		pc->data->set_enable(chip, pwm, false, state->polarity);
+		enabled = false;
+	}
 
-	return 0;
-}
+	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (ret) {
+		if (enabled != pwm_is_enabled(pwm))
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
 
+out:
 	clk_disable(pc->clk);
+
+	return ret;
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
 	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
+	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
 	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
+	.apply = rockchip_pwm_apply,
 	.set_polarity = rockchip_pwm_set_polarity,
-	.enable = rockchip_pwm_enable,
-	.disable = rockchip_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
2.1.4
