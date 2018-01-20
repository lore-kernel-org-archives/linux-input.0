From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: tps6507x-ts: Improve a size determination in
 tps6507x_ts_probe()
Date: Sat, 20 Jan 2018 22:00:17 +0100
Message-ID: <61c1f15b-64aa-8bad-6f56-9607590421c4@users.sourceforge.net>
References: <1ee278a0-a855-cfb3-fd04-24034ec42a65@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:63079 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756642AbeATVAU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Jan 2018 16:00:20 -0500
In-Reply-To: <1ee278a0-a855-cfb3-fd04-24034ec42a65@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 21:47:16 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/tps6507x-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 5b2756ec1766..83b24e202d8e 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -226,7 +226,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	 */
 	init_data = tps_board->tps6507x_ts_init_data;
 
-	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
+	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
 	if (!tsc)
 		return -ENOMEM;
 
-- 
2.15.1

