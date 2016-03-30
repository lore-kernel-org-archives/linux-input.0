From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 06/46] pwm: use pwm_get/set_xxx() helpers
 where appropriate
Date: Wed, 30 Mar 2016 22:03:29 +0200
Message-ID: <1459368249-13241-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBV7C6C3QKGQEZ3VCPAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Use pwm_get/set_xxx() helpers instead of directly accessing the pwm->xxx
field. Doing that will ease adaptation of the PWM framework to support
atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Patch generated with the following coccinelle script:

--->8---
virtual patch

@@
struct pwm_device *p;
expression e;
@@
(
-(p)->polarity = e;
+pwm_set_polarity(p, e);
|
-(p)->polarity
+pwm_get_polarity(p)
|
-(p)->period = e;
+pwm_set_period(p, e);
|
-(p)->period
+pwm_get_period(p)
|
-(p)->duty_cycle = e;
+pwm_set_duty_cycle(p, e);
|
-(p)->duty_cycle
+pwm_get_duty_cycle(p)
)
--->8---
---
 drivers/pwm/pwm-crc.c          | 2 +-
 drivers/pwm/pwm-lpc18xx-sct.c  | 2 +-
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 drivers/pwm/pwm-sun4i.c        | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 7101c70..bd0ebd0 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -75,7 +75,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	if (pwm->period != period_ns) {
+	if (pwm_get_period(pwm) != period_ns) {
 		int clk_div;
 
 		/* changing the clk divisor, need to disable fisrt */
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9861fed..19dc64c 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -249,7 +249,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 			   LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
 			   LPC18XX_PWM_EVSTATEMSK_ALL);
 
-	if (pwm->polarity == PWM_POLARITY_NORMAL) {
+	if (pwm_get_polarity(pwm) == PWM_POLARITY_NORMAL) {
 		set_event = lpc18xx_pwm->period_event;
 		clear_event = lpc18xx_data->duty_event;
 		res_action = LPC18XX_PWM_RES_SET;
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index b7e6ecb..3e95090 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -192,7 +192,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		load_value, load_value,	match_value, match_value);
 
 	omap->pdata->set_pwm(omap->dm_timer,
-			      pwm->polarity == PWM_POLARITY_INVERSED,
+			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
 			      true,
 			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
 
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 67af9f6..03a99a5 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -354,7 +354,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
 	for (i = 0; i < pwm->chip.npwm; i++)
 		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
-			pwm->chip.pwms[i].polarity = PWM_POLARITY_INVERSED;
+			pwm_set_polarity(&pwm->chip.pwms[i],
+					 PWM_POLARITY_INVERSED);
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
-- 
2.5.0
