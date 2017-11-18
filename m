From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/10 v2] Input: w90p910_ts: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 16:25:13 +0530
Message-ID: <1d35ad94214f0e0ba6cd50d443067c323121486b.1510999334.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39915 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946484AbdKRKzs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:55:48 -0500
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <76d6a73ba51e1a8a86d8d9a1d0bbbf7723d5153a.1510999334.git.arvind.yadav.cs@gmail.com>
References: <76d6a73ba51e1a8a86d8d9a1d0bbbf7723d5153a.1510999334.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/touchscreen/w90p910_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 638c1d7..fa74f2c 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -277,6 +277,10 @@ static int w90x900ts_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, w90p910_ts);
 
 	w90p910_ts->irq_num = platform_get_irq(pdev, 0);
+	if (w90p910_ts->irq_num <= 0) {
+		err = w90p910_ts->irq_num;
+		goto fail4;
+	}
 	if (request_irq(w90p910_ts->irq_num, w90p910_ts_interrupt,
 			0, "w90p910ts", w90p910_ts)) {
 		err = -EBUSY;
-- 
2.7.4

