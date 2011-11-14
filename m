From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/7] Input: cyttsp - set up bus type in input device
Date: Mon, 14 Nov 2011 00:16:07 -0800
Message-ID: <20111114081607.10141.91821.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab1KNIQK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:16:10 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:16:10 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Also clean up input device initialization.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |    7 +++----
 drivers/input/touchscreen/cyttsp_core.h |    2 ++
 drivers/input/touchscreen/cyttsp_i2c.c  |    2 ++
 drivers/input/touchscreen/cyttsp_spi.c  |    4 +++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 4bc9fcd..764efd6 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -719,18 +719,17 @@ void *cyttsp_core_init(const struct cyttsp_bus_ops *bus_ops,
 	}
 
 	ts->input = input_device;
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
+
 	input_device->name = ts->platform_data->name;
-	snprintf(ts->phys, sizeof(ts->phys), "%s", dev_name(dev));
 	input_device->phys = ts->phys;
+	input_device->id.bustype = bus_ops->bustype;
 	input_device->dev.parent = ts->dev;
 	input_device->open = cyttsp_open;
 	input_device->close = cyttsp_close;
 	input_set_drvdata(input_device, ts);
 
-	__set_bit(EV_SYN, input_device->evbit);
-	__set_bit(EV_KEY, input_device->evbit);
 	__set_bit(EV_ABS, input_device->evbit);
-
 	input_set_abs_params(input_device, ABS_MT_POSITION_X,
 			     0, ts->platform_data->maxx, 0, 0);
 	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 36f94ec..979a2f1 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -36,12 +36,14 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/input/cyttsp.h>
 
 #define CY_NUM_RETRY                4 /* max number of retries for read ops */
 
 
 struct cyttsp_bus_ops {
+	u16 bustype;
 	int (*write)(struct device *dev,
 		     u8 addr, u8 length, const void *values);
 	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 5911d9c..3c2dd9d 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -32,6 +32,7 @@
 #include "cyttsp_core.h"
 
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/slab.h>
 
 #define CY_I2C_DATA_SIZE  128
@@ -80,6 +81,7 @@ static int ttsp_i2c_write_block_data(struct device *dev,
 }
 
 static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops = {
+	.bustype	= BUS_I2C,
 	.write		= ttsp_i2c_write_block_data,
 	.read		= ttsp_i2c_read_block_data,
 };
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 4540262..4c689c7 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -31,8 +31,9 @@
 
 #include "cyttsp_core.h"
 
-#include <linux/spi/spi.h>
 #include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/spi/spi.h>
 
 #define CY_SPI_WR_OP      0x00 /* r/~w */
 #define CY_SPI_RD_OP      0x01
@@ -179,6 +180,7 @@ static int ttsp_spi_write_block_data(struct device *dev,
 }
 
 static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
+	.bustype	= BUS_SPI,
 	.write		= ttsp_spi_write_block_data,
 	.read		= ttsp_spi_read_block_data,
 };

