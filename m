From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 05/46] pwm: introduce the pwm_args concept
Date: Wed, 30 Mar 2016 22:03:28 +0200
Message-ID: <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBVXC6C3QKGQEF3MIIQQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Currently the PWM core mixes the current PWM state with the per-platform
reference config (specified through the PWM lookup table, DT definition or
directly hardcoded in PWM drivers).

Create a pwm_args struct to store this reference config, so that PWM users
can differentiate the current config from the reference one.

Patch all places where pwm->args should be initialized. We keep the
pwm_set_polarity/period() calls until all PWM users are patched to
use pwm_args instead of pwm_get_period/polarity().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c         | 13 +++++++++----
 drivers/pwm/pwm-clps711x.c |  3 ++-
 drivers/pwm/pwm-pxa.c      |  1 +
 include/linux/pwm.h        | 26 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7c330ff..cd55d61 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -146,12 +146,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm_set_period(pwm, args->args[1]);
+	pwm->args.period = args->args[1];
+	pwm_set_period(pwm, pwm->args.period);
 
 	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
 	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+		pwm->args.polarity = PWM_POLARITY_NORMAL;
+	pwm_set_polarity(pwm, pwm->args.polarity);
 
 	return pwm;
 }
@@ -172,7 +174,8 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm_set_period(pwm, args->args[1]);
+	pwm->args.period = args->args[1];
+	pwm_set_period(pwm, pwm->args.period);
 
 	return pwm;
 }
@@ -740,6 +743,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ERR(pwm))
 		goto out;
 
+	pwm->args.period = chosen->period;
+	pwm->args.polarity = chosen->polarity;
 	pwm_set_period(pwm, chosen->period);
 	pwm_set_polarity(pwm, chosen->polarity);
 
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index a80c108..807a48d 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -60,7 +60,8 @@ static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return -EINVAL;
 
 	/* Store constant period value */
-	pwm_set_period(pwm, DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq));
+	pwm->args.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
+	pwm_set_period(pwm, pwm->args.period);
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cb2f702..3fcc886 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -160,6 +160,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
+	pwm->args.period = args->args[0];
 	pwm_set_period(pwm, args->args[0]);
 
 	return pwm;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 6555f01..ed65354 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -74,6 +74,23 @@ enum pwm_polarity {
 	PWM_POLARITY_INVERSED,
 };
 
+/**
+ * struct pwm_args - PWM arguments
+ * @period: reference period
+ * @polarity: reference polarity
+ *
+ * This structure describe board-dependent arguments attached to a PWM
+ * device. Those arguments are usually retrieved from the PWM lookup table or
+ * DT definition.
+ * This should not be confused with the PWM state: PWM args not representing
+ * the current PWM state, but the configuration the PWM user plan to use
+ * on this PWM device.
+ */
+struct pwm_args {
+	unsigned int period;
+	enum pwm_polarity polarity;
+};
+
 enum {
 	PWMF_REQUESTED = 1 << 0,
 	PWMF_ENABLED = 1 << 1,
@@ -91,6 +108,7 @@ enum {
  * @period: period of the PWM signal (in nanoseconds)
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  * @polarity: polarity of the PWM signal
+ * @args: PWM arguments
  */
 struct pwm_device {
 	const char *label;
@@ -103,6 +121,8 @@ struct pwm_device {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+
+	struct pwm_args args;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -142,6 +162,12 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
 }
 
+static inline void pwm_get_args(const struct pwm_device *pwm,
+				struct pwm_args *args)
+{
+	*args = pwm->args;
+}
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
-- 
2.5.0
