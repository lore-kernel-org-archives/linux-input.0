From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v3 1/2] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Mon, 27 Mar 2017 22:07:42 +0900
Message-ID: <20170327130743.27783-2-andi.shyti@samsung.com>
References: <20170327130743.27783-1-andi.shyti@samsung.com>
        <CGME20170327130756epcas1p3134e88ccee37242db029357ae3d52603@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170327130743.27783-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Add binding for the STMicroelectronics FingerTip (stmfts)
touchscreen driver.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 .../bindings/input/touchscreen/st,stmfts.txt       | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
new file mode 100644
index 000000000000..9683595cd0f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
@@ -0,0 +1,43 @@
+* ST-Microelectronics FingerTip touchscreen controller
+
+The ST-Microelectronics FingerTip device provides a basic touchscreen
+functionality. Along with it the user can enable the touchkey which can work as
+a basic HOME and BACK key for phones.
+
+The driver supports also hovering as an absolute single touch event with x, y, z
+coordinates.
+
+Required properties:
+- compatible		: must be "st,stmfts"
+- reg			: I2C slave address, (e.g. 0x49)
+- interrupt-parent	: the phandle to the interrupt controller which provides
+			  the interrupt
+- interrupts		: interrupt specification
+- avdd-supply		: analogic power supply
+- vdd-supply		: power supply
+- touchscreen-size-x	: see touchscreen.txt
+- touchscreen-size-y	: see touchscreen.txt
+
+Optional properties:
+- touch-key-connected	: specifies whether the touchkey feature is connected
+- ledvdd-supply		: power supply to the touch key leds
+
+Example:
+
+i2c@00000000 {
+
+	/* ... */
+
+	touchscreen@49 {
+		compatible = "st,stmfts";
+		reg = <0x49>;
+		interrupt-parent = <&gpa1>;
+		interrupts = <1 IRQ_TYPE_NONE>;
+		touchscreen-size-x = <1599>;
+		touchscreen-size-y = <2559>;
+		touch-key-connected;
+		avdd-supply = <&ldo30_reg>;
+		vdd-supply = <&ldo31_reg>;
+		ledvdd-supply = <&ldo33_reg>;
+	};
+};
-- 
2.11.0
