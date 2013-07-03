From: Ferruh Yigit <fery@cypress.com>
Subject: [PATCH] Input: cyttsp4 - kfree xfer_buf on error path in probe()
Date: Wed,  3 Jul 2013 20:14:52 +0300
Message-ID: <1372871693-9871-1-git-send-email-fery@cypress.com>
References: <51D42CD3.2000705@cypress.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61103 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964815Ab3GCRPU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jul 2013 13:15:20 -0400
In-Reply-To: <51D42CD3.2000705@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ttdrivers@cypress.com, Javier Martinez Canillas <javier@dowhile0.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, Ferruh Yigit <fery@cypress.com>

If probe() fails after cd->xfer_buf allocated, it will not freed.
Added kfree(cd->xfer_buf) with and error label.

Signed-off-by: Ferruh Yigit <fery@cypress.com>
---
 drivers/input/touchscreen/cyttsp4_core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index a7987e1..edcf799 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -2049,7 +2049,7 @@ struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
 	cd->irq = gpio_to_irq(cd->cpdata->irq_gpio);
 	if (cd->irq < 0) {
 		rc = -EINVAL;
-		goto error_free_cd;
+		goto error_free_xfer;
 	}
 
 	dev_set_drvdata(dev, cd);
@@ -2117,6 +2117,8 @@ error_request_irq:
 	if (cd->cpdata->init)
 		cd->cpdata->init(cd->cpdata, 0, dev);
 	dev_set_drvdata(dev, NULL);
+error_free_xfer:
+	kfree(cd->xfer_buf);
 error_free_cd:
 	kfree(cd);
 error_alloc_data:
-- 
1.7.9.5

