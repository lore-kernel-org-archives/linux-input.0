From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] ARM: dts: set up trigger type for edt-ft5x06 interrupts
Date: Sat, 12 Sep 2015 10:45:51 -0700
Message-ID: <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Now that the driver respects IRQ trigger settings from device tree, let's
fix them up in individual DTSes (note that the driver is still compatible
with older DTSes).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts   | 2 +-
 arch/arm/boot/dts/imx28-tx28.dts      | 3 ++-
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 3 ++-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi    | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index c17097d..d83fdcd 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -471,7 +471,7 @@
 
 		reg = <0x38>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <31 0>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
 
 		reset-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index a5b27c8..4ea8934 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -13,6 +13,7 @@
 /dts-v1/;
 #include "imx28.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Ka-Ro electronics TX28 module";
@@ -324,7 +325,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_edt_ft5x06_pins>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <5 0>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 3b73e81..13e842b 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "imx53-tx53.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -216,7 +217,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06_1>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <15 0>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index da08de3..13cb7cc 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -272,7 +273,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <15 0>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 		linux,wakeup;
-- 
2.6.0.rc0.131.gf624c3d
