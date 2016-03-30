From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 04/46] pwm: get rid of pwm->lock
Date: Wed, 30 Mar 2016 22:03:27 +0200
Message-ID: <1459368249-13241-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBU7C6C3QKGQEODJHVYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

PWM devices are not protected against concurrent accesses. The lock in
pwm_device might let PWM users think it is, but it's actually only
protecting the enabled state.

Removing this lock should be fine as long as all PWM users are aware that
accesses to the PWM device have to be serialized, which seems to be the
case for all of them except the sysfs interface.
Patch the sysfs code by adding a lock to the pwm_export struct and making
sure it's taken for all accesses to the exported PWM device.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  | 19 ++++--------------
 drivers/pwm/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----------
 include/linux/pwm.h |  2 --
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7831bc6..7c330ff 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -269,7 +269,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->polarity = polarity;
-		mutex_init(&pwm->lock);
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -474,22 +473,16 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
-	mutex_lock(&pwm->lock);
-
-	if (pwm_is_enabled(pwm)) {
-		err = -EBUSY;
-		goto unlock;
-	}
+	if (pwm_is_enabled(pwm))
+		return -EBUSY;
 
 	err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
 	if (err)
-		goto unlock;
+		return err;
 
 	pwm->polarity = polarity;
 
-unlock:
-	mutex_unlock(&pwm->lock);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
 
@@ -506,16 +499,12 @@ int pwm_enable(struct pwm_device *pwm)
 	if (!pwm)
 		return -EINVAL;
 
-	mutex_lock(&pwm->lock);
-
 	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
 		err = pwm->chip->ops->enable(pwm->chip, pwm);
 		if (err)
 			clear_bit(PWMF_ENABLED, &pwm->flags);
 	}
 
-	mutex_unlock(&pwm->lock);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..ab28c89 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -26,6 +26,7 @@
 struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
+	struct mutex lock;
 };
 
 static struct pwm_export *child_to_pwm_export(struct device *child)
@@ -44,16 +45,23 @@ static ssize_t period_show(struct device *child,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	const struct pwm_device *pwm = export->pwm;
+	unsigned int period;
+
+	mutex_lock(&export->lock);
+	period = pwm_get_period(pwm);
+	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%u\n", pwm_get_period(pwm));
+	return sprintf(buf, "%u\n", period);
 }
 
 static ssize_t period_store(struct device *child,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
 	unsigned int val;
 	int ret;
 
@@ -61,7 +69,9 @@ static ssize_t period_store(struct device *child,
 	if (ret)
 		return ret;
 
+	mutex_lock(&export->lock);
 	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), val);
+	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -70,16 +80,23 @@ static ssize_t duty_cycle_show(struct device *child,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	const struct pwm_device *pwm = export->pwm;
+	unsigned int duty;
+
+	mutex_lock(&export->lock);
+	duty = pwm_get_duty_cycle(pwm);
+	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%u\n", pwm_get_duty_cycle(pwm));
+	return sprintf(buf, "%u\n", duty);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
 				struct device_attribute *attr,
 				const char *buf, size_t size)
 {
-	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
 	unsigned int val;
 	int ret;
 
@@ -87,7 +104,9 @@ static ssize_t duty_cycle_store(struct device *child,
 	if (ret)
 		return ret;
 
+	mutex_lock(&export->lock);
 	ret = pwm_config(pwm, val, pwm_get_period(pwm));
+	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -96,22 +115,30 @@ static ssize_t enable_show(struct device *child,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	const struct pwm_device *pwm = export->pwm;
+	bool enabled;
+
+	mutex_lock(&export->lock);
+	enabled = pwm_is_enabled(pwm);
+	mutex_unlock(&export->lock);
 
-	return sprintf(buf, "%d\n", pwm_is_enabled(pwm));
+	return sprintf(buf, "%d\n", enabled);
 }
 
 static ssize_t enable_store(struct device *child,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
 	int val, ret;
 
 	ret = kstrtoint(buf, 0, &val);
 	if (ret)
 		return ret;
 
+	mutex_lock(&export->lock);
 	switch (val) {
 	case 0:
 		pwm_disable(pwm);
@@ -123,6 +150,7 @@ static ssize_t enable_store(struct device *child,
 		ret = -EINVAL;
 		break;
 	}
+	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -131,9 +159,11 @@ static ssize_t polarity_show(struct device *child,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	const struct pwm_device *pwm = export->pwm;
 	const char *polarity = "unknown";
 
+	mutex_lock(&export->lock);
 	switch (pwm_get_polarity(pwm)) {
 	case PWM_POLARITY_NORMAL:
 		polarity = "normal";
@@ -143,6 +173,7 @@ static ssize_t polarity_show(struct device *child,
 		polarity = "inversed";
 		break;
 	}
+	mutex_unlock(&export->lock);
 
 	return sprintf(buf, "%s\n", polarity);
 }
@@ -151,7 +182,8 @@ static ssize_t polarity_store(struct device *child,
 			      struct device_attribute *attr,
 			      const char *buf, size_t size)
 {
-	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
 	enum pwm_polarity polarity;
 	int ret;
 
@@ -162,7 +194,9 @@ static ssize_t polarity_store(struct device *child,
 	else
 		return -EINVAL;
 
+	mutex_lock(&export->lock);
 	ret = pwm_set_polarity(pwm, polarity);
+	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -203,6 +237,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	}
 
 	export->pwm = pwm;
+	mutex_init(&export->lock);
 
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cfc3ed4..6555f01 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -88,7 +88,6 @@ enum {
  * @pwm: global index of the PWM device
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
- * @lock: used to serialize accesses to the PWM device where necessary
  * @period: period of the PWM signal (in nanoseconds)
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  * @polarity: polarity of the PWM signal
@@ -100,7 +99,6 @@ struct pwm_device {
 	unsigned int pwm;
 	struct pwm_chip *chip;
 	void *chip_data;
-	struct mutex lock;
 
 	unsigned int period;
 	unsigned int duty_cycle;
-- 
2.5.0
