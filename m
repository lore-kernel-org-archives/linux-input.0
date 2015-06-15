From: Dudley Du <dudl@cypress.com>
Subject: [PATCH v1 6/7] input: cyapa: add of match device support and description document
Date: Mon, 15 Jun 2015 17:01:36 +0800
Message-ID: <1434358897-24668-7-git-send-email-dudl@cypress.com>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add of_match_device mechanism support for Cypress trackpad device, and
add the sample description document of adding the trackpad device node in
device tree.
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 .../devicetree/bindings/input/cypress,cyapa.txt    | 44 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/mouse/cyapa.c                        | 10 +++++
 3 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt

diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.txt b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
new file mode 100644
index 0000000..9be2b44
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
@@ -0,0 +1,44 @@
+Cypress I2C Touchpad
+
+Required properties:
+- compatible: must be "cypress,cyapa".
+- reg: I2C address of the chip.
+- interrupt-parent: a phandle for the interrupt controller (see interrupt
+  binding[0]).
+- interrupts: interrupt to which the chip is connected (see interrupt
+  binding[0]).
+
+Optional properties:
+- wakeup-source: touchpad can be used as a wakeup source.
+- pinctrl-names: should be "default" (see pinctrl binding [1]).
+- pinctrl-0: a phandle pointing to the pin settings for the device (see
+  pinctrl binding [1]).
+- vcc-supply: a phandle for the regulator supplying 3.3V power.
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	&i2c0 {
+		/* ... */
+
+		/* Cypress Gen3 touchpad */
+		touchpad@67 {
+			compatible = "cypress,cyapa";
+			reg = <0x24>;
+			interrupt-parent = <&gpio>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
+			wakeup-source;
+		};
+
+		/* Cypress Gen5 and later touchpad */
+		touchpad@24 {
+			compatible = "cypress,cyapa";
+			reg = <0x24>;
+			interrupt-parent = <&gpio>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
+			wakeup-source;
+		};
+
+		/* ... */
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ee2ce7b..e43d532 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ cortina	Cortina Systems, Inc.
 cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
 cubietech	Cubietech, Ltd.
+cypress	Cypress Semiconductor Corporation
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
 delta	Delta Electronics, Inc.
diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 4e69594..7b6d6d4 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
 #include "cyapa.h"
 
 
@@ -1562,12 +1563,21 @@ static const struct acpi_device_id cyapa_acpi_id[] = {
 MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id cyapa_of_match[] = {
+	{ .compatible = "cypress,cyapa" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cyapa_of_match);
+#endif
+
 static struct i2c_driver cyapa_driver = {
 	.driver = {
 		.name = "cyapa",
 		.owner = THIS_MODULE,
 		.pm = &cyapa_pm_ops,
 		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
+		.of_match_table = of_match_ptr(cyapa_of_match),
 	},
 
 	.probe = cyapa_probe,
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
