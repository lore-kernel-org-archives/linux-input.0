From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 22/24] pwm: rockchip: add initial state retrieval
Date: Mon, 16 Nov 2015 09:56:45 +0100
Message-ID: <1447664207-24370-23-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB35UU2ZAKGQEIVTT2NI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>linu
List-Id: linux-input@vger.kernel.org

Implement the ->reset_state() function to expose initial state.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7d9cc90..6eab25c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -51,6 +51,7 @@ struct rockchip_pwm_data {
 
 	void (*set_enable)(struct pwm_chip *chip,
 			   struct pwm_device *pwm, bool enable);
+	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
@@ -75,6 +76,18 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_reset_state_v1(struct pwm_chip *chip,
+					struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
+	u32 val;
+
+	val = readl(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) == enable_conf)
+		pwm->state.enabled = true;
+}
+
 static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 				       struct pwm_device *pwm, bool enable)
 {
@@ -98,6 +111,54 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
 }
 
+static void rockchip_pwm_reset_state_v2(struct pwm_chip *chip,
+					struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
+			  PWM_CONTINUOUS;
+	u32 val;
+
+	val = readl(pc->base + pc->data->regs.ctrl);
+	if ((val & enable_conf) != enable_conf)
+		return;
+
+	pwm->state.enabled = true;
+
+	if (!(val & PWM_DUTY_POSITIVE))
+		pwm->state.polarity = PWM_POLARITY_INVERSED;
+}
+
+static void rockchip_pwm_reset_state(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	unsigned long clk_rate;
+	u64 tmp;
+	int ret;
+
+	ret = clk_enable(pc->clk);
+	if (ret)
+		return;
+
+	clk_rate = clk_get_rate(pc->clk);
+
+	tmp = readl(pc->base + pc->data->regs.period);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	do_div(tmp, clk_rate);
+	pwm->state.period = tmp;
+
+	tmp = readl(pc->base + pc->data->regs.duty);
+	tmp *= pc->data->prescaler * NSEC_PER_SEC;
+	do_div(tmp, clk_rate);
+	pwm->state.duty_cycle = tmp;
+
+	pc->data->reset_state(chip, chip->pwms);
+
+	if (!pwm_is_enabled(pwm))
+		clk_disable(pc->clk);
+}
+
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -171,6 +232,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops rockchip_pwm_ops_v1 = {
+	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
 	.enable = rockchip_pwm_enable,
 	.disable = rockchip_pwm_disable,
@@ -178,6 +240,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
 };
 
 static const struct pwm_ops rockchip_pwm_ops_v2 = {
+	.reset_state = rockchip_pwm_reset_state,
 	.config = rockchip_pwm_config,
 	.set_polarity = rockchip_pwm_set_polarity,
 	.enable = rockchip_pwm_enable,
@@ -195,6 +258,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
 	.prescaler = 2,
 	.ops = &rockchip_pwm_ops_v1,
 	.set_enable = rockchip_pwm_set_enable_v1,
+	.reset_state = rockchip_pwm_reset_state_v1,
 };
 
 static const struct rockchip_pwm_data pwm_data_v2 = {
@@ -207,6 +271,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.reset_state = rockchip_pwm_reset_state_v2,
 };
 
 static const struct rockchip_pwm_data pwm_data_vop = {
@@ -219,6 +284,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
 	.prescaler = 1,
 	.ops = &rockchip_pwm_ops_v2,
 	.set_enable = rockchip_pwm_set_enable_v2,
+	.reset_state = rockchip_pwm_reset_state_v2,
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-- 
2.1.4
