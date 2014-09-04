From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 4/4] mfd: max77693: Update DT binding to support haptic
Date: Fri, 05 Sep 2014 00:01:31 +0900
Message-ID: <1409842891-26549-5-git-send-email-jaewon02.kim@samsung.com>
References: <1409842891-26549-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1409842891-26549-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch add haptic DT binding documentation and example
to support haptic driver in max77693 Multifunction device.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77693.txt |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
index 11921cc..d178b9e 100644
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ b/Documentation/devicetree/bindings/mfd/max77693.txt
@@ -27,6 +27,17 @@ Optional properties:
 
 	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
 
+- haptic : The haptic of max77693 have to be instantiated under subnod
+  named "haptic" using the following haptic format in example.
+  Haptic sensation from motor can be changed by changing a period cycle in pwms.
+
+ Required properties:
+	- compatible : Must be "maxim,max77693-hpatic"
+	- haptic-supply : power supply for haptic motor
+		[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
+	- pwms : phandle to the physical PWM device,
+		[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
+
 Example:
 	max77693@66 {
 		compatible = "maxim,max77693";
@@ -52,4 +63,11 @@ Example:
 					regulator-boot-on;
 			};
 		};
+
+		haptic {
+			compatible = "maxim,max77693-haptic";
+			haptic-supply = <&haptic_supply>;
+			pwms = <&pwm 0 40000 0>;
+			pwm-names = "haptic";
+		};
 	};
-- 
1.7.9.5
