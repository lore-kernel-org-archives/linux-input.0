From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v4 3/5] input: Add support for the tm2 touchkey device driver
Date: Fri, 06 Jan 2017 20:41:12 +0900
Message-ID: <20170106114114.19321-4-andi.shyti@samsung.com>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p299b63311b3c55738537a40486f1462d8@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170106114114.19321-1-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Jaechul Lee <jcsing.lee@samsung.com>

This patch adds the binding description of the tm2 touchkey
device driver.

Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
new file mode 100644
index 000000000000..4de1af0f0a37
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
2.11.0
