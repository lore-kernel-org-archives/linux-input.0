From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: mcs5000_ts: Delete an error message for a failed
 memory allocation in mcs5000_ts_probe()
Date: Sun, 21 Jan 2018 19:19:27 +0100
Message-ID: <47946655-de9f-f51f-3b6a-d5c76861e92a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:55927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbeAUSUX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 13:20:23 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 19:14:15 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/mcs5000_ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 8868573133ab..ca3c5f78ab55 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -198,10 +198,8 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 		return -EINVAL;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->client = client;
 
-- 
2.16.0

