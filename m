From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH RESEND 6/7] input: ti_am335x_tsc: Add DT support
Date: Wed, 7 Nov 2012 12:22:03 +0530
Message-ID: <1352271124-5513-7-git-send-email-rachna@ti.com>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352271124-5513-1-git-send-email-rachna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jonathan Cameron <jic23@cam.ac.uk>, "Patil, Rachna" <rachna@ti.com>
List-Id: linux-input@vger.kernel.org

Add DT support for client touchscreen driver

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   60 ++++++++++++++++++++++++-----
 1 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 7a26810..c063cf6 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -26,6 +26,8 @@
 #include <linux/io.h>
 #include <linux/input/ti_am335x_tsc.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -398,12 +400,18 @@ static int __devinit titsc_probe(struct platform_device *pdev)
 	struct titsc *ts_dev;
 	struct input_dev *input_dev;
 	struct ti_tscadc_dev *tscadc_dev = pdev->dev.platform_data;
-	struct mfd_tscadc_board	*pdata;
-	int err;
-
-	pdata = tscadc_dev->dev->platform_data;
-
-	if (!pdata) {
+	int err, i;
+	struct mfd_tscadc_board	*pdata = NULL;
+	struct device_node *node = NULL;
+	u32 val32, wires_conf[4];
+
+	if (tscadc_dev->dev->of_node) {
+		node = tscadc_dev->dev->of_node;
+		node = of_find_node_by_name(node, "tsc");
+	} else
+		pdata = tscadc_dev->dev->platform_data;
+
+	if (!pdata && !node) {
 		dev_err(&pdev->dev, "Could not find platform data\n");
 		return -EINVAL;
 	}
@@ -421,11 +429,43 @@ static int __devinit titsc_probe(struct platform_device *pdev)
 	ts_dev->mfd_tscadc = tscadc_dev;
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
-	ts_dev->wires = pdata->tsc_init->wires;
-	ts_dev->x_plate_resistance = pdata->tsc_init->x_plate_resistance;
-	ts_dev->steps_to_configure = pdata->tsc_init->steps_to_configure;
-	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
+
+	if (node) {
+		err = of_property_read_u32(node, "wires", &val32);
+		if (err < 0)
+			goto err_free_mem;
+		else
+			ts_dev->wires = val32;
+
+		err = of_property_read_u32(node, "x-plate-resistance", &val32);
+		if (err < 0)
+			goto err_free_mem;
+		else
+			ts_dev->x_plate_resistance = val32;
+
+		err = of_property_read_u32(node, "steps-to-configure", &val32);
+		if (err < 0)
+			goto err_free_mem;
+		else
+			ts_dev->steps_to_configure = val32;
+
+		err = of_property_read_u32_array(node, "wire-config",
+				wires_conf, ARRAY_SIZE(wires_conf));
+		if (err < 0)
+			goto err_free_mem;
+		else {
+			for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
+				ts_dev->config_inp[i] = wires_conf[i];
+		}
+	} else {
+		ts_dev->wires = pdata->tsc_init->wires;
+		ts_dev->x_plate_resistance =
+			pdata->tsc_init->x_plate_resistance;
+		ts_dev->steps_to_configure =
+			pdata->tsc_init->steps_to_configure;
+		memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
 			sizeof(pdata->tsc_init->wire_config));
+	}
 
 	err = request_irq(ts_dev->irq, titsc_irq,
 			  0, pdev->dev.driver->name, ts_dev);
-- 
1.7.0.4
