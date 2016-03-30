From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 41/46] backlight: lp855x: switch to the atomic PWM API
Date: Wed, 30 Mar 2016 22:04:04 +0200
Message-ID: <1459368249-13241-42-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbd
List-Id: linux-input@vger.kernel.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/lp855x_bl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index daca9e6..5468e7a 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -235,8 +235,7 @@ err:
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
+	struct pwm_state pstate;
 	struct pwm_device *pwm;
 
 	/* request pwm device with the consumer name */
@@ -248,11 +247,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 		lp->pwm = pwm;
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
+	pwm_get_state(lp->pwm, &pstate);
+	pstate.period = lp->pdata->period_ns;
+	pstate.duty_cycle = br * pstate.period / max_br;
+	if (pstate.duty_cycle)
+		pstate.enabled = true;
 	else
-		pwm_disable(lp->pwm);
+		pstate.enabled = false;
+
+	pwm_apply_state(lp->pwm, &pstate);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.5.0

