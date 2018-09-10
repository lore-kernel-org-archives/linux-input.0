From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/8] dt-bindings: olpc,ap-sp: add GPIO lines
Date: Mon, 10 Sep 2018 13:26:48 +0200
Message-ID: <20180910112654.42061-3-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Add properties describing the GPIO lines used by the keyboard controller.
The olpc-apsp driver will do happily without them, but they are still part
of the hardware description. The driver could still reserve the lines,
so that nothing else touches them.

This makes the device node almost compatible with "ps2-gpio". I'm not
adding a compatible property, because ps2-gpio would use a different
interrupt, so that we'd need to name it. And I haven't actually tried it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 36603419d6f8..2b1b1dbb54c1 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -7,6 +7,10 @@ Required properties:
 - clocks : phandle + clock-specifier for the clock that drives the WTM
 - clock-names:  should be "sp"
 
+Optional properties:
+- data-gpios : GPIO line used for PS/2 interface data
+- clk-gpios : GPIO line used for PS/2 interface clock
+
 Example:
 	ap-sp@d4290000 {
 		compatible = "olpc,ap-sp";
@@ -14,4 +18,6 @@ Example:
 		interrupts = <40>;
 		clocks = <&soc_clocks MMP2_CLK_SP>;
 		clock-names = "sp";
+		data-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
+		clk-gpios = <&gpio 71 GPIO_ACTIVE_HIGH>;
 	}
-- 
2.17.1
