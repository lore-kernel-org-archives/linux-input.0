From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: da9034-ts: Delete an error message for a failed
 memory allocation in da9034_touch_probe()
Date: Sun, 21 Jan 2018 20:47:22 +0100
Message-ID: <f01314ac-c256-3033-f421-5ff7f152311a@users.sourceforge.net>
References: <44ae37ef-deaa-c963-e0f7-c407159afa0c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:50579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeAUTr0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 14:47:26 -0500
In-Reply-To: <44ae37ef-deaa-c963-e0f7-c407159afa0c@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:32:48 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/da9034-ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 8264822dc4b9..b30cfe1e62da 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -305,10 +305,8 @@ static int da9034_touch_probe(struct platform_device *pdev)
 
 	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
 			     GFP_KERNEL);
-	if (!touch) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (!touch)
 		return -ENOMEM;
-	}
 
 	touch->da9034_dev = pdev->dev.parent;
 
-- 
2.16.0

