From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: [PATCH v1 4/4] leds: no longer use unnamed gpios
Date: Wed,  7 Jan 2015 10:08:42 +0100
Message-ID: <1420621722-7428-5-git-send-email-oliver+list@schinagl.nl>
References: <1420621722-7428-1-git-send-email-oliver+list@schinagl.nl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420621722-7428-1-git-send-email-oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Cc: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

The gpio document says we should not use unnamed bindings for gpios.
This patch uses the 'led-' prefix to the gpios and updates code and
documents. Because the devm_get_gpiod_from_child() falls back to using
old-style unnamed gpios, we can update the code first, and update
dts files as time allows.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
---
 Documentation/devicetree/bindings/leds/leds-gpio.txt | 12 ++++++------
 drivers/leds/leds-gpio.c                             |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
index d544cf1..2c138cc 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -7,7 +7,7 @@ Each LED is represented as a sub-node of the gpio-leds device.  Each
 node's name represents the name of the corresponding LED.
 
 LED sub-node properties:
-- gpios :  Should specify the LED's GPIO, see "gpios property" in
+- led-gpios :  Should specify the LED's GPIO, see "gpios property" in
   Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs should be
   indicated using flags in the GPIO specifier.
 - label :  (optional)
@@ -32,12 +32,12 @@ leds {
 	compatible = "gpio-leds";
 	hdd {
 		label = "IDE Activity";
-		gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
+		led-gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
 		linux,default-trigger = "ide-disk";
 	};
 
 	fault {
-		gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
+		led-gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
 		/* Keep LED on if BIOS detected hardware fault */
 		default-state = "keep";
 	};
@@ -46,11 +46,11 @@ leds {
 run-control {
 	compatible = "gpio-leds";
 	red {
-		gpios = <&mpc8572 6 GPIO_ACTIVE_HIHG>;
+		led-gpios = <&mpc8572 6 GPIO_ACTIVE_HIHG>;
 		default-state = "off";
 	};
 	green {
-		gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
+		led-gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
 		default-state = "on";
 	};
 };
@@ -59,7 +59,7 @@ leds {
 	compatible = "gpio-leds";
 
 	charger-led {
-		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		led-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		linux,default-trigger = "max8903-charger-charging";
 		retain-state-suspended;
 	};
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 8e5af69..5b7bc84 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -184,7 +184,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		struct gpio_led led = {};
 		const char *state = NULL;
 
-		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child);
+		led.gpiod = devm_get_gpiod_from_child(dev, "led", child);
 		if (IS_ERR(led.gpiod)) {
 			fwnode_handle_put(child);
 			goto err;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
