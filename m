From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 2/3] input: rmi4: Acquire and enable VDD and VIO supplies
Date: Fri,  6 May 2016 21:40:07 -0700
Message-ID: <1462596008-21381-3-git-send-email-bjorn.andersson@linaro.org>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

For systems where the rmi4 device is not powered by always-on regulators
we need to acquire handles to VDD and VIO and enable these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added patch 1 and 3
- Moved regulator handling to the core driver

 .../devicetree/bindings/input/rmi4/rmi_i2c.txt       |  6 ++++++
 .../devicetree/bindings/input/rmi4/rmi_spi.txt       |  6 ++++++
 drivers/input/rmi4/rmi_driver.c                      | 20 ++++++++++++++++++++
 include/linux/rmi.h                                  |  4 +++-
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
index 95fa715c6046..29aedd05cb81 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -22,6 +22,12 @@ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - syna,reset-delay-ms: The number of milliseconds to wait after resetting the
 			device.
 
+- vdd-supply: VDD power supply.
+See Documentation/devicetree/bindings/regulator/regulator.txt
+
+- vio-supply: VIO power supply
+See Documentation/devicetree/bindings/regulator/regulator.txt
+
 Function Parameters:
 Parameters specific to RMI functions are contained in child nodes of the rmi device
  node. Documentation for the parameters of each function can be found in:
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
index a4ca7828f21d..71388bac4bc7 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
@@ -22,6 +22,12 @@ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - spi-rx-delay-us: microsecond delay after a read transfer.
 - spi-tx-delay-us: microsecond delay after a write transfer.
 
+- vdd-supply: VDD power supply.
+See Documentation/devicetree/bindings/regulator/regulator.txt
+
+- vio-supply: VIO power supply
+See Documentation/devicetree/bindings/regulator/regulator.txt
+
 Function Parameters:
 Parameters specific to RMI functions are contained in child nodes of the rmi device
  node. Documentation for the parameters of each function can be found in:
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 48c7991c9898..7e73539719cb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
+#include <linux/regulator/consumer.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -875,6 +876,9 @@ static int rmi_driver_remove(struct device *dev)
 
 	rmi_free_function_list(rmi_dev);
 
+	regulator_bulk_disable(ARRAY_SIZE(rmi_dev->supplies),
+			       rmi_dev->supplies);
+
 	return 0;
 }
 
@@ -938,6 +942,22 @@ static int rmi_driver_probe(struct device *dev)
 	data->rmi_dev = rmi_dev;
 	dev_set_drvdata(&rmi_dev->dev, data);
 
+	rmi_dev->supplies[0].supply = "vdd";
+	rmi_dev->supplies[1].supply = "vio";
+	retval = devm_regulator_bulk_get(rmi_dev->xport->dev,
+					 ARRAY_SIZE(rmi_dev->supplies),
+					 rmi_dev->supplies);
+	if (retval < 0)
+		return retval;
+
+	retval = regulator_bulk_enable(ARRAY_SIZE(rmi_dev->supplies),
+				       rmi_dev->supplies);
+	if (retval < 0)
+		return retval;
+
+	/* Allow the firmware to get ready */
+	msleep(10);
+
 	/*
 	 * Right before a warm boot, the sensor might be in some unusual state,
 	 * such as F54 diagnostics, or F34 bootloader mode after a firmware
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 5944e6c2470d..38ff4c1d31d4 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/regulator/consumer.h>
 
 #define NAME_BUFFER_SIZE 256
 
@@ -315,7 +316,7 @@ struct rmi_driver {
  * @number: Unique number for the device on the bus.
  * @driver: Pointer to associated driver
  * @xport: Pointer to the transport interface
- *
+ * @supplies: vdd and vdio regulator supplies
  */
 struct rmi_device {
 	struct device dev;
@@ -324,6 +325,7 @@ struct rmi_device {
 	struct rmi_driver *driver;
 	struct rmi_transport_dev *xport;
 
+	struct regulator_bulk_data supplies[2];
 };
 
 struct rmi_driver_data {
-- 
2.5.0
