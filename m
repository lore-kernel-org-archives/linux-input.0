From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 2/2] ARM: dts: sun6i: Add resistive touchscreen controller node to dtsi
Date: Sat, 24 Jan 2015 22:33:48 +0800
Message-ID: <1422110028-30270-3-git-send-email-wens@csie.org>
References: <1422110028-30270-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:55576 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbbAXOdv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jan 2015 09:33:51 -0500
In-Reply-To: <1422110028-30270-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>, Sugar <shuge@allwinnertech.com>, Meng Zhang <kevin@allwinnertech.com>

Now that we support the sun6i variant of the touchscreen controller,
add the device node to the dtsi so we can use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 188f59e558bc..ec70454b0add 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -664,6 +664,13 @@
 			reg = <0x01c20ca0 0x20>;
 		};
 
+		rtp: rtp@01c25000 {
+			compatible = "allwinner,sun6i-a31-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.1.4

