From: Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCHv13 02/17] dts: exynos4: add node for the HDMI CEC device
Date: Fri, 18 Mar 2016 15:07:01 +0100
Message-ID: <1458310036-19252-3-git-send-email-hans.verkuil@cisco.com>
References: <1458310036-19252-1-git-send-email-hans.verkuil@cisco.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1458310036-19252-1-git-send-email-hans.verkuil@cisco.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Kamil Debski <kamil@wypas.org>, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

From: Kamil Debski <kamil@wypas.org>

This patch adds HDMI CEC node specific to the Exynos4210/4x12 SoC series.

Signed-off-by: Kamil Debski <kamil@wypas.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 045785c..8913408 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -751,6 +751,18 @@
 		status = "disabled";
 	};
 
+	hdmicec: cec@100B0000 {
+		compatible = "samsung,s5p-cec";
+		reg = <0x100B0000 0x200>;
+		interrupts = <0 114 0>;
+		clocks = <&clock CLK_HDMI_CEC>;
+		clock-names = "hdmicec";
+		samsung,syscon-phandle = <&pmu_system_controller>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_cec>;
+		status = "disabled";
+	};
+
 	mixer: mixer@12C10000 {
 		compatible = "samsung,exynos4210-mixer";
 		interrupts = <0 91 0>;
-- 
2.7.0
