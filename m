From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 34/46] clk: pwm: switch to the atomic API
Date: Wed, 30 Mar 2016 22:03:57 +0200
Message-ID: <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBF7D6C3QKGQEIDZSEUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/clk/clk-pwm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index ebcd738..49ec5b1 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
 static int clk_pwm_prepare(struct clk_hw *hw)
 {
 	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
+	struct pwm_state pstate;
 
-	return pwm_enable(clk_pwm->pwm);
+	pwm_get_state(clk_pwm->pwm, &pstate);
+	if (pstate.enabled)
+		return 0;
+
+	pstate.enabled = true;
+
+	return pwm_apply_state(clk_pwm->pwm, &pstate);
 }
 
 static void clk_pwm_unprepare(struct clk_hw *hw)
 {
 	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
+	struct pwm_state pstate;
+
+	pwm_get_state(clk_pwm->pwm, &pstate);
+	if (!pstate.enabled)
+		return;
 
-	pwm_disable(clk_pwm->pwm);
+	pstate.enabled = false;
+
+	pwm_apply_state(clk_pwm->pwm, &pstate);
 }
 
 static unsigned long clk_pwm_recalc_rate(struct clk_hw *hw,
@@ -56,6 +70,7 @@ static const struct clk_ops clk_pwm_ops = {
 static int clk_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct pwm_state pstate;
 	struct pwm_args pargs = { };
 	struct clk_init_data init;
 	struct clk_pwm *clk_pwm;
@@ -88,7 +103,12 @@ static int clk_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = pwm_config(pwm, (pargs.period + 1) >> 1, pargs.period);
+	pwm_get_state(pwm, &pstate);
+	pstate.period = pargs.period;
+	pstate.polarity = pargs.polarity;
+	pstate.duty_cycle = (pargs.period + 1) >> 1;
+
+	ret = pwm_apply_state(pwm, &pstate);
 	if (ret < 0)
 		return ret;
 
-- 
2.5.0
