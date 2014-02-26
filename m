From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 8/8] ARM: dts: am43x-epos-evm: Correct Touch controller info
Date: Wed, 26 Feb 2014 17:28:06 +0200
Message-ID: <1393428486-15001-9-git-send-email-rogerq@ti.com>
References: <1393428486-15001-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393428486-15001-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-input@vger.kernel.org

Fixup Y resolution and add default pin state. Also update
the compatible id.

CC: Benoit Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..6c8efcf 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -79,6 +79,13 @@
 				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
+
+		pixcir_ts_pins: pixcir_ts_pins {
+			pinctrl-single,pins = <
+				0x44 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
+			>;
+		};
+
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -157,7 +164,9 @@
 	};
 
 	pixcir_ts@5c {
-		compatible = "pixcir,pixcir_ts";
+		compatible = "pixcir,pixcir_tangoc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pixcir_ts_pins>;
 		reg = <0x5c>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <17 0>;
@@ -165,7 +174,7 @@
 		attb-gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 
 		x-size = <1024>;
-		y-size = <768>;
+		y-size = <600>;
 	};
 };
 
-- 
1.8.3.2
