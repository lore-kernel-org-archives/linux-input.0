From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 06/17] ARM: dts: sun7i: Add cpu clock reference and operating points to dtsi
Date: Tue,  6 Jan 2015 10:35:16 +0800
Message-ID: <1420511727-8242-7-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40938 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbbAFCfm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:42 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

The cpu core is clocked from the "cpu" clock. Add a reference to it
in the first cpu node. Also add "cpu0" label to the node.

The operating points were taken from the A20 FEX files in the
sunxi-boards repository. Not all boards have the same settings. The
settings in this patch are the most generic ones.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 01c7133e699c..887b0521bbfb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -82,10 +82,26 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz    uV */
+				1008000 1450000
+				960000  1400000
+				912000  1400000
+				864000  1300000
+				720000  1200000
+				528000  1100000
+				312000  1000000
+				144000  900000
+				>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu@1 {
-- 
2.1.4

