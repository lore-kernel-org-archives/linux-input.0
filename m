From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] Input: cyttsp4_core - Remove redundant dev_set_drvdata
Date: Fri,  6 Sep 2013 23:38:06 +0530
Message-ID: <1378490888-5083-2-git-send-email-sachin.kamat@linaro.org>
References: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35738 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab3IFSIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:08:24 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3572682pdj.17
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:08:24 -0700 (PDT)
In-Reply-To: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Ferruh Yigit <fery@cypress.com>

Driver core sets the data to NULL upon release or probe
failure. Hence explicit setting is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Ferruh Yigit <fery@cypress.com>
---
 drivers/input/touchscreen/cyttsp4_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index d038575..42d830e 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -2113,7 +2113,6 @@ error_startup:
 error_request_irq:
 	if (cd->cpdata->init)
 		cd->cpdata->init(cd->cpdata, 0, dev);
-	dev_set_drvdata(dev, NULL);
 error_free_xfer:
 	kfree(cd->xfer_buf);
 error_free_cd:
@@ -2151,7 +2150,6 @@ int cyttsp4_remove(struct cyttsp4 *cd)
 	free_irq(cd->irq, cd);
 	if (cd->cpdata->init)
 		cd->cpdata->init(cd->cpdata, 0, dev);
-	dev_set_drvdata(dev, NULL);
 	cyttsp4_free_si_ptrs(cd);
 	kfree(cd);
 	return 0;
-- 
1.7.4.1

