From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v3 3/3] arm: dts: sun8i: a83t: a711: Add touchscreen node
Date: Wed, 18 Jul 2018 20:27:19 +0200
Message-ID: <20180718182719.29663-4-mylene.josserand@bootlin.com>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718182719.29663-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mylene.josserand@bootlin.com, thomas.petazzoni@bootlin.com
List-Id: linux-input@vger.kernel.org

Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
It is connected via I2C0. The reset line is PD5, the interrupt
line is PL7 and the VCC supply is the ldo_io0 regulator.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1537ce148cc1..dc7b94a6c068 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -156,6 +156,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pio 3 5 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
-- 
2.11.0
