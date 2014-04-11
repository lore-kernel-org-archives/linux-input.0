From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v3 4/7] ARM: STi: DT: add keyscan for stih415
Date: Fri, 11 Apr 2014 16:33:33 +0200
Message-ID: <1397226820-5604-7-git-send-email-gabriel.fernandez@linaro.org>
References: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>, Gabriel Fernandez <gabriel.fernandez@linaro.org>, Giuseppe Condorelli <giuseppe.condorelli@st.com>, Gabriel Fernandez <gabriel.fernandez@st.com>
List-Id: linux-input@vger.kernel.org

Add keyscan support for stih415.
It is put disabled by default because it is not enabled on all boards
Also there are PIOs conflict with already claimed lines.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index f09fb10..caeac7e 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -102,6 +102,22 @@
 				};
 			};
 
+			keyscan {
+				pinctrl_keyscan: keyscan {
+					st,pins {
+						keyin0 = <&PIO0 2 ALT2 IN>;
+						keyin1 = <&PIO0 3 ALT2 IN>;
+						keyin2 = <&PIO0 4 ALT2 IN>;
+						keyin3 = <&PIO2 6 ALT2 IN>;
+
+						keyout0 = <&PIO1 6 ALT2 OUT>;
+						keyout1 = <&PIO1 7 ALT2 OUT>;
+						keyout2 = <&PIO0 6 ALT2 OUT>;
+						keyout3 = <&PIO2 7 ALT2 OUT>;
+					};
+				};
+			};
+
 			sbc_i2c0 {
 				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
 					st,pins {
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d89064c..ba0905c 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -206,5 +206,17 @@
 			pinctrl-0	= <&pinctrl_ir>;
 			resets		= <&softreset STIH415_IRB_SOFTRESET>;
 		};
+
+		keyscan: keyscan@fe4b0000 {
+			compatible = "st,sti-keyscan";
+			status = "disabled";
+			reg = <0xfe4b0000 0x2000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_NONE>;
+			clocks = <&CLK_SYSIN>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_keyscan>;
+			resets	= <&powerdown STIH415_KEYSCAN_POWERDOWN>,
+				  <&softreset STIH415_KEYSCAN_SOFTRESET>;
+		};
 	};
 };
-- 
1.9.1
