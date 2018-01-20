From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: zforce_ts: Delete an error message for a failed
 memory allocation in zforce_parse_dt()
Date: Sat, 20 Jan 2018 21:18:45 +0100
Message-ID: <2f111be7-11cd-d4a5-3c42-92290c1597d2@users.sourceforge.net>
References: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65298 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756578AbeATUS4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Jan 2018 15:18:56 -0500
In-Reply-To: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 20:36:33 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/zforce_ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 7b3845aa5983..9fb6b3f201f9 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -722,10 +722,8 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOENT);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "failed to allocate platform data\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
-- 
2.15.1

