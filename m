From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 05/17] ARM: dts: sunxi: Enable thermal sensor support for RTP on sun[457]i
Date: Tue,  6 Jan 2015 10:35:15 +0800
Message-ID: <1420511727-8242-6-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40996 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbAFCfn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:43 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Now that the resistive touchpanel driver supports thermal sensors,
add the "#thermal-sensor-cells" property as required by the thermal
framework.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 1 +
 arch/arm/boot/dts/sun5i-a10s.dtsi | 1 +
 arch/arm/boot/dts/sun5i-a13.dtsi  | 1 +
 arch/arm/boot/dts/sun7i-a20.dtsi  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 847d5e09fcfb..f92635ecb937 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -712,6 +712,7 @@
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		uart0: serial@01c28000 {
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 3c3c1920788a..8d324ef7e46e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -535,6 +535,7 @@
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		uart0: serial@01c28000 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 2448d7f38d6b..4fe0bd192e29 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -469,6 +469,7 @@
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		uart1: serial@01c28400 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce5992d56..01c7133e699c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -926,6 +926,7 @@
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <0 29 4>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		uart0: serial@01c28000 {
-- 
2.1.4

