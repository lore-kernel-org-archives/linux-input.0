From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: sun4i: inet9f-rev03: Add support for game buttons / joysticks
Date: Sat, 12 Sep 2015 15:26:12 +0200
Message-ID: <1442064372-3030-4-git-send-email-hdegoede@redhat.com>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442064372-3030-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The inet9f-rev03 tablet has multiple fire-buttons / direction controls,
add support for these using the same axis mapping as ps2 compatible game
controllers with the same stick / button layout use.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Do not include dt-bindings/input/evdev.h, as the necessary evdev codes
 have been added to dt-bindings/input/input.h instead
---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 164 +++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 932e397..8ef3160 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -59,6 +59,159 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys-polled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_pins_inet9f>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <20>;
+
+		button@0 {
+			label = "Left Joystick Left";
+			linux,code = <ABS_X>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 0 6 GPIO_ACTIVE_LOW>; /* PA6 */
+		};
+
+		button@1 {
+			label = "Left Joystick Right";
+			linux,code = <ABS_X>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 0 5 GPIO_ACTIVE_LOW>; /* PA5 */
+		};
+
+		button@2 {
+			label = "Left Joystick Up";
+			linux,code = <ABS_Y>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
+		};
+
+		button@3 {
+			label = "Left Joystick Down";
+			linux,code = <ABS_Y>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
+		};
+
+		button@4 {
+			label = "Right Joystick Left";
+			linux,code = <ABS_Z>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 0 1 GPIO_ACTIVE_LOW>; /* PA1 */
+		};
+
+		button@5 {
+			label = "Right Joystick Right";
+			linux,code = <ABS_Z>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 0 0 GPIO_ACTIVE_LOW>; /* PA0 */
+		};
+
+		button@6 {
+			label = "Right Joystick Up";
+			linux,code = <ABS_RZ>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 0 3 GPIO_ACTIVE_LOW>; /* PA3 */
+		};
+
+		button@7 {
+			label = "Right Joystick Down";
+			linux,code = <ABS_RZ>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
+		};
+
+		button@8 {
+			label = "DPad Left";
+			linux,code = <ABS_HAT0X>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 7 23 GPIO_ACTIVE_LOW>; /* PH23 */
+		};
+
+		button@9 {
+			label = "DPad Right";
+			linux,code = <ABS_HAT0X>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 7 24 GPIO_ACTIVE_LOW>; /* PH24 */
+		};
+
+		button@10 {
+			label = "DPad Up";
+			linux,code = <ABS_HAT0Y>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <0xffffffff>; /* -1 */
+			gpios = <&pio 7 25 GPIO_ACTIVE_LOW>; /* PH25 */
+		};
+
+		button@11 {
+			label = "DPad Down";
+			linux,code = <ABS_HAT0Y>;
+			linux,input-type = <EV_ABS>;
+			linux,input-value = <1>;
+			gpios = <&pio 7 26 GPIO_ACTIVE_LOW>; /* PH26 */
+		};
+
+		button@12 {
+			label = "Button X";
+			linux,code = <BTN_X>;
+			gpios = <&pio 0 16 GPIO_ACTIVE_LOW>; /* PA16 */
+		};
+
+		button@13 {
+			label = "Button Y";
+			linux,code = <BTN_Y>;
+			gpios = <&pio 0 14 GPIO_ACTIVE_LOW>; /* PA14 */
+		};
+
+		button@14 {
+			label = "Button A";
+			linux,code = <BTN_A>;
+			gpios = <&pio 0 17 GPIO_ACTIVE_LOW>; /* PA17 */
+		};
+
+		button@15 {
+			label = "Button B";
+			linux,code = <BTN_B>;
+			gpios = <&pio 0 15 GPIO_ACTIVE_LOW>; /* PA15 */
+		};
+
+		button@16 {
+			label = "Select Button";
+			linux,code = <BTN_SELECT>;
+			gpios = <&pio 0 11 GPIO_ACTIVE_LOW>; /* PA11 */
+		};
+
+		button@17 {
+			label = "Start Button";
+			linux,code = <BTN_START>;
+			gpios = <&pio 0 12 GPIO_ACTIVE_LOW>; /* PA12 */
+		};
+
+		button@18 {
+			label = "Top Left Button";
+			linux,code = <BTN_TL>;
+			gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
+		};
+
+		button@19 {
+			label = "Top Right Button";
+			linux,code = <BTN_TR>;
+			gpios = <&pio 0 13 GPIO_ACTIVE_LOW>; /* PA13 */
+		};
+	};
 };
 
 &cpu0 {
@@ -167,6 +320,17 @@
 };
 
 &pio {
+	key_pins_inet9f: key_pins@0 {
+		allwinner,pins = "PA0", "PA1", "PA3", "PA4",
+				 "PA5", "PA6", "PA8", "PA9",
+				 "PA11", "PA12", "PA13",
+				 "PA14", "PA15", "PA16", "PA17",
+				 "PH22", "PH23", "PH24", "PH25", "PH26";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
 	usb0_id_detect_pin: usb0_id_detect_pin@0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
