From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 2/4] input: touchscreen: of: Register multitouch axes
Date: Tue,  3 Mar 2015 14:50:44 +0100
Message-ID: <1425390646-31196-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-input@vger.kernel.org

So far, the DT parsing code was only setting up the regular input axes,
completely ignoring their multitouch counter parts.

Fill them with the same parameters than the regular axes.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/touchscreen/of_touchscreen.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index fe80d8ba7efa..b82b5207c78b 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/input.h>
+#include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 
 static u32 of_get_optional_u32(struct device_node *np,
@@ -30,8 +31,13 @@ static void touchscreen_set_params(struct input_dev *dev,
 	struct input_absinfo *absinfo;
 
 	if (!test_bit(axis, dev->absbit)) {
-		dev_warn(&dev->dev,
-			 "DT specifies parameters but the axis is not set up\n");
+		/*
+		 * Emit a warning only if the axis is not a multitouch
+		 * axis, which might not be set by the driver.
+		 */
+		if (!input_is_mt_axis(axis))
+			dev_warn(&dev->dev,
+				 "DT specifies parameters but the axis is not set up\n");
 		return;
 	}
 
@@ -59,17 +65,23 @@ void touchscreen_parse_of_params(struct input_dev *dev)
 
 	maximum = of_get_optional_u32(np, "touchscreen-size-x");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-x");
-	if (maximum || fuzz)
+	if (maximum || fuzz) {
 		touchscreen_set_params(dev, ABS_X, maximum, fuzz);
+		touchscreen_set_params(dev, ABS_MT_POSITION_X, maximum, fuzz);
+	}
 
 	maximum = of_get_optional_u32(np, "touchscreen-size-y");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-y");
-	if (maximum || fuzz)
+	if (maximum || fuzz) {
 		touchscreen_set_params(dev, ABS_Y, maximum, fuzz);
+		touchscreen_set_params(dev, ABS_MT_POSITION_Y, maximum, fuzz);
+	}
 
 	maximum = of_get_optional_u32(np, "touchscreen-max-pressure");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-pressure");
-	if (maximum || fuzz)
+	if (maximum || fuzz) {
 		touchscreen_set_params(dev, ABS_PRESSURE, maximum, fuzz);
+		touchscreen_set_params(dev, ABS_MT_PRESSURE, maximum, fuzz);
+	}
 }
 EXPORT_SYMBOL(touchscreen_parse_of_params);
-- 
2.3.0
