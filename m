From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH v2] input: touchscreen: add OF match table for ads7846
Date: Mon, 13 Jun 2011 18:45:55 -0700
Message-ID: <1308015955-8286-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:38888 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab1FNBrI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 21:47:08 -0400
Received: from rly53d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly53d.srv.mailcontrol.com (MailControl) with ESMTP id p5E1l5Nd026829
	for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 02:47:05 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly53d.srv.mailcontrol.com (MailControl) id p5E1kh96023792
	for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 02:46:43 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, DL-SHA-APBULinux@csr.com, junyi.zhang@csr.com, Barry Song <Baohua.Song@csr.com>, Thomas Chou <thomas@wytron.com.tw>

The current ads7846 has no OF match table. The method used is by applying a heuristic (of_modalias_node) which tries to name the device in a way that will match an existing device driver.
This patch adds explicit OF match table for ads7846, then the normal device tree match behaviour will always work.
It has been tested on PRIMA2 EVB board of CSR with a SPI's child node like the below:
ts@0 {
        compatible = "ti,ads7845";
        reg = <0x0>;
        spi-max-frequency = <31250>;
        interrupts = <90>;
};

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Thomas Chou <thomas@wytron.com.tw>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/input/ads7846.txt          |   20 ++++++++++++++++++++
 drivers/input/touchscreen/ads7846.c                |   14 ++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ads7846.txt

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
new file mode 100644
index 0000000..36c1fd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -0,0 +1,20 @@
+ADS7846/ADS7845/ADS7843 touchscreen connected to a SPI bus
+
+Required properties:
+- compatible : should be "ti,ads7846", "ti,ads7845" or "ti,ads7843"
+- reg : should specify SPI address (chip-select number).
+- spi-max-frequency : maximum frequency for this device (Hz).
+- interrupts : the interrupt of pendown.
+
+Optional properties:
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+
+Example:
+
+	ts@0 {
+		compatible = "ti,ads7845",
+		reg = <0>;
+		spi-max-frequency = <31250>;
+		interrupts = <90>;
+	};
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5196861..fa9345c 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/pm.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/consumer.h>
@@ -1425,12 +1426,25 @@ static int __devexit ads7846_remove(struct spi_device *spi)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static struct of_device_id ads7846_spi_of_match_table[] __devinitdata = {
+	{ .compatible = "ti,ads7846", },
+	{ .compatible = "ti,ads7845", },
+	{ .compatible = "ti,ads7843", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ads7846_spi_of_match_table);
+#else
+#define ads7846_spi_of_match_table NULL
+#endif
+
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name	= "ads7846",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
+		.of_match_table = ads7846_spi_of_match_table,
 	},
 	.probe		= ads7846_probe,
 	.remove		= __devexit_p(ads7846_remove),
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
