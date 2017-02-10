From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2 3/3] arm64: dts: exynos: Add stmfts touchscreen node for TM2
 and TM2E
Date: Fri, 10 Feb 2017 11:17:21 +0900
Message-ID: <20170210021721.12218-4-andi.shyti@samsung.com>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021729epcas5p4101902873e65e0a8faeb2f9cbea5843c@epcas5p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170210021721.12218-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

TM2 and TM2E devices are provided with a ST-Microelectronics
Finger Tip S device with small differences:

 - screen size
 - TM2E uses the stmfts also as a touchkey for "back" and "menu"

In this commit the initial value of the interrupt line is set to
EXYNOS_PIN_PULL_UP as the interrupt is triggered when the line
goes down.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 15 ++++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         |  5 +++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts        |  7 +++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 098ad557fee3..b1f7083dbe72 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -749,6 +749,19 @@
 	};
 };
 
+&hsi2c_5 {
+	status = "okay";
+
+	stmfts: touchscreen@49 {
+		compatible = "st,stmfts";
+		reg = <0x49>;
+		interrupt-parent = <&gpa1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&ldo30_reg>;
+		vdd-supply = <&ldo31_reg>;
+	};
+};
+
 &hsi2c_7 {
 	status = "okay";
 
@@ -894,7 +907,7 @@
 		PIN(INPUT, gpa0-7, NONE, FAST_SR1);
 
 		PIN(INPUT, gpa1-0, UP, FAST_SR1);
-		PIN(INPUT, gpa1-1, NONE, FAST_SR1);
+		PIN(INPUT, gpa1-1, UP, FAST_SR1);
 		PIN(INPUT, gpa1-2, NONE, FAST_SR1);
 		PIN(INPUT, gpa1-3, DOWN, FAST_SR1);
 		PIN(INPUT, gpa1-4, DOWN, FAST_SR1);
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index dea0a6f5bc18..75274b3afbd3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -76,3 +76,8 @@
 	regulator-min-microvolt = <3000000>;
 	regulator-max-microvolt = <3000000>;
 };
+
+&stmfts {
+	touchscreen-size-x = <1439>;
+	touchscreen-size-y = <2559>;
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 7891a31adc17..694717ade927 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -63,3 +63,10 @@
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
 };
+
+&stmfts {
+	touchscreen-size-x = <1599>;
+	touchscreen-size-y = <2559>;
+	touch-key-connected;
+	ledvdd-supply = <&ldo33_reg>;
+};
-- 
2.11.0
