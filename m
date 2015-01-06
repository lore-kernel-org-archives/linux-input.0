From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 10/17] ARM: dts: sun5i: Add cpu clock reference and operating points to dtsi
Date: Tue,  6 Jan 2015 10:35:20 +0800
Message-ID: <1420511727-8242-11-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41000 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbbAFCfo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:44 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

The cpu core is clocked from the "cpu" clock. Add a reference to it
in the first cpu node. Also add "cpu0" label to the node.

The operating points were taken from the A13 FEX files in the
sunxi-boards repository. All FEX files have the same settings.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 4fe0bd192e29..dd93d227865e 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -24,10 +24,26 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@0 {
+
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz    uV */
+				1104000	1500000
+				1008000 1400000
+				912000  1350000
+				864000  1300000
+				624000  1200000
+				576000  1200000
+				432000  1200000
+				>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <6>;
 		};
 	};
 
-- 
2.1.4

