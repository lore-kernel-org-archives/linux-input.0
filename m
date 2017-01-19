From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 7/7] Input: pwm-beeper - switch to using "atomic" PWM API
Date: Thu, 19 Jan 2017 14:40:57 -0800
Message-ID: <20170119224057.9995-7-dmitry.torokhov@gmail.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33778 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdASWlF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 17:41:05 -0500
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>

The "atomic" API allows us to configure PWM period and duty cycle and
enable it in one call.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 7b213e0ab06c..3408dc666afa 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -37,13 +37,16 @@ struct pwm_beeper {
 
 static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 {
+	struct pwm_state state;
 	int error;
 
-	error = pwm_config(beeper->pwm, period / 2, period);
-	if (error)
-		return error;
+	pwm_get_state(beeper->pwm, &state);
 
-	error = pwm_enable(beeper->pwm);
+	state.enabled = true;
+	state.period = period;
+	pwm_set_relative_duty_cycle(&state, 50, 100);
+
+	error = pwm_apply_state(beeper->pwm, &state);
 	if (error)
 		return error;
 
@@ -127,6 +130,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pwm_beeper *beeper;
+	struct pwm_state state;
 	int error;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
@@ -141,11 +145,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(beeper->pwm);
+	/* Sync up PWM state and ensure it is off. */
+	pwm_init_state(beeper->pwm, &state);
+	state.enabled = false;
+	error = pwm_apply_state(beeper->pwm, &state);
+	if (error) {
+		dev_err(dev, "failed to apply initial pwm state\n");
+		return error;
+	}
 
 	beeper->amplifier = devm_regulator_get(dev, "amp");
 	if (IS_ERR(beeper->amplifier)) {
-- 
2.11.0.483.g087da7b7c-goog

