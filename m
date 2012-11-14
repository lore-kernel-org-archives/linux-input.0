From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/5] Input: bu21013_ts - Request a regulator that actually exists
Date: Wed, 14 Nov 2012 13:47:13 +0000
Message-ID: <1352900837-20759-2-git-send-email-lee.jones@linaro.org>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59289 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422927Ab2KNNrv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 08:47:51 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm14so280597wib.1
        for <linux-input@vger.kernel.org>; Wed, 14 Nov 2012 05:47:49 -0800 (PST)
In-Reply-To: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Currently the BU21013 Touch Screen driver requests a regulator by the
name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
correct name, as referenced in platform regulator code is 'avdd'. Here,
when we request a regulator, we use the correct name instead.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/bu21013_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 5c487d2..2fae682 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -461,7 +461,7 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	bu21013_data->chip = pdata;
 	bu21013_data->client = client;
 
-	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
+	bu21013_data->regulator = regulator_get(&client->dev, "avdd");
 	if (IS_ERR(bu21013_data->regulator)) {
 		dev_err(&client->dev, "regulator_get failed\n");
 		error = PTR_ERR(bu21013_data->regulator);
-- 
1.7.9.5

