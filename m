From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH] dt-bindings: input: pwm-vibrator: correct pwm-names in example
Date: Sat, 18 Aug 2018 15:58:55 -0400
Message-ID: <20180818195855.13429-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk, robh@kernel.org, mark.rutland@arm.com, masneyb@onstation.org
List-Id: linux-input@vger.kernel.org

In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
and pwm9 is the enable pin. The pwm-names on the vibrator node has these
two values swapped. This patch corrects the values for pwm-names.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
arch/arm/boot/dts/omap4-droid4-xt894.dts is actual implementation for
the example and it is correct.

 Documentation/devicetree/bindings/input/pwm-vibrator.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
index 09145d18491d..2731cbb7e8d7 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
@@ -60,7 +60,7 @@ Example from Motorola Droid 4:
 		compatible = "pwm-vibrator";
 		pwms = <&pwm8 0 1000000000 0>,
 		       <&pwm9 0 1000000000 0>;
-		pwm-names = "enable", "direction";
+		pwm-names = "direction", "enable";
 		direction-duty-cycle-ns = <1000000000>;
 	};
 };
-- 
2.17.1
