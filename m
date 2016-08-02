From: <mika.penttila@nextfour.com>
Subject: [PATCH v6 2/2] Input: SiS 9200 documentation parts
Date: Tue, 2 Aug 2016 12:52:31 +0300
Message-ID: <1470131552-13401-3-git-send-email-mika.penttila@nextfour.com>
References: <1470131552-13401-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470131552-13401-1-git-send-email-mika.penttila@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>
List-Id: linux-input@vger.kernel.org

From: Mika Penttilä <mika.penttila@nextfour.com>

Signed-off-by: Mika Penttilä <mika.penttila@nextfour.com>
Acked-by: Tammy Tseng <tammy_tseng@sis.com>
Acked-by: Yuger Yu <yuger_yu@sis.com>
---
 .../bindings/input/touchscreen/sis_i2c.txt         | 22 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
new file mode 100644
index 0000000..e2c4902
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
@@ -0,0 +1,22 @@
+* SiS I2C Multiple Touch Controller
+
+Required properties:
+- compatible: must be "sis,9200-ts"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- irq-gpio: the gpio pin used as irq pin
+- reset-gpio: the gpio pin used to reset the controller 
+
+Example:
+
+	sis9255@5c  {
+                compatible = "sis,9200-ts";
+                reg = <0x5c>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_sis>;
+                interrupt-parent = <&gpio3>;
+                interrupts = <19 IRQ_TYPE_EDGE_FALLING>>;
+                irq-gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+                reset-gpio = <&gpio2 30 GPIO_ACTIVE_LOW>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 68391a4..1992aa9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -238,6 +238,7 @@ simtek
 sii	Seiko Instruments, Inc.
 silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
+sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
 smsc	Standard Microsystems Corporation
-- 
1.9.1
