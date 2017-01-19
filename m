From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 6/7] Input: pwm-beeper - add optional amplifier regulator
Date: Thu, 19 Jan 2017 14:40:56 -0800
Message-ID: <20170119224057.9995-6-dmitry.torokhov@gmail.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

From: David Lechner <david@lechnology.com>

This adds an optional regulator to the pwm-beeper device. This regulator
acts as an amplifier. The amplifier is only enabled while beeping in order
to reduce power consumption.

Tested on LEGO MINDSTORMS EV3, which has a speaker connected to PWM through
an amplifier.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Rob Herring <robh@kernel.org>
Patchwork-Id: 9511151
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/pwm-beeper.txt       | 16 ++++++
 drivers/input/misc/pwm-beeper.c                    | 62 +++++++++++++++++-----
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index be332ae4f2d6..529408b4431a 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -5,3 +5,19 @@ Registers a PWM device as beeper.
 Required properties:
 - compatible: should be "pwm-beeper"
 - pwms: phandle to the physical PWM device
+
+Optional properties:
+- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
+
+Example:
+
+beeper_amp: amplifier {
+	compatible = "fixed-regulator";
+	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+};
+
+beeper {
+	compatible = "pwm-beeper";
+	pwms = <&pwm0>;
+	amp-supply = <&beeper_amp>;
+};
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 9964c46468d3..7b213e0ab06c 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -25,30 +26,59 @@
 struct pwm_beeper {
 	struct input_dev *input;
 	struct pwm_device *pwm;
+	struct regulator *amplifier;
 	struct work_struct work;
 	unsigned long period;
 	bool suspended;
+	bool amplifier_on;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
 
-static void __pwm_beeper_set(struct pwm_beeper *beeper)
+static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 {
-	unsigned long period = beeper->period;
+	int error;
+
+	error = pwm_config(beeper->pwm, period / 2, period);
+	if (error)
+		return error;
+
+	error = pwm_enable(beeper->pwm);
+	if (error)
+		return error;
+
+	if (!beeper->amplifier_on) {
+		error = regulator_enable(beeper->amplifier);
+		if (error) {
+			pwm_disable(beeper->pwm);
+			return error;
+		}
+
+		beeper->amplifier_on = true;
+	}
+
+	return 0;
+}
 
-	if (period) {
-		pwm_config(beeper->pwm, period / 2, period);
-		pwm_enable(beeper->pwm);
-	} else
-		pwm_disable(beeper->pwm);
+static void pwm_beeper_off(struct pwm_beeper *beeper)
+{
+	if (beeper->amplifier_on) {
+		regulator_disable(beeper->amplifier);
+		beeper->amplifier_on = false;
+	}
+
+	pwm_disable(beeper->pwm);
 }
 
 static void pwm_beeper_work(struct work_struct *work)
 {
-	struct pwm_beeper *beeper =
-		container_of(work, struct pwm_beeper, work);
+	struct pwm_beeper *beeper = container_of(work, struct pwm_beeper, work);
+	unsigned long period = READ_ONCE(beeper->period);
 
-	__pwm_beeper_set(beeper);
+	if (period)
+		pwm_beeper_on(beeper, period);
+	else
+		pwm_beeper_off(beeper);
 }
 
 static int pwm_beeper_event(struct input_dev *input,
@@ -83,9 +113,7 @@ static int pwm_beeper_event(struct input_dev *input,
 static void pwm_beeper_stop(struct pwm_beeper *beeper)
 {
 	cancel_work_sync(&beeper->work);
-
-	if (beeper->period)
-		pwm_disable(beeper->pwm);
+	pwm_beeper_off(beeper);
 }
 
 static void pwm_beeper_close(struct input_dev *input)
@@ -119,6 +147,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	 */
 	pwm_apply_args(beeper->pwm);
 
+	beeper->amplifier = devm_regulator_get(dev, "amp");
+	if (IS_ERR(beeper->amplifier)) {
+		error = PTR_ERR(beeper->amplifier);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get amp regulator\n");
+		return error;
+	}
+
 	INIT_WORK(&beeper->work, pwm_beeper_work);
 
 	beeper->input = devm_input_allocate_device(dev);
-- 
2.11.0.483.g087da7b7c-goog
