From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5 12/46] fbdev: ssd1307fb: use pwm_get_args() where appropriate
Date: Wed, 30 Mar 2016 22:03:35 +0200
Message-ID: <1459368249-13241-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbd
List-Id: linux-input@vger.kernel.org

The PWM framework has clarified the concept of reference PWM config
(the platform dependent config retrieved from the DT or the PWM
lookup table) and real PWM state.

Use pwm_get_args() when the PWM user wants to retrieve this reference
config and not the current state.

This is part of the rework allowing the PWM framework to support
hardware readout and expose real PWM state even when the PWM has
just been requested (before the user calls pwm_config/enable/disable()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/fbdev/ssd1307fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index fa34808..df9c63a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -286,6 +286,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
 	int ret;
 	u32 precharge, dclk, com_invdir, compins;
+	struct pwm_args pargs = { };
 
 	if (par->device_info->need_pwm) {
 		par->pwm = pwm_get(&par->client->dev, NULL);
@@ -294,7 +295,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 			return PTR_ERR(par->pwm);
 		}
 
-		par->pwm_period = pwm_get_period(par->pwm);
+		pwm_get_args(par->pwm, &pargs);
+		par->pwm_period = pargs.period;
 		/* Enable the PWM */
 		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
 		pwm_enable(par->pwm);
-- 
2.5.0
