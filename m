From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v6 1/2] dt-bindings: Input: add Samsung S6SY761 touchscreen
 binding file
Date: Wed, 08 Nov 2017 17:21:04 +0900
Message-ID: <20171108082105.30739-2-andi.shyti@samsung.com>
References: <20171108082105.30739-1-andi.shyti@samsung.com>
        <CGME20171108082115epcas2p4e9f9b62e77ed7f8028e746bc3cd6051c@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171108082105.30739-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Add the binding file for the Samsung capacitive multi-touch
touchscreen S6SY761.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/touchscreen/samsung,s6sy761.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
new file mode 100644
index 000000000000..d9b7c2ff611e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
@@ -0,0 +1,34 @@
+* Samsung S6SY761 touchscreen controller
+
+Required properties:
+- compatible		: must be "samsung,s6sy761"
+- reg			: I2C slave address, (e.g. 0x48)
+- interrupt-parent	: the phandle to the interrupt controller which provides
+			  the interrupt
+- interrupts		: interrupt specification
+- avdd-supply		: analogic power supply
+- vdd-supply		: power supply
+
+Optional properties:
+- touchscreen-size-x	: see touchscreen.txt. This property is embedded in the
+			  device. If defined it forces a different x resolution.
+- touchscreen-size-y	: see touchscreen.txt. This property is embedded in the
+			  device. If defined it forces a different y resolution.
+
+Example:
+
+i2c@00000000 {
+
+	/* ... */
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&gpa1>;
+		interrupts = <1 IRQ_TYPE_NONE>;
+		avdd-supply = <&ldo30_reg>;
+		vdd-supply = <&ldo31_reg>;
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
+	};
+};
-- 
2.15.0
