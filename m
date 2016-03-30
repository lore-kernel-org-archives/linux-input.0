From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 38/46] input: misc: pwm-beeper: switch to the
 atomic PWM API
Date: Wed, 30 Mar 2016 22:04:01 +0200
Message-ID: <1459368249-13241-39-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBH7D6C3QKGQEILDU7ZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/input/misc/pwm-beeper.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index f2261ab..36c9897 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -34,7 +34,7 @@ static int pwm_beeper_event(struct input_dev *input,
 {
 	int ret = 0;
 	struct pwm_beeper *beeper = input_get_drvdata(input);
-	unsigned long period;
+	struct pwm_state pstate;
 
 	if (type != EV_SND || value < 0)
 		return -EINVAL;
@@ -49,19 +49,22 @@ static int pwm_beeper_event(struct input_dev *input,
 		return -EINVAL;
 	}
 
+	pwm_get_state(beeper->pwm, &pstate);
+
 	if (value == 0) {
-		pwm_disable(beeper->pwm);
+		pstate.enabled = false;
 	} else {
-		period = HZ_TO_NANOSECONDS(value);
-		ret = pwm_config(beeper->pwm, period / 2, period);
-		if (ret)
-			return ret;
-		ret = pwm_enable(beeper->pwm);
-		if (ret)
-			return ret;
-		beeper->period = period;
+		pstate.enabled = false;
+		pstate.period = HZ_TO_NANOSECONDS(value);
+		pstate.duty_cycle = pstate.period / 2;
 	}
 
+	ret = pwm_apply_state(beeper->pwm, &pstate);
+	if (ret)
+		return ret;
+
+	beeper->period = value ? pstate.period : 0;
+
 	return 0;
 }
 
@@ -132,10 +135,13 @@ err_free:
 static int pwm_beeper_remove(struct platform_device *pdev)
 {
 	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
+	struct pwm_state pstate;
 
 	input_unregister_device(beeper->input);
 
-	pwm_disable(beeper->pwm);
+	pwm_get_state(beeper->pwm, &pstate);
+	pstate.enabled = false;
+	pwm_apply_state(beeper->pwm, &pstate);
 	pwm_free(beeper->pwm);
 
 	kfree(beeper);
@@ -147,8 +153,13 @@ static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
-	if (beeper->period)
-		pwm_disable(beeper->pwm);
+	if (beeper->period) {
+		struct pwm_state pstate;
+
+		pwm_get_state(beeper->pwm, &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(beeper->pwm, &pstate);
+	}
 
 	return 0;
 }
@@ -158,8 +169,13 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
 	if (beeper->period) {
-		pwm_config(beeper->pwm, beeper->period / 2, beeper->period);
-		pwm_enable(beeper->pwm);
+		struct pwm_state pstate;
+
+		pwm_get_state(beeper->pwm, &pstate);
+		pstate.period = beeper->period;
+		pstate.duty_cycle = beeper->period / 2;
+		pstate.enabled = true;
+		pwm_apply_state(beeper->pwm, &pstate);
 	}
 
 	return 0;
-- 
2.5.0
