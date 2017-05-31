From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 1/2] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Wed, 31 May 2017 15:59:14 +0900
Message-ID: <20170531065915.15695-2-andi.shyti@samsung.com>
References: <20170531065915.15695-1-andi.shyti@samsung.com>
        <CGME20170531065928epcas1p2b6473d8eb979258cda797bd2664b7680@epcas1p2.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20170531065915.15695-1-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add binding for the STMicroelectronics FingerTip (stmfts)
touchscreen driver.

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
