From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: cap11xx - switch to using set_brightness_blocking()
Date: Tue, 5 Feb 2019 14:20:50 -0800
Message-ID: <20190205222050.GA145676@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sven Van Asbroeck <thesven73@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Updating LED state requires access to regmap and therefore we may sleep, so
we could not do that directly form set_brightness() method. Historically
we used private work to adjust the brightness, but with the introduction of
set_brightness_blocking() we no longer need it.

As a bonus, not having our own work item means we do not have
use-after-free issue as we neglected to cancel outstanding work on driver
unbind.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 47 ++++++++++++++------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 312916f99597..c0baf323ddda 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -75,9 +75,8 @@
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
 	struct led_classdev cdev;
-	struct work_struct work;
 	u32 reg;
-	enum led_brightness new_brightness;
+	enum led_brightness brightness;
 };
 #endif
 
@@ -233,30 +232,28 @@ static void cap11xx_input_close(struct input_dev *idev)
 }
 
 #ifdef CONFIG_LEDS_CLASS
-static void cap11xx_led_work(struct work_struct *work)
-{
-	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
-	struct cap11xx_priv *priv = led->priv;
-	int value = led->new_brightness;
-
-	/*
-	 * All LEDs share the same duty cycle as this is a HW limitation.
-	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
-	 */
-	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
-				BIT(led->reg), value ? BIT(led->reg) : 0);
-}
-
-static void cap11xx_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
+static int cap11xx_led_set(struct led_classdev *cdev,
+			    enum led_brightness value)
 {
 	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
+	struct cap11xx_priv *priv = led->priv;
+	int error = 0;
+
+	if (led->brightness != value) {
+		/*
+		 * All LEDs share the same duty cycle as this is a HW
+		 * limitation. Brightness levels per LED are either
+		 * 0 (OFF) and 1 (ON).
+		 */
+		error = regmap_update_bits(priv->regmap,
+					   CAP11XX_REG_LED_OUTPUT_CONTROL,
+					   BIT(led->reg),
+					   value ? BIT(led->reg) : 0);
+		if (!error)
+			led->brightness = value;
+	}
 
-	if (led->new_brightness == value)
-		return;
-
-	led->new_brightness = value;
-	schedule_work(&led->work);
+	return error;
 }
 
 static int cap11xx_init_leds(struct device *dev,
@@ -299,7 +296,7 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 		led->cdev.flags = 0;
-		led->cdev.brightness_set = cap11xx_led_set;
+		led->cdev.brightness_set_blocking = cap11xx_led_set;
 		led->cdev.max_brightness = 1;
 		led->cdev.brightness = LED_OFF;
 
@@ -312,8 +309,6 @@ static int cap11xx_init_leds(struct device *dev,
 		led->reg = reg;
 		led->priv = priv;
 
-		INIT_WORK(&led->work, cap11xx_led_work);
-
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error) {
 			of_node_put(child);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
