From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1] Input: synaptics-rmi4 - allow number of PDT pages to be specified
Date: Mon, 24 Oct 2016 23:55:22 +0100
Message-ID: <1477349722-26635-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:40776 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbcJXWzy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Oct 2016 18:55:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

We have encountered some RMI4 firmwares where there are blank pages in between
PDT pages which contain functions. Add a device tree property which can be set
to force reading the first N pages.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt |  2 ++
 drivers/input/rmi4/rmi_driver.c                          | 16 ++++++++++++++--
 include/linux/rmi.h                                      |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
index ec908b9..a611374 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
@@ -25,6 +25,8 @@ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - syna,startup-delay-ms: The number of milliseconds to wait after powering on
 			 the device.
 
+- syna,pdt-scan-pages: Scan the first N PDT pages, ignoring blank pages.
+
 - vdd-supply: VDD power supply.
 See ../regulator/regulator.txt
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 4a88312..8f94160 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -428,6 +428,8 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 					     const struct pdt_entry *entry))
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	const struct rmi_device_platform_data *pdata =
+		rmi_get_platform_data(rmi_dev);
 	struct pdt_entry pdt_entry;
 	u16 page_start = RMI4_PAGE_SIZE * page;
 	u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
@@ -449,8 +451,13 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 			return retval;
 	}
 
-	return (data->f01_bootloader_mode || addr == pdt_start) ?
-					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
+	if (data->f01_bootloader_mode)
+		return RMI_SCAN_DONE;
+
+	if (page >= pdata->pdt_scan_pages && addr == pdt_start)
+		return RMI_SCAN_DONE;
+
+	return RMI_SCAN_CONTINUE;
 }
 
 static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
@@ -832,6 +839,11 @@ static int rmi_driver_of_probe(struct device *dev,
 	if (retval)
 		return retval;
 
+	retval = rmi_of_property_read_u32(dev, &pdata->pdt_scan_pages,
+					"syna,pdt-scan-pages", 1);
+	if (retval)
+		return retval;
+
 	return 0;
 }
 #else
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index e0aca14..2c4570d 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -207,6 +207,7 @@ struct rmi_device_platform_data_spi {
  */
 struct rmi_device_platform_data {
 	int reset_delay_ms;
+	u32 pdt_scan_pages;
 
 	struct rmi_device_platform_data_spi spi_data;
 
-- 
2.7.4

