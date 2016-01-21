From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v4 1/4] Input: cyttsp - use devres managed resource allocations
Date: Thu, 21 Jan 2016 20:21:13 +0100
Message-ID: <20e9f0188f07fc420912b3defa747303be3cf290.1453403916.git.oreste.salerno@tomtom.com>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:34439 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760025AbcAUTV1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 14:21:27 -0500
In-Reply-To: <cover.1453403916.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

Use devm_() functions for allocating memory, input device and IRQ.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 5b74e8b..3c2ee84 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -541,11 +541,11 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 		goto err_out;
 	}
 
-	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
-	input_dev = input_allocate_device();
+	ts = devm_kzalloc(dev, sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
+	input_dev = devm_input_allocate_device(dev);
 	if (!ts || !input_dev) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_out;
 	}
 
 	ts->dev = dev;
@@ -562,7 +562,7 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 		if (error) {
 			dev_err(ts->dev, "platform init failed, err: %d\n",
 				error);
-			goto err_free_mem;
+			goto err_out;
 		}
 	}
 
@@ -586,9 +586,9 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	input_mt_init_slots(input_dev, CY_MAX_ID, 0);
 
-	error = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     pdata->name, ts);
+	error = devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp_irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  pdata->name, ts);
 	if (error) {
 		dev_err(ts->dev, "failed to request IRQ %d, err: %d\n",
 			ts->irq, error);
@@ -599,25 +599,20 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	error = cyttsp_power_on(ts);
 	if (error)
-		goto err_free_irq;
+		goto err_platform_exit;
 
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(ts->dev, "failed to register input device: %d\n",
 			error);
-		goto err_free_irq;
+		goto err_platform_exit;
 	}
 
 	return ts;
 
-err_free_irq:
-	free_irq(ts->irq, ts);
 err_platform_exit:
 	if (pdata->exit)
 		pdata->exit();
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts);
 err_out:
 	return ERR_PTR(error);
 }
@@ -625,11 +620,8 @@ EXPORT_SYMBOL_GPL(cyttsp_probe);
 
 void cyttsp_remove(struct cyttsp *ts)
 {
-	free_irq(ts->irq, ts);
-	input_unregister_device(ts->input);
 	if (ts->pdata->exit)
 		ts->pdata->exit();
-	kfree(ts);
 }
 EXPORT_SYMBOL_GPL(cyttsp_remove);
 
-- 
1.9.1

