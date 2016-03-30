From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 18/46] pwm: add the core infrastructure to
 allow atomic update
Date: Wed, 30 Mar 2016 22:03:41 +0200
Message-ID: <1459368249-13241-19-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB3PC6C3QKGQEYMFK54I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
implement atomic update.
This method will be preferred over the ->enable(), ->disable() and
->config() methods if available.

Add the pwm_apply_state() function to the PWM user API.

Note that the pwm_apply_state() does not guarantee the atomicity of the
update operation, it all depends on the availability and implementation
of the ->apply() method.

pwm_enable/disable/set_polarity/config() are now implemented as wrappers
around the pwm_apply_state() function.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  | 155 ++++++++++++++++++---------------------
 include/linux/pwm.h | 207 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 220 insertions(+), 142 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a909c64..62e6b3c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -226,6 +226,19 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
+static bool pwm_ops_check(const struct pwm_ops *ops)
+{
+	/* driver supports legacy, non-atomic operation */
+	if (ops->config && ops->enable && ops->disable)
+		return true;
+
+	/* driver supports atomic operation */
+	if (ops->apply)
+		return true;
+
+	return false;
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -244,8 +257,10 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	unsigned int i;
 	int ret;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
-	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
+	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+		return -EINVAL;
+
+	if (!pwm_ops_check(chip->ops))
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
@@ -431,102 +446,72 @@ void pwm_free(struct pwm_device *pwm)
 EXPORT_SYMBOL_GPL(pwm_free);
 
 /**
- * pwm_config() - change a PWM device configuration
+ * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
- * @duty_ns: "on" time (in nanoseconds)
- * @period_ns: duration (in nanoseconds) of one cycle
- *
- * Returns: 0 on success or a negative error code on failure.
+ * @state: new state to apply. This can be adjusted by the PWM driver
+ *	   if the requested config is not achievable, for example,
+ *	   ->duty_cycle and ->period might be approximated.
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 {
 	int err;
 
-	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
-		return -EINVAL;
-
-	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
-	if (err)
-		return err;
-
-	pwm->state.duty_cycle = duty_ns;
-	pwm->state.period = period_ns;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pwm_config);
-
-/**
- * pwm_set_polarity() - configure the polarity of a PWM signal
- * @pwm: PWM device
- * @polarity: new polarity of the PWM signal
- *
- * Note that the polarity cannot be configured while the PWM device is
- * enabled.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
-{
-	int err;
-
-	if (!pwm || !pwm->chip->ops)
-		return -EINVAL;
-
-	if (!pwm->chip->ops->set_polarity)
-		return -ENOSYS;
-
-	if (pwm_is_enabled(pwm))
-		return -EBUSY;
-
-	err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
-	if (err)
-		return err;
-
-	pwm->state.polarity = polarity;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pwm_set_polarity);
-
-/**
- * pwm_enable() - start a PWM output toggling
- * @pwm: PWM device
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwm_enable(struct pwm_device *pwm)
-{
-	int err = 0;
-
 	if (!pwm)
 		return -EINVAL;
 
-	if (!pwm_is_enabled(pwm)) {
-		err = pwm->chip->ops->enable(pwm->chip, pwm);
-		if (!err)
-			pwm->state.enabled = true;
-	}
+	if (!memcmp(state, &pwm->state, sizeof(*state)))
+		return 0;
 
-	return err;
-}
-EXPORT_SYMBOL_GPL(pwm_enable);
+	if (pwm->chip->ops->apply) {
+		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+		if (err)
+			return err;
+	} else {
+		/*
+		 * FIXME: restore the initial state in case of error.
+		 */
+		if (state->polarity != pwm->state.polarity) {
+			if (!pwm->chip->ops->set_polarity)
+				return -ENOTSUPP;
+
+			/*
+			 * Changing the polarity of a running PWM is
+			 * only allowed when the PWM driver implements
+			 * ->apply().
+			 */
+			if (pwm->state.enabled)
+				return -EBUSY;
+
+			err = pwm->chip->ops->set_polarity(pwm->chip, pwm,
+							   state->polarity);
+			if (err)
+				return err;
+		}
 
-/**
- * pwm_disable() - stop a PWM output toggling
- * @pwm: PWM device
- */
-void pwm_disable(struct pwm_device *pwm)
-{
-	if (!pwm)
-		return;
+		if (state->period != pwm->state.period ||
+		    state->duty_cycle != pwm->state.duty_cycle) {
+			err = pwm->chip->ops->config(pwm->chip, pwm,
+						     state->period,
+						     state->duty_cycle);
+			if (err)
+				return err;
+		}
 
-	if (pwm_is_enabled(pwm)) {
-		pwm->chip->ops->disable(pwm->chip, pwm);
-		pwm->state.enabled = false;
+		if (state->enabled != pwm->state.enabled) {
+			if (state->enabled) {
+				err = pwm->chip->ops->enable(pwm->chip, pwm);
+				if (err)
+					return err;
+			} else {
+				pwm->chip->ops->disable(pwm->chip, pwm);
+			}
+		}
 	}
+
+	pwm->state = *state;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pwm_disable);
+EXPORT_SYMBOL_GPL(pwm_apply_state);
 
 static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index ceedcf8..4aad4eb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,59 +5,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 
-struct pwm_device;
 struct seq_file;
-
-#if IS_ENABLED(CONFIG_PWM)
-/*
- * pwm_request - request a PWM device
- */
-struct pwm_device *pwm_request(int pwm_id, const char *label);
-
-/*
- * pwm_free - free a PWM device
- */
-void pwm_free(struct pwm_device *pwm);
-
-/*
- * pwm_config - change a PWM device configuration
- */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
-
-/*
- * pwm_enable - start a PWM output toggling
- */
-int pwm_enable(struct pwm_device *pwm);
-
-/*
- * pwm_disable - stop a PWM output toggling
- */
-void pwm_disable(struct pwm_device *pwm);
-#else
-static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-static inline void pwm_free(struct pwm_device *pwm)
-{
-}
-
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	return -EINVAL;
-}
-
-static inline int pwm_enable(struct pwm_device *pwm)
-{
-	return -EINVAL;
-}
-
-static inline void pwm_disable(struct pwm_device *pwm)
-{
-}
-#endif
-
 struct pwm_chip;
 
 /**
@@ -183,11 +131,6 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 	return pstate.duty_cycle;
 }
 
-/*
- * pwm_set_polarity - configure the polarity of a PWM signal
- */
-int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
-
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state pstate;
@@ -211,6 +154,10 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @apply: atomically apply a new PWM config. The state argument
+ *	   should be adjusted with the real hardware config (if the
+ *	   approximate the period or duty_cycle value, state should
+ *	   reflect it)
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
@@ -226,6 +173,8 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
+		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *pstate);
 #ifdef CONFIG_DEBUG_FS
@@ -263,6 +212,114 @@ struct pwm_chip {
 };
 
 #if IS_ENABLED(CONFIG_PWM)
+/* PWM user APIs */
+struct pwm_device *pwm_request(int pwm_id, const char *label);
+void pwm_free(struct pwm_device *pwm);
+int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+
+/**
+ * pwm_config() - change a PWM device configuration
+ * @pwm: PWM device
+ * @duty_ns: "on" time (in nanoseconds)
+ * @period_ns: duration (in nanoseconds) of one cycle
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
+			     int period_ns)
+{
+	struct pwm_state pstate;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &pstate);
+	if (pstate.duty_cycle == duty_ns && pstate.period == period_ns)
+		return 0;
+
+	pstate.duty_cycle = duty_ns;
+	pstate.period = period_ns;
+	return pwm_apply_state(pwm, &pstate);
+}
+
+/**
+ * pwm_set_polarity() - configure the polarity of a PWM signal
+ * @pwm: PWM device
+ * @polarity: new polarity of the PWM signal
+ *
+ * Note that the polarity cannot be configured while the PWM device is
+ * enabled.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_set_polarity(struct pwm_device *pwm,
+				   enum pwm_polarity polarity)
+{
+	struct pwm_state pstate;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &pstate);
+	if (pstate.polarity == polarity)
+		return 0;
+
+	/*
+	 * Changing the polarity of a running PWM without adjusting the
+	 * dutycycle/period value is a bit risky (can introduce glitches).
+	 * Return -EBUSY in this case.
+	 * Note that this is allowed when using pwm_apply_state() because
+	 * the user specifies all the parameters.
+	 */
+	if (pstate.enabled)
+		return -EBUSY;
+
+	pstate.polarity = polarity;
+	return pwm_apply_state(pwm, &pstate);
+}
+
+/**
+ * pwm_enable() - start a PWM output toggling
+ * @pwm: PWM device
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_enable(struct pwm_device *pwm)
+{
+	struct pwm_state pstate;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &pstate);
+	if (pstate.enabled)
+		return 0;
+
+	pstate.enabled = true;
+	return pwm_apply_state(pwm, &pstate);
+}
+
+/**
+ * pwm_disable() - stop a PWM output toggling
+ * @pwm: PWM device
+ */
+static inline void pwm_disable(struct pwm_device *pwm)
+{
+	struct pwm_state pstate;
+
+	if (!pwm)
+		return;
+
+	pwm_get_state(pwm, &pstate);
+	if (!pstate.enabled)
+		return;
+
+	pstate.enabled = false;
+	pwm_apply_state(pwm, &pstate);
+}
+
+
+/* PWM provider APIs */
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
@@ -288,6 +345,42 @@ void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 
 bool pwm_can_sleep(struct pwm_device *pwm);
 #else
+static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void pwm_free(struct pwm_device *pwm)
+{
+}
+
+static inline int pwm_apply_state(struct pwm_device *pwm,
+				  const struct pwm_state *state)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
+			     int period_ns)
+{
+	return -EINVAL;
+}
+
+static inline int pwm_set_polarity(struct pwm_device *pwm,
+				   enum pwm_polarity polarity)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pwm_enable(struct pwm_device *pwm)
+{
+	return -EINVAL;
+}
+
+static inline void pwm_disable(struct pwm_device *pwm)
+{
+}
+
 static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
 {
 	return -EINVAL;
-- 
2.5.0
