From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/10] Input: sun4i-ts: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 00:45:29 +0530
Message-ID: <1510946132-13554-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35630 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935587AbdKQTQV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:16:21 -0500
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9..2753fd3 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -315,6 +315,9 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 		return PTR_ERR(ts->base);
 
 	ts->irq = platform_get_irq(pdev, 0);
+	if (ts->irq < 0)
+		return ts->irq;
+
 	error = devm_request_irq(dev, ts->irq, sun4i_ts_irq, 0, "sun4i-ts", ts);
 	if (error)
 		return error;
-- 
2.7.4

