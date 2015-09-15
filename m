From: yassinjaffer@gmail.com
Subject: [PATCH 1/4] ARM:dts:sun7i: Add keypad clk node
Date: Wed, 16 Sep 2015 00:05:54 +1000
Message-ID: <1442325957-10102-2-git-send-email-yassinjaffer@gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34545 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbIOOG5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2015 10:06:57 -0400
In-Reply-To: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-sunxi@googlegroups.com
Cc: maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yassin Jaffer <yassinjaffer@gmail.com>

From: Yassin Jaffer <yassinjaffer@gmail.com>

This patch add support to the keypad clock on sun7i

Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2bebaa2..333604a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -465,6 +465,14 @@
 			clock-output-names = "ir1";
 		};
 
+		keypad_clk: clk@01c200c4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c200c4 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "keypad";
+		};
+
 		usb_clk: clk@01c200cc {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
1.9.1

