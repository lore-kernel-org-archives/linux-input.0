From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 45/46] drm: i915: switch to the atomic PWM API
Date: Wed, 30 Mar 2016 22:04:08 +0200
Message-ID: <1459368249-13241-46-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBPHD6C3QKGQEF4KWZTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/gpu/drm/i915/intel_panel.c | 39 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index 21ee647..b86bd20 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -538,10 +538,10 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
 static u32 pwm_get_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
-	int duty_ns;
+	struct pwm_state pstate;
 
-	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
-	return DIV_ROUND_UP(duty_ns * 100, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	return DIV_ROUND_UP(pstate.duty_cycle * 100, CRC_PMIC_PWM_PERIOD_NS);
 }
 
 static u32 intel_panel_get_backlight(struct intel_connector *connector)
@@ -630,9 +630,12 @@ static void bxt_set_backlight(struct intel_connector *connector, u32 level)
 static void pwm_set_backlight(struct intel_connector *connector, u32 level)
 {
 	struct intel_panel *panel = &connector->panel;
-	int duty_ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
+	struct pwm_state pstate;
 
-	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	pstate.duty_cycle = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
+	pstate.period = CRC_PMIC_PWM_PERIOD_NS;
+	pwm_apply_state(panel->backlight.pwm, &pstate);
 }
 
 static void
@@ -801,11 +804,15 @@ static void bxt_disable_backlight(struct intel_connector *connector)
 static void pwm_disable_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
+	struct pwm_state pstate;
 
 	/* Disable the backlight */
-	pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	pstate.duty_cycle = 0;
+	pwm_apply_state(panel->backlight.pwm, &pstate);
 	usleep_range(2000, 3000);
-	pwm_disable(panel->backlight.pwm);
+	pstate.enabled = false;
+	pwm_apply_state(panel->backlight.pwm, &pstate);
 }
 
 void intel_panel_disable_backlight(struct intel_connector *connector)
@@ -1068,8 +1075,11 @@ static void bxt_enable_backlight(struct intel_connector *connector)
 static void pwm_enable_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
+	struct pwm_state pstate;
 
-	pwm_enable(panel->backlight.pwm);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	pstate.enabled = true;
+	pwm_apply_state(panel->backlight.pwm, &pstate);
 	intel_panel_actually_set_backlight(connector, panel->backlight.level);
 }
 
@@ -1630,6 +1640,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 {
 	struct drm_device *dev = connector->base.dev;
 	struct intel_panel *panel = &connector->panel;
+	struct pwm_state pstate;
 	int retval;
 
 	/* Get the PWM chip for backlight control */
@@ -1640,8 +1651,10 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return -ENODEV;
 	}
 
-	retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
-			    CRC_PMIC_PWM_PERIOD_NS);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	pstate.period = CRC_PMIC_PWM_PERIOD_NS;
+	pstate.duty_cycle = CRC_PMIC_PWM_PERIOD_NS;
+	retval = pwm_apply_state(panel->backlight.pwm, &pstate);
 	if (retval < 0) {
 		DRM_ERROR("Failed to configure the pwm chip\n");
 		pwm_put(panel->backlight.pwm);
@@ -1651,9 +1664,9 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
 	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
-	panel->backlight.level = DIV_ROUND_UP(
-				 pwm_get_duty_cycle(panel->backlight.pwm) * 100,
-				 CRC_PMIC_PWM_PERIOD_NS);
+	pwm_get_state(panel->backlight.pwm, &pstate);
+	panel->backlight.level = DIV_ROUND_UP(pstate.duty_cycle * 100,
+					      pstate.period);
 	panel->backlight.enabled = panel->backlight.level != 0;
 
 	return 0;
-- 
2.5.0
