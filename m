From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2] dt-bindings: input: pwm-vibrator: correct pwms in example
Date: Wed, 26 Sep 2018 20:48:58 -0400
Message-ID: <20180927004858.32529-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk, mark.rutland@arm.com
Cc: masneyb@onstation.org
List-Id: linux-input@vger.kernel.org

In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
and pwm9 is the enable pin. The pwms on the vibrator node has these two
values swapped so this patch corrects it.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Swapped the pwms values instead of the pwm-names values since enable
  is required and direction is optional. Based on feedback from
  Rob Herring.

 Documentation/devicetree/bindings/input/pwm-vibrator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
index 09145d18491d..88c775a3fe21 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
@@ -58,8 +58,8 @@ Example from Motorola Droid 4:
 
 	vibrator {
 		compatible = "pwm-vibrator";
-		pwms = <&pwm8 0 1000000000 0>,
-		       <&pwm9 0 1000000000 0>;
+		pwms = <&pwm9 0 1000000000 0>,
+                       <&pwm8 0 1000000000 0>;
 		pwm-names = "enable", "direction";
 		direction-duty-cycle-ns = <1000000000>;
 	};
-- 
2.17.1
