From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: mms114: Delete an error message for a failed memory
 allocation in mms114_parse_dt()
Date: Sun, 21 Jan 2018 19:03:40 +0100
Message-ID: <9e7748dc-76ba-f147-6ee0-d06c160c7aa6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:61983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbeAUSDr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 13:03:47 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 18:58:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/mms114.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index e5eeb6311f7d..b4482a024084 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -386,10 +386,8 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 		return NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "failed to allocate platform data\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
 		dev_err(dev, "failed to get x-size property\n");
-- 
2.16.0

