From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT PATCH 3/3] Input: ad7879 - allow exporting AUX/VBAT/GPIO pin via device property
Date: Fri, 17 Feb 2017 15:31:52 -0800
Message-ID: <20170217233152.31715-3-dmitry.torokhov@gmail.com>
References: <20170217233152.31715-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170217233152.31715-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

Up until now only platforms using legacy platform data were able to switch
AUX/VBAT/GPIO pin in GPIO mode and use it as regular GPIO line. Let's
allow platforms using generic device properties to do the same.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/ad7879.txt      |  1 +
 drivers/input/touchscreen/ad7879.c                        | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
index e3f22d23fc8f..323b6098be19 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
@@ -35,6 +35,7 @@ Optional properties:
 - adi,conversion-interval:	: 0    : convert one time only
 				  1-255: 515us + val * 35us (up to 9.440ms)
 				  This property has to be a '/bits/ 8' value
+- gpio-controller		: Switch AUX/VBAT/GPIO pin to GPIO mode
 
 Example:
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index b7ab7f9767ca..b6da5cee80eb 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -454,17 +454,28 @@ static void ad7879_gpio_set_value(struct gpio_chip *chip,
 static int ad7879_gpio_add(struct ad7879 *ts,
 			   const struct ad7879_platform_data *pdata)
 {
+	bool gpio_export;
+	int gpio_base;
 	int ret = 0;
 
+	if (pdata) {
+		gpio_export = pdata->gpio_export;
+		gpio_base = pdata->gpio_base;
+	} else {
+		gpio_export = device_property_read_bool(ts->dev,
+							"gpio-controller");
+		gpio_base = -1;
+	}
+
 	mutex_init(&ts->mutex);
 
-	if (pdata && pdata->gpio_export) {
+	if (gpio_export) {
 		ts->gc.direction_input = ad7879_gpio_direction_input;
 		ts->gc.direction_output = ad7879_gpio_direction_output;
 		ts->gc.get = ad7879_gpio_get_value;
 		ts->gc.set = ad7879_gpio_set_value;
 		ts->gc.can_sleep = 1;
-		ts->gc.base = pdata->gpio_base;
+		ts->gc.base = gpio_base;
 		ts->gc.ngpio = 1;
 		ts->gc.label = "AD7879-GPIO";
 		ts->gc.owner = THIS_MODULE;
-- 
2.11.0.483.g087da7b7c-goog
