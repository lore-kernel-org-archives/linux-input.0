From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 04/24] hwmon: pwm-fan: use pwm_get_xxx()
 helpers where appropriate
Date: Mon, 16 Nov 2015 09:56:27 +0100
Message-ID: <1447664207-24370-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBXNUU2ZAKGQEQAASJSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
Doing that will ease adaptation of the PWM framework to support atomic
update.

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
+pwm_set_polarity((p), e);
|
-(p)->polarity
+pwm_get_polarity((p))
|
-(p)->period = e;
+pwm_set_period((p), e);
|
-(p)->period
+pwm_get_period((p))
|
-(p)->duty_cycle = e;
+pwm_set_duty_cycle((p), e);
|
-(p)->duty_cycle
+pwm_get_duty_cycle((p))
)
--->8---
---
 drivers/hwmon/pwm-fan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 3e23003..105b964 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -47,8 +47,8 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	duty = DIV_ROUND_UP(pwm * (pwm_get_period((ctx->pwm)) - 1), MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
 	if (ret)
 		goto exit_set_pwm_err;
 
@@ -234,10 +234,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	/* Set duty cycle to maximum allowed */
-	duty_cycle = ctx->pwm->period - 1;
+	duty_cycle = pwm_get_period((ctx->pwm)) - 1;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
+	ret = pwm_config(ctx->pwm, duty_cycle, pwm_get_period((ctx->pwm)));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
@@ -309,8 +309,9 @@ static int pwm_fan_resume(struct device *dev)
 	if (ctx->pwm_value == 0)
 		return 0;
 
-	duty = DIV_ROUND_UP(ctx->pwm_value * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	duty = DIV_ROUND_UP(ctx->pwm_value * (pwm_get_period((ctx->pwm)) - 1),
+			    MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
 	if (ret)
 		return ret;
 	return pwm_enable(ctx->pwm);
-- 
2.1.4
