From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 20/24] pwm: add the core infrastructure to allow atomic update
Date: Mon, 16 Nov 2015 09:56:43 +0100
Message-ID: <1447664207-24370-21-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34687 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752460AbbKPI5S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 03:57:18 -0500
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbd

Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
implement atomic update.
This method will be preferred over the ->enable(), ->disable() and
->config() methods if available.

Add the pwm_get_state(), pwm_get_default_state() and pwm_apply_state()
functions for PWM users to be able to use the atomic update feature.

Note that the pwm_apply_state() does not guarantee the atomicity of the
update operation, it all depends on the availability and implementation
of the ->apply() method.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/core.c  | 124 +++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h |  27 ++++++++++++
 2 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ce8b373..fbc71d3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -46,6 +46,12 @@ static struct pwm_device *pwm_to_device(unsigned int pwm)
 	return radix_tree_lookup(&pwm_tree, pwm);
 }
 
+static void pwm_set_state(struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	pwm->state = *state;
+}
+
 static int alloc_pwms(int pwm, unsigned int count)
 {
 	unsigned int from = 0;
@@ -226,6 +232,19 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
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
@@ -244,8 +263,10 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
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
@@ -446,7 +467,19 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.period = period_ns;
+		state.duty_cycle = duty_ns;
+
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+	} else {
+		err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns,
+					     period_ns);
+	}
+
 	if (err)
 		return err;
 
@@ -474,6 +507,18 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
+	if (pwm->chip->ops->apply) {
+		struct pwm_state state;
+
+		pwm_get_state(pwm, &state);
+		state.polarity = polarity;
+		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+		if (!err)
+			pwm->state.polarity = polarity;
+
+		return err;
+	}
+
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
@@ -512,7 +557,17 @@ int pwm_enable(struct pwm_device *pwm)
 	mutex_lock(&pwm->lock);
 
 	if (!pwm_is_enabled(pwm)) {
-		err = pwm->chip->ops->enable(pwm->chip, pwm);
+		if (pwm->chip->ops->apply) {
+			struct pwm_state state;
+
+			pwm_get_state(pwm, &state);
+			state.enabled = true;
+
+			err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
+		} else {
+			err = pwm->chip->ops->enable(pwm->chip, pwm);
+		}
+
 		if (!err)
 			pwm->state.enabled = true;
 	}
@@ -535,7 +590,16 @@ void pwm_disable(struct pwm_device *pwm)
 	mutex_lock(&pwm->lock);
 
 	if (pwm_is_enabled(pwm)) {
-		pwm->chip->ops->disable(pwm->chip, pwm);
+		if (pwm->chip->ops->apply) {
+			struct pwm_state state;
+
+			pwm_get_state(pwm, &state);
+			state.enabled = false;
+
+			pwm->chip->ops->apply(pwm->chip, pwm, &state);
+		} else {
+			pwm->chip->ops->disable(pwm->chip, pwm);
+		}
 		pwm->state.enabled = false;
 	}
 
@@ -543,6 +607,56 @@ void pwm_disable(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
+/**
+ * pwm_apply_state() - atomically apply a new state to a PWM device
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err = 0;
+
+	if (!pwm)
+		return -EINVAL;
+
+	if (!memcmp(state, &pwm->state, sizeof(*state)))
+		return 0;
+
+	if (pwm->chip->ops->apply) {
+		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+		if (!err)
+			pwm_set_state(pwm, state);
+	} else {
+		/*
+		 * FIXME: restore the initial state in case of error.
+		 */
+		if (state->polarity != pwm->state.polarity) {
+			pwm_disable(pwm);
+			err = pwm_set_polarity(pwm, state->polarity);
+			if (err)
+				goto out;
+		}
+
+		if (state->period != pwm->state.period ||
+		    state->duty_cycle != pwm->state.duty_cycle) {
+			err = pwm_config(pwm, state->period, state->duty_cycle);
+			if (err)
+				goto out;
+		}
+
+		if (state->enabled != pwm->state.enabled) {
+			if (state->enabled)
+				err = pwm_enable(pwm);
+			else
+				pwm_disable(pwm);
+		}
+	}
+
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_apply_state);
+
 static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index caa0ffe..5e7b378 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -174,6 +174,30 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
+
+/**
+ * pwm_get_state() - retrieve the current PWM state
+ * @pwm: PWM device
+ * @state: state to fill with the current PWM state
+ */
+static inline void pwm_get_state(struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	*state = pwm->state;
+}
+
+/**
+ * pwm_get_default_state() - retrieve the default PWM state
+ * @pwm: PWM device
+ * @state: state to fill with the default PWM state
+ */
+static inline void pwm_get_default_state(struct pwm_device *pwm,
+					 struct pwm_state *state)
+{
+	*state = pwm->default_state;
+}
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
@@ -182,6 +206,7 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @apply: atomically apply a new PWM config
  * @reset_state: reset the current PWM state (pwm->state) to the actual
  *		 hardware state. This function is only called once per
  *		 PWM device when the PWM chip is registered.
@@ -197,6 +222,8 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
+		     const struct pwm_state *state);
 	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
-- 
2.1.4

