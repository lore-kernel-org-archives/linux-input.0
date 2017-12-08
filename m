From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 1/5] arm: dts: sun8i: a83t: Add I2C0 node
Date: Fri,  8 Dec 2017 22:54:15 +0100
Message-ID: <20171208215419.30396-2-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: simon.budig@kernelconcepts.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com
List-Id: linux-input@vger.kernel.org

Add I2C0 node for A83T.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 19acae1b4089..848cf3f19962 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -177,6 +177,17 @@
 			#dma-cells = <1>;
 		};
 
+		i2c0: i2c@01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun8i-a83t-mmc",
 				     "allwinner,sun7i-a20-mmc";
-- 
2.11.0
