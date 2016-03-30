From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 31/46] pwm: update documentation
Date: Wed, 30 Mar 2016 22:03:54 +0200
Message-ID: <1459368249-13241-32-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBEXD6C3QKGQEK745QSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Update the PWM subsystem documentation to reflect the atomic PWM changes.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/pwm.txt | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index ca895fd..cb25fca 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -42,9 +42,23 @@ variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
 
 After being requested, a PWM has to be configured using:
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *pstate);
 
-To start/stop toggling the PWM output use pwm_enable()/pwm_disable().
+This API controls both the PWM period/duty_cycle config and the
+enable/disable state.
+
+The legacy pwm_config(), pwm_enable() and pwm_disable() are now deprecated,
+and should be replaced by pwm_apply_state() calls.
+
+The PWM user API also allows one to query the PWM state with pwm_get_state().
+
+In addition to the PWM state, the PWM API also exposes PWM arguments, which
+are the reference PWM config one should use on this PWM.
+PWM arguments are usually platform-specific and allows the PWM user to only
+care about dutycycle relatively to the full period (like, duty = 50% of the
+period). struct pwm_args contains 2 fields (period and polarity) and should
+be used to set the initial PWM config (usually done in the probe function
+of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
 Using PWMs with the sysfs interface
 -----------------------------------
@@ -105,6 +119,15 @@ goes low for the remainder of the period. Conversely, a signal with inversed
 polarity starts low for the duration of the duty cycle and goes high for the
 remainder of the period.
 
+Drivers are encouraged to implement ->apply() instead of the legacy
+->enable(), ->disable() and ->config() methods. Doing that should provide
+atomicity in the PWM config workflow, which is required when the PWM controls
+a critical device (like a regulator).
+
+The implementation of ->get_state() (a method used to retrieve initial PWM
+state) is also encouraged for the same reason: letting the PWM user know
+about the current PWM state would allow him to avoid glitches.
+
 Locking
 -------
 
-- 
2.5.0
