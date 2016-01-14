From: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Subject: [PATCH] Input: DT binding: Change touchscreen to touch for use with touchscreens and touchpads
Date: Thu, 14 Jan 2016 15:42:45 -0800
Message-ID: <1452814965-22731-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Heiny <cheiny-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, Stephen Chandler Paul <cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vincent Huang <vincent.huang-8LB1SX4YFO85ffrT631h+Q@public.gmane.org>, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrey Gusakov <andrey.gusakov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

These generic touchscreen bindings can also be used for touchpads.
Instead of creating new generic bindings this patch just renames then to
touch-*.

Signed-off-by: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
---
It was suggested that for the synaptics-rmi4 driver I use the generic
bindings. But, since the rmi4 driver is used for both touchpads and
touchscreens it seemed weird to have a touchpad with a parameter
of touchscreen-inverted-y. I changed all of the references to it in the
source tree. But, I realize this could cause a backwards compatibilty
issue with device trees which are not included in the kernel.

Thanks,
Andrew

 Documentation/devicetree/bindings/input/touch.txt  | 29 ++++++++++++++++++++++
 .../bindings/input/touchscreen/touchscreen.txt     | 29 ----------------------
 arch/arm/boot/dts/am437x-gp-evm.dts                |  4 +--
 arch/arm/boot/dts/am437x-sk-evm.dts                |  4 +--
 arch/arm/boot/dts/am43x-epos-evm.dts               |  4 +--
 arch/arm/boot/dts/omap3-n900.dts                   | 12 ++++-----
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  8 +++---
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 12 ++++-----
 drivers/input/touchscreen/chipone_icn8318.c        | 16 ++++++------
 drivers/input/touchscreen/of_touchscreen.c         | 12 ++++-----
 10 files changed, 65 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touch.txt
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touch.txt b/Documentation/devicetree/bindings/input/touch.txt
new file mode 100644
index 0000000..3000b5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touch.txt
@@ -0,0 +1,29 @@
+General Touchscreen and Touchpad Properties:
+
+Optional properties for Touchscreens:
+ - touch-size-x 		: horizontal resolution of touchscreen
+				 (in pixels)
+ - touch-size-y 		: vertical resolution of touchscreen
+				  (in pixels)
+ - touch-max-pressure		: maximum reported pressure (arbitrary range
+				  dependent on the controller)
+ - touch-fuzz-x 		: horizontal noise value of the absolute input
+				  device (in pixels)
+ - touch-fuzz-y 		: vertical noise value of the absolute input
+				  device (in pixels)
+ - touch-fuzz-pressure		: pressure noise value of the absolute input
+				  device (arbitrary range dependent on the
+				  controller)
+ - touch-inverted-x		: X axis is inverted (boolean)
+ - touch-inverted-y		: Y axis is inverted (boolean)
+ - touch-swapped-x-y		: X and Y axis are swapped (boolean)
+				  Swapping is done after inverting the axis
+
+Deprecated properties for Touchscreens:
+ - x-size			: deprecated name for touch-size-x
+ - y-size			: deprecated name for touch-size-y
+ - moving-threshold		: deprecated name for a combination of
+				  touch-fuzz-x and touch-fuzz-y
+ - contact-threshold		: deprecated name for touch-fuzz-pressure
+ - x-invert			: deprecated name for touch-inverted-x
+ - y-invert			: deprecated name for touch-inverted-y
diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index ac23caf..0000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-General Touchscreen Properties:
-
-Optional properties for Touchscreens:
- - touchscreen-size-x		: horizontal resolution of touchscreen
-				  (in pixels)
- - touchscreen-size-y		: vertical resolution of touchscreen
-				  (in pixels)
- - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
-				  dependent on the controller)
- - touchscreen-fuzz-x		: horizontal noise value of the absolute input
-				  device (in pixels)
- - touchscreen-fuzz-y		: vertical noise value of the absolute input
-				  device (in pixels)
- - touchscreen-fuzz-pressure	: pressure noise value of the absolute input
-				  device (arbitrary range dependent on the
-				  controller)
- - touchscreen-inverted-x	: X axis is inverted (boolean)
- - touchscreen-inverted-y	: Y axis is inverted (boolean)
- - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
-				  Swapping is done after inverting the axis
-
-Deprecated properties for Touchscreens:
- - x-size			: deprecated name for touchscreen-size-x
- - y-size			: deprecated name for touchscreen-size-y
- - moving-threshold		: deprecated name for a combination of
-				  touchscreen-fuzz-x and touchscreen-fuzz-y
- - contact-threshold		: deprecated name for touchscreen-fuzz-pressure
- - x-invert			: deprecated name for touchscreen-inverted-x
- - y-invert			: deprecated name for touchscreen-inverted-y
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index d2450ab..87510df 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -603,8 +603,8 @@
 				      <&am43xx_pinmux 0x264>;
 		interrupt-names = "tsc", "wakeup";
 
-		touchscreen-size-x = <1024>;
-		touchscreen-size-y = <600>;
+		touch-size-x = <1024>;
+		touch-size-y = <600>;
 		wakeup-source;
 	};
 
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 63de2a1..2f92cd6 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -506,8 +506,8 @@
 
 		reset-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 
-		touchscreen-size-x = <480>;
-		touchscreen-size-y = <272>;
+		touch-size-x = <480>;
+		touch-size-y = <272>;
 	};
 
 	tlv320aic3106: tlv320aic3106@1b {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 47954ed..83dc081 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -495,8 +495,8 @@
 
 		attb-gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 
-		touchscreen-size-x = <1024>;
-		touchscreen-size-y = <600>;
+		touch-size-x = <1024>;
+		touch-size-y = <600>;
 	};
 
 	tlv320aic3111: tlv320aic3111@18 {
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5f5e0f3..ee66f97 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -829,12 +829,12 @@
 		reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>; /* 104 */
 		interrupts-extended = <&gpio4 4 IRQ_TYPE_EDGE_RISING>; /* 100 */
 
-		touchscreen-fuzz-x = <4>;
-		touchscreen-fuzz-y = <7>;
-		touchscreen-fuzz-pressure = <2>;
-		touchscreen-size-x = <4096>;
-		touchscreen-size-y = <4096>;
-		touchscreen-max-pressure = <2048>;
+		touch-fuzz-x = <4>;
+		touch-fuzz-y = <7>;
+		touch-fuzz-pressure = <2>;
+		touch-size-x = <4096>;
+		touch-size-y = <4096>;
+		touch-max-pressure = <2048>;
 
 		ti,x-plate-ohms = <280>;
 		ti,esd-recovery-timeout-ms = <8000>;
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index eb793d5..59d1820 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -97,10 +97,10 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts_wake_pin_p66>;
 		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-		touchscreen-inverted-x;
-		touchscreen-swapped-x-y;
+		touch-size-x = <800>;
+		touch-size-y = <480>;
+		touch-inverted-x;
+		touch-swapped-x-y;
 	};
 
 	pcf8563: rtc@51 {
diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index ae460a5c..77fe4f7 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -394,18 +394,18 @@ static int iproc_get_tsc_config(struct device *dev, struct iproc_ts_priv *priv)
 	}
 
 	/* Parse optional properties. */
-	of_property_read_u32(np, "touchscreen-size-x", &priv->cfg_params.max_x);
-	of_property_read_u32(np, "touchscreen-size-y", &priv->cfg_params.max_y);
+	of_property_read_u32(np, "touch-size-x", &priv->cfg_params.max_x);
+	of_property_read_u32(np, "touch-size-y", &priv->cfg_params.max_y);
 
-	of_property_read_u32(np, "touchscreen-fuzz-x",
+	of_property_read_u32(np, "touch-fuzz-x",
 			     &priv->cfg_params.fuzz_x);
-	of_property_read_u32(np, "touchscreen-fuzz-y",
+	of_property_read_u32(np, "touch-fuzz-y",
 			     &priv->cfg_params.fuzz_y);
 
 	priv->cfg_params.invert_x =
-		of_property_read_bool(np, "touchscreen-inverted-x");
+		of_property_read_bool(np, "touch-inverted-x");
 	priv->cfg_params.invert_y =
-		of_property_read_bool(np, "touchscreen-inverted-y");
+		of_property_read_bool(np, "touch-inverted-y");
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 22a6fea..6a56a1c 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -223,18 +223,18 @@ static int icn8318_probe(struct i2c_client *client,
 		return error;
 	}
 
-	if (of_property_read_u32(np, "touchscreen-size-x", &data->max_x) ||
-	    of_property_read_u32(np, "touchscreen-size-y", &data->max_y)) {
-		dev_err(dev, "Error touchscreen-size-x and/or -y missing\n");
+	if (of_property_read_u32(np, "touch-size-x", &data->max_x) ||
+	    of_property_read_u32(np, "touch-size-y", &data->max_y)) {
+		dev_err(dev, "Error touch-size-x and/or -y missing\n");
 		return -EINVAL;
 	}
 
 	/* Optional */
-	of_property_read_u32(np, "touchscreen-fuzz-x", &fuzz_x);
-	of_property_read_u32(np, "touchscreen-fuzz-y", &fuzz_y);
-	data->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
-	data->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
-	data->swap_x_y = of_property_read_bool(np, "touchscreen-swapped-x-y");
+	of_property_read_u32(np, "touch-fuzz-x", &fuzz_x);
+	of_property_read_u32(np, "touch-fuzz-y", &fuzz_y);
+	data->invert_x = of_property_read_bool(np, "touch-inverted-x");
+	data->invert_y = of_property_read_bool(np, "touch-inverted-y");
+	data->swap_x_y = of_property_read_bool(np, "touch-swapped-x-y");
 
 	input = devm_input_allocate_device(dev);
 	if (!input)
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index bb6f2fe..d8c1008 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -72,22 +72,22 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
 		return;
 
 	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
-	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-x",
+	data_present = touchscreen_get_prop_u32(dev, "touch-size-x",
 						input_abs_get_max(input,
 								  axis) + 1,
 						&maximum) |
-		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-x",
+		       touchscreen_get_prop_u32(dev, "touch-fuzz-x",
 						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
 		touchscreen_set_params(input, axis, maximum - 1, fuzz);
 
 	axis = multitouch ? ABS_MT_POSITION_Y : ABS_Y;
-	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-y",
+	data_present = touchscreen_get_prop_u32(dev, "touch-size-y",
 						input_abs_get_max(input,
 								  axis) + 1,
 						&maximum) |
-		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-y",
+		       touchscreen_get_prop_u32(dev, "touch-fuzz-y",
 						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
@@ -95,11 +95,11 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
 
 	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
 	data_present = touchscreen_get_prop_u32(dev,
-						"touchscreen-max-pressure",
+						"touch-max-pressure",
 						input_abs_get_max(input, axis),
 						&maximum) |
 		       touchscreen_get_prop_u32(dev,
-						"touchscreen-fuzz-pressure",
+						"touch-fuzz-pressure",
 						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
