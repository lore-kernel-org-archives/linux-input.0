From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 33/46] pwm: replace pwm_disable() by pwm_apply_state()
Date: Wed, 30 Mar 2016 22:03:56 +0200
Message-ID: <1459368249-13241-34-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBFXD6C3QKGQED44GUTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Some PWM drivers are calling the deprecated pwm_disable() function in
their pwm->free() or pdev->remove() function. Replace those calls by
the pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 7 +++++--
 drivers/pwm/pwm-lpc32xx.c     | 9 +++++++--
 drivers/pwm/pwm-spear.c       | 9 +++++++--
 drivers/pwm/pwm-sti.c         | 9 +++++++--
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 19dc64c..c4d7cb1 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -305,9 +305,12 @@ static void lpc18xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct pwm_state pstate;
 
-	pwm_disable(pwm);
-	pwm_set_duty_cycle(pwm, 0);
+	pwm_get_state(pwm, &pstate);
+	pstate.duty_cycle = 0;
+	pstate.enabled = false;
+	pwm_apply_state(pwm, &pstate);
 	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
 }
 
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 4d470c1..95870e0 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -138,8 +138,13 @@ static int lpc32xx_pwm_remove(struct platform_device *pdev)
 	struct lpc32xx_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < lpc32xx->chip.npwm; i++)
-		pwm_disable(&lpc32xx->chip.pwms[i]);
+	for (i = 0; i < lpc32xx->chip.npwm; i++) {
+		struct pwm_state pstate;
+
+		pwm_get_state(&lpc32xx->chip.pwms[i], &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(&lpc32xx->chip.pwms[i], &pstate);
+	}
 
 	return pwmchip_remove(&lpc32xx->chip);
 }
diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6c6b44f..2ee4cd5 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -233,8 +233,13 @@ static int spear_pwm_remove(struct platform_device *pdev)
 	struct spear_pwm_chip *pc = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < NUM_PWM; i++)
-		pwm_disable(&pc->chip.pwms[i]);
+	for (i = 0; i < NUM_PWM; i++) {
+		struct pwm_state pstate;
+
+		pwm_get_state(&pc->chip.pwms[i], &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(&pc->chip.pwms[i], &pstate);
+	}
 
 	/* clk was prepared in probe, hence unprepare it here */
 	clk_unprepare(pc->clk);
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index bea1d17..0ec44a8 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -435,8 +435,13 @@ static int sti_pwm_remove(struct platform_device *pdev)
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < pc->cdata->num_chan; i++)
-		pwm_disable(&pc->chip.pwms[i]);
+	for (i = 0; i < pc->cdata->num_chan; i++) {
+		struct pwm_state pstate;
+
+		pwm_get_state(&pc->chip.pwms[i], &pstate);
+		pstate.enabled = false;
+		pwm_apply_state(&pc->chip.pwms[i], &pstate);
+	}
 
 	clk_unprepare(pc->clk);
 
-- 
2.5.0
