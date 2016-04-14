From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 17/24] pwm: keep PWM state in sync with
 hardware state
Date: Thu, 14 Apr 2016 21:17:37 +0200
Message-ID: <1460661464-11216-18-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBFG2X64AKGQE3UOKG2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Before the introduction of pwm_args, the core was resetting the PWM period
and polarity states to the reference values (those provided through the
DT, a PWM lookup table or hardcoded in the driver).

Now that all PWM users are correctly using pwm_args to configure their
PWM device, we can safely remove the pwm_apply_args() call in
pwm_device_request().

We can also get rid of the pwm_set_period() call done in
pwm_apply_args(), because PWM users are now directly using pargs->period
instead of pwm_get_period(). By doing that we avoid messing with the
current PWM period.

The only remaining bit in pwm_apply_args() is the initial polarity
setting, and it should go away when all PWM users have been patched to
use the atomic API (with this API the polarity will be set along with
other PWM arguments when configuring the PWM).

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/core.c  | 8 --------
 include/linux/pwm.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ac89529..26c3cf5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -128,14 +128,6 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	set_bit(PWMF_REQUESTED, &pwm->flags);
 	pwm->label = label;
 
-	/*
-	 * FIXME: this should be removed as soon as all PWM users are
-	 * properly making use of pwm_args to initialize the PWM device.
-	 * If we don't get rid of it, then PWM state and hardware can be
-	 * desynchronized.
-	 */
-	pwm_apply_args(pwm);
-
 	return 0;
 }
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c8859b7..2f500a5 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -170,7 +170,6 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
-	pwm_set_period(pwm, pwm->args.period);
 	pwm_set_polarity(pwm, pwm->args.polarity);
 }
 
-- 
2.5.0
