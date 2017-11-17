From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/10] Input: w90p910_ts: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 00:45:28 +0530
Message-ID: <1510946132-13554-7-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37045 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935576AbdKQTQR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:16:17 -0500
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/w90p910_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 638c1d7..fa74f2c 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -277,6 +277,10 @@ static int w90x900ts_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, w90p910_ts);
 
 	w90p910_ts->irq_num = platform_get_irq(pdev, 0);
+	if (w90p910_ts->irq_num < 0) {
+		err = w90p910_ts->irq_num;
+		goto fail4;
+	}
 	if (request_irq(w90p910_ts->irq_num, w90p910_ts_interrupt,
 			0, "w90p910ts", w90p910_ts)) {
 		err = -EBUSY;
-- 
2.7.4

