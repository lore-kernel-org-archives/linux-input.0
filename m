From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] Input: cyttsp - Fix check after pointer dereferencing
Date: Wed, 15 Feb 2012 11:42:52 +0100
Message-ID: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65015 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab2BOKnA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Feb 2012 05:43:00 -0500
Received: by wgbdt10 with SMTP id dt10so797283wgb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Feb 2012 02:42:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <martinez.javier@dowhile0.org>Javier Martinez Canillas <javier@dowhile0.org>

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

