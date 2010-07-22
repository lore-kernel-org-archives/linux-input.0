From: Dan Carpenter <error27@gmail.com>
Subject: [patch -next] input: adxl34x: fix leak and use after free
Date: Thu, 22 Jul 2010 10:55:52 +0200
Message-ID: <20100722085552.GW17585@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40551 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758998Ab0GVI4j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jul 2010 04:56:39 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, Chris Verges <chrisv@cyberswitching.com>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

These are a couple smatch issues.  In the original code, if only one of
the allocation fails we leak the other variable so we should goto
out_free_mem.

Also there was a use after free if debugging was enabled and so I moved
the kfree() down a line.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index bb9c10f..e925d12 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -709,7 +709,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	input_dev = input_allocate_device();
 	if (!ac || !input_dev) {
 		err = -ENOMEM;
-		goto err_out;
+		goto err_free_mem;
 	}
 
 	ac->fifo_delay = fifo_delay_default;
@@ -904,9 +904,9 @@ int adxl34x_remove(struct adxl34x *ac)
 	sysfs_remove_group(&ac->dev->kobj, &adxl34x_attr_group);
 	free_irq(ac->irq, ac);
 	input_unregister_device(ac->input);
+	dev_dbg(ac->dev, "unregistered accelerometer\n");
 	kfree(ac);
 
-	dev_dbg(ac->dev, "unregistered accelerometer\n");
 	return 0;
 }
 EXPORT_SYMBOL_GPL(adxl34x_remove);
