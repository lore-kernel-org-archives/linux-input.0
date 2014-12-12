From: VishnuPatekar <vishnupatekar0510@gmail.com>
Subject: [PATCHv3 3/5] ARM: sunxi: dts: Add PS2 nodes to dtsi for A10 and A20
Date: Fri, 12 Dec 2014 23:55:46 +0530
Message-ID: <1418408748-9797-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, hdegoede@redhat.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, grant.likely@linaro.org, benh@kernel.crashing.org, msalter@redhat.com, ralf@linux-mips.org, jdelvare@suse.de, VishnuPatekar <vishnupatekar0510@gmail.com>
List-Id: linux-input@vger.kernel.org

1) Fixup the sun4i ps/2 nodes interrupt property, sun4i interrupts take
only 1 specifier

2) dt bindings should use the compat string for the earliest version of the
hardware which has the relevant hardware block, unless there are differences,
the A10 and A20 ps2 controllers are identical, so for both sun4i-a10-ps2
should be used as compat string, update the sun7i.dtsi ps2 entries to
use the sun4i-a10-ps2 compat string.



Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi |   18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7b4099f..ef9a01c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -629,6 +629,7 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
 		};
 
 		timer@01c20c00 {
@@ -795,5 +796,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ps20: ps2@01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <62>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2@01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <63>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce59..6ab7714 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -866,6 +866,7 @@
 				    allwinner,drive = <0>;
 				    allwinner,pull = <0>;
 			};
+
 		};
 
 		timer@01c20c00 {
@@ -1093,5 +1094,22 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+
+		ps20: ps2@01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <0 62 4>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2@01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <0 63 4>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.7.9.5
