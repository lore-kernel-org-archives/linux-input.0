From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/2] Input: synaptics-rmi4 - Fix error handling in SPI transport driver
Date: Fri, 30 Sep 2016 21:04:10 -0700
Message-ID: <1475294650-29059-2-git-send-email-linux@roeck-us.net>
References: <1475294650-29059-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35177 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbcJAEEQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 00:04:16 -0400
In-Reply-To: <1475294650-29059-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Nick Dyer <nick@shmanahar.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>

Instantiating the rmi4 SPI transport driver without an interrupt assigned
caused the driver to fail to load, but it does not clean up its transport
device registration. Result may be a crash at a later time, for example
when rebooting the system.

Fixes: 8d99758dee31 ("Input: synaptics-rmi4 - add SPI transport driver")
Cc: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use devm_add_action to register cleanup functions
    Drop remove function as no longer necessary

 drivers/input/rmi4/rmi_spi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 55bd1b34970c..4ebef607e214 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -396,6 +396,13 @@ static inline int rmi_spi_of_probe(struct spi_device *spi,
 }
 #endif
 
+static void rmi_spi_unregister_transport(void *data)
+{
+	struct rmi_spi_xport *rmi_spi = data;
+
+	rmi_unregister_transport_device(&rmi_spi->xport);
+}
+
 static int rmi_spi_probe(struct spi_device *spi)
 {
 	struct rmi_spi_xport *rmi_spi;
@@ -464,6 +471,11 @@ static int rmi_spi_probe(struct spi_device *spi)
 		dev_err(&spi->dev, "failed to register transport.\n");
 		return retval;
 	}
+	retval = devm_add_action_or_reset(&spi->dev,
+					  rmi_spi_unregister_transport,
+					  rmi_spi);
+	if (retval)
+		return retval;
 
 	retval = rmi_spi_init_irq(spi);
 	if (retval < 0)
@@ -473,15 +485,6 @@ static int rmi_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int rmi_spi_remove(struct spi_device *spi)
-{
-	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
-
-	rmi_unregister_transport_device(&rmi_spi->xport);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int rmi_spi_suspend(struct device *dev)
 {
@@ -577,7 +580,6 @@ static struct spi_driver rmi_spi_driver = {
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_spi_probe,
-	.remove		= rmi_spi_remove,
 };
 
 module_spi_driver(rmi_spi_driver);
-- 
2.5.0

