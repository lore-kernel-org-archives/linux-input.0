From: Jaechul Lee <jcsing.lee@samsung.com>
Subject: [PATCH 1/4] input: Add support for the tm2 touchkey device driver
Date: Tue, 03 Jan 2017 16:57:14 +0900
Message-ID: <1483430237-26823-2-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075733epcas5p47dff8d21854938b2439c9843d91bc301@epcas5p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds the binding description of the tm2 touchkey
device driver.

Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
---
 .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
new file mode 100644
index 0000000..4de1af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
@@ -0,0 +1,27 @@
+Samsung tm2-touchkey
+
+Required properties:
+- compatible: must be "samsung,tm2-touchkey"
+- reg: I2C address of the chip.
+- interrupt-parent: a phandle for the interrupt controller (see interrupt
+	binding[0]).
+- interrupts: interrupt to which the chip is connected (see interrupt
+	binding[0]).
+- vcc-supply : internal regulator output. 1.8V
+- vdd-supply : power supply for IC 3.3V
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+	&i2c0 {
+		/* ... */
+
+		touchkey@20 {
+			compatible = "samsung,tm2-touchkey";
+			reg = <0x20>;
+			interrupt-parent = <&gpa3>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+			vcc-supply=<&ldo32_reg>;
+			vdd-supply=<&ldo33_reg>;
+		};
+	};
-- 
2.7.4
