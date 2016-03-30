From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 43/46] backlight: pwm_bl: switch to the
 atomic PWM API
Date: Wed, 30 Mar 2016 22:04:06 +0200
Message-ID: <1459368249-13241-44-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBMPD6C3QKGQEWGCD73Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/video/backlight/pwm_bl.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 2479c11..b069fb2 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -43,8 +43,22 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
 
+static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
+{
+	unsigned int lth = pb->lth_brightness;
+	int duty_cycle;
+
+	if (pb->levels)
+		duty_cycle = pb->levels[brightness];
+	else
+		duty_cycle = brightness;
+
+	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
+}
+
 static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 {
+	struct pwm_state pstate;
 	int err;
 
 	if (pb->enabled)
@@ -57,17 +71,24 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (pb->enable_gpio)
 		gpiod_set_value(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
+	pwm_get_state(pb->pwm, &pstate);
+	pstate.duty_cycle = compute_duty_cycle(pb, brightness);
+	pstate.enabled = true;
+	pwm_apply_state(pb->pwm, &pstate);
 	pb->enabled = true;
 }
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
+	struct pwm_state pstate;
+
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+	pwm_get_state(pb->pwm, &pstate);
+	pstate.duty_cycle = 0;
+	pstate.enabled = false;
+	pwm_apply_state(pb->pwm, &pstate);
 
 	if (pb->enable_gpio)
 		gpiod_set_value(pb->enable_gpio, 0);
@@ -76,24 +97,10 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	pb->enabled = false;
 }
 
-static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
-{
-	unsigned int lth = pb->lth_brightness;
-	int duty_cycle;
-
-	if (pb->levels)
-		duty_cycle = pb->levels[brightness];
-	else
-		duty_cycle = brightness;
-
-	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
-}
-
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
 	int brightness = bl->props.brightness;
-	int duty_cycle;
 
 	if (bl->props.power != FB_BLANK_UNBLANK ||
 	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
@@ -104,8 +111,6 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		brightness = pb->notify(pb->dev, brightness);
 
 	if (brightness > 0) {
-		duty_cycle = compute_duty_cycle(pb, brightness);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_backlight_power_on(pb, brightness);
 	} else
 		pwm_backlight_power_off(pb);
-- 
2.5.0
