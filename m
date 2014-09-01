From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 3/3] mfd: max77693: add haptic of_compatible in mfd_cell
Date: Mon, 01 Sep 2014 20:14:31 +0900
Message-ID: <1409570071-26719-4-git-send-email-jaewon02.kim@samsung.com>
References: <1409570071-26719-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1409570071-26719-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch add haptic of_compatible in order to use the Haptic device driver
using devicetree. and added the related documentation and example.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77693.txt |   19 +++++++++++++++++++
 drivers/mfd/max77693.c                             |    2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
index 11921cc..6e30ad8 100644
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ b/Documentation/devicetree/bindings/mfd/max77693.txt
@@ -27,6 +27,18 @@ Optional properties:
 
 	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
 
+- haptic :
+ Required properties:
+	- compatible : Must be "maxim,max77693-hpatic"
+	- pwms : phandle to the physical PWM device,
+		A feel can be changed by changing a peroid cycle.
+ Optional properties:
+	 - haptic-supply : power supply for haptic motor
+	 - pwm-names : Name to be used by the PWM subsystem for the PWM device
+
+ The haptic require of max77693 have to be instantiated under subnod
+  named "haptic" using the following haptic format in example.
+
 Example:
 	max77693@66 {
 		compatible = "maxim,max77693";
@@ -52,4 +64,11 @@ Example:
 					regulator-boot-on;
 			};
 		};
+
+		haptic {
+			compatible = "maxim,max77693-haptic";
+			haptic-supply = <&haptic_supply>;
+			pwms = <&pwm 0 38022 0>;
+			pwm-names = "haptic";
+		};
 	};
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index fbfed56..ceb7ebf 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -46,7 +46,7 @@ static const struct mfd_cell max77693_devs[] = {
 	{ .name = "max77693-charger", },
 	{ .name = "max77693-flash", },
 	{ .name = "max77693-muic", },
-	{ .name = "max77693-haptic", },
+	{ .name = "max77693-haptic", .of_compatible = "maxim,max77693-haptic" },
 };
 
 static const struct regmap_config max77693_regmap_config = {
-- 
1.7.9.5
