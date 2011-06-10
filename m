From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH] input: touchscreen: add OF match table for ads7846
Date: Thu, 9 Jun 2011 19:28:40 -0700
Message-ID: <1307672920-6261-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:42276 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab1FJCaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 22:30:11 -0400
Received: from rly25g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) with ESMTP id p5A2U1mj011068
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 03:30:10 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) id p5A2T9ss005929
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 03:29:09 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Barry Song <21cnbao@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Thomas Chou <thomas@wytron.com.tw>

The current ads7846 has no OF match table. The method used is by applying a heuristic (of_modalias_node) which tries to name the device in a way that will match an existing device driver.
This patch adds explicit OF match table for ads7846, then the normal device tree match behaviour will always work.
It has been tested on PRIMA2 EVB board of CSR with a SPI's child node like the below:
ts@0 {
	compatible = "ti,ads7845";
	reg = <0x0>;
	spi-max-frequency = <31250>;
        interrupts = <90>;
};

Signed-off-by: Barry Song <21cnbao@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
cc: Thomas Chou <thomas@wytron.com.tw>
---
 drivers/input/touchscreen/ads7846.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5196861..643138b 100644
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
+#endif
+
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name	= "ads7846",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
+#if defined(CONFIG_OF)
+		.of_match_table = ads7846_spi_of_match_table,
+#endif
 	},
 	.probe		= ads7846_probe,
 	.remove		= __devexit_p(ads7846_remove),
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
