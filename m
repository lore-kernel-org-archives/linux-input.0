From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 32/46] pwm: deprecate pwm_config(),
 pwm_enable() and pwm_disable()
Date: Wed, 30 Mar 2016 22:03:55 +0200
Message-ID: <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBFPD6C3QKGQEJOQ6ZKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Prefix those function as deprecated to encourage all existing users to
switch to pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 include/linux/pwm.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4aad4eb..9bac10f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -225,8 +225,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
+					  int period_ns)
 {
 	struct pwm_state pstate;
 
@@ -252,8 +252,8 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
+						enum pwm_polarity polarity)
 {
 	struct pwm_state pstate;
 
@@ -284,7 +284,7 @@ static inline int pwm_set_polarity(struct pwm_device *pwm,
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_enable(struct pwm_device *pwm)
+static inline int __deprecated pwm_enable(struct pwm_device *pwm)
 {
 	struct pwm_state pstate;
 
@@ -303,7 +303,7 @@ static inline int pwm_enable(struct pwm_device *pwm)
  * pwm_disable() - stop a PWM output toggling
  * @pwm: PWM device
  */
-static inline void pwm_disable(struct pwm_device *pwm)
+static inline void __deprecated pwm_disable(struct pwm_device *pwm)
 {
 	struct pwm_state pstate;
 
@@ -360,24 +360,24 @@ static inline int pwm_apply_state(struct pwm_device *pwm,
 	return -ENOTSUPP;
 }
 
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
+					  int period_ns)
 {
 	return -EINVAL;
 }
 
-static inline int pwm_set_polarity(struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
+						enum pwm_polarity polarity)
 {
 	return -ENOTSUPP;
 }
 
-static inline int pwm_enable(struct pwm_device *pwm)
+static inline int __deprecated pwm_enable(struct pwm_device *pwm)
 {
 	return -EINVAL;
 }
 
-static inline void pwm_disable(struct pwm_device *pwm)
+static inline void __deprecated pwm_disable(struct pwm_device *pwm)
 {
 }
 
-- 
2.5.0
