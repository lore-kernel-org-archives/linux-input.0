From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/2] Input: cyttsp - Fix check after pointer dereferencing
Date: Fri, 10 Feb 2012 02:18:29 +0100
Message-ID: <1328836710-9897-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63579 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2BJBUl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2012 20:20:41 -0500
Received: by wics10 with SMTP id s10so1664258wic.19
        for <linux-input@vger.kernel.org>; Thu, 09 Feb 2012 17:20:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <martinez.javier@dowhile0.org>Javier Martinez Canillas <javier@dowhile0.org>

From: Javier Martinez Canillas <martinez.javier@dowhile0.org>

In the cyttsp_probe() function the struct device *dev pointer was
dereferenced before checking if it was NULL.

Now dev is never NULL since both I2C and SPI bus drivers pass a pointer to a
member of an previously allocated structure. But others bus drivers can do
it differently so is better to sanity check instead of trust in the callers.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 drivers/input/touchscreen/cyttsp_core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 8be2247..071e5ae8 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -518,12 +518,19 @@ static void cyttsp_close(struct input_dev *dev)
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size)
 {
-	const struct cyttsp_platform_data *pdata = dev->platform_data;
+	const struct cyttsp_platform_data *pdata;
 	struct cyttsp *ts;
 	struct input_dev *input_dev;
 	int error;
 
-	if (!dev || !bus_ops || !pdata || !pdata->name || irq <= 0) {
+	if (!dev || !bus_ops || !dev->platform_data || irq <= 0) {
+		error = -EINVAL;
+		goto err_out;
+	}
+
+	pdata = dev->platform_data;
+
+	if (!pdata->name) {
 		error = -EINVAL;
 		goto err_out;
 	}
-- 
1.7.7.6

