From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] input: touchscreen: mxs-lradc: Do a NULL check on iores
Date: Wed, 21 Jun 2017 23:51:12 -0300
Message-ID: <1498099872-16959-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35699 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbdFVCva (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 22:51:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id x58so506357qtc.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jun 2017 19:51:30 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: marex@denx.de, ksenija.stanojevic@gmail.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

platform_get_resource() may fail, so we should better do a NULL check
and return error on failure.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Instead of using devm_ioremap_resource, do a NULL check on iores

 drivers/input/touchscreen/mxs-lradc-ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 58c016c..71bf493 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -630,6 +630,8 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	spin_lock_init(&ts->lock);
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -EINVAL;
 	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
-- 
2.7.4

