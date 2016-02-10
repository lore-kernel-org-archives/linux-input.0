From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v5 09/10] Input: synaptics-rmi4: Add device tree support to the SPI transport driver
Date: Wed, 10 Feb 2016 14:25:43 -0800
Message-ID: <1455143143-10464-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add devicetree binding for SPI devices.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     | 57 ++++++++++++++++++++++
 Documentation/devicetree/bindings/spi/spi-bus.txt  |  2 +
 drivers/input/rmi4/rmi_spi.c                       | 44 ++++++++++++++++-
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
new file mode 100644
index 0000000..a4ca782
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
@@ -0,0 +1,57 @@
+Synaptics RMI4 SPI Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using different
+transports and different functions. This file describes the device tree
+bindings for devices using the SPI transport driver. Complete documentation
+for other transports and functions can be found in
+Documentation/devicetree/bindings/input/rmi4.
+
+Required Properties:
+- compatible: syna,rmi4-spi
+- reg: Chip select address for the device
+- #address-cells: Set to 1 to indicate that the function child nodes
+		    consist of only on uint32 value.
+- #size-cells: Set to 0 to indicate that the function child nodes do not
+		have a size property.
+
+Optional Properties:
+- interrupts: interrupt which the rmi device is connected to.
+- interrupt-parent: The interrupt controller.
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+- spi-rx-delay-us: microsecond delay after a read transfer.
+- spi-tx-delay-us: microsecond delay after a write transfer.
+
+Function Parameters:
+Parameters specific to RMI functions are contained in child nodes of the rmi device
+ node. Documentation for the parameters of each function can be found in:
+Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
+
+
+
+Example:
+	spi@7000d800 {
+		rmi4-spi-dev@0 {
+			compatible = "syna,rmi4-spi";
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi-max-frequency = <4000000>;
+			spi-cpha;
+			spi-cpol;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(K, 2) 0x2>;
+			spi-rx-delay-us = <30>;
+
+			rmi4-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi4-f11@11 {
+				reg = <0x11>;
+				touchscreen-inverted-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index bbaa857..42d5954 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -61,6 +61,8 @@ contain the following properties.
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
+- spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
+- spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 4319c63..55bd1b3 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define RMI_SPI_DEFAULT_XFER_BUF_SIZE	64
@@ -360,6 +361,41 @@ static int rmi_spi_init_irq(struct spi_device *spi)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int rmi_spi_of_probe(struct spi_device *spi,
+			struct rmi_device_platform_data *pdata)
+{
+	struct device *dev = &spi->dev;
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.read_delay_us,
+			"spi-rx-delay-us", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.write_delay_us,
+			"spi-tx-delay-us", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+static const struct of_device_id rmi_spi_of_match[] = {
+	{ .compatible = "syna,rmi4-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rmi_spi_of_match);
+#else
+static inline int rmi_spi_of_probe(struct spi_device *spi,
+				struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
 static int rmi_spi_probe(struct spi_device *spi)
 {
 	struct rmi_spi_xport *rmi_spi;
@@ -377,8 +413,13 @@ static int rmi_spi_probe(struct spi_device *spi)
 
 	pdata = &rmi_spi->xport.pdata;
 
-	if (spi_pdata)
+	if (spi->dev.of_node) {
+		retval = rmi_spi_of_probe(spi, pdata);
+		if (retval)
+			return retval;
+	} else if (spi_pdata) {
 		*pdata = *spi_pdata;
+	}
 
 	if (pdata->spi_data.bits_per_word)
 		spi->bits_per_word = pdata->spi_data.bits_per_word;
@@ -532,6 +573,7 @@ static struct spi_driver rmi_spi_driver = {
 	.driver = {
 		.name	= "rmi4_spi",
 		.pm	= &rmi_spi_pm,
+		.of_match_table = of_match_ptr(rmi_spi_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_spi_probe,
-- 
2.5.0
