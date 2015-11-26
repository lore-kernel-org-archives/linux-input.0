From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 09/10] Input: synaptics-rmi4: Add device tree support to the SPI transport driver
Date: Wed, 25 Nov 2015 16:10:25 -0800
Message-ID: <1448496625-25408-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add devicetree binding for SPI devices.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     | 57 ++++++++++++++++++++++
 drivers/input/rmi4/rmi_spi.c                       | 44 ++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
new file mode 100644
index 0000000..f20366b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
@@ -0,0 +1,57 @@
+Synaptics RMI4 SPI Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices using the SPI tranport driver. Complete documentation
+for other transports and functions cen be found ini
+Documentation/devicetree/bindings/input/rmi4.
+
+Required Properties:
+- compatible: syna,rmi-spi
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
+- syna,spi-read-delay: millisecond delay between read byte transfers.
+- syna,spi-write-delay: millisecond delay between write byte transfers.
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
+		rmi-spi-dev@0 {
+			compatible = "syna,rmi-spi";
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi-max-frequency = <4000000>;
+			spi-cpha;
+			spi-cpol;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(K, 2) 0x2>;
+			syna,spi-read-delay = <30>;
+
+			rmi-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,flip-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 7f9a188..9bdd9cf 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -12,6 +12,7 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
 
 #define RMI_SPI_DEFAULT_XFER_BUF_SIZE	64
@@ -322,6 +323,41 @@ static const struct rmi_transport_ops rmi_spi_ops = {
 	.read_block	= rmi_spi_read_block,
 };
 
+#ifdef CONFIG_OF
+static int rmi_spi_of_probe(struct spi_device *spi,
+			struct rmi_device_platform_data *pdata)
+{
+	struct device *dev = &spi->dev;
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.read_delay_us,
+			"syna,spi-read-delay", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.write_delay_us,
+			"syna,spi-write-delay", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+static const struct of_device_id rmi_spi_of_match[] = {
+	{ .compatible = "syna,rmi-spi" },
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
@@ -339,8 +375,13 @@ static int rmi_spi_probe(struct spi_device *spi)
 
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
@@ -407,6 +448,7 @@ static struct spi_driver rmi_spi_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "rmi_spi",
+		.of_match_table = of_match_ptr(rmi_spi_of_match),
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_spi_probe,
-- 
2.5.0
