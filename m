From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/10] Input: bu21013_ts - Request a regulator that actually exists
Date: Tue,  2 Oct 2012 09:13:16 +0100
Message-ID: <1349165603-24401-4-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59838 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2JBINi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 04:13:38 -0400
Received: by weyt9 with SMTP id t9so3444258wey.19
        for <linux-input@vger.kernel.org>; Tue, 02 Oct 2012 01:13:37 -0700 (PDT)
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Currently the BU21013 Touch Screen driver requests a regulator by the
name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
correct name, as referenced in platform regulator code is 'avdd'. Here,
when we request a regulator, we use the correct name instead.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
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

