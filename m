From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v3 5/7] ARM: STi: DT: add keyscan for stih416
Date: Fri, 11 Apr 2014 16:33:35 +0200
Message-ID: <1397226820-5604-9-git-send-email-gabriel.fernandez@linaro.org>
References: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@linaro.org>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

Add keyscan support for stih416.
It is disabled by default given that it is not enabled on all boards.
Also there are PIOs conflict with already claimed lines.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/stih416.dtsi         | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index aeea304..6252188 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -122,6 +122,22 @@
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
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..d3bc263 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -224,5 +224,17 @@
 
 			status = "disabled";
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
+			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
+				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
+		};
 	};
 };
-- 
1.9.1
