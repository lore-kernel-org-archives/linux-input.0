From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 19/46] pwm: switch to the atomic API
Date: Wed, 30 Mar 2016 22:03:42 +0200
Message-ID: <1459368249-13241-20-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB3XC6C3QKGQE26OCL2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Replace legacy pwm_get/set_xxx() and pwm_config/enable/disable() calls
by pwm_get/apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  |  5 ++++-
 drivers/pwm/sysfs.c | 61 +++++++++++++++++++++++++++++++----------------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 62e6b3c..c2b1569 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -882,13 +882,16 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
+		struct pwm_state pstate;
+
+		pwm_get_state(pwm, &pstate);
 
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
 
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
 
-		if (pwm_is_enabled(pwm))
+		if (pstate.enabled)
 			seq_puts(s, " enabled");
 
 		seq_puts(s, "\n");
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ab28c89..7ec1747 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -47,13 +47,13 @@ static ssize_t period_show(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	const struct pwm_device *pwm = export->pwm;
-	unsigned int period;
+	struct pwm_state pstate;
 
 	mutex_lock(&export->lock);
-	period = pwm_get_period(pwm);
+	pwm_get_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%u\n", period);
+	return sprintf(buf, "%u\n", pstate.period);
 }
 
 static ssize_t period_store(struct device *child,
@@ -62,6 +62,7 @@ static ssize_t period_store(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
+	struct pwm_state pstate;
 	unsigned int val;
 	int ret;
 
@@ -70,7 +71,9 @@ static ssize_t period_store(struct device *child,
 		return ret;
 
 	mutex_lock(&export->lock);
-	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), val);
+	pwm_get_state(pwm, &pstate);
+	pstate.period = val;
+	ret = pwm_apply_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
 	return ret ? : size;
@@ -82,13 +85,13 @@ static ssize_t duty_cycle_show(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	const struct pwm_device *pwm = export->pwm;
-	unsigned int duty;
+	struct pwm_state pstate;
 
 	mutex_lock(&export->lock);
-	duty = pwm_get_duty_cycle(pwm);
+	pwm_get_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%u\n", duty);
+	return sprintf(buf, "%u\n", pstate.duty_cycle);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
@@ -97,6 +100,7 @@ static ssize_t duty_cycle_store(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
+	struct pwm_state pstate;
 	unsigned int val;
 	int ret;
 
@@ -105,7 +109,9 @@ static ssize_t duty_cycle_store(struct device *child,
 		return ret;
 
 	mutex_lock(&export->lock);
-	ret = pwm_config(pwm, val, pwm_get_period(pwm));
+	pwm_get_state(pwm, &pstate);
+	pstate.duty_cycle = val;
+	ret = pwm_apply_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
 	return ret ? : size;
@@ -117,13 +123,13 @@ static ssize_t enable_show(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	const struct pwm_device *pwm = export->pwm;
-	bool enabled;
+	struct pwm_state pstate;
 
 	mutex_lock(&export->lock);
-	enabled = pwm_is_enabled(pwm);
+	pwm_get_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%d\n", enabled);
+	return sprintf(buf, "%d\n", pstate.enabled);
 }
 
 static ssize_t enable_store(struct device *child,
@@ -132,24 +138,20 @@ static ssize_t enable_store(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
+	struct pwm_state pstate;
 	int val, ret;
 
 	ret = kstrtoint(buf, 0, &val);
 	if (ret)
 		return ret;
 
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
 	mutex_lock(&export->lock);
-	switch (val) {
-	case 0:
-		pwm_disable(pwm);
-		break;
-	case 1:
-		ret = pwm_enable(pwm);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	pwm_get_state(pwm, &pstate);
+	pstate.enabled = val;
+	ret = pwm_apply_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
 	return ret ? : size;
@@ -162,9 +164,13 @@ static ssize_t polarity_show(struct device *child,
 	struct pwm_export *export = child_to_pwm_export(child);
 	const struct pwm_device *pwm = export->pwm;
 	const char *polarity = "unknown";
+	struct pwm_state pstate;
 
 	mutex_lock(&export->lock);
-	switch (pwm_get_polarity(pwm)) {
+	pwm_get_state(pwm, &pstate);
+	mutex_unlock(&export->lock);
+
+	switch (pstate.polarity) {
 	case PWM_POLARITY_NORMAL:
 		polarity = "normal";
 		break;
@@ -173,7 +179,6 @@ static ssize_t polarity_show(struct device *child,
 		polarity = "inversed";
 		break;
 	}
-	mutex_unlock(&export->lock);
 
 	return sprintf(buf, "%s\n", polarity);
 }
@@ -185,6 +190,7 @@ static ssize_t polarity_store(struct device *child,
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
 	enum pwm_polarity polarity;
+	struct pwm_state pstate;
 	int ret;
 
 	if (sysfs_streq(buf, "normal"))
@@ -195,7 +201,12 @@ static ssize_t polarity_store(struct device *child,
 		return -EINVAL;
 
 	mutex_lock(&export->lock);
-	ret = pwm_set_polarity(pwm, polarity);
+	pwm_get_state(pwm, &pstate);
+	pstate.polarity = polarity;
+	if (pstate.enabled)
+		ret = -EBUSY;
+	else
+		ret = pwm_apply_state(pwm, &pstate);
 	mutex_unlock(&export->lock);
 
 	return ret ? : size;
-- 
2.5.0
