From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 21/24] pwm: add the core infrastructure to
 allow atomic update
Date: Thu, 14 Apr 2016 21:17:41 +0200
Message-ID: <1460661464-11216-22-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBHW2X64AKGQEFA5LB3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

pwm_adjust_config() is allowing smooth handover between the bootloader
and the kernel. This function tries to adapt the current PWM state to
the PWM arguments coming from a PWM lookup table or a DT definition
without changing the duty_cycle/period proportion.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  | 186 +++++++++++++++++++++++-------------
 include/linux/pwm.h | 269 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 302 insertions(+), 153 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0e7f687..112a696 100644
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
@@ -431,102 +446,137 @@ void pwm_free(struct pwm_device *pwm)
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
+	if (!pwm)
 		return -EINVAL;
 
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
+	if (!memcmp(state, &pwm->state, sizeof(*state)))
+		return 0;
 
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
+	if (pwm->chip->ops->apply) {
+		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+		if (err)
+			return err;
 
-	if (!pwm || !pwm->chip->ops)
-		return -EINVAL;
+		pwm->state = *state;
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
+			if (pwm->state.enabled) {
+				pwm->chip->ops->disable(pwm->chip, pwm);
+				pwm->state.enabled = false;
+			}
+
+			err = pwm->chip->ops->set_polarity(pwm->chip, pwm,
+							   state->polarity);
+			if (err)
+				return err;
+
+			pwm->state.polarity = state->polarity;
+		}
 
-	if (!pwm->chip->ops->set_polarity)
-		return -ENOSYS;
+		if (state->period != pwm->state.period ||
+		    state->duty_cycle != pwm->state.duty_cycle) {
+			err = pwm->chip->ops->config(pwm->chip, pwm,
+						     state->duty_cycle,
+						     state->period);
+			if (err)
+				return err;
 
-	if (pwm_is_enabled(pwm))
-		return -EBUSY;
+			pwm->state.duty_cycle = state->duty_cycle;
+			pwm->state.period = state->period;
+		}
 
-	err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
-	if (err)
-		return err;
+		if (state->enabled != pwm->state.enabled) {
+			if (state->enabled) {
+				err = pwm->chip->ops->enable(pwm->chip, pwm);
+				if (err)
+					return err;
+			} else {
+				pwm->chip->ops->disable(pwm->chip, pwm);
+			}
 
-	pwm->state.polarity = polarity;
+			pwm->state.enabled = state->enabled;
+		}
+	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pwm_set_polarity);
+EXPORT_SYMBOL_GPL(pwm_apply_state);
 
 /**
- * pwm_enable() - start a PWM output toggling
+ * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
  * @pwm: PWM device
  *
- * Returns: 0 on success or a negative error code on failure.
+ * This function will adjust the PWM config to the PWM arguments provided
+ * by the DT or PWM lookup table. This is particularly useful to adapt
+ * the bootloader config to the Linux one.
  */
-int pwm_enable(struct pwm_device *pwm)
+int pwm_adjust_config(struct pwm_device *pwm)
 {
-	int err = 0;
+	struct pwm_state state;
+	struct pwm_args pargs;
 
-	if (!pwm)
-		return -EINVAL;
+	pwm_get_args(pwm, &pargs);
+	pwm_get_state(pwm, &state);
+
+	/*
+	 * if the current period is zero this either means the PWM driver
+	 * does not support initial state retrieval or the PWM was not
+	 * configured.
+	 * In any case, we setup the new period and poloarity, and assign a
+	 * duty_cycle of 0.
+	 */
+	if (!state.period) {
+		state.duty_cycle = 0;
+		state.period = pargs.period;
+		state.polarity = pargs.polarity;
 
-	if (!pwm_is_enabled(pwm)) {
-		err = pwm->chip->ops->enable(pwm->chip, pwm);
-		if (!err)
-			pwm->state.enabled = true;
+		return pwm_apply_state(pwm, &state);
 	}
 
-	return err;
-}
-EXPORT_SYMBOL_GPL(pwm_enable);
+	/*
+	 * Adjust the PWM dutycycle/period based on the period value provided
+	 * in PWM args.
+	 */
+	if (pargs.period != state.period) {
+		u64 dutycycle = (u64)state.duty_cycle * pargs.period;
 
-/**
- * pwm_disable() - stop a PWM output toggling
- * @pwm: PWM device
- */
-void pwm_disable(struct pwm_device *pwm)
-{
-	if (!pwm)
-		return;
+		do_div(dutycycle, state.period);
+		state.duty_cycle = dutycycle;
+		state.period = pargs.period;
+	}
 
-	if (pwm_is_enabled(pwm)) {
-		pwm->chip->ops->disable(pwm->chip, pwm);
-		pwm->state.enabled = false;
+	/*
+	 * If the polarity changed, we should also change the dutycycle value.
+	 */
+	if (pargs.polarity != state.polarity) {
+		state.polarity = pargs.polarity;
+		state.duty_cycle = state.period - state.duty_cycle;
 	}
+
+	return pwm_apply_state(pwm, &state);
 }
-EXPORT_SYMBOL_GPL(pwm_disable);
+EXPORT_SYMBOL_GPL(pwm_adjust_config);
 
 static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 73ca679..2ec9200 100644
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
 	return state.duty_cycle;
 }
 
-/*
- * pwm_set_polarity - configure the polarity of a PWM signal
- */
-int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
-
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
@@ -203,34 +146,6 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 	*args = pwm->args;
 }
 
-static inline void pwm_apply_args(struct pwm_device *pwm)
-{
-	/*
-	 * PWM users calling pwm_apply_args() expect to have a fresh config
-	 * where the polarity and period are set according to pwm_args info.
-	 * The problem is, polarity can only be changed when the PWM is
-	 * disabled.
-	 *
-	 * PWM drivers supporting hardware readout may declare the PWM device
-	 * as enabled, and prevent polarity setting, which changes from the
-	 * existing behavior, where all PWM devices are declared as disabled
-	 * at startup (even if they are actually enabled), thus authorizing
-	 * polarity setting.
-	 *
-	 * Instead of setting ->enabled to false, we call pwm_disable()
-	 * before pwm_set_polarity() to ensure that everything is configured
-	 * as expected, and the PWM is really disabled when the user request
-	 * it.
-	 *
-	 * Note that PWM users requiring a smooth handover between the
-	 * bootloader and the kernel (like critical regulators controlled by
-	 * PWM devices) will have to switch to the atomic API and avoid calling
-	 * pwm_apply_args().
-	 */
-	pwm_disable(pwm);
-	pwm_set_polarity(pwm, pwm->args.polarity);
-}
-
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
@@ -239,6 +154,10 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
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
@@ -254,6 +173,8 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
+		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
 #ifdef CONFIG_DEBUG_FS
@@ -291,6 +212,115 @@ struct pwm_chip {
 };
 
 #if IS_ENABLED(CONFIG_PWM)
+/* PWM user APIs */
+struct pwm_device *pwm_request(int pwm_id, const char *label);
+void pwm_free(struct pwm_device *pwm);
+int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+int pwm_adjust_config(struct pwm_device *pwm);
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
+	struct pwm_state state;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &state);
+	if (state.duty_cycle == duty_ns && state.period == period_ns)
+		return 0;
+
+	state.duty_cycle = duty_ns;
+	state.period = period_ns;
+	return pwm_apply_state(pwm, &state);
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
+	struct pwm_state state;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &state);
+	if (state.polarity == polarity)
+		return 0;
+
+	/*
+	 * Changing the polarity of a running PWM without adjusting the
+	 * dutycycle/period value is a bit risky (can introduce glitches).
+	 * Return -EBUSY in this case.
+	 * Note that this is allowed when using pwm_apply_state() because
+	 * the user specifies all the parameters.
+	 */
+	if (state.enabled)
+		return -EBUSY;
+
+	state.polarity = polarity;
+	return pwm_apply_state(pwm, &state);
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
+	struct pwm_state state;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &state);
+	if (state.enabled)
+		return 0;
+
+	state.enabled = true;
+	return pwm_apply_state(pwm, &state);
+}
+
+/**
+ * pwm_disable() - stop a PWM output toggling
+ * @pwm: PWM device
+ */
+static inline void pwm_disable(struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	if (!pwm)
+		return;
+
+	pwm_get_state(pwm, &state);
+	if (!state.enabled)
+		return;
+
+	state.enabled = false;
+	pwm_apply_state(pwm, &state);
+}
+
+
+/* PWM provider APIs */
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
@@ -316,6 +346,47 @@ void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 
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
+static inline int pwm_adjust_config(struct pwm_device *pwm)
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
@@ -387,6 +458,34 @@ static inline bool pwm_can_sleep(struct pwm_device *pwm)
 }
 #endif
 
+static inline void pwm_apply_args(struct pwm_device *pwm)
+{
+	/*
+	 * PWM users calling pwm_apply_args() expect to have a fresh config
+	 * where the polarity and period are set according to pwm_args info.
+	 * The problem is, polarity can only be changed when the PWM is
+	 * disabled.
+	 *
+	 * PWM drivers supporting hardware readout may declare the PWM device
+	 * as enabled, and prevent polarity setting, which changes from the
+	 * existing behavior, where all PWM devices are declared as disabled
+	 * at startup (even if they are actually enabled), thus authorizing
+	 * polarity setting.
+	 *
+	 * Instead of setting ->enabled to false, we call pwm_disable()
+	 * before pwm_set_polarity() to ensure that everything is configured
+	 * as expected, and the PWM is really disabled when the user request
+	 * it.
+	 *
+	 * Note that PWM users requiring a smooth handover between the
+	 * bootloader and the kernel (like critical regulators controlled by
+	 * PWM devices) will have to switch to the atomic API and avoid calling
+	 * pwm_apply_args().
+	 */
+	pwm_disable(pwm);
+	pwm_set_polarity(pwm, pwm->args.polarity);
+}
+
 struct pwm_lookup {
 	struct list_head list;
 	const char *provider;
-- 
2.5.0
