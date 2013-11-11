From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: mma8450 - add missing i2c_set_clientdata() in mma8450_probe()
Date: Mon, 11 Nov 2013 14:24:20 +0800
Message-ID: <CAPgLHd-02-tPeJghvYq+ZB9_MxdRKQ7Kvdqf2YdB=0wg9MoXow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:36662 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3KKGYW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 01:24:22 -0500
Received: by mail-bk0-f48.google.com with SMTP id u10so1530585bkz.35
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 22:24:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, sebastien.royen@armadeus.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing i2c_set_clientdata() in mma8450_probe(), otherwise
calling i2c_get_clientdata() in mma8450_remove() returns NULL.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/misc/mma8450.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index f330969..92c43a1 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -204,6 +204,8 @@ static int mma8450_probe(struct i2c_client *c,
 		goto err_free_mem;
 	}
 
+	i2c_set_clientdata(c, m);
+
 	return 0;
 
 err_free_mem:

