From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 2/4] dt-bindings: add binding for Nsiway NS2009 touchscreen
 controller
Date: Wed, 15 Mar 2017 23:51:38 +0800
Message-ID: <20170315155140.54518-3-icenowy@aosc.xyz>
References: <20170315155140.54518-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170315155140.54518-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Nsiway NS2009 is a resistive touchscreen controller, with I2C interface
and optional interrupt pin.

Add binding document for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../bindings/input/touchscreen/ns2009.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ns2009.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ns2009.txt b/Documentation/devicetree/bindings/input/touchscreen/ns2009.txt
new file mode 100644
index 000000000000..0e9090ba978c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ns2009.txt
@@ -0,0 +1,23 @@
+* Nsiway NS2009 Resistive Touchscreen Controller
+
+Required properties:
+- compatible		  : "nsiway,ns2009"
+- reg			  : I2C slave address of the chip (0x48 or 0x49, depends on
+			    the hardware)
+
+Optional properties:
+- interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+- interrupts		  : interrupt specification for the ns2009 pen interrupt
+- properties defined in touchscreen.txt
+
+Example:
+
+i2c@00000000 {
+	ns2009: touchscreen@48 {
+		compatible = "nsiway,ns2009";
+		reg = <0x48>;
+		touchscreen-fuzz-x = <8>;
+		touchscreen-fuzz-y = <8>;
+	};
+};
-- 
2.12.0
