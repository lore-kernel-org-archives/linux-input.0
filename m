From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 01/11] ARM: ux500: improve BU21013 touchpad bindings
Date: Fri,  9 Aug 2019 17:20:29 -0700
Message-ID: <20190810002039.95876-2-dmitry.torokhov@gmail.com>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In preparation to update to bu21013_tp driver properly annotate GPIOs
property (the INT GPIOs are active low, not open drain), and also define
interrupt lines so we do not have to have special conversion in the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts  | 14 ++++++++++----
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts | 14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
index aed940bd65a8..b78be5f4c212 100644
--- a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
@@ -4,6 +4,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "ste-hrefprev60.dtsi"
 #include "ste-href-stuib.dtsi"
 
@@ -23,12 +25,16 @@
 		i2c@80110000 {
 			/* Only one of these will be used */
 			bu21013_tp@5c {
-				touch-gpio = <&gpio2 12 0x4>;
-				reset-gpio = <&tc3589x_gpio 13 0x4>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+				touch-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&tc3589x_gpio 13 GPIO_LINE_OPEN_DRAIN>;
 			};
 			bu21013_tp@5d {
-				touch-gpio = <&gpio2 12 0x4>;
-				reset-gpio = <&tc3589x_gpio 13 0x4>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+				touch-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&tc3589x_gpio 13 GPIO_LINE_OPEN_DRAIN>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
index 0f3c3b86bb20..9be513aad549 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
@@ -6,6 +6,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "ste-hrefv60plus.dtsi"
 #include "ste-href-stuib.dtsi"
 
@@ -25,12 +27,16 @@
 		i2c@80110000 {
 			/* Only one of these will be used */
 			bu21013_tp@5c {
-				touch-gpio = <&gpio2 20 0x4>;
-				reset-gpio = <&gpio4 17 0x4>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+				touch-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio4 17 GPIO_LINE_OPEN_DRAIN>;
 			};
 			bu21013_tp@5d {
-				touch-gpio = <&gpio2 20 0x4>;
-				reset-gpio = <&gpio4 17 0x4>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+				touch-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio4 17 GPIO_LINE_OPEN_DRAIN>;
 			};
 		};
 	};
-- 
2.23.0.rc1.153.gdeed80330f-goog
