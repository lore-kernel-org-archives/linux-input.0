From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 3/3] Input: cyttsp4 - leak on error path in probe()
Date: Wed, 3 Jul 2013 00:44:55 +0300
Message-ID: <20130702214455.GC1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43220 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab3GBVo4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jul 2013 17:44:56 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We leak "cd" if the cd->xfer_buf allocation fails.  It was weird to
"goto error_gpio_irq" so I changed the label name.  (Label names should
reflect the label location not the goto location otherwise you get an
"all roads lead to Rome problem").

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 851e3ff..a7987e1 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -2025,7 +2025,7 @@ struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
 	if (!cd->xfer_buf) {
 		dev_err(dev, "%s: Error, kzalloc\n", __func__);
 		rc = -ENOMEM;
-		goto error_alloc_data;
+		goto error_free_cd;
 	}
 
 	/* Initialize device info */
@@ -2049,7 +2049,7 @@ struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
 	cd->irq = gpio_to_irq(cd->cpdata->irq_gpio);
 	if (cd->irq < 0) {
 		rc = -EINVAL;
-		goto error_gpio_irq;
+		goto error_free_cd;
 	}
 
 	dev_set_drvdata(dev, cd);
@@ -2117,7 +2117,7 @@ error_request_irq:
 	if (cd->cpdata->init)
 		cd->cpdata->init(cd->cpdata, 0, dev);
 	dev_set_drvdata(dev, NULL);
-error_gpio_irq:
+error_free_cd:
 	kfree(cd);
 error_alloc_data:
 error_no_pdata:
